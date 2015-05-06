unit Server;

interface

uses
  SysUtils,
  SfmlAudio, SfmlNetwork, SfmlSystem;

const
  AudioData   = 1;
  EndOfStream = 2;

type
  TNetworkAudioStream = class(TSfmlSoundStream)
  private
    ////////////////////////////////////////////////////////////
    // Member data
    ////////////////////////////////////////////////////////////
    FListener: TSfmlTcpListener;
    FClient: TSfmlTcpSocket;
    FMutex: TSfmlMutex;
    FSamples: array of SmallInt;
    FTempBuffer: array of SmallInt;
    FOffset: Integer;
    FHasFinished: Boolean;

    function OnGetData(Data: PSfmlSoundStreamChunk): Boolean; virtual;
    procedure OnSeek(TimeOffset: TSfmlTime); virtual;

    procedure ReceiveLoop;
  public
    constructor Create;

    procedure Start(Port: Byte);
  end;

procedure DoServer(Port: Word);

implementation


function OnGetDataHandler(Chunk: PSfmlSoundStreamChunk; UserData: Pointer): Boolean; cdecl;
begin
  Assert(TObject(UserData) is TNetworkAudioStream);
  Result := TNetworkAudioStream(UserData).OnGetData(Chunk);
end;

procedure OnSeekHandler(TimeOffset: TSfmlTime; UserData: Pointer); cdecl;
begin
  Assert(TObject(UserData) is TNetworkAudioStream);
  TNetworkAudioStream(UserData).OnSeek(TimeOffset);
end;


{ TNetworkAudioStream }

constructor TNetworkAudioStream.Create;
begin
  FOffset := 0;
  FHasFinished := False;

  // Set the sound parameters
  inherited Create(OnGetDataHandler, OnSeekHandler, 1, 44100, Self);
end;


procedure TNetworkAudioStream.ReceiveLoop;
var
  Packet: TSfmlPacket;
  ID: Byte;
  Samples: PSmallInt;
  SampleCount, Pos: Integer;
begin
  Packet := TSfmlPacket.Create;
  try
    while not FHasFinished do
    begin
      // Get waiting audio data from the network
      if (FClient.ReceivePacket(Packet.Handle) <> sfSocketDone) then
        Break;

      // Extract the message ID
      ID := Packet.ReadUint8;

      if ID = AudioData then
      begin
        // Extract audio samples from the packet, and append it to our samples buffer
        Samples := Packet.GetData;
        SampleCount := (Packet.DataSize - 1) div SizeOf(SmallInt);

        // Don't forget that the other thread can access the sample array at any time
        // (so we protect any operation on it with the mutex)
        begin
          FMutex.Lock;
          Pos := Length(FSamples);
          SetLength(FSamples, Length(FSamples) + SampleCount);
          Move(Samples, FSamples[Pos], SampleCount);
        end;
      end
      else if ID = EndOfStream then
      begin
        // End of stream reached: we stop receiving audio data
        WriteLn('Audio data has been 100% received!');
        FHasFinished := True;
      end
      else
      begin
        // Something's wrong...
        WriteLn('Invalid packet received...');
        FHasFinished := True;
      end;
    end;
  finally
    Packet.Free;
  end;
end;

function TNetworkAudioStream.OnGetData(Data: PSfmlSoundStreamChunk): Boolean;
begin
  // We have reached the end of the buffer and all audio data have been played: we can stop playback
  if ((FOffset >= Length(FSamples)) and FHasFinished) then
    Exit(False);

  // No new data has arrived since last update: wait until we get some
  while ((FOffset >= Length(FSamples)) and not FHasFinished) do
    SfmlSleep(SfmlMilliseconds(10));

  // Copy samples into a local buffer to avoid synchronization problems
  // (don't forget that we run in two separate threads)
  FMutex.Lock;
  try
    // TODO:
//    FTempBuffer.Assign(FSamples[FOffset], FSamples[Length(FSamples)]);
  finally
    FMutex.Unlock;
  end;

  // Fill audio data to pass to the stream
  Data.Samples     := @FTempBuffer[0];
  Data.SampleCount := Length(FTempBuffer);

  // Update the playing offset
  FOffset := FOffset + Length(FTempBuffer);

  Result := True;
end;

procedure TNetworkAudioStream.OnSeek(TimeOffset: TSfmlTime);
begin
  FOffset := TimeOffset.asMilliseconds * Integer(SampleRate * ChannelCount div 1000);
end;

procedure TNetworkAudioStream.Start(Port: Byte);
begin
  if not FHasFinished then
  begin
    // Listen to the given port for incoming connections
    if (FListener.listen(port) <> sfSocketDone) then
      Exit;

    WriteLn('Server is listening to port ', Port, ', waiting for connections... ');

    // Wait for a connection
    if (FListener.Accept(FClient) <> sfSocketDone)
      Exit;
    WriteLn('Client connected: ', FClient.getRemoteAddress.Address);

    // Start playback
    Play;

    // Start receiving audio data
    ReceiveLoop;
  end
  else
  begin
    // Start playback
    play;
  end;
end;

procedure DoServer(Port: Word);
var
  AudioStream: TNetworkAudioStream;
begin
  AudioStream := TNetworkAudioStream.Create;

  // Build an audio stream to play sound data as it is received through the network
  AudioStream.Start(Port);

  // Loop until the sound playback is finished
  while AudioStream.Status <> sfStopped do
  begin
    // Leave some CPU time for other threads
    SfmlSleep(SfmlMilliseconds(100));
  end;

  ReadLn;

  // Wait until the user presses 'enter' key
  WriteLn('Press enter to replay the sound...');
  ReadLn;

  // Replay the sound (just to make sure replaying the received data is OK)
  AudioStream.Play;

  // Loop until the sound playback is finished
  while (AudioStream.Status <> sfStopped) do
  begin
    // Leave some CPU time for other threads
    SfmlSleep(SfmlMilliseconds(100));
  end;
end;

end.
