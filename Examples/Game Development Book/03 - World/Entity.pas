unit Entity;

interface

uses
  SceneNode, SfmlSystem;

type
  TEntity = class(TSceneNode)
  private
    FVelocity: TSfmlVector2f;
    procedure SetVelocity(Velocity: TSfmlVector2f);
    function GetVelocity: TSfmlVector2f;
  protected
    procedure UpdateCurrent(dt: TSfmlTime); override;
  public
    property Velocity: TSfmlVector2f read GetVelocity write SetVelocity;
  end;

implementation

procedure TEntity.SetVelocity(Velocity: TSfmlVector2f);
begin
  FVelocity := Velocity;
end;

function TEntity.GetVelocity: TSfmlVector2f;
begin
  Result := FVelocity;
end;

procedure TEntity.UpdateCurrent(dt: TSfmlTime);
begin
  Move(FVelocity.X * dt.AsSeconds, FVelocity.Y * dt.AsSeconds);
end;

end.
