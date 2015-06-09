program Shader;

uses
  SysUtils,
  SfmlAudio in '..\..\Source\SfmlAudio.pas',
  SfmlGraphics in '..\..\Source\SfmlGraphics.pas',
  SfmlNetwork in '..\..\Source\SfmlNetwork.pas',
  SfmlSystem in '..\..\Source\SfmlSystem.pas',
  SfmlWindow in '..\..\Source\SfmlWindow.pas',
  Effect in 'Effect.pas';

type
  TPixelate = class(TEffect)
  private
    FTexture: TSfmlTexture;
    FSprite: TSfmlSprite;
    FShader: TSfmlShader;
  public
    constructor Create;
    function OnLoad: Boolean; override;
    procedure OnUpdate(Time, X, Y: Single); override;
    procedure OnDraw(Target: TSfmlRenderTarget; States: PSfmlRenderStates); override;
  end;

  TWaveBlur = class(TEffect)
  private
    FText: TSfmlText;
    FShader: TSfmlShader;
  public
    constructor Create;
    function OnLoad: Boolean; override;
    procedure OnUpdate(Time, X, Y: Single); override;
    procedure OnDraw(Target: TSfmlRenderTarget; States: PSfmlRenderStates); override;
  end;

  TStormBlink = class(TEffect)
  private
    FPoints: TSfmlVertexArray;
    FShader: TSfmlShader;
  public
    constructor Create;
    function OnLoad: Boolean; override;
    procedure OnUpdate(Time, X, Y: Single); override;
    procedure OnDraw(Target: TSfmlRenderTarget; States: PSfmlRenderStates); override;
  end;

  TEdge = class(TEffect)
  private
    FSurface: TSfmlRenderTexture;
    FBackgroundTexture: TSfmlTexture;
    FEntityTexture: TSfmlTexture;
    FBackgroundSprite: TSfmlSprite;
    FEntities: array of TSfmlSprite;
    FShader: TSfmlShader;
  public
    constructor Create;
    function OnLoad: Boolean; override;
    procedure OnUpdate(Time, X, Y: Single); override;
    procedure OnDraw(Target: TSfmlRenderTarget; States: PSfmlRenderStates); override;
  end;


{ TPixelate }

constructor TPixelate.Create;
begin
  inherited Create('Pixelate');
  FSprite := TSfmlSprite.Create;
end;

procedure TPixelate.OnDraw(Target: TSfmlRenderTarget;
  States: PSfmlRenderStates);
begin
  States.Shader := FShader.Handle;
  Target.Draw(FSprite, States);
end;

function TPixelate.OnLoad: Boolean;
begin
  // Load the texture and initialize the sprite
  Assert(FileExists('../Resources/OncaPintada.jpg'));
  FTexture := TSfmlTexture.Create('../Resources/OncaPintada.jpg');
  FSprite.SetTexture(FTexture);

  // Load the Shader
  Assert(FileExists('../Resources/Pixelate.frag'));
  FShader := TSfmlShader.CreateFromFile('', '../Resources/Pixelate.frag');
  FShader.SetCurrentTextureParameter('texture');
  Result := Assigned(FShader);
end;

procedure TPixelate.OnUpdate(Time, X, Y: Single);
begin
  inherited;
  FShader.SetParameter('pixel_threshold', (X + Y) / 30);
end;


{ TWaveBlur }

constructor TWaveBlur.Create;
begin
  inherited Create('Wave + Blur');
  FText := TSfmlText.Create;
end;

procedure TWaveBlur.OnDraw(Target: TSfmlRenderTarget;
  States: PSfmlRenderStates);
begin
  States.Shader := FShader.Handle;
  Target.Draw(FText, States);
end;

function TWaveBlur.OnLoad: Boolean;
begin
  // Create the text
  FText.&String := 'Praesent suscipit augue in velit pulvinar hendrerit varius purus aliquam.'#10 +
    'Mauris mi odio, bibendum quis fringilla a, laoreet vel orci. Proin vitae vulputate tortor.'#10 +
    'Praesent cursus ultrices justo, ut feugiat ante vehicula quis.'#10 +
    'Donec fringilla scelerisque mauris et viverra.'#10 +
    'Maecenas adipiscing ornare scelerisque. Nullam at libero elit.'#10 +
    'Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.'#10 +
    'Nullam leo urna, tincidunt id semper eget, ultricies sed mi.'#10 +
    'Morbi mauris massa, commodo id dignissim vel, lobortis et elit.'#10 +
    'Fusce vel libero sed neque scelerisque venenatis.'#10 +
    'Integer mattis tincidunt quam vitae iaculis.'#10 +
    'Vivamus fringilla sem non velit venenatis fermentum.'#10 +
    'Vivamus varius tincidunt nisi id vehicula.'#10 +
    'Integer ullamcorper, enim vitae euismod rutrum, massa nisl semper ipsum,'#10 +
    'vestibulum sodales sem ante in massa.'#10 +
    'Vestibulum in augue non felis convallis viverra.'#10 +
    'Mauris ultricies dolor sed massa convallis sed aliquet augue fringilla.'#10 +
    'Duis erat eros, porta in accumsan in, blandit quis sem.'#10 +
    'In hac habitasse platea dictumst. Etiam fringilla est id odio dapibus sit amet semper dui laoreet.'#10;
  FText.Font := Font.Handle;
  FText.CharacterSize := 22;
  FText.Position := SfmlVector2f(30, 20);

  // Load the Shader
  Assert(FileExists('../Resources/Wave.vert'));
  Assert(FileExists('../Resources/Blur.frag'));
  FShader := TSfmlShader.CreateFromFile('../Resources/Wave.vert', '../Resources/Blur.frag');
  Result := Assigned(FShader);
