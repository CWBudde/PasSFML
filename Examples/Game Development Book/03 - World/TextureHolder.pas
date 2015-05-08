unit TextureHolder;

interface

uses
  SysUtils, SfmlGraphics;

type
  TTextureID = (tiDesert, tiEagle, tiRaptor);

  TResource = TSfmlTexture;
  TIdentifier = TTextureID;
{$DEFINE INTERFACE}
{$INCLUDE 'ResourceHolder.inc'}
  TTextureHolder = TResourceHolder;

implementation

{$DEFINE IMPLEMENTATION}
{$INCLUDE 'ResourceHolder.inc'}

end.
