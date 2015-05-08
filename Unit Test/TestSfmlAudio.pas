unit TestSfmlAudio;

{$I ..\Source\Sfml.inc}

interface

uses
  SysUtils,
{$IFNDEF FPC}
  TestFramework,
{$ELSE}
  FPCUnit, TestUtils, TestRegistry,
{$ENDIF}
  SfmlSystem, SfmlAudio;

type
  TestTSfmlMusic = class(TTestCase)
  strict private
    FSfmlMusic: TSfmlMusic;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestPlayPauseStop;
  end;

  TestTSfmlSoundStream = class(TTestCase)
  strict private
    FSfmlSoundStream: TSfmlSoundStream;
  public
    SeekCallbackCalled: Boolean;
    GetDataCallbackCalled: Boolean;
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestPlayPauseStop;
  end;

  TestTSfmlSoundBuffer = class(TTestCase)
  strict private
    FSfmlSoundBuffer: TSfmlSoundBuffer;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestCopyAndTestSamples;
  end;

  TestTSfmlSound = class(TTestCase)
  strict private
    FSfmlSoundBuffer: TSfmlSoundBuffer;
    FSfmlSound: TSfmlSound;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestCopy;
    procedure TestGetBuffer;
    procedure TestSetBuffer;
    procedure TestPlayPauseStop;
  end;

  TestTSfmlSoundBufferRecorder = class(TTestCase)
  strict private
    FSfmlSoundBufferRecorder: TSfmlSoundBufferRecorder;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestStartStop;
  end;

  TestTSfmlSoundRecorder = class(TTestCase)
  strict private
    FSfmlSoundRecorder: TSfmlSoundRecorder;
  public
    StartCallbackCalled: Boolean;
    ProcessCallbackCalled: Boolean;
    StopCallbackCalled: Boolean;
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestStartStop;
  end;

implementation

{ TestTSfmlMusic }

procedure TestTSfmlMusic.SetUp;
begin
  Assert(FileExists('../Resources/OncaPintada.ogg'));
  FSfmlMusic := TSfmlMusic.Create('../Resources/OncaPintada.ogg');
end;

procedure TestTSfmlMusic.TearDown;
begin
  FSfmlMusic.Free;
  FSfmlMusic := nil;
end;

procedure TestTSfmlMusic.TestPlayPauseStop;
begin
  FSfmlMusic.Play;
  SfmlSleep(SfmlMilliseconds(1000));
  FSfmlMusic.Pause;
  SfmlSleep(SfmlMilliseconds(1000));
  FSfmlMusic.Play;
  SfmlSleep(SfmlMilliseconds(1000));
  FSfmlMusic.Stop;
end;


{ TestTSfmlSoundStream }

function GetDataCallback(Chunk: PSfmlSoundStreamChunk;
  UserData: Pointer): Boolean; cdecl;
var
  Index: Integer;
  Data: PSmallInt;
begin
  Assert(TObject(UserData) is TestTSfmlSoundStream);
  TestTSfmlSoundStream(UserData).GetDataCallbackCalled := True;

  // check whether the chuck contains any sample at all
  if Chunk^.SampleCount = 0 then
    Exit(True);

  Data := Chunk^.Samples;
  for Index := 0 to Chunk^.SampleCount - 1 do
  begin
    Data^ := Random(65536) - 32768;
    Inc(Data);
  end;

  Result := True;
end;

procedure SeekCallback(Time: TSfmlTime; UserData: Pointer); cdecl;
begin
  Assert(TObject(UserData) is TestTSfmlSoundStream);
  TestTSfmlSoundStream(UserData).SeekCallbackCalled := True;
end;

procedure TestTSfmlSoundStream.SetUp;
begin
  FSfmlSoundStream := TSfmlSoundStream.Create(GetDataCallback, SeekCallback,
    1, 44100, Self);
end;

procedure TestTSfmlSoundStream.TearDown;
begin
  FSfmlSoundStream.Free;
  FSfmlSoundStream := nil;
end;

procedure TestTSfmlSoundStream.TestPlayPauseStop;
begin
  SeekCallbackCalled := False;
  GetDataCallbackCalled := False;
  FSfmlSoundStream.Play;
  SfmlSleep(SfmlMilliseconds(1000));
  FSfmlSoundStream.Pause;
  SfmlSleep(SfmlMilliseconds(1000));
  FSfmlSoundStream.Stop;

  CheckTrue(SeekCallbackCalled);
  CheckTrue(GetDataCallbackCalled);
