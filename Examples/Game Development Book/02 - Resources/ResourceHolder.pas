unit ResourceHolder;

interface

uses
  SysUtils;

type
  TResourceHolder = class<TResource, TIdentifier>
  private
    FResourceMap: array [TIdentifier] of TResource;
    procedure InsertResource(ID: TIdentifier; Resource: TResource);
  public
    procedure Load(ID: TIdentifier; const FileName: TFileName);
    function Get(ID: TIdentifier): TResource;
  end;

implementation

{ TResourceHolder }

procedure TResourceHolder.Load(ID: TIdentifier; const FileName: TFileName);
var
  Item: TResource;
begin
  if FileExists(FileName) then
    Exception.Create('TResourceHolder.Load - Failed to load ' + FileName);

  // Create and load resource
  Item := TResource.Create(FileName)

  // If loading successful, insert resource to map
  InsertResource(ID, Resource);
end;

function TResourceHolder.Get(ID: TIdentifier): TResource;
begin
  Result := FResourceMap[ID];
end;

procedure TResourceHolder.InsertResource(ID: TIdentifier; Resource: TResource);
begin
  // Insert and check success
  FResourceMap[ID] := Resource;
end;

end.
