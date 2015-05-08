unit SceneNode;

interface

uses
  SfmlGraphics, SfmlSystem, SfmlWindow;

type
  TSceneNode = class(TSfmlTransformable) //SfmlTransformable, public SfmlDrawable, private SfmlNonCopyable
  private
    FChildren: array of TSceneNode;
    FParent: TSceneNode;
    procedure UpdateChildren(dt: TSfmlTime);
    procedure DrawChildren(Target: TSfmlRenderTarget; States: PSfmlRenderStates);
  protected
    procedure UpdateCurrent(dt: TSfmlTime); virtual;
    procedure Draw(Target: TSfmlRenderTarget; States: PSfmlRenderStates); virtual;
    procedure DrawCurrent(Target: TSfmlRenderTarget; States: PSfmlRenderStates); virtual;
  public
    constructor Create;

    procedure AttachChild(Child: TSceneNode);
    function DetachChild(const Node: TSceneNode): TSceneNode;

    procedure Update(dt: TSfmlTime);

    function GetWorldPosition: TSfmlVector2f;
    function GetWorldTransform: TSfmlTransform;
  end;

implementation

{ TSceneNode }

constructor TSceneNode.Create;
begin
  inherited Create;
  FParent := nil;
  SetLength(FChildren, 0);
end;

procedure TSceneNode.AttachChild(Child: TSceneNode);
var
  Position: Integer;
begin
  Child.FParent := Self;
  Position := Length(FChildren);
  SetLength(FChildren, Position + 1);
  FChildren[Position] := Child;
end;

function TSceneNode.DetachChild(const Node: TSceneNode): TSceneNode;
var
  Index: Integer;
begin
  Result := nil;
  for Index := Low(FChildren) to High(FChildren) do
  begin
    if FChildren[Index] = Node then
    begin
      Node.FParent := nil;
      Result := Node;
      if Index < High(FChildren) then
        System.Move(FChildren[Index + 1], FChildren[Index], (High(FChildren) - Index) * SizeOf(TSceneNode));
      SetLength(FChildren, High(FChildren));
      Exit;
    end;
  end;
end;

procedure TSceneNode.Update(dt: TSfmlTime);
begin
  UpdateCurrent(dt);
  UpdateChildren(dt);
end;

procedure TSceneNode.UpdateCurrent(dt: TSfmlTime);
begin
  // Do nothing by default
end;

procedure TSceneNode.UpdateChildren(dt: TSfmlTime);
var
  Index: Integer;
begin
  for Index := Low(FChildren) to High(FChildren) do
    FChildren[Index].Update(dt);
end;

procedure TSceneNode.Draw(Target: TSfmlRenderTarget; States: PSfmlRenderStates);
begin
  // Apply transform of current node
  States.Transform := States.Transform * Transform; // eventually use this in case of an error: SfmlTransformCombine(States.Transform, @Transform);

  // Draw node and children with changed transform
  DrawCurrent(Target, States);
  DrawChildren(Target, States);
end;

procedure TSceneNode.DrawCurrent(Target: TSfmlRenderTarget; States: PSfmlRenderStates);
begin
  // Do nothing by default
end;

procedure TSceneNode.DrawChildren(Target: TSfmlRenderTarget; States: PSfmlRenderStates);
var
  Index: Integer;
begin
  for Index := Low(FChildren) to High(FChildren) do
    FChildren[Index].Draw(Target, States);
end;

function TSceneNode.GetWorldPosition: TSfmlVector2f;
begin
  Result := GetWorldTransform * SfmlVector2f(1, 1); // was SfmlVector2f( , )
end;

function TSceneNode.getWorldTransform: TSfmlTransform;
var
  Node: TSceneNode;
begin
  Result := SfmlTransformIdentity;
  Node := Self;
  repeat
    Result := Node.Transform * Result;
    Node := Node.FParent;
  until Node = nil;
end;

end.
