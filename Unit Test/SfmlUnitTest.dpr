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
  SfmlSystem in '..\Source\SfmlSystem.pas',
  SfmlWindow in '..\Source\SfmlWindow.pas',
  SfmlAudio in '..\Source\SfmlAudio.pas',
  TestSfmlSystem in 'TestSfmlSystem.pas',
  TestSfmlWindow in 'TestSfmlWindow.pas',
  TestSfmlAudio in 'TestSfmlAudio.pas';

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


