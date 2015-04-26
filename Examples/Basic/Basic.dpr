program Basic;

{$R *.res}

uses
  SysUtils,
  SfmlGraphics in '..\..\Source\SfmlGraphics.pas',
  SfmlSystem in '..\..\Source\SfmlSystem.pas',
  SfmlWindow in '..\..\Source\SfmlWindow.pas';

procedure RunApp;
var
  Mode: TSfmlVideoMode;
  Window: PSfmlRenderWindow;
  Texture: PSfmlTexture;
  Sprite: PSfmlSprite;
  Font: PSfmlFont;
  Text: PSfmlText;
{$IFDEF Music}
  Music: PSfmlMusic;
{$ENDIF}
  Event: TSfmlEvent;

begin
  Mode.Width := 800;
  Mode.Height := 600;
  Mode.BitsPerPixel := 32;
  if SfmlVideoModeIsValid(Mode) = sfFalse then
    raise Exception.Create('Invalid video mode');

  Window := SfmlRenderWindowCreate(Mode, 'SFML Window', [sfResize, sfClose], nil);
  if not Assigned(Window) then
    raise Exception.Create('Window error');

  // Load a Sprite to display
  Texture := SfmlTextureCreateFromFile('example.jpg', nil);
  if not Assigned(Texture) then
    raise Exception.Create('Texture error');
  Sprite := SfmlSpriteCreate;
  SfmlSpriteSetTexture(Sprite, texture, sfTrue);

  // Create a graphical Text to display
  Font := SfmlFontCreateFromFile('arial.ttf');
  if not assigned(Font) then
    raise Exception.Create('Font error');
  Text := SfmlTextCreate;
  SfmlTextSetString(Text, 'Hello SFML');
  SfmlTextSetFont(Text, font);
  SfmlTextSetCharacterSize(Text, 50);

{$IFDEF Music}
  // Load a music to play
  music = sfMusic_createFromFile('nice_music.ogg');
  if (!music)
    raise Exception.Create('Music error');

  // Play the music
  sfMusic_play(music);
{$ENDIF}

  // Start the game loop
  while SfmlRenderWindowIsOpen(Window) = sfTrue do
  begin
    // Process events
    while SfmlRenderWindowPollEvent(Window, @Event) = sfTrue do
    begin
      // Close Window : exit
      if Event.EventType = sfEvtClosed then
        SfmlRenderWindowClose(Window);
    end;

    // Clear the screen
    SfmlRenderWindowClear(Window, SfmlBlack);

    // Draw the sprite
    SfmlRenderWindowDrawSprite(Window, Sprite, nil);

    // Draw the text
    SfmlRenderWindowDrawText(Window, Text, nil);

    // Update the window
    SfmlRenderWindowDisplay(Window);
  end;

  // Cleanup resources
{$IFDEF Music}
  SfmlMusicDestroy(music);
{$ENDIF}
  SfmlTextDestroy(Text);
  SfmlFontDestroy(Font);
  SfmlSpriteDestroy(Sprite);
  SfmlTextureDestroy(Texture);
  SfmlRenderWindowDestroy(Window);
end;

begin
  RunApp;
end.

