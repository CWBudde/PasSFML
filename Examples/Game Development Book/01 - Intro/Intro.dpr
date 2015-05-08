program Intro;

uses
  SysUtils,
  SfmlGraphics in '..\..\..\Source\SfmlGraphics.pas',
  SfmlSystem in '..\..\..\Source\SfmlSystem.pas',
  SfmlWindow in '..\..\..\Source\SfmlWindow.pas',
  Game in 'Game.pas';

var
  Game: TGame;
begin
  Game := TGame.Create;
  try
    Game.Run;
  finally
    Game.Free;
  end;
end.
