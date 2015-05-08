unit SpriteNode;

interface

uses
  SceneNode, SfmlGraphics;

type
  TSpriteNode = class(TSceneNode)
  private
    FSprite: TSfmlSprite;
  protected
    procedure DrawCurrent(Target: TSfmlRenderTarget; States: PSfmlRenderStates); override;
  public
    constructor Create(const Texture: TSfmlTexture); overload;
    constructor Create(const Texture: TSfmlTexture; const TextureRect: TSfmlIntRect); overload;
  end;

implementation

{ TSpriteNode }

constructor TSpriteNode.Create(const Texture: TSfmlTexture);
begin
  inherited Create;
  FSprite := TSfmlSprite.Create(Texture);
end;

constructor TSpriteNode.Create(const Texture: TSfmlTexture; const TextureRect: TSfmlIntRect);
begin
  inherited Create;
  FSprite := TSfmlSprite.Create(Texture, TextureRect);
end;

procedure TSpriteNode.DrawCurrent(Target: TSfmlRenderTarget; States: PSfmlRenderStates);
begin
  Target.Draw(FSprite, States);
end;

end.
