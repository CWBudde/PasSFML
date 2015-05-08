unit ResourceHolder;

interface

uses
  SysUtils, SfmlGraphics, System.Generics.Collections;

type
  TResource = TSfmlTexture;
  TIdentifier = (tiLandscape, tiAirplane);
{$DEFINE INTERFACE}
{$INCLUDE 'ResourceHolder.inc'}

(*
type
  TResourceHolder<TResource, TIdentifier> = class
  private
    FDictionary: TObjectDictionary<TIdentifier, TResource>;
    procedure InsertResource(ID: TIdentifier; Resource: TResource);
  public
    procedure Load(ID: TIdentifier; const FileName: TFileName);
    procedure Add(ID: TIdentifier; Resource: TResource);
    function Get(ID: TIdentifier): TResource;

    property Resource[ID: TIdentifier]: TResource read Get; default;
  end;
*)

implementation

{$DEFINE IMPLEMENTATION}
{$INCLUDE 'ResourceHolder.inc'}

(*
{ TResourceHolder }

procedure TResourceHolder<TResource, TIdentifier>.Load(ID: TIdentifier; const FileName: TFileName);
var
  Resource: TResource;
begin
  if FileExists(FileName) then
    Exception.Create('TResourceHolder<TResource, TIdentifier>.Load - Failed to load ' + FileName);

  // Create and load resource
  Resource := TResource.Create(FileName);

  // If loading successful, insert resource to map
  InsertResource(ID, Resource);
end;

function TResourceHolder<TResource, TIdentifier>.Get(ID: TIdentifier): TResource;
begin
  Result := FDictionary[ID];
end;

procedure TResourceHolder<TResource, TIdentifier>.InsertResource(ID: TIdentifier; Resource: TResource);
begin
  // Insert and check success
  FDictionary[ID] := Resource;
end;
*)

end.