end;


{ TestTSfmlSoundBuffer }

procedure TestTSfmlSoundBuffer.SetUp;
begin
  Assert(FileExists('../Resources/OncaPintada.ogg'));
  FSfmlSoundBuffer := TSfmlSoundBuffer.Create('../Resources/OncaPintada.ogg');
end;

procedure TestTSfmlSoundBuffer.TearDown;
begin
  FSfmlSoundBuffer.Free;
  FSfmlSoundBuffer := nil;
end;

procedure TestTSfmlSoundBuffer.TestCopyAndTestSamples;
var
  NewBuffer: TSfmlSoundBuffer;
  Samples: array [0 .. 1] of PSmallInt;
  Index: Integer;
begin
  NewBuffer := FSfmlSoundBuffer.Copy;
  try
    CheckEquals(FSfmlSoundBuffer.ChannelCount, NewBuffer.ChannelCount);
    CheckEquals(FSfmlSoundBuffer.Duration.MicroSeconds, NewBuffer.Duration.MicroSeconds);
    CheckEquals(FSfmlSoundBuffer.SampleCount, NewBuffer.SampleCount);

    Samples[0] := FSfmlSoundBuffer.GetSamples;
    Samples[1] := NewBuffer.GetSamples;

    for Index := 0 to FSfmlSoundBuffer.SampleCount - 1 do
    begin
      CheckEquals(Samples[0]^, Samples[1]^);
      Inc(Samples[0]);
      Inc(Samples[1]);
    end;
  finally
    NewBuffer.Free;
  end;
end;


{ TestTSfmlSound }

procedure TestTSfmlSound.SetUp;
begin
  Assert(FileExists('../Resources/OncaPintada.ogg'));
  FSfmlSoundBuffer := TSfmlSoundBuffer.Create('../Resources/OncaPintada.ogg');
  FSfmlSound := TSfmlSound.Create(FSfmlSoundBuffer);
end;

procedure TestTSfmlSound.TearDown;
begin
  FSfmlSound.Free;
  FSfmlSound := nil;
  FSfmlSoundBuffer.Free;
  FSfmlSoundBuffer := nil;
end;

procedure TestTSfmlSound.TestCopy;
var
  ReturnValue: TSfmlSound;
begin
  ReturnValue := FSfmlSound.Copy;
  try
    CheckEquals(FSfmlSound.Attenuation, ReturnValue.Attenuation);
    CheckEquals(Pointer(FSfmlSound.GetBuffer), Pointer(ReturnValue.GetBuffer));
    CheckEquals(FSfmlSound.Loop, ReturnValue.Loop);
    CheckEquals(FSfmlSound.MinDistance, ReturnValue.MinDistance);
    CheckEquals(FSfmlSound.Pitch, ReturnValue.Pitch);
    CheckEquals(FSfmlSound.PlayingOffset.MicroSeconds, ReturnValue.PlayingOffset.MicroSeconds);
    CheckEquals(FSfmlSound.Position.X, ReturnValue.Position.X);
    CheckEquals(FSfmlSound.Position.Y, ReturnValue.Position.Y);
    CheckEquals(FSfmlSound.Position.Z, ReturnValue.Position.Z);
    CheckEquals(FSfmlSound.RelativeToListener, ReturnValue.RelativeToListener);
    CheckEquals(Integer(FSfmlSound.Status), Integer(ReturnValue.Status));
    CheckEquals(FSfmlSound.Volume, ReturnValue.Volume);
  finally
    ReturnValue.Free;
  end;
end;

procedure TestTSfmlSound.TestGetBuffer;
var
  ReturnValue: PSfmlSoundBuffer;
begin
  ReturnValue := FSfmlSound.GetBuffer;
  CheckEquals(Pointer(FSfmlSoundBuffer.Handle), Pointer(ReturnValue));
end;

procedure TestTSfmlSound.TestSetBuffer;
begin
  FSfmlSound.SetBuffer(nil);
//  CheckEquals(nil, FSfmlSound.GetBuffer);
  FSfmlSound.SetBuffer(FSfmlSoundBuffer);
  CheckEquals(Pointer(FSfmlSoundBuffer.Handle), Pointer(FSfmlSound.GetBuffer));
end;

procedure TestTSfmlSound.TestPlayPauseStop;
begin
  FSfmlSound.Play;
  SfmlSleep(SfmlMilliseconds(1000));
  FSfmlSound.Pause;
  SfmlSleep(SfmlMilliseconds(1000));
  FSfmlSound.Stop;
