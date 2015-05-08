unit Aircraft;

interface

uses
  Entity, TextureHolder, SfmlSystem, SfmlGraphics;

type
  TAircraft = class(TEntity)
  type
    TAircraftType = (
      atEagle,
      atRaptor
    );
  private
    FType: TAircraftType;
    FSprite: TSfmlSprite;
  public
    procedure DrawCurrent(Target: TSfmlRenderTarget; States: PSfmlRenderStates); override;
    constructor Create(AircraftType: TAircraftType; Textures: TTextureHolder);
  end;

implementation

function ToTextureID(AircraftType: TAircraft.TAircraftType): TTextureID;
begin
  case AircraftType of
    atEagle:
      Result := tiEagle;
    atRaptor:
      Result := tiRaptor;
    else
      Result := tiEagle;
  end;
end;

{ TAircraft }

constructor TAircraft.Create(AircraftType: TAircraftType; Textures: TTextureHolder);
var
  Bounds: TSfmlFloatRect;
begin
  inherited Create;

  FType := AircraftType;
  FSprite := TSfmlSprite.Create(Textures.Get(toTextureID(AircraftType)));

  Bounds := FSprite.LocalBounds;
  FSprite.Origin := SfmlVector2f(0.5 * Bounds.Width, 0.5 * Bounds.Height);
end;

procedure TAircraft.DrawCurrent(Target: TSfmlRenderTarget; States: PSfmlRenderStates);
begin
  Target.Draw(FSprite, States);
end;

end.

