unit TestSfmlSystem;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses
{$IFnDEF FPC}
  TestFramework,
{$ELSE}
  FPCUnit, TestUtils, TestRegistry,
{$ENDIF}
  SfmlSystem;

type
  TestTSfmlTime = class(TTestCase)
  published
    procedure TestTimeZero;

    procedure TestTimeAsSeconds;
    procedure TestTimeAsMilliseconds;
    procedure TestTimeAsMicroseconds;

    procedure TestSeconds;
    procedure TestMilliseconds;
    procedure TestMicroseconds;
  end;

  TestTSfmlClock = class(TTestCase)
  strict private
    FSfmlClock: TSfmlClock;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestCopy;
    procedure TestElapsedTime;
    procedure TestRestart;
  end;

  TestTSfmlThread = class(TTestCase)
  strict private
    FSfmlThread: TSfmlThread;
  public
    Signal: Boolean;
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestLaunchWait;
    procedure TestLaunchTerminate;
  end;

implementation

{ TestTSfmlTime }

procedure TestTSfmlTime.TestMicroseconds;
var
  Time: TSfmlTime;
  Microseconds: Int64;
begin
  Microseconds := 1234;
  Time := SfmlMicroseconds(Microseconds);
  CheckEquals(Microseconds, Time.MicroSeconds);
end;

procedure TestTSfmlTime.TestMilliseconds;
var
  Time: TSfmlTime;
  Milleseconds: LongInt;
begin
  Milleseconds := 1234;
  Time := SfmlMilliseconds(Milleseconds);
  CheckEquals(1000 * Milleseconds, Time.MicroSeconds);
end;

procedure TestTSfmlTime.TestSeconds;
var
  Time: TSfmlTime;
  Seconds: Single;
begin
  Seconds := 1;
  Time := SfmlSeconds(Seconds);
  CheckEquals(Round(Seconds * 1000000), Time.MicroSeconds);
end;

procedure TestTSfmlTime.TestTimeAsMicroseconds;
var
  Time: TSfmlTime;
  Microseconds: Int64;
begin
  Time.MicroSeconds := 1234;
  Microseconds := SfmlTimeAsMicroseconds(Time);
  CheckEquals(Time.MicroSeconds, Microseconds);
end;

procedure TestTSfmlTime.TestTimeAsMilliseconds;
var
  Time: TSfmlTime;
  Milliseconds: LongInt;
begin
  Time.MicroSeconds := 1234000;
  Milliseconds := SfmlTimeAsMilliseconds(Time);
  CheckEquals(Time.MicroSeconds div 1000, Milliseconds);
end;

procedure TestTSfmlTime.TestTimeAsSeconds;
var
  Time: TSfmlTime;
  Seconds: Single;
begin
  Time.MicroSeconds := 1000000;
  Seconds := SfmlTimeAsSeconds(Time);
  CheckEquals(Time.MicroSeconds / 1000000, Seconds);
end;

procedure TestTSfmlTime.TestTimeZero;
var
  ReturnValue: TSfmlTime;
begin
  ReturnValue := SfmlTimeZero;
  CheckEquals(ReturnValue.MicroSeconds, 0);
end;


{ TestTSfmlClock }

procedure TestTSfmlClock.SetUp;
begin
  FSfmlClock := TSfmlClock.Create;
end;

procedure TestTSfmlClock.TearDown;
begin
  FSfmlClock.Free;
  FSfmlClock := nil;
end;

procedure TestTSfmlClock.TestCopy;
var
  CopiedClock: TSfmlClock;
  TimeStamp: array [0..1] of TSfmlTime;
begin
  CopiedClock := FSfmlClock.Copy;
  TimeStamp[0] := CopiedClock.ElapsedTime;
  TimeStamp[1] := FSfmlClock.ElapsedTime;
  CheckTrue(TimeStamp[1].MicroSeconds >= TimeStamp[0].MicroSeconds);
end;

procedure TestTSfmlClock.TestElapsedTime;
var
  TimeStamp: array [0..1] of TSfmlTime;
begin
  TimeStamp[0] := FSfmlClock.ElapsedTime;
  SfmlSleep(SfmlTime(100000));
  TimeStamp[1] := FSfmlClock.ElapsedTime;

  CheckTrue(TimeStamp[1].MicroSeconds > TimeStamp[0].MicroSeconds);
end;

procedure TestTSfmlClock.TestRestart;
var
  TimeStamp: array [0..1] of TSfmlTime;
begin
  SfmlSleep(SfmlTime(100000));
  TimeStamp[0] := FSfmlClock.Restart;
  TimeStamp[1] := FSfmlClock.Restart;

  CheckTrue(TimeStamp[1].MicroSeconds < TimeStamp[0].MicroSeconds);
end;


{ TestTSfmlThread }

procedure TestFunction(UserData: Pointer); cdecl;
begin
  // sleep one second
//  SfmlSleep(SfmlSeconds(1));

  // set signal
  Assert(TObject(UserData) is TestTSfmlThread);
  TestTSfmlThread(UserData).Signal := True;
end;

procedure TestTSfmlThread.SetUp;
begin
  FSfmlThread := TSfmlThread.Create(@TestFunction, Self);
end;

procedure TestTSfmlThread.TearDown;
begin
  FSfmlThread.Free;
  FSfmlThread := nil;
end;

procedure TestTSfmlThread.TestLaunchWait;
begin
  Signal := False;
  FSfmlThread.Launch;
  FSfmlThread.Wait;
  CheckTrue(Signal);
end;

procedure TestTSfmlThread.TestLaunchTerminate;
begin
  Signal := False;
  FSfmlThread.Launch;
  FSfmlThread.Terminate;
  CheckFalse(Signal, 'Thread terminated too late');
end;

initialization
{$IFDEF FPC}
  RegisterTest(TestTSfmlTime);
  RegisterTest(TestTSfmlClock);
  RegisterTest(TestTSfmlThread);
{$ELSE}
  RegisterTest(TestTSfmlTime.Suite);
  RegisterTest(TestTSfmlClock.Suite);
  RegisterTest(TestTSfmlThread.Suite);
{$ENDIF}
end.
