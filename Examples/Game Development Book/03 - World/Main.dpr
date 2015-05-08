program Main;

uses
  SysUtils,
  SfmlGraphics in '..\..\..\Source\SfmlGraphics.pas',
  SfmlSystem in '..\..\..\Source\SfmlSystem.pas',
  SfmlWindow in '..\..\..\Source\SfmlWindow.pas',
  Aircraft in 'Aircraft.pas',
  Entity in 'Entity.pas',
  Game in 'Game.pas',
  SceneNode in 'SceneNode.pas',
  SpriteNode in 'SpriteNode.pas',
  World in 'World.pas',
  TextureHolder in 'TextureHolder.pas';

var
  Game: TGame;
begin
  Game := TGame.Create;
  try
    Game.Run;
  except
    on E: Exception do
      WriteLn('EXCEPTION: ', E.Message);
  end;

  Game.Free;
end.