end;


{ TestTSfmlSoundBufferRecorder }

procedure TestTSfmlSoundBufferRecorder.SetUp;
begin
  FSfmlSoundBufferRecorder := TSfmlSoundBufferRecorder.Create;
end;

procedure TestTSfmlSoundBufferRecorder.TearDown;
begin
  FSfmlSoundBufferRecorder.Free;
  FSfmlSoundBufferRecorder := nil;
end;

procedure TestTSfmlSoundBufferRecorder.TestStartStop;
var
  SampleRate: Cardinal;
  Buffer: PSfmlSoundBuffer;
begin
  SampleRate := 44100;
  FSfmlSoundBufferRecorder.Start(SampleRate);
  SfmlSleep(SfmlMilliseconds(1000));
  FSfmlSoundBufferRecorder.Stop;

  Buffer := FSfmlSoundBufferRecorder.GetBuffer;
  CheckTrue(SfmlSoundBufferGetSampleCount(Buffer) > 44000);
end;


{ TestTSfmlSoundRecorder }

function StartCallback(UserData: Pointer): Boolean; cdecl;
begin
  Assert(TObject(UserData) is TestTSfmlSoundRecorder);

  TestTSfmlSoundRecorder(UserData).StartCallbackCalled := True;

  Result := True;
end;

function ProcessCallback(Data: PSmallInt; SampleFrames: NativeUInt; UserData: Pointer): Boolean; cdecl;
begin
  Assert(TObject(UserData) is TestTSfmlSoundRecorder);

  TestTSfmlSoundRecorder(UserData).ProcessCallbackCalled := True;

  Result := True;
end;

procedure StopCallback(UserData: Pointer); cdecl;
begin
  Assert(TObject(UserData) is TestTSfmlSoundRecorder);

  TestTSfmlSoundRecorder(UserData).StopCallbackCalled := True;
end;

procedure TestTSfmlSoundRecorder.SetUp;
begin
  FSfmlSoundRecorder := TSfmlSoundRecorder.Create(StartCallback,
    ProcessCallback, StopCallback, Self);
end;

procedure TestTSfmlSoundRecorder.TearDown;
begin
  FSfmlSoundRecorder.Free;
  FSfmlSoundRecorder := nil;
end;

procedure TestTSfmlSoundRecorder.TestStartStop;
begin
  if not SfmlSoundRecorderIsAvailable then
    Exit;

  // reset callback called flags
  StartCallbackCalled := False;
  ProcessCallbackCalled := False;
  StopCallbackCalled := False;

  // check device
  CheckTrue(FSfmlSoundRecorder.Device <> '');

  // set processing time (10 times a second)
  FSfmlSoundRecorder.SetProcessingInterval(SfmlMilliseconds(100));

  // start & stop recording (approx. 1 second)
  FSfmlSoundRecorder.Start(44100);
  SfmlSleep(SfmlMilliseconds(1000));
  CheckEquals(44100, FSfmlSoundRecorder.SampleRate);
  FSfmlSoundRecorder.Stop;
  SfmlSleep(SfmlMilliseconds(100));

  // check whether the callback has been called
  CheckTrue(StartCallbackCalled, 'StartCallback not called');
  CheckTrue(ProcessCallbackCalled, 'ProcessCallback not called');
  CheckTrue(StopCallbackCalled, 'StopCallback not called');
end;

initialization
{$IFDEF FPC}
  RegisterTest(TestTSfmlMusic);
  RegisterTest(TestTSfmlSoundStream);
  RegisterTest(TestTSfmlSoundBuffer);
  RegisterTest(TestTSfmlSound);
  RegisterTest(TestTSfmlSoundBufferRecorder);
  RegisterTest(TestTSfmlSoundRecorder);
{$ELSE}
  RegisterTest('SfmlAudio', TestTSfmlMusic.Suite);
  RegisterTest('SfmlAudio', TestTSfmlSoundStream.Suite);
  RegisterTest('SfmlAudio', TestTSfmlSoundBuffer.Suite);
  RegisterTest('SfmlAudio', TestTSfmlSound.Suite);
  RegisterTest('SfmlAudio', TestTSfmlSoundBufferRecorder.Suite);
  RegisterTest('SfmlAudio', TestTSfmlSoundRecorder.Suite);
{$ENDIF}
end.
