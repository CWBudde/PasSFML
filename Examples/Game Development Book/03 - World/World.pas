unit World;

interface

uses
  Aircraft, SceneNode, SpriteNode, TextureHolder, SfmlGraphics, SfmlSystem;

type
  TWorld = class
  type
    TLayer = (
      lBackground,
      lAir
    );

  private
    FWindow: TSfmlRenderWindow;
    FWorldView: TSfmlView;
    FTextures: TTextureHolder;

    FSceneGraph: TSceneNode;
    FSceneLayers: array [TLayer] of TSceneNode;

    FWorldBounds: TSfmlFloatRect;
    FSpawnPosition: TSfmlVector2f;
    FScrollSpeed: Single;
    FPlayerAircraft: TAircraft;
    procedure LoadTextures;
    procedure BuildScene;
  public
    constructor Create(Window: TSfmlRenderWindow);

    procedure Update(dt: TSfmlTime);
    procedure Draw;
  end;

implementation

{ TWorld }

constructor TWorld.Create(Window: TSfmlRenderWindow);
begin
  FWindow := Window;
  FWorldView := Window.DefaultView;
  FWorldBounds := SfmlFloatRect(0, 0, FWorldView.Size.X, 2000);
  FSpawnPosition := SfmlVector2f(FWorldView.Size.X / 2, FWorldBounds.Height - FWorldView.Size.Y / 2);
  FScrollSpeed := -50;
  FPlayerAircraft := nil;
  FSceneGraph := TSceneNode.Create;
  FTextures := TTextureHolder.Create;

  LoadTextures;
  BuildScene;

  // Prepare the view
  FWorldView.Center := FSpawnPosition;
end;

procedure TWorld.Update(dt: TSfmlTime);
var
  Position, Velocity: TSfmlVector2f;
begin
  // Scroll the world
  FWorldView.Move(SfmlVector2f(0, FScrollSpeed * dt.asSeconds));

  // Move the player sidewards (plane scouts follow the main aircraft)
  Position := FPlayerAircraft.Position;
  Velocity := FPlayerAircraft.Velocity;

  // If player touches borders, flip its X Velocity
  if (Position.X <= FWorldBounds.Left + 150)
   or (Position.X >= FWorldBounds.Left + FWorldBounds.Width - 150) then
  begin
    Velocity.X := -Velocity.X;
    FPlayerAircraft.Velocity := Velocity;
  end;

  // Apply movements
  FSceneGraph.Update(dt);
end;

procedure TWorld.Draw;
var
  RenderStates: TSfmlRenderStates;
begin
  FWindow.View := FWorldView;
  FillChar(RenderStates, SizeOf(TSfmlRenderStates), 0);
  RenderStates.BlendMode := SfmlBlendAlpha;
  RenderStates.Transform := SfmlTransformIdentity;
  FSceneGraph.Draw(FWindow, @RenderStates);
//  FWindow.Draw(FSceneGraph);
end;

procedure TWorld.LoadTextures;
begin
  FTextures.Load(tiEagle, '../Resources/Eagle.png');
  FTextures.Load(tiRaptor, '../Resources/Raptor.png');
  FTextures.Load(tiDesert, '../Resources/Desert.png');
end;

procedure TWorld.BuildScene;
var
  i: TLayer;
  Layer: TSceneNode;
  Texture: TSfmlTexture;
  TextureRect: TSfmlIntRect;
  BackgroundSprite: TSpriteNode;
  Leader, LeftEscort, RightEscort: TAircraft;
begin
  // Initialize the different layers
  for i := Low(TLayer) to High(TLayer) do
  begin
    Layer := TSceneNode.Create;
    FSceneLayers[i] := Layer;
    FSceneGraph.AttachChild(Layer);
  end;

  // Prepare the tiled background
  Texture := FTextures.Get(tiDesert);
  TextureRect := FWorldBounds;
  Texture.Repeated := True;

  // Add the background sprite to the scene
  BackgroundSprite := TSpriteNode.Create(Texture, TextureRect);
  BackgroundSprite.Position := SfmlVector2f(FWorldBounds.Left, FWorldBounds.Top);
  FSceneLayers[lBackground].AttachChild(BackgroundSprite);

  // Add player's aircraft
  Leader := TAircraft.Create(atEagle, FTextures);
  FPlayerAircraft := Leader;
  FPlayerAircraft.Position := FSpawnPosition;
  FPlayerAircraft.Velocity := SfmlVector2f(40, FScrollSpeed);
  FSceneLayers[lAir].AttachChild(Leader);

  // Add two escorting aircrafts, placed relatively to the main plane
  LeftEscort := TAircraft.Create(atRaptor, FTextures);
  LeftEscort.Position := SfmlVector2f(-80, 50);
  FPlayerAircraft.AttachChild(LeftEscort);

  RightEscort := TAircraft.Create(atRaptor, FTextures);
  RightEscort.Position := SfmlVector2f(80, 50);
  FPlayerAircraft.AttachChild(RightEscort);
end;

end.
