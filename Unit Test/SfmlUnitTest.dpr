program SfmlUnitTest;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

{$IFDEF CONSOLE_TESTRUNNER}
{$APPTYPE CONSOLE}
{$ENDIF}

uses
{$IFDEF FPC}
  Interfaces, Forms, GuiTestRunner,
{$ELSE}
  DUnitTestRunner,
{$ENDIF}
  TestSfmlSystem in 'TestSfmlSystem.pas',
  SfmlSystem in '..\Source\SfmlSystem.pas';

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


