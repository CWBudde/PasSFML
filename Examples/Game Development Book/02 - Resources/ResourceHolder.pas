unit ResourceHolder;

interface

uses
  SysUtils, SfmlGraphics;

type
  // hack to simulate templates
  TResource = TSfmlTexture;
  TIdentifier = (tiLandscape, tiAirplane);

{$DEFINE INTERFACE}
{$INCLUDE 'ResourceHolder.inc'}

implementation

{$DEFINE IMPLEMENTATION}
{$INCLUDE 'ResourceHolder.inc'}

end.
