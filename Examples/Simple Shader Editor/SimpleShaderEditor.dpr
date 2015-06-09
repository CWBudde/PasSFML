program SimpleShaderEditor;

uses
  Vcl.Forms,
  SfmlGraphics in '..\..\Source\SfmlGraphics.pas',
  SfmlSystem in '..\..\Source\SfmlSystem.pas',
  SfmlWindow in '..\..\Source\SfmlWindow.pas',
  MainUnit in 'MainUnit.pas' {FormMain};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.

