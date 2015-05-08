program Resource;

uses
  SysUtils,
  SfmlGraphics in '..\..\..\Source\SfmlGraphics.pas',
  SfmlSystem in '..\..\..\Source\SfmlSystem.pas',
  SfmlWindow in '..\..\..\Source\SfmlWindow.pas',
  ResourceHolder;

var
  Window: TSfmlRenderWindow;
  Landscape, Airplane: TSfmlSprite;
  Textures: TResourceHolder;
  Event: TSfmlEvent;
begin
  Window := TSfmlRenderWindow.Create(SfmlVideoMode(640, 480), 'Resources');
  Window.SetFramerateLimit(20);

  // Try to load resources
  Textures := TResourceHolder.Create;
  try
    Assert(FileExists('../Resources/Desert.png'));
    Textures.Load(tiLandscape, '../Resources/Desert.png');

    Assert(FileExists('../Resources/Eagle.png'));
    Textures.Load(tiAirplane, '../Resources/Eagle.png');
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
