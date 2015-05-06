unit Client;

interface

uses
  SysUtils,
  SfmlAudio, SfmlNetwork, SfmlSystem;

const
  AudioData   = 1;
  EndOfStream = 2;

type
  TNetworkRecorder = class(TSfmlSoundRecorder)
  private
    FHost: TSfmlIpAddress;
    FPort: Word;
    FSocket: TSfmlTcpSocket;
    function OnStart: Boolean; virtual;
    function OnProcessSamples(const Samples: PSmallInt; SampleCount: NativeUInt): Boolean; virtual;
    procedure OnStop; virtual;
  public
    constructor Create(Host: TSfmlIpAddress; Port: Word);
  end;

procedure DoClient(Port: Word);

implementation

function OnStartHandler(UserData: Pointer): Boolean; cdecl;
begin
  Assert(TObject(UserData) is TNetworkRecorder);
  Result := TNetworkRecorder(UserData).OnStart;
end;


function OnProcessSamplesHandler(Data: PSmallInt; SampleFrames: NativeUInt;
  UserData: Pointer): Boolean; cdecl;
begin
  Assert(TObject(UserData) is TNetworkRecorder);
  Result := TNetworkRecorder(UserData).OnProcessSamples(Data, SampleFrames);
end;

procedure OnStopHandler(UserData: Pointer); cdecl;
begin
  Assert(TObject(UserData) is TNetworkRecorder);
  TNetworkRecorder(UserData).OnStop;
end;


{ TNetworkRecorder }

constructor TNetworkRecorder.Create(Host: TSfmlIpAddress; Port: Word);
begin
  inherited Create(OnStartHandler, OnProcessSamplesHandler, OnStopHandler, Self);
  FHost := Host;
  FPort := Port;
end;

function TNetworkRecorder.OnStart: Boolean;
begin
  if FSocket.Connect(FHost, FPort, SfmlTimeZero) = sfSocketDone then
  begin
    WriteLn('Connected to server ', FHost.Address);
    Result := True;
  end
  else
    Result := false;
end;

function TNetworkRecorder.OnProcessSamples(const Samples: PSmallInt; SampleCount: NativeUInt): Boolean;
var
  Packet: TSfmlPacket;
begin
  Packet := TSfmlPacket.Create;
  try
    // Pack the audio samples into a network packet
    Packet.WriteUint8(AudioData);
    Packet.Append(Samples, SampleCount * SizeOf(SmallInt));

    // Send the audio packet to the server
    Result := FSocket.SendPacket(Packet.Handle) = sfSocketDone;
  finally
    Packet.Free;
  end;
end;

procedure TNetworkRecorder.OnStop;
var
  Packet: TSfmlPacket;
begin
  Packet := TSfmlPacket.Create;
  try
    // Send a 'end-of-stream' packet
    Packet.WriteUInt8(EndOfStream);
    FSocket.SendPacket(Packet.Handle);

    // Close the socket
    FSocket.Disconnect;
  finally
    Packet.Free;
  end;
end;

procedure DoClient(Port: Word);
var
  Server: TSfmlIpAddress;
  Recorder: TNetworkRecorder;
begin
  // Check that the device can capture audio
  if not SfmlSoundRecorderIsAvailable then
  begin
    WriteLn('Sorry, audio capture is not supported by your system');
    Halt;
  end;

  // Ask for server address
  repeat
    WriteLn('Type address or name of the server to connect to: ');
    ReadLn(Server.Address);
  until Server.Address <> SfmlIpAddressNone.Address;

  // Create an instance of our custom recorder
  Recorder := TNetworkRecorder.Create(Server, Port);

  // Wait for user input...
  ReadLn;
  WriteLn('Press enter to start recording audio');
  ReadLn;

  // Start capturing audio data
  Recorder.start(44100);
  WriteLn('Recording... press enter to stop');
  ReadLn;
  Recorder.Stop;
end;

end.