end;

procedure TWaveBlur.OnUpdate(Time, X, Y: Single);
begin
  FShader.SetParameter('wave_phase', Time);
  FShader.SetParameter('wave_amplitude', X * 40, Y * 40);
  FShader.SetParameter('blur_radius', (X + Y) * 0.008);
end;


{ TStormBlink }

constructor TStormBlink.Create;
begin
  inherited Create('Storm + Blink');
  FPoints := TSfmlVertexArray.Create;
end;

procedure TStormBlink.OnDraw(Target: TSfmlRenderTarget;
  States: PSfmlRenderStates);
begin
  States.Shader := FShader.Handle;
  Target.Draw(FPoints, States);
end;

function TStormBlink.OnLoad: Boolean;
var
  Index: Integer;
  X, Y: Single;
  R, G, B: Byte;
begin
  // Create the points
  FPoints.PrimitiveType := sfPoints;
  for Index := 1 to 40000 do
  begin
    x := 800 * Random;
    y := 600 * Random;
    R := Random(256);
    G := Random(256);
    B := Random(256);
    FPoints.Append(SfmlVertex(SfmlVector2f(X, Y), SfmlColorFromRGB(r, g, b)));
  end;

  // Load the Shader
  Assert(FileExists('../Resources/Storm.vert'));
  Assert(FileExists('../Resources/Blink.frag'));
  FShader := TSfmlShader.CreateFromFile('../Resources/Storm.vert', '../Resources/Blink.frag');
  Result := Assigned(FShader);
end;

procedure TStormBlink.OnUpdate(Time, X, Y: Single);
var
  Radius: Single;
begin
  Radius := 200 + Cos(Time) * 150;
  FShader.SetParameter('storm_position', X * 800, Y * 600);
  FShader.SetParameter('storm_inner_radius', Radius / 3);
  FShader.SetParameter('storm_total_radius', Radius);
  FShader.SetParameter('blink_alpha', 0.5 + Cos(Time * 3) * 0.25);
end;


{ TEdge }

constructor TEdge.Create;
begin
  inherited Create('Edge Post-Effect');
  FBackgroundSprite := TSfmlSprite.Create;
end;

procedure TEdge.OnDraw(Target: TSfmlRenderTarget; States: PSfmlRenderStates);
var
  Sprite: TSfmlSprite;
begin
  States.Shader := FShader.Handle;
  Sprite := TSfmlSprite.Create(FSurface.Texture);
  try
    Target.Draw(Sprite, States);
  finally
    Sprite.Free;
  end;
end;

function TEdge.OnLoad: Boolean;
var
  Index: Integer;
  Entity: TSfmlSprite;
begin
  // Create the off-screen surface
  FSurface := TSfmlRenderTexture.Create(800, 600, False);
  FSurface.Smooth := True;

  // Load the textures
  Assert(FileExists('../Resources/Sfml.png'));
  FBackgroundTexture := TSfmlTexture.Create('../Resources/Sfml.png');
  FBackgroundTexture.Smooth := True;
  Assert(FileExists('../Resources/Devices.png'));
  FEntityTexture := TSfmlTexture.Create('../Resources/Devices.png');
  FEntityTexture.Smooth := True;

  // Initialize the background sprite
  FBackgroundSprite.SetTexture(FBackgroundTexture);
  FBackgroundSprite.Position := SfmlVector2f(135, 100);

  // Load the moving entities
  for Index := 0 to 5 do
  begin
    Entity := TSfmlSprite.Create(FEntityTexture, SfmlIntRect(96 * Index, 0, 96, 96));
    SetLength(FEntities, Length(FEntities) + 1);
    FEntities[Length(FEntities) - 1] := Entity;
  end;

  // Load the Shader
  Assert(FileExists('../Resources/Edge.frag'));
  FShader := TSfmlShader.CreateFromFile('', '../Resources/Edge.frag');
  FShader.SetCurrentTextureParameter('texture');

  Result := Assigned(FShader);
