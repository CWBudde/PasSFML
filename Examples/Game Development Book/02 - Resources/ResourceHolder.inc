{$IFDEF INTERFACE}
  // TResourceHolder<TResource, TIdentifier> = class
  TResourceHolder = class
  private
    procedure InsertResource(ID: TIdentifier; Resource: TResource);
  public
    Items: array [TIdentifier] of TResource;
    procedure Load(ID: TIdentifier; const FileName: TFileName);
    function Get(ID: TIdentifier): TResource;

    property Resource[ID: TIdentifier]: TResource read Get; default;
  end;
{$UNDEF INTERFACE}
{$ENDIF}

{$IFDEF IMPLEMENTATION}
procedure TResourceHolder.Load(ID: TIdentifier; const FileName: TFileName);
var
  Resource: TResource;
begin
  if not FileExists(FileName) then
    Exception.Create('TResourceHolder<TResource, TIdentifier>.Load - Failed to load ' + FileName);

  // Create and load resource
  Resource := TResource.Create(AnsiString(FileName));

  // If loading successful, insert resource to map
  InsertResource(ID, Resource);
end;

function TResourceHolder.Get(ID: TIdentifier): TResource;
begin
  Result := Items[ID];
end;

procedure TResourceHolder.InsertResource(ID: TIdentifier; Resource: TResource);
begin
  // Insert and check success
  Items[ID] := Resource;
end;
{$UNDEF IMPLEMENTATION}
{$ENDIF}

