program HelloWorld;

uses
  SysUtils,
  SfmlAudio in '..\..\Source\SfmlAudio.pas',
  SfmlGraphics in '..\..\Source\SfmlGraphics.pas',
  SfmlNetwork in '..\..\Source\SfmlNetwork.pas',
  SfmlSystem in '..\..\Source\SfmlSystem.pas',
  SfmlWindow in '..\..\Source\SfmlWindow.pas';

var
  Mode: TSfmlVideoMode;
  Window: TSfmlRenderWindow;
  Texture: TSfmlTexture;
  Sprite: TSfmlSprite;
  Font: TSfmlFont;
  Text: TSfmlText;
  Music: TSfmlMusic;
  Event: TSfmlEvent;
  TextPos: TSfmlVector2f;
begin
  Mode.Width := 800;
  Mode.Height := 600;
  Mode.BitsPerPixel := 32;
  if not SfmlVideoModeIsValid(Mode) then
    raise Exception.Create('Invalid video mode');

  Window := TSfmlRenderWindow.Create(Mode, AnsiString('SFML Window'),
    [sfResize, sfClose], nil);
  try
    // Load a sprite to display
    Texture := TSfmlTexture.Create('../Resources/OncaPintada.jpg', nil);
    try
      Sprite := TSfmlSprite.Create;
      try
        Sprite.SetTexture(Texture, True);

        // Create a graphical text to display
        Font := TSfmlFont.Create('../Resources/AdmirationPains.ttf');
        try
          Text := TSfmlText.Create;
          try
            Text.&String := 'Hello World';
            Text.Font := Font.Handle;
            Text.CharacterSize := 50;
            Text.Color := SfmlBlack;
            TextPos.X := 300;
            TextPos.Y := 20;
            Text.Position := TextPos;

            // Load a music to play
            Music := TSfmlMusic.Create('../Resources/OncaPintada.ogg');
            try
              // Play the music
              Music.Play;

              // Start the game loop
              while Window.IsOpen do
              begin
                // Process events
                while Window.PollEvent(Event) do
                begin
                  // Close window : exit
                  if Event.EventType = sfEvtClosed then
                    Window.Close;
                end;

                // Clear the screen
                Window.Clear(SfmlWhite);

                // Draw the sprite
                Window.Draw(Sprite, nil);

                // Draw the text
                Window.Draw(Text, nil);

                // Update the window
                Window.Display;
              end;
            finally
              Music.Free;
            end;
          finally
            Text.Free;
          end;
        finally
          Font.Free;
        end;
      finally
        Sprite.Free;
      end;
    finally
      Texture.Free;
    end;
  finally
    Window.Free;
  end;
end.
