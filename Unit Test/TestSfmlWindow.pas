unit TestSfmlWindow;

{$I ..\Source\Sfml.inc}

interface

uses
{$IFNDEF FPC}
  TestFramework,
{$ELSE}
  FPCUnit, TestUtils, TestRegistry,
{$ENDIF}
  SfmlSystem, SfmlWindow;

type
  TestTSfmlVideoMode = class(TTestCase)
  published
    procedure TestDesktopMode;
    procedure TestFullscreenModes;
  end;

  TestTSfmlWindow = class(TTestCase)
  strict private
    FSfmlWindow: TSfmlWindow;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestBasics;
    procedure TestSetTitle;
    procedure TestSetUnicodeTitle;
  end;

implementation

{ TestTSfmlWindow }

procedure TestTSfmlWindow.SetUp;
begin
  FSfmlWindow := TSfmlWindow.Create(SfmlVideoMode(800, 600), 'Test',
    [sfTitleBar, sfResize, sfClose]);
end;

procedure TestTSfmlWindow.TearDown;
begin
  FSfmlWindow.Free;
  FSfmlWindow := nil;
end;

procedure TestTSfmlWindow.TestBasics;
var
  Settings: TSfmlContextSettings;
  Event: TSfmlEvent;
begin
  // get settings
  Settings := FSfmlWindow.GetSettings;

  CheckTrue(FSfmlWindow.IsOpen);

  // bring window to front
  FSfmlWindow.RequestFocus;
  CheckTrue(FSfmlWindow.HasFocus);

  // display window
  FSfmlWindow.Display;

  while FSfmlWindow.IsOpen do
  begin
    // poll event
    if FSfmlWindow.PollEvent(Event) then
      if Event.EventType = sfEvtClosed then
        Break;

    // display window
    FSfmlWindow.Display;

    // wait a little bit
    SfmlSleep(SfmlMilliseconds(10));
  end;

  // close window
  FSfmlWindow.Close;
  CheckFalse(FSfmlWindow.IsOpen);
end;

procedure TestTSfmlWindow.TestSetTitle;
var
  Event: TSfmlEvent;
begin
  FSfmlWindow.SetTitle('ASCII Title');

  while FSfmlWindow.IsOpen do
  begin
    // display window
    FSfmlWindow.Display;

    // wait for event
    if FSfmlWindow.WaitEvent(Event) then
      if Event.EventType = sfEvtClosed then
        Break
  end;

  // close window
  FSfmlWindow.Close;
end;

procedure TestTSfmlWindow.TestSetUnicodeTitle;
var
  Event: TSfmlEvent;
begin
  FSfmlWindow.SetUnicodeTitle(WideCharToUCS4String('Unicode Title'));

  while FSfmlWindow.IsOpen do
  begin
    // display window
    FSfmlWindow.Display;

    // wait for event
    if FSfmlWindow.WaitEvent(Event) then
      if Event.EventType = sfEvtClosed then
        Break
  end;

  // close window
  FSfmlWindow.Close;
end;

{ TestTSfmlVideoMode }

procedure TestTSfmlVideoMode.TestDesktopMode;
var
  VideoMode: TSfmlVideoMode;
begin
  VideoMode := SfmlVideoModeGetDesktopMode;
  CheckTrue(VideoMode.Width > 0);
  CheckTrue(VideoMode.Height > 0);
  CheckTrue(VideoMode.BitsPerPixel > 0);
end;

procedure TestTSfmlVideoMode.TestFullscreenModes;
var
  Index, Count: NativeUInt;
  VideoModes: PSfmlVideoMode;
begin
  VideoModes := SfmlVideoModeGetFullscreenModes(Count);
  CheckTrue(Count > 0);

  for Index := 0 to Count - 1 do
  begin
    CheckTrue(VideoModes^.Width > 0);
    CheckTrue(VideoModes^.Height > 0);
    CheckTrue(VideoModes^.BitsPerPixel > 0);

    Inc(VideoModes);
  end;
end;

initialization
{$IFDEF FPC}
  RegisterTest(TestTSfmlVideoMode);
  RegisterTest(TestTSfmlWindow);
{$ELSE}
  RegisterTest(TestTSfmlVideoMode.Suite);
  RegisterTest(TestTSfmlWindow.Suite);
{$ENDIF}
end.
