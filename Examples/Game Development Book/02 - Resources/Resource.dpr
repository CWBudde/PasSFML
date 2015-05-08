program Resource;

uses
  SysUtils,
  SfmlGraphics in '..\..\..\Source\SfmlGraphics.pas',
  SfmlSystem in '..\..\..\Source\SfmlSystem.pas',
  SfmlWindow in '..\..\..\Source\SfmlWindow.pas';

type
  TTextureID = (tiLandscape, tiAirplane);

var
  Window: TSfmlRenderWindow;
  Landscape, Airplane: TSfmlSprite;
  Textures: array [TTextureID] of TSfmlTexture;
  Event: TSfmlEvent;
begin
  Window := TSfmlRenderWindow.Create(SfmlVideoMode(640, 480), 'Resources');
  Window.SetFramerateLimit(20);

  // Try to load resources
  try
    Assert(FileExists('../Resources/Desert.png'));
    Textures[tiLandscape] := TSfmlTexture.Create('../../Textures/Desert.png');

    Assert(FileExists('../Resources/Eagle.png'));
    Textures[tiAirplane] := TSfmlTexture.Create('../../Textures/Eagle.png');
  except
    on E: Exception do
      WriteLn('Exception: ', e.Message);
  end;

  // Access resources
  Landscape := TSfmlSprite.Create(Textures[tiLandscape]);
  Airplane := TSfmlSprite.Create(Textures[tiAirplane]);
  Airplane.Position := SfmlVector2f(200, 200);

  while Window.isOpen do
  begin
    while Window.PollEvent(Event) do
      if (Event.EventType = sfEvtKeyPressed) or (Event.EventType = sfEvtClosed) then
        Halt;

    Window.Clear;
    Window.Draw(Landscape);
    Window.Draw(Airplane);
    Window.Display;
  end;
end.
