program SfmlUnitTest;

{$I ..\Source\Sfml.inc}

{$IFDEF CONSOLE_TESTRUNNER}
{$APPTYPE CONSOLE}
{$ENDIF}

uses
  {$IFDEF FPC}
  Interfaces, Forms, GuiTestRunner,
  {$ELSE}
  DUnitTestRunner,
  {$ENDIF}
  SfmlAudio in '..\Source\SfmlAudio.pas',
  SfmlGraphics in '..\Source\SfmlGraphics.pas',
  SfmlNetwork in '..\Source\SfmlNetwork.pas',
  SfmlSystem in '..\Source\SfmlSystem.pas',
  SfmlWindow in '..\Source\SfmlWindow.pas',
  TestSfmlAudio in 'TestSfmlAudio.pas',
  TestSfmlGraphics in 'TestSfmlGraphics.pas',
  TestSfmlSystem in 'TestSfmlSystem.pas',
  TestSfmlWindow in 'TestSfmlWindow.pas';

{$R *.res}

begin
{$IFDEF FPC}
  Application.Initialize;
  Application.CreateForm(TGuiTestRunner, TestRunner);
  Application.Run;
{$ELSE}
  DUnitTestRunner.RunRegisteredTests;
{$ENDIF}
end.