end;

procedure TEdge.OnUpdate(Time, X, Y: Single);
var
  Index: Integer;
  Position: TSfmlVector2f;
begin
  FShader.setParameter('edge_threshold', 1 - (x + y) / 2);

  // Update the position of the moving entities
  for Index := 0 to Length(FEntities) - 1 do
  begin
    Position.x := Cos(0.25 * (time * Index + (Length(FEntities) - Index))) * 300 + 350;
    Position.y := Sin(0.25 * (time * (Length(FEntities) - Index) + Index)) * 200 + 250;
    FEntities[Index].Position := Position;
  end;

  // Render the updated scene to the off-screen surface
  FSurface.Clear(SfmlWhite);
  FSurface.Draw(FBackgroundSprite);
  for Index := 0 to Length(FEntities) - 1 do
    FSurface.Draw(FEntities[Index]);
  FSurface.Display;
end;

var
  Window: TSfmlRenderWindow;
  Font: TSfmlFont;
  Description, Instructions: TSfmlText;
  TextBackgroundTexture: TSfmlTexture;
  TextBackground: TSfmlSprite;
  State: TSfmlRenderStates;
  Clock: TSfmlClock;
  Current, Index: Integer;
  Effects: array of TEffect;
  Event: TSfmlEvent;
  X, Y: Single;
begin
  State.BlendMode := SfmlBlendAlpha;
  State.Transform := SfmlTransformIdentity;

  // Create the main Window
  Window := TSfmlRenderWindow.Create(SfmlVideoMode(800, 600), 'SFML Shader',
    [sfTitleBar, sfClose]);
  Window.SetVerticalSyncEnabled(true);

  // Load the application font and pass it to the Effect class
  Font := TSfmlFont.Create('../Resources/sansation.ttf');

  // Create the effects
  SetLength(Effects, 4);
  Effects[0] := TPixelate.Create;
  Effects[1] := TWaveBlur.Create;
  Effects[2] := TStormBlink.Create;
  Effects[3] := TEdge.Create;
  Current := 0;

  // Initialize them
  for Index := Low(Effects) to High(Effects) do
  begin
    Effects[Index].Font := Font;
    Effects[Index].Load;
  end;

  // Create the messages background
  Assert(FileExists('../Resources/Text-Background.png'));
  TextBackgroundTexture := TSfmlTexture.Create('../Resources/Text-Background.png');

  TextBackground := TSfmlSprite.Create;
  TextBackground.SetTexture(TextBackgroundTexture);
  TextBackground.Position := SfmlVector2f(0, 520);
  TextBackground.Color := SfmlColorFromRGBA(255, 255, 255, 200);

  // Create the description text
  Description := TSfmlText.Create('Current effect: ' + Effects[Current].Name, Font, 20);
  Description.Position := SfmlVector2f(10, 530);
  Description.Color := SfmlColorFromRGB(80, 80, 80);

  // Create the instructions text
  Instructions := TSfmlText.Create('Press left and right arrows to change the current shader', Font, 20);
  Instructions.Position := SfmlVector2f(280, 555);
  Instructions.Color := SfmlColorFromRGB(80, 80, 80);

  // Start the game loop
  Clock := TSfmlClock.Create;
  while Window.isOpen do
  begin
    // Process events
    while Window.PollEvent(Event) do
    begin
      // Close Window: exit
      if Event.EventType = sfEvtClosed then
        Window.Close;

      if Event.EventType = sfEvtKeyPressed then
      begin
        case Event.Key.Code of
          // Escape key: exit
          sfKeyEscape:
            Window.Close;

          // Left arrow key: previous Shader
          sfKeyLeft:
            begin
              if Current = 0 then
                Current := Length(Effects) - 1
              else
                Dec(Current);
              Description.&String := 'Current effect: ' + AnsiString(Effects[Current].Name);
            end;

          // Right arrow key: next Shader
          sfKeyRight:
            begin
              if Current = High(Effects) then
                Current := 0
              else
                Inc(Current);
              Description.&String := 'Current effect: ' + AnsiString(Effects[current].Name);
            end;
        end;
      end;
    end;

    // Update the current example
    X := Window.MousePosition.X / Window.Size.X;
    Y := Window.MousePosition.Y / Window.Size.Y;
    Effects[Current].Update(Clock.ElapsedTime.AsSeconds, X, Y);

    // Clear the Window
    Window.Clear(SfmlColorFromRGB(255, 128, 0));

    // Draw the current example
    Effects[Current].Draw(Window, @State);

    // Draw the text
    Window.Draw(TextBackground);
    Window.Draw(Instructions);
    Window.Draw(Description);

    // Finally, display the rendered frame on screen
    Window.Display;
  end;

  // delete the effects
  for Index := Low(Effects) to High(Effects) do
    Effects[Index].Free;
end.
