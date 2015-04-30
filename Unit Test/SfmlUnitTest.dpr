program SfmlUnitTest;

{$I ..\Source\Sfml.inc}

{$IFDEF CONSOLE_TESTRUNNER}
{$APPTYPE CONSOLE}
{$ENDIF}

uses
  DUnitTestRunner,
  SfmlSystem in '..\Source\SfmlSystem.pas',
  SfmlWindow in '..\Source\SfmlWindow.pas',
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


