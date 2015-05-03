unit TestSfmlGraphics;

{$I ..\Source\Sfml.inc}

interface

uses
  {$IFNDEF FPC}
  TestFramework,
{$ELSE}
  FPCUnit, TestUtils, TestRegistry,
{$ENDIF}
  SfmlSystem, SfmlGraphics, SfmlWindow;

type
  TestTSfmlCircleShape = class(TTestCase)
  strict private
    FSfmlCircleShape: TSfmlCircleShape;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestPosition;
    procedure TestTextureRect;
    procedure TestOrigin;
    procedure TestCopy;
    procedure TestMove;
    procedure TestRotate;
    procedure TestScale;
    procedure TestSetTexture;
  end;

  TestTSfmlConvexShape = class(TTestCase)
  strict private
    FSfmlConvexShape: TSfmlConvexShape;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestCopy;
    procedure TestMove;
    procedure TestRotate;
    procedure TestScale;
    procedure TestSetTexture;
  end;

  TestTSfmlFont = class(TTestCase)
  strict private
    FSfmlFont: TSfmlFont;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestCopy;
    procedure TestGetGlyph;
    procedure TestGetKerning;
    procedure TestGetInfo;
  end;

  TestTSfmlImage = class(TTestCase)
  strict private
    FSfmlImage: TSfmlImage;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestCopy;
    procedure TestCopyImage;
    procedure TestCreateMaskFromColor;
    procedure TestFlip;
  end;

  TestTSfmlRectangleShape = class(TTestCase)
  strict private
    FSfmlRectangleShape: TSfmlRectangleShape;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestCopy;
    procedure TestMove;
    procedure TestRotate;
    procedure TestScale;
    procedure TestSetTexture;
  end;

  TestTSfmlRenderTexture = class(TTestCase)
  strict private
    FSfmlRenderTexture: TSfmlRenderTexture;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestGetDefaultView;
    procedure TestGetTexture;
    procedure TestGetView;
    procedure TestGetViewport;
    procedure TestMapCoordsToPixel;
    procedure TestMapPixelToCoords;
    procedure TestClear;
    procedure TestDisplay;
    procedure TestDraw;
    procedure TestDrawCircleShape;
    procedure TestDrawConvexShape;
    procedure TestDrawPrimitives;
    procedure TestDrawRectangleShape;
    procedure TestDrawShape;
    procedure TestDrawSprite;
    procedure TestDrawText;
    procedure TestDrawVertexArray;
    procedure TestPushPopResetGLStates;
    procedure TestSetView;
  end;

  TestTSfmlRenderWindow = class(TTestCase)
  strict private
    FSfmlRenderWindow: TSfmlRenderWindow;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestBasics;

    procedure TestCapture;
    procedure TestGetDefaultView;
    procedure TestGetSystemHandle;
    procedure TestGetView;
    procedure TestGetViewport;
    procedure TestMapCoordsToPixel;
    procedure TestMapPixelToCoords;
    procedure TestSetActive;
    procedure TestClear;
    procedure TestDraw;
    procedure TestDrawCircleShape;
    procedure TestDrawConvexShape;
    procedure TestDrawPrimitives;
    procedure TestDrawRectangleShape;
    procedure TestDrawShape;
    procedure TestDrawSprite;
    procedure TestDrawText;
    procedure TestDrawVertexArray;
    procedure TestPushPopResetGLStates;
    procedure TestSetIcon;
    procedure TestSetSize;
    procedure TestSetTitle;
  end;

  TestTSfmlShader = class(TTestCase)
  strict private
    FSfmlShader: TSfmlShader;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestSetParameter;
  end;

  TestTSfmlShape = class(TTestCase)
  strict private
    FSfmlShape: TSfmlShape;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestMove;
    procedure TestRotate;
    procedure TestScale;
    procedure TestSetTexture;
    procedure TestUpdate;
  end;

  TestTSfmlSprite = class(TTestCase)
  strict private
    FSfmlSprite: TSfmlSprite;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestCopy;
    procedure TestMove;
    procedure TestRotate;
    procedure TestScale;
    procedure TestSetTexture;
  end;

  TestTSfmlText = class(TTestCase)
  strict private
    FSfmlText: TSfmlText;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestCopy;
    procedure TestFindCharacterPos;
    procedure TestMove;
    procedure TestRotate;
    procedure TestScale;
  end;

  TestTSfmlTexture = class(TTestCase)
  strict private
    FSfmlTexture: TSfmlTexture;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestCopy;
    procedure TestCopyToImage;
    procedure TestBind;
    procedure TestUpdateFromImageAndPixels;
    procedure TestUpdateFromWindow;
  end;

  TestTSfmlTransformable = class(TTestCase)
  strict private
    FSfmlTransformable: TSfmlTransformable;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestCopy;
    procedure TestMove;
    procedure TestRotate;
    procedure TestScale;
  end;

  TestTSfmlVertexArray = class(TTestCase)
  strict private
    FSfmlVertexArray: TSfmlVertexArray;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestCopy;
    procedure TestAppendClearResize;
  end;

  TestTSfmlView = class(TTestCase)
  strict private
    FSfmlView: TSfmlView;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestCopy;
    procedure TestMove;
    procedure TestReset;
    procedure TestRotate;
    procedure TestZoom;
  end;

implementation

uses
  SysUtils;

{ TestTSfmlCircleShape }

procedure TestTSfmlCircleShape.SetUp;
begin
  FSfmlCircleShape := TSfmlCircleShape.Create;
end;

procedure TestTSfmlCircleShape.TearDown;
begin
  FSfmlCircleShape.Free;
  FSfmlCircleShape := nil;
end;

procedure TestTSfmlCircleShape.TestCopy;
var
  ReturnValue: TSfmlCircleShape;
  Index: Integer;
  Point: array [0 .. 1] of TSfmlVector2f;
begin
  ReturnValue := FSfmlCircleShape.Copy;

  CheckEquals(FSfmlCircleShape.FillColor.Value, ReturnValue.FillColor.Value);
  CheckEquals(FSfmlCircleShape.GlobalBounds.Left, ReturnValue.GlobalBounds.Left);
  CheckEquals(FSfmlCircleShape.GlobalBounds.Top, ReturnValue.GlobalBounds.Top);
  CheckEquals(FSfmlCircleShape.GlobalBounds.Width, ReturnValue.GlobalBounds.Width);
  CheckEquals(FSfmlCircleShape.GlobalBounds.Height, ReturnValue.GlobalBounds.Height);
  for Index := 0 to 8 do
    CheckEquals(FSfmlCircleShape.InverseTransform.Matrix[Index], ReturnValue.InverseTransform.Matrix[Index]);
  CheckEquals(FSfmlCircleShape.LocalBounds.Left, ReturnValue.LocalBounds.Left);
  CheckEquals(FSfmlCircleShape.LocalBounds.Top, ReturnValue.LocalBounds.Top);
  CheckEquals(FSfmlCircleShape.LocalBounds.Width, ReturnValue.LocalBounds.Width);
  CheckEquals(FSfmlCircleShape.LocalBounds.Height, ReturnValue.LocalBounds.Height);
  Point[0] := FSfmlCircleShape.Origin;
  Point[1] := ReturnValue.Origin;
  CheckEquals(Point[0].X, Point[1].X);
  CheckEquals(Point[0].Y, Point[1].Y);
  CheckEquals(FSfmlCircleShape.OutlineColor.Value, ReturnValue.OutlineColor.Value);
  CheckEquals(FSfmlCircleShape.OutlineThickness, ReturnValue.OutlineThickness);
  CheckEquals(FSfmlCircleShape.PointCount, ReturnValue.PointCount);
  for Index := 0 to FSfmlCircleShape.PointCount - 1 do
  begin
    Point[0] := FSfmlCircleShape.Point[Index];
    Point[1] := ReturnValue.Point[Index];
    CheckEquals(Point[0].X, Point[1].X);
    CheckEquals(Point[0].Y, Point[1].Y);
  end;
  CheckEquals(FSfmlCircleShape.Position.X, ReturnValue.Position.X);
  CheckEquals(FSfmlCircleShape.Position.Y, ReturnValue.Position.Y);
  CheckEquals(FSfmlCircleShape.Radius, ReturnValue.Radius);
  CheckEquals(FSfmlCircleShape.Rotation, ReturnValue.Rotation);
  CheckEquals(FSfmlCircleShape.ScaleFactor.X, ReturnValue.ScaleFactor.X);
  CheckEquals(FSfmlCircleShape.ScaleFactor.Y, ReturnValue.ScaleFactor.Y);
  CheckEquals(Pointer(FSfmlCircleShape.Texture), Pointer(ReturnValue.Texture));
  CheckEquals(FSfmlCircleShape.TextureRect.Left, ReturnValue.TextureRect.Left);
  CheckEquals(FSfmlCircleShape.TextureRect.Top, ReturnValue.TextureRect.Top);
  CheckEquals(FSfmlCircleShape.TextureRect.Width, ReturnValue.TextureRect.Width);
  CheckEquals(FSfmlCircleShape.TextureRect.Height, ReturnValue.TextureRect.Height);
  for Index := 0 to 8 do
    CheckEquals(FSfmlCircleShape.Transform.Matrix[Index], ReturnValue.Transform.Matrix[Index]);
end;

procedure TestTSfmlCircleShape.TestTextureRect;
var
  NewValue: TSfmlIntRect;
begin
  FSfmlCircleShape.TextureRect := SfmlIntRect(1, 2, 3, 4);
  NewValue := FSfmlCircleShape.TextureRect;
  CheckEquals(1, NewValue.Left);
  CheckEquals(2, NewValue.Top);
  CheckEquals(3, NewValue.Width);
  CheckEquals(4, NewValue.Height);
end;

procedure TestTSfmlCircleShape.TestMove;
var
  Pos: array [0 .. 1] of TSfmlVector2f;
begin
  // get current position
  Pos[0] := FSfmlCircleShape.Position;

  // move shape
  FSfmlCircleShape.Move(SfmlVector2f(10, 10));

  // get current position
  Pos[1] := FSfmlCircleShape.Position;

  // compare positions
  CheckEquals(Pos[0].X + 10, Pos[1].X);
  CheckEquals(Pos[0].Y + 10, Pos[1].Y);
end;

procedure TestTSfmlCircleShape.TestOrigin;
var
  NewValue: TSfmlVector2f;
begin
  FSfmlCircleShape.Origin := SfmlVector2f(1, 2);
  NewValue := FSfmlCircleShape.Origin;
  CheckEquals(1, NewValue.X);
  CheckEquals(2, NewValue.Y);
end;

procedure TestTSfmlCircleShape.TestPosition;
var
  NewValue: TSfmlVector2f;
begin
  FSfmlCircleShape.Position := SfmlVector2f(1, 2);
  NewValue := FSfmlCircleShape.Position;
  CheckEquals(1, NewValue.X);
  CheckEquals(2, NewValue.Y);
end;

procedure TestTSfmlCircleShape.TestRotate;
var
  Rotation: array [0 .. 1] of Single;
begin
  // get current rotation
  Rotation[0] := FSfmlCircleShape.Rotation;

  // perform rotation
  FSfmlCircleShape.Rotate(0.5);

  // get current rotation
  Rotation[1] := FSfmlCircleShape.Rotation;

  // compare rotation
  CheckEquals(Rotation[0] + 0.5, Rotation[1]);
end;

procedure TestTSfmlCircleShape.TestScale;
var
  Factor: array [0 .. 1] of TSfmlVector2f;
begin
  // get current scale factor
  Factor[0] := FSfmlCircleShape.ScaleFactor;

  FSfmlCircleShape.Scale(SfmlVector2f(2, 2));

  // get current scale factor
  Factor[1] := FSfmlCircleShape.ScaleFactor;

  // compare scale factors
  CheckEquals(Factor[0].X * 2, Factor[1].X);
  CheckEquals(Factor[0].Y * 2, Factor[1].Y);
end;

procedure TestTSfmlCircleShape.TestSetTexture;
var
  Texture: TSfmlTexture;
begin
  Assert(FileExists('../Resources/Sfml.png'));
  Texture := TSfmlTexture.Create('../Resources/Sfml.png');

  FSfmlCircleShape.SetTexture(Texture.Handle, True);
  // TODO: check results
end;


{ TestTSfmlConvexShape }

procedure TestTSfmlConvexShape.SetUp;
begin
  FSfmlConvexShape := TSfmlConvexShape.Create;
end;

procedure TestTSfmlConvexShape.TearDown;
begin
  FSfmlConvexShape.Free;
  FSfmlConvexShape := nil;
end;

procedure TestTSfmlConvexShape.TestCopy;
var
  ReturnValue: TSfmlConvexShape;
  Index: Integer;
begin
  ReturnValue := FSfmlConvexShape.Copy;

  CheckEquals(FSfmlConvexShape.FillColor.Value, ReturnValue.FillColor.Value);
  CheckEquals(FSfmlConvexShape.GlobalBounds.Left, ReturnValue.GlobalBounds.Left);
  CheckEquals(FSfmlConvexShape.GlobalBounds.Top, ReturnValue.GlobalBounds.Top);
  CheckEquals(FSfmlConvexShape.GlobalBounds.Width, ReturnValue.GlobalBounds.Width);
  CheckEquals(FSfmlConvexShape.GlobalBounds.Height, ReturnValue.GlobalBounds.Height);
  for Index := 0 to 8 do
    CheckEquals(FSfmlConvexShape.InverseTransform.Matrix[Index], ReturnValue.InverseTransform.Matrix[Index]);
  CheckEquals(FSfmlConvexShape.LocalBounds.Left, ReturnValue.LocalBounds.Left);
  CheckEquals(FSfmlConvexShape.LocalBounds.Top, ReturnValue.LocalBounds.Top);
  CheckEquals(FSfmlConvexShape.LocalBounds.Width, ReturnValue.LocalBounds.Width);
  CheckEquals(FSfmlConvexShape.LocalBounds.Height, ReturnValue.LocalBounds.Height);
  CheckEquals(FSfmlConvexShape.Origin.X, ReturnValue.Origin.X);
  CheckEquals(FSfmlConvexShape.Origin.Y, ReturnValue.Origin.Y);
  CheckEquals(FSfmlConvexShape.OutlineColor.Value, ReturnValue.OutlineColor.Value);
  CheckEquals(FSfmlConvexShape.OutlineThickness, ReturnValue.OutlineThickness);
  CheckEquals(FSfmlConvexShape.PointCount, ReturnValue.PointCount);
  for Index := 0 to FSfmlConvexShape.PointCount - 1 do
  begin
    CheckEquals(FSfmlConvexShape.Point[Index].X, ReturnValue.Point[Index].X);
    CheckEquals(FSfmlConvexShape.Point[Index].Y, ReturnValue.Point[Index].Y);
  end;
  CheckEquals(FSfmlConvexShape.Position.X, ReturnValue.Position.X);
  CheckEquals(FSfmlConvexShape.Position.Y, ReturnValue.Position.Y);
  CheckEquals(FSfmlConvexShape.Rotation, ReturnValue.Rotation);
  CheckEquals(FSfmlConvexShape.ScaleFactor.X, ReturnValue.ScaleFactor.X);
  CheckEquals(FSfmlConvexShape.ScaleFactor.Y, ReturnValue.ScaleFactor.Y);
// ToDo    CheckEquals(FSfmlConvexShape.Texture, ReturnValue.Texture);
  CheckEquals(FSfmlConvexShape.TextureRect.Left, ReturnValue.TextureRect.Left);
  CheckEquals(FSfmlConvexShape.TextureRect.Top, ReturnValue.TextureRect.Top);
  CheckEquals(FSfmlConvexShape.TextureRect.Width, ReturnValue.TextureRect.Width);
  CheckEquals(FSfmlConvexShape.TextureRect.Height, ReturnValue.TextureRect.Height);
  for Index := 0 to 8 do
    CheckEquals(FSfmlConvexShape.Transform.Matrix[Index], ReturnValue.Transform.Matrix[Index]);
end;

procedure TestTSfmlConvexShape.TestMove;
var
  Pos: array [0 .. 1] of TSfmlVector2f;
begin
  // get current position
  Pos[0] := FSfmlConvexShape.Position;

  // move shape
  FSfmlConvexShape.Move(SfmlVector2f(10, 10));

  // get current position
  Pos[1] := FSfmlConvexShape.Position;

  // compare positions
  CheckEquals(Pos[0].X + 10, Pos[1].X);
  CheckEquals(Pos[0].Y + 10, Pos[1].Y);
end;

procedure TestTSfmlConvexShape.TestRotate;
var
  Rotation: array [0 .. 1] of Single;
begin
  // get current rotation
  Rotation[0] := FSfmlConvexShape.Rotation;

  // perform rotation
  FSfmlConvexShape.Rotate(0.5);

  // get current rotation
  Rotation[1] := FSfmlConvexShape.Rotation;

  // compare rotation
  CheckEquals(Rotation[0] + 0.5, Rotation[1]);
end;

procedure TestTSfmlConvexShape.TestScale;
var
  Factor: array [0 .. 1] of TSfmlVector2f;
begin
  // get current scale factor
  Factor[0] := FSfmlConvexShape.ScaleFactor;

  FSfmlConvexShape.Scale(SfmlVector2f(2, 2));

  // get current scale factor
  Factor[1] := FSfmlConvexShape.ScaleFactor;

  // compare scale factors
  CheckEquals(Factor[0].X * 2, Factor[1].X);
  CheckEquals(Factor[0].Y * 2, Factor[1].Y);
end;

procedure TestTSfmlConvexShape.TestSetTexture;
var
  Texture: TSfmlTexture;
begin
  Assert(FileExists('../Resources/Sfml.png'));
  Texture := TSfmlTexture.Create('../Resources/Sfml.png');

  FSfmlConvexShape.SetTexture(Texture.Handle, True);
  // TODO: check results
end;


{ TestTSfmlFont }

procedure TestTSfmlFont.SetUp;
begin
  Assert(FileExists('../Resources/Sansation.ttf'));
  FSfmlFont := TSfmlFont.Create('../Resources/Sansation.ttf');
end;

procedure TestTSfmlFont.TearDown;
begin
  FSfmlFont.Free;
  FSfmlFont := nil;
end;

procedure TestTSfmlFont.TestCopy;
var
  ReturnValue: TSfmlFont;
begin
  ReturnValue := FSfmlFont.Copy;
  CheckEquals(FSfmlFont.GetInfo.Family, ReturnValue.GetInfo.Family);
end;

procedure TestTSfmlFont.TestGetGlyph;
var
  ReturnValue: TSfmlGlyph;
  Bold: Boolean;
  CharacterSize: Cardinal;
  CodePoint: Cardinal;
begin
  for Bold := False to True do
    for CharacterSize := 10 to 20 do
      for CodePoint := $20 to $FF do
      begin
        ReturnValue := FSfmlFont.GetGlyph(CodePoint, CharacterSize, Bold);

        CheckTrue(ReturnValue.Advance >= 0);
(*
        CheckTrue(ReturnValue.Bounds.Left >= 0);
        CheckTrue(ReturnValue.Bounds.Top >= 0);
        CheckTrue(ReturnValue.Bounds.Width >= 0);
        CheckTrue(ReturnValue.Bounds.Height >= 0);
*)
        CheckTrue(ReturnValue.TextureRect.Left >= 0);
        CheckTrue(ReturnValue.TextureRect.Top >= 0);
        CheckTrue(ReturnValue.TextureRect.Width >= 0);
        CheckTrue(ReturnValue.TextureRect.Height >= 0);
      end;
end;

procedure TestTSfmlFont.TestGetKerning;
var
  ReturnValue: Single;
  CharacterSize: Cardinal;
  Second: Cardinal;
  First: Cardinal;
begin
  for CharacterSize := 10 to 20 do
    for First := $20 to $FF do
      for Second := $20 to $FF do
      begin
        ReturnValue := FSfmlFont.GetKerning(First, Second, CharacterSize);
        CheckTrue(Abs(ReturnValue) < 2 * CharacterSize);
      end;
end;

procedure TestTSfmlFont.TestGetInfo;
var
  ReturnValue: TSfmlFontInfo;
begin
  ReturnValue := FSfmlFont.GetInfo;

  CheckTrue(ReturnValue.Family <> '');
end;


{ TestTSfmlImage }

procedure TestTSfmlImage.SetUp;
begin
  Assert(FileExists('../Resources/Sfml.png'));
  FSfmlImage := TSfmlImage.Create('../Resources/Sfml.png');
end;

procedure TestTSfmlImage.TearDown;
begin
  FSfmlImage.Free;
  FSfmlImage := nil;
end;

procedure TestTSfmlImage.TestCopy;
var
  ReturnValue: TSfmlImage;
  Index: Integer;
  Data: array [0 .. 1] of PByte;
begin
  ReturnValue := FSfmlImage.Copy;

  CheckEquals(FSfmlImage.Size.X, ReturnValue.Size.X);
  CheckEquals(FSfmlImage.Size.Y, ReturnValue.Size.Y);
  Data[0] := FSfmlImage.GetPixelsPtr;
  Data[1] := ReturnValue.GetPixelsPtr;
  for Index := 0 to 4 * (FSfmlImage.Size.X * FSfmlImage.Size.Y) - 1 do
  begin
    CheckEquals(Data[0]^, Data[1]^);
    Inc(Data[0]);
    Inc(Data[1]);
  end;
end;

procedure TestTSfmlImage.TestCopyImage;
var
  Source: TSfmlImage;
begin
  Assert(FileExists('../Resources/Sfml.png'));
  Source := TSfmlImage.Create('../Resources/Sfml.png');
  FSfmlImage.CopyImage(Source, 0, 0, SfmlIntRect(0, 0, 32, 32), True);
  // TODO: Check results
end;

procedure TestTSfmlImage.TestCreateMaskFromColor;
begin
  FSfmlImage.CreateMaskFromColor(SfmlGreen, 100);
  // TODO: Check results
end;

procedure TestTSfmlImage.TestFlip;
var
  Original: TSfmlImage;
  Index, X, Y, C: Integer;
  Data: array [0 .. 1] of PByte;
begin
  Original := FSfmlImage.Copy;

  FSfmlImage.FlipHorizontally;

  // test horizontally flipped image
  Data[0] := FSfmlImage.GetPixelsPtr;
  Data[1] := Original.GetPixelsPtr;
  for Y := 0 to FSfmlImage.Size.Y - 1 do
    for X := 0 to FSfmlImage.Size.X - 1 do
      for C := 0 to 3 do
      begin
//        CheckEquals(Data[0]^, Data[1]^);
        Inc(Data[0]);
        Inc(Data[1]);
      end;

  FSfmlImage.FlipVertically;

  // test vertically (and horizontally) flipped image
  Data[0] := FSfmlImage.GetPixelsPtr;
  Data[1] := Original.GetPixelsPtr;
  for Y := 0 to FSfmlImage.Size.Y - 1 do
    for X := 0 to FSfmlImage.Size.X - 1 do
      for C := 0 to 3 do
      begin
//        CheckEquals(Data[0]^, Data[1]^);
        Inc(Data[0]);
        Inc(Data[1]);
      end;

  // flip back
  FSfmlImage.FlipHorizontally;
  FSfmlImage.FlipVertically;

  Data[0] := FSfmlImage.GetPixelsPtr;
  Data[1] := Original.GetPixelsPtr;
  for Index := 0 to 4 * (FSfmlImage.Size.X * FSfmlImage.Size.Y) - 1 do
  begin
    CheckEquals(Data[0]^, Data[1]^);
    Inc(Data[0]);
    Inc(Data[1]);
  end;
end;


{ TestTSfmlRectangleShape }

procedure TestTSfmlRectangleShape.SetUp;
begin
  FSfmlRectangleShape := TSfmlRectangleShape.Create;
end;

procedure TestTSfmlRectangleShape.TearDown;
begin
  FSfmlRectangleShape.Free;
  FSfmlRectangleShape := nil;
end;

procedure TestTSfmlRectangleShape.TestCopy;
var
  ReturnValue: TSfmlRectangleShape;
  Index: Integer;
begin
  ReturnValue := FSfmlRectangleShape.Copy;

  CheckEquals(FSfmlRectangleShape.FillColor.Value, ReturnValue.FillColor.Value);
  CheckEquals(FSfmlRectangleShape.GlobalBounds.Left, ReturnValue.GlobalBounds.Left);
  CheckEquals(FSfmlRectangleShape.GlobalBounds.Top, ReturnValue.GlobalBounds.Top);
  CheckEquals(FSfmlRectangleShape.GlobalBounds.Width, ReturnValue.GlobalBounds.Width);
  CheckEquals(FSfmlRectangleShape.GlobalBounds.Height, ReturnValue.GlobalBounds.Height);
  for Index := 0 to 8 do
    CheckEquals(FSfmlRectangleShape.InverseTransform.Matrix[Index], ReturnValue.InverseTransform.Matrix[Index]);
  CheckEquals(FSfmlRectangleShape.LocalBounds.Left, ReturnValue.LocalBounds.Left);
  CheckEquals(FSfmlRectangleShape.LocalBounds.Top, ReturnValue.LocalBounds.Top);
  CheckEquals(FSfmlRectangleShape.LocalBounds.Width, ReturnValue.LocalBounds.Width);
  CheckEquals(FSfmlRectangleShape.LocalBounds.Height, ReturnValue.LocalBounds.Height);
  CheckEquals(FSfmlRectangleShape.Origin.X, ReturnValue.Origin.X);
  CheckEquals(FSfmlRectangleShape.Origin.Y, ReturnValue.Origin.Y);
  CheckEquals(FSfmlRectangleShape.OutlineColor.Value, ReturnValue.OutlineColor.Value);
  CheckEquals(FSfmlRectangleShape.OutlineThickness, ReturnValue.OutlineThickness);
  CheckEquals(FSfmlRectangleShape.PointCount, ReturnValue.PointCount);
  for Index := 0 to FSfmlRectangleShape.PointCount - 1 do
  begin
    CheckEquals(FSfmlRectangleShape.Point[Index].X, ReturnValue.Point[Index].X);
    CheckEquals(FSfmlRectangleShape.Point[Index].Y, ReturnValue.Point[Index].Y);
  end;
  CheckEquals(FSfmlRectangleShape.Position.X, ReturnValue.Position.X);
  CheckEquals(FSfmlRectangleShape.Position.Y, ReturnValue.Position.Y);
  CheckEquals(FSfmlRectangleShape.Rotation, ReturnValue.Rotation);
  CheckEquals(FSfmlRectangleShape.ScaleFactor.X, ReturnValue.ScaleFactor.X);
  CheckEquals(FSfmlRectangleShape.ScaleFactor.Y, ReturnValue.ScaleFactor.Y);
// ToDo    CheckEquals(FSfmlRectangleShape.Texture, ReturnValue.Texture);
  CheckEquals(FSfmlRectangleShape.TextureRect.Left, ReturnValue.TextureRect.Left);
  CheckEquals(FSfmlRectangleShape.TextureRect.Top, ReturnValue.TextureRect.Top);
  CheckEquals(FSfmlRectangleShape.TextureRect.Width, ReturnValue.TextureRect.Width);
  CheckEquals(FSfmlRectangleShape.TextureRect.Height, ReturnValue.TextureRect.Height);
  for Index := 0 to 8 do
    CheckEquals(FSfmlRectangleShape.Transform.Matrix[Index], ReturnValue.Transform.Matrix[Index]);
end;

procedure TestTSfmlRectangleShape.TestMove;
var
  Pos: array [0 .. 1] of TSfmlVector2f;
begin
  // get current position
  Pos[0] := FSfmlRectangleShape.Position;

  // move shape
  FSfmlRectangleShape.Move(SfmlVector2f(10, 10));

  // get current position
  Pos[1] := FSfmlRectangleShape.Position;

  // compare positions
  CheckEquals(Pos[0].X + 10, Pos[1].X);
  CheckEquals(Pos[0].Y + 10, Pos[1].Y);
end;

procedure TestTSfmlRectangleShape.TestRotate;
var
  Rotation: array [0 .. 1] of Single;
begin
  // get current rotation
  Rotation[0] := FSfmlRectangleShape.Rotation;

  // perform rotation
  FSfmlRectangleShape.Rotate(0.5);

  // get current rotation
  Rotation[1] := FSfmlRectangleShape.Rotation;

  // compare rotation
  CheckEquals(Rotation[0] + 0.5, Rotation[1]);
end;

procedure TestTSfmlRectangleShape.TestScale;
var
  Factor: array [0 .. 1] of TSfmlVector2f;
begin
  // get current scale factor
  Factor[0] := FSfmlRectangleShape.ScaleFactor;

  FSfmlRectangleShape.Scale(SfmlVector2f(2, 2));

  // get current scale factor
  Factor[1] := FSfmlRectangleShape.ScaleFactor;

  // compare scale factors
  CheckEquals(Factor[0].X * 2, Factor[1].X);
  CheckEquals(Factor[0].Y * 2, Factor[1].Y);
end;

procedure TestTSfmlRectangleShape.TestSetTexture;
var
  Texture: TSfmlTexture;
begin
  Assert(FileExists('../Resources/Sfml.png'));
  Texture := TSfmlTexture.Create('../Resources/Sfml.png');

  FSfmlRectangleShape.SetTexture(Texture.Handle, True);
  // TODO: Check results
end;


{ TestTSfmlRenderTexture }

procedure TestTSfmlRenderTexture.SetUp;
begin
  FSfmlRenderTexture := TSfmlRenderTexture.Create(64, 64);
end;

procedure TestTSfmlRenderTexture.TearDown;
begin
  FSfmlRenderTexture.Free;
  FSfmlRenderTexture := nil;
end;

procedure TestTSfmlRenderTexture.TestGetDefaultView;
var
  ReturnValue: PSfmlView;
begin
  ReturnValue := FSfmlRenderTexture.GetDefaultView;
  // TODO: Check results
end;

procedure TestTSfmlRenderTexture.TestGetTexture;
var
  ReturnValue: PSfmlTexture;
begin
  ReturnValue := FSfmlRenderTexture.GetTexture;
  // TODO: Check results
end;

procedure TestTSfmlRenderTexture.TestGetView;
var
  ReturnValue: PSfmlView;
  View: TSfmlView;
  ViewportRect: TSfmlFloatRect;
begin
  View := TSfmlView.Create;

  View.Size := SfmlVector2f(64, 64);
  ViewportRect := SfmlFloatRect(0, 0, 200, 200);
  View.Viewport := ViewportRect;

  FSfmlRenderTexture.SetView(View.Handle);
  ReturnValue := FSfmlRenderTexture.GetView;

  CheckEquals(Integer(View.Handle), Integer(ReturnValue));
end;

procedure TestTSfmlRenderTexture.TestGetViewport;
var
  ReturnValue: TSfmlIntRect;
  View: TSfmlView;
  ViewportRect: TSfmlFloatRect;
begin
  View := TSfmlView.Create;

  View.Size := SfmlVector2f(64, 64);
  ViewportRect := SfmlFloatRect(0, 0, 200, 200);
  View.Viewport := ViewportRect;

  ReturnValue := FSfmlRenderTexture.GetViewport(View.Handle);

  CheckEquals(ViewportRect.Left, ReturnValue.Left);
  CheckEquals(ViewportRect.Top, ReturnValue.Top);
  CheckEquals(ViewportRect.Width, ReturnValue.Width);
  CheckEquals(ViewportRect.Height, ReturnValue.Height);

  // TODO: Check results
end;

procedure TestTSfmlRenderTexture.TestMapCoordsToPixel;
var
  ReturnValue: TSfmlVector2i;
  View: TSfmlView;
  Point: TSfmlVector2i;
begin
  View := TSfmlView.Create;

  View.Size := SfmlVector2f(64, 64);
  View.Viewport := SfmlFloatRect(0, 0, 200, 200);

  ReturnValue := FSfmlRenderTexture.MapCoordsToPixel(Point, View.Handle);
  // TODO: Check results
end;

procedure TestTSfmlRenderTexture.TestMapPixelToCoords;
var
  ReturnValue: TSfmlVector2f;
  View: TSfmlView;
  Point: TSfmlVector2i;
begin
  View := TSfmlView.Create;

  View.Size := SfmlVector2f(64, 64);
  View.Viewport := SfmlFloatRect(0, 0, 200, 200);

  ReturnValue := FSfmlRenderTexture.MapPixelToCoords(Point, View.Handle);
  // TODO: Check results
end;

procedure TestTSfmlRenderTexture.TestClear;
begin
  FSfmlRenderTexture.Clear(SfmlWhite);
  // TODO: Check results

  FSfmlRenderTexture.Clear(SfmlRed);
  // TODO: Check results
end;

procedure TestTSfmlRenderTexture.TestDisplay;
begin
  FSfmlRenderTexture.Display;
  // TODO: Check results
end;

procedure TestTSfmlRenderTexture.TestDraw;
var
  CircleShape: TSfmlCircleShape;
  RectangleShape: TSfmlRectangleShape;
  ConvexShape: TSfmlConvexShape;
  Texture: TSfmlTexture;
  Sprite: TSfmlSprite;
  Font: TSfmlFont;
  Text: TSfmlText;
  VertexArray: TSfmlVertexArray;
begin
  CircleShape := TSfmlCircleShape.Create;
  try
    CircleShape.Radius := 10;
    CircleShape.Position := SfmlVector2f(16, 16);
    CircleShape.FillColor := SfmlRed;
    FSfmlRenderTexture.Draw(CircleShape);
  finally
    CircleShape.Free;
  end;

  RectangleShape := TSfmlRectangleShape.Create;
  try
    RectangleShape.Size := SfmlVector2f(12, 9);
    RectangleShape.Position := SfmlVector2f(16, 16);
    RectangleShape.FillColor := SfmlRed;
    FSfmlRenderTexture.Draw(RectangleShape);
  finally
    RectangleShape.Free;
  end;

  ConvexShape := TSfmlConvexShape.Create;
  try
    ConvexShape.PointCount := 3;
    ConvexShape.Point[0] := SfmlVector2f(3, 4);
    ConvexShape.Point[1] := SfmlVector2f(12, 6);
    ConvexShape.Point[2] := SfmlVector2f(6, 9);
    ConvexShape.Position := SfmlVector2f(16, 16);
    ConvexShape.FillColor := SfmlRed;
    FSfmlRenderTexture.Draw(ConvexShape);
  finally
    ConvexShape.Free;
  end;

  Sprite := TSfmlSprite.Create;
  try
    Assert(FileExists('../Resources/Sfml.png'));
    Texture := TSfmlTexture.Create('../Resources/Sfml.png');
    try
      Sprite.SetTexture(Texture);
      FSfmlRenderTexture.Draw(Sprite);
    finally
      Texture.Free;
    end;
  finally
    Sprite.Free;
  end;

  Assert(FileExists('../Resources/Sansation.ttf'));
  Font := TSfmlFont.Create('../Resources/Sansation.ttf');
  try
    Text := TSfmlText.Create('Hello World', Font);
    try
      FSfmlRenderTexture.Draw(Text);
    finally
      Text.Free;
    end;
  finally
    Font.Free;
  end;

  VertexArray := TSfmlVertexArray.Create;
  try
    VertexArray.Append(SfmlVertex(SfmlVector2f(2, 2), SfmlRed));
    VertexArray.Append(SfmlVertex(SfmlVector2f(7, 5), SfmlGreen));
    VertexArray.Append(SfmlVertex(SfmlVector2f(4, 9), SfmlBlue));
    VertexArray.PrimitiveType := sfLines;

    FSfmlRenderTexture.Draw(VertexArray);
  finally
    VertexArray.Free;
  end;

  // TODO: Check results
end;

procedure TestTSfmlRenderTexture.TestDrawCircleShape;
var
  States: TSfmlRenderStates;
  CircleShape: TSfmlCircleShape;
begin
  // setup states
  FillChar(States, SizeOf(States), 0);
  States.BlendMode := SfmlBlendAlpha;
  States.Transform.Matrix[0] := 1;
  States.Transform.Matrix[4] := 1;
  States.Transform.Matrix[8] := 1;

  CircleShape := TSfmlCircleShape.Create;
  try
    CircleShape.Radius := 10;
    CircleShape.Position := SfmlVector2f(16, 16);
    CircleShape.FillColor := SfmlRed;

    FSfmlRenderTexture.DrawCircleShape(CircleShape.Handle, @States);
  finally
    CircleShape.Free;
  end;

  // TODO: Check results
end;

procedure TestTSfmlRenderTexture.TestDrawConvexShape;
var
  States: TSfmlRenderStates;
  ConvexShape: TSfmlConvexShape;
begin
  // setup states
  FillChar(States, SizeOf(States), 0);
  States.BlendMode := SfmlBlendAlpha;
  States.Transform.Matrix[0] := 1;
  States.Transform.Matrix[4] := 1;
  States.Transform.Matrix[8] := 1;

  ConvexShape := TSfmlConvexShape.Create;
  try
    ConvexShape.Position := SfmlVector2f(16, 16);
    ConvexShape.FillColor := SfmlRed;

    FSfmlRenderTexture.DrawConvexShape(ConvexShape.Handle, @States);
  finally
    ConvexShape.Free;
  end;

  // TODO: Check results
end;

procedure TestTSfmlRenderTexture.TestDrawPrimitives;
var
  Vertices: array [0 .. 2] of TSfmlVertex;
begin
  Vertices[0].Position := SfmlVector2f(2, 2);
  Vertices[1].Position := SfmlVector2f(4, 6);
  Vertices[2].Position := SfmlVector2f(12, 3);

  FSfmlRenderTexture.DrawPrimitives(@Vertices[0], Length(Vertices), sfLines);
  // TODO: Check results
end;

procedure TestTSfmlRenderTexture.TestDrawRectangleShape;
var
  States: TSfmlRenderStates;
  RectangleShape: TSfmlRectangleShape;
begin
  // setup states
  FillChar(States, SizeOf(States), 0);
  States.BlendMode := SfmlBlendAlpha;
  States.Transform.Matrix[0] := 1;
  States.Transform.Matrix[4] := 1;
  States.Transform.Matrix[8] := 1;

  RectangleShape := TSfmlRectangleShape.Create;
  try
    RectangleShape.Position := SfmlVector2f(16, 16);
    RectangleShape.FillColor := SfmlRed;

    FSfmlRenderTexture.DrawRectangleShape(RectangleShape.Handle, @States);
  finally
    RectangleShape.Free;
  end;

  // TODO: Check results
end;

function TriangleGetPointCountCallback(UserData: Pointer): Cardinal; cdecl;
begin
  Result := 3;
end;

function TriangleGetPointCallback(Index: Cardinal; UserData: Pointer): TSfmlVector2f; cdecl;
begin
  case Index of
    0:
      begin
        Result.X := 1;
        Result.Y := 2;
      end;
    1:
      begin
        Result.X := 12;
        Result.Y := 1;
      end;
    2:
      begin
        Result.X := 4;
        Result.Y := 8;
      end;
  end;
end;

procedure TestTSfmlRenderTexture.TestDrawShape;
var
  States: TSfmlRenderStates;
  Shape: TSfmlShape;
begin
  // setup states
  FillChar(States, SizeOf(States), 0);
  States.BlendMode := SfmlBlendAlpha;
  States.Transform.Matrix[0] := 1;
  States.Transform.Matrix[4] := 1;
  States.Transform.Matrix[8] := 1;

  Shape := TSfmlShape.Create(TriangleGetPointCountCallback,
    TriangleGetPointCallback, nil);
  try
    Shape.Position := SfmlVector2f(16, 16);
    Shape.FillColor := SfmlRed;

    FSfmlRenderTexture.DrawShape(Shape.Handle, @States);
  finally
    Shape.Free;
  end;

  // TODO: Check results
end;

procedure TestTSfmlRenderTexture.TestDrawSprite;
var
  States: TSfmlRenderStates;
  Sprite: TSfmlSprite;
  Texture: TSfmlTexture;
begin
  // setup states
  FillChar(States, SizeOf(States), 0);
  States.BlendMode := SfmlBlendAlpha;
  States.Transform.Matrix[0] := 1;
  States.Transform.Matrix[4] := 1;
  States.Transform.Matrix[8] := 1;

  Sprite := TSfmlSprite.Create;
  try
    Sprite.Position := SfmlVector2f(16, 16);

    Assert(FileExists('../Resources/Sfml.png'));
    Texture := TSfmlTexture.Create('../Resources/Sfml.png');
    try
      Sprite.SetTexture(Texture);
      FSfmlRenderTexture.Draw(Sprite, @States);
    finally
      Texture.Free;
    end;
  finally
    Sprite.Free;
  end;

  // TODO: Check results
end;

procedure TestTSfmlRenderTexture.TestDrawText;
var
  States: TSfmlRenderStates;
  Font: TSfmlFont;
  Text: TSfmlText;
begin
  // setup states
  FillChar(States, SizeOf(States), 0);
  States.BlendMode := SfmlBlendAlpha;
  States.Transform.Matrix[0] := 1;
  States.Transform.Matrix[4] := 1;
  States.Transform.Matrix[8] := 1;

  Assert(FileExists('../Resources/Sansation.ttf'));
  Font := TSfmlFont.Create('../Resources/Sansation.ttf');
  try
    Text := TSfmlText.Create('Hello World', Font);
    try
      FSfmlRenderTexture.DrawText(Text.Handle, @States);
    finally
      Text.Free;
    end;
  finally
    Font.Free;
  end;

  // TODO: Check results
end;

procedure TestTSfmlRenderTexture.TestDrawVertexArray;
var
  States: TSfmlRenderStates;
  VertexArray: TSfmlVertexArray;
begin
  // setup states
  FillChar(States, SizeOf(States), 0);
  States.BlendMode := SfmlBlendAlpha;
  States.Transform.Matrix[0] := 1;
  States.Transform.Matrix[4] := 1;
  States.Transform.Matrix[8] := 1;

  VertexArray := TSfmlVertexArray.Create;
  try
    VertexArray.Append(SfmlVertex(SfmlVector2f(2, 2), SfmlRed));
    VertexArray.Append(SfmlVertex(SfmlVector2f(7, 5), SfmlGreen));
    VertexArray.Append(SfmlVertex(SfmlVector2f(4, 9), SfmlBlue));
    VertexArray.PrimitiveType := sfLines;

    FSfmlRenderTexture.DrawVertexArray(VertexArray.Handle, @States);
  finally
    VertexArray.Free;
  end;

  // TODO: Check results
end;

procedure TestTSfmlRenderTexture.TestPushPopResetGLStates;
begin
  FSfmlRenderTexture.PushGLStates;

  FSfmlRenderTexture.ResetGLStates;
  // TODO: Check results

  FSfmlRenderTexture.PopGLStates;
  // TODO: Check results
end;

procedure TestTSfmlRenderTexture.TestSetView;
var
  View: TSfmlView;
begin
  View := TSfmlView.Create;

  View.Size := SfmlVector2f(64, 64);
  View.Viewport := SfmlFloatRect(0, 0, 200, 200);

  FSfmlRenderTexture.SetView(View.Handle);
  // TODO: Check results
end;


{ TestTSfmlRenderWindow }

procedure TestTSfmlRenderWindow.SetUp;
begin
  FSfmlRenderWindow := TSfmlRenderWindow.Create(SfmlVideoMode(800, 600),
    'Test', [sfTitleBar, sfResize, sfClose]);
end;

procedure TestTSfmlRenderWindow.TearDown;
begin
  FSfmlRenderWindow.Free;
  FSfmlRenderWindow := nil;
end;

procedure TestTSfmlRenderWindow.TestBasics;
var
  Settings: TSfmlContextSettings;
  Event: TSfmlEvent;
begin
  // get settings
  Settings := FSfmlRenderWindow.GetSettings;

  CheckTrue(FSfmlRenderWindow.IsOpen);

  // bring window to front
  FSfmlRenderWindow.RequestFocus;
  CheckTrue(FSfmlRenderWindow.HasFocus);

  // display window
  FSfmlRenderWindow.Display;

  while FSfmlRenderWindow.IsOpen do
  begin
    // poll event
    if FSfmlRenderWindow.PollEvent(Event) then
      if Event.EventType = sfEvtClosed then
        Break;

    // display window
    FSfmlRenderWindow.Display;

    // wait a little bit
    SfmlSleep(SfmlMilliseconds(10));
  end;

  // close window
  FSfmlRenderWindow.Close;
  CheckFalse(FSfmlRenderWindow.IsOpen);
end;

procedure TestTSfmlRenderWindow.TestCapture;
var
  ReturnValue: PSfmlImage;
begin
  ReturnValue := FSfmlRenderWindow.Capture;
  // TODO: Check results
end;

procedure TestTSfmlRenderWindow.TestGetDefaultView;
var
  ReturnValue: PSfmlView;
begin
  ReturnValue := FSfmlRenderWindow.GetDefaultView;
  // TODO: Check results
end;

procedure TestTSfmlRenderWindow.TestGetSystemHandle;
var
  ReturnValue: TSfmlWindowHandle;
begin
  ReturnValue := FSfmlRenderWindow.GetSystemHandle;
  // TODO: Check results
end;

procedure TestTSfmlRenderWindow.TestGetView;
var
  ReturnValue: PSfmlView;
  View: TSfmlView;
  ViewportRect: TSfmlFloatRect;
begin
  View := TSfmlView.Create;

  View.Size := SfmlVector2f(64, 64);
  ViewportRect := SfmlFloatRect(0, 0, 200, 200);
  View.Viewport := ViewportRect;

  FSfmlRenderWindow.SetView(View.Handle);
  ReturnValue := FSfmlRenderWindow.GetView;

  CheckEquals(Integer(View.Handle), Integer(ReturnValue));
end;

procedure TestTSfmlRenderWindow.TestGetViewport;
var
  ReturnValue: TSfmlIntRect;
  View: TSfmlView;
  ViewportRect: TSfmlFloatRect;
begin
  View := TSfmlView.Create;

  View.Size := SfmlVector2f(64, 64);
  ViewportRect := SfmlFloatRect(0, 0, 200, 200);
  View.Viewport := ViewportRect;

  ReturnValue := FSfmlRenderWindow.GetViewport(View.Handle);

  CheckEquals(ViewportRect.Left, ReturnValue.Left);
  CheckEquals(ViewportRect.Top, ReturnValue.Top);
  CheckEquals(ViewportRect.Width, ReturnValue.Width);
  CheckEquals(ViewportRect.Height, ReturnValue.Height);
  // TODO: Check results
end;

procedure TestTSfmlRenderWindow.TestMapCoordsToPixel;
var
  ReturnValue: TSfmlVector2i;
  View: TSfmlView;
  Point: TSfmlVector2i;
begin
  View := TSfmlView.Create;

  View.Size := SfmlVector2f(64, 64);
  View.Viewport := SfmlFloatRect(0, 0, 200, 200);

  ReturnValue := FSfmlRenderWindow.MapCoordsToPixel(Point, View.Handle);
  // TODO: Check results
end;

procedure TestTSfmlRenderWindow.TestMapPixelToCoords;
var
  ReturnValue: TSfmlVector2f;
  View: TSfmlView;
  Point: TSfmlVector2i;
begin
  View := TSfmlView.Create;

  View.Size := SfmlVector2f(64, 64);
  View.Viewport := SfmlFloatRect(0, 0, 200, 200);

  ReturnValue := FSfmlRenderWindow.MapPixelToCoords(Point, View.Handle);
  // TODO: Check results
end;

procedure TestTSfmlRenderWindow.TestSetActive;
var
  ReturnValue: Boolean;
  Active: Boolean;
begin
  // TODO: Methodenaufrufparameter einrichten
  ReturnValue := FSfmlRenderWindow.SetActive(Active);
  // TODO: Check results
end;

procedure TestTSfmlRenderWindow.TestClear;
begin
  FSfmlRenderWindow.Clear(SfmlWhite);
  // TODO: Check results

  FSfmlRenderWindow.Clear(SfmlRed);
  // TODO: Check results
end;

procedure TestTSfmlRenderWindow.TestDraw;
var
  CircleShape: TSfmlCircleShape;
  RectangleShape: TSfmlRectangleShape;
  ConvexShape: TSfmlConvexShape;
  Texture: TSfmlTexture;
  Sprite: TSfmlSprite;
  Font: TSfmlFont;
  Text: TSfmlText;
  VertexArray: TSfmlVertexArray;
begin
  CircleShape := TSfmlCircleShape.Create;
  try
    CircleShape.Radius := 10;
    CircleShape.Position := SfmlVector2f(16, 16);
    CircleShape.FillColor := SfmlRed;
    FSfmlRenderWindow.Draw(CircleShape);
  finally
    CircleShape.Free;
  end;

  RectangleShape := TSfmlRectangleShape.Create;
  try
    RectangleShape.Size := SfmlVector2f(12, 9);
    RectangleShape.Position := SfmlVector2f(16, 16);
    RectangleShape.FillColor := SfmlRed;
    FSfmlRenderWindow.Draw(RectangleShape);
  finally
    RectangleShape.Free;
  end;

  ConvexShape := TSfmlConvexShape.Create;
  try
    ConvexShape.PointCount := 3;
    ConvexShape.Point[0] := SfmlVector2f(3, 4);
    ConvexShape.Point[1] := SfmlVector2f(12, 6);
    ConvexShape.Point[2] := SfmlVector2f(6, 9);
    ConvexShape.Position := SfmlVector2f(16, 16);
    ConvexShape.FillColor := SfmlRed;
    FSfmlRenderWindow.Draw(ConvexShape);
  finally
    ConvexShape.Free;
  end;

  Sprite := TSfmlSprite.Create;
  try
    Assert(FileExists('../Resources/Sfml.png'));
    Texture := TSfmlTexture.Create('../Resources/Sfml.png');
    try
      Sprite.SetTexture(Texture);
      FSfmlRenderWindow.Draw(Sprite);
    finally
      Texture.Free;
    end;
  finally
    Sprite.Free;
  end;

  Assert(FileExists('../Resources/Sansation.ttf'));
  Font := TSfmlFont.Create('../Resources/Sansation.ttf');
  try
    Text := TSfmlText.Create('Hello World', Font);
    try
      FSfmlRenderWindow.Draw(Text);
    finally
      Text.Free;
    end;
  finally
    Font.Free;
  end;

  VertexArray := TSfmlVertexArray.Create;
  try
    VertexArray.Append(SfmlVertex(SfmlVector2f(2, 2), SfmlRed));
    VertexArray.Append(SfmlVertex(SfmlVector2f(7, 5), SfmlGreen));
    VertexArray.Append(SfmlVertex(SfmlVector2f(4, 9), SfmlBlue));
    VertexArray.PrimitiveType := sfLines;

    FSfmlRenderWindow.Draw(VertexArray);
  finally
    VertexArray.Free;
  end;

  // TODO: Check results
end;

procedure TestTSfmlRenderWindow.TestDrawCircleShape;
var
  States: TSfmlRenderStates;
  CircleShape: TSfmlCircleShape;
begin
  // setup states
  FillChar(States, SizeOf(States), 0);
  States.BlendMode := SfmlBlendAlpha;
  States.Transform.Matrix[0] := 1;
  States.Transform.Matrix[4] := 1;
  States.Transform.Matrix[8] := 1;

  CircleShape := TSfmlCircleShape.Create;
  try
    CircleShape.Radius := 10;
    CircleShape.Position := SfmlVector2f(16, 16);
    CircleShape.FillColor := SfmlRed;

    FSfmlRenderWindow.DrawCircleShape(CircleShape.Handle, @States);
  finally
    CircleShape.Free;
  end;

  // TODO: Check results
end;

procedure TestTSfmlRenderWindow.TestDrawConvexShape;
var
  States: TSfmlRenderStates;
  ConvexShape: TSfmlConvexShape;
begin
  // setup states
  FillChar(States, SizeOf(States), 0);
  States.BlendMode := SfmlBlendAlpha;
  States.Transform.Matrix[0] := 1;
  States.Transform.Matrix[4] := 1;
  States.Transform.Matrix[8] := 1;

  ConvexShape := TSfmlConvexShape.Create;
  try
    ConvexShape.Position := SfmlVector2f(16, 16);
    ConvexShape.FillColor := SfmlRed;

    FSfmlRenderWindow.DrawConvexShape(ConvexShape.Handle, @States);
  finally
    ConvexShape.Free;
  end;

  // TODO: Check results
end;

procedure TestTSfmlRenderWindow.TestDrawPrimitives;
var
  Vertices: array [0 .. 2] of TSfmlVertex;
begin
  Vertices[0].Position := SfmlVector2f(2, 2);
  Vertices[1].Position := SfmlVector2f(4, 6);
  Vertices[2].Position := SfmlVector2f(12, 3);

  FSfmlRenderWindow.DrawPrimitives(@Vertices[0], Length(Vertices), sfLines);
  // TODO: Check results
end;

procedure TestTSfmlRenderWindow.TestDrawRectangleShape;
var
  States: TSfmlRenderStates;
  RectangleShape: TSfmlRectangleShape;
begin
  // setup states
  FillChar(States, SizeOf(States), 0);
  States.BlendMode := SfmlBlendAlpha;
  States.Transform.Matrix[0] := 1;
  States.Transform.Matrix[4] := 1;
  States.Transform.Matrix[8] := 1;

  RectangleShape := TSfmlRectangleShape.Create;
  try
    RectangleShape.Position := SfmlVector2f(16, 16);
    RectangleShape.FillColor := SfmlRed;

    FSfmlRenderWindow.DrawRectangleShape(RectangleShape.Handle, @States);
  finally
    RectangleShape.Free;
  end;

  // TODO: Check results
end;

procedure TestTSfmlRenderWindow.TestDrawShape;
var
  States: TSfmlRenderStates;
  Shape: TSfmlShape;
begin
  // setup states
  FillChar(States, SizeOf(States), 0);
  States.BlendMode := SfmlBlendAlpha;
  States.Transform.Matrix[0] := 1;
  States.Transform.Matrix[4] := 1;
  States.Transform.Matrix[8] := 1;

  Shape := TSfmlShape.Create(TriangleGetPointCountCallback,
    TriangleGetPointCallback, nil);
  try
    Shape.Position := SfmlVector2f(16, 16);
    Shape.FillColor := SfmlRed;

    FSfmlRenderWindow.DrawShape(Shape.Handle, @States);
  finally
    Shape.Free;
  end;

  // TODO: Check results
end;

procedure TestTSfmlRenderWindow.TestDrawSprite;
var
  States: TSfmlRenderStates;
  Sprite: TSfmlSprite;
  Texture: TSfmlTexture;
begin
  // setup states
  FillChar(States, SizeOf(States), 0);
  States.BlendMode := SfmlBlendAlpha;
  States.Transform.Matrix[0] := 1;
  States.Transform.Matrix[4] := 1;
  States.Transform.Matrix[8] := 1;

  Sprite := TSfmlSprite.Create;
  try
    Sprite.Position := SfmlVector2f(16, 16);

    Assert(FileExists('../Resources/Sfml.png'));
    Texture := TSfmlTexture.Create('../Resources/Sfml.png');
    try
      Sprite.SetTexture(Texture);
      FSfmlRenderWindow.Draw(Sprite);
    finally
      Texture.Free;
    end;
  finally
    Sprite.Free;
  end;

  // TODO: Check results
end;

procedure TestTSfmlRenderWindow.TestDrawText;
var
  States: TSfmlRenderStates;
  Font: TSfmlFont;
  Text: TSfmlText;
begin
  // setup states
  FillChar(States, SizeOf(States), 0);
  States.BlendMode := SfmlBlendAlpha;
  States.Transform.Matrix[0] := 1;
  States.Transform.Matrix[4] := 1;
  States.Transform.Matrix[8] := 1;

  Assert(FileExists('../Resources/Sansation.ttf'));
  Font := TSfmlFont.Create('../Resources/Sansation.ttf');
  try
    Text := TSfmlText.Create('Hello World', Font);
    try
      FSfmlRenderWindow.DrawText(Text.Handle, @States);
    finally
      Text.Free;
    end;
  finally
    Font.Free;
  end;

  // TODO: Check results
end;

procedure TestTSfmlRenderWindow.TestDrawVertexArray;
var
  States: TSfmlRenderStates;
  VertexArray: TSfmlVertexArray;
begin
  // setup states
  FillChar(States, SizeOf(States), 0);
  States.BlendMode := SfmlBlendAlpha;
  States.Transform.Matrix[0] := 1;
  States.Transform.Matrix[4] := 1;
  States.Transform.Matrix[8] := 1;

  VertexArray := TSfmlVertexArray.Create;
  try
    VertexArray.Append(SfmlVertex(SfmlVector2f(2, 2), SfmlRed));
    VertexArray.Append(SfmlVertex(SfmlVector2f(7, 5), SfmlGreen));
    VertexArray.Append(SfmlVertex(SfmlVector2f(4, 9), SfmlBlue));
    VertexArray.PrimitiveType := sfLines;

    FSfmlRenderWindow.DrawVertexArray(VertexArray.Handle, @States);
  finally
    VertexArray.Free;
  end;

  // TODO: Check results
end;

procedure TestTSfmlRenderWindow.TestPushPopResetGLStates;
begin
  FSfmlRenderWindow.PushGLStates;

  FSfmlRenderWindow.ResetGLStates;
  // TODO: Check results

  FSfmlRenderWindow.PopGLStates;
  // TODO: Check results
end;

procedure TestTSfmlRenderWindow.TestSetIcon;
var
  Image: TSfmlImage;
begin
  Image := TSfmlImage.Create('../Resources/Sfml.png');
  FSfmlRenderWindow.SetIcon(Image.Size.X, Image.Size.Y, Image.GetPixelsPtr);
  // TODO: Check results
end;

procedure TestTSfmlRenderWindow.TestSetSize;
var
  Size: TSfmlVector2u;
begin
  // TODO: Methodenaufrufparameter einrichten
  FSfmlRenderWindow.SetSize(Size);
  // TODO: Check results
end;

procedure TestTSfmlRenderWindow.TestSetTitle;
var
  Event: TSfmlEvent;
begin
  FSfmlRenderWindow.SetTitle(AnsiString('ANSI Title'));

  while FSfmlRenderWindow.IsOpen do
  begin
    // display window
    FSfmlRenderWindow.Display;

    // wait for event
    if FSfmlRenderWindow.WaitEvent(Event) then
      if Event.EventType = sfEvtMouseButtonPressed then
        FSfmlRenderWindow.SetTitle(UnicodeString('Unicode Title'))
      else if Event.EventType = sfEvtClosed then
        Break
  end;

  // close window
  FSfmlRenderWindow.Close;
  // TODO: Check results
end;


{ TestTSfmlShader }

procedure TestTSfmlShader.SetUp;
begin
  Assert(FileExists('../Resources/Wave.vert'));
  Assert(FileExists('../Resources/Blur.frag'));
  FSfmlShader := TSfmlShader.CreateFromFile('../Resources/Wave.vert', '../Resources/Blur.frag');
end;

procedure TestTSfmlShader.TearDown;
begin
  FSfmlShader.Free;
  FSfmlShader := nil;
end;

procedure TestTSfmlShader.TestSetParameter;
begin
  FSfmlShader.SetParameter('wave_phase', 10);
  FSfmlShader.SetParameter('wave_amplitude', 40, 40);
  FSfmlShader.SetParameter('blur_radius', 0.01);

  // TODO: Check results
end;


{ TestTSfmlShape }

function GetPointCountCallback(UserData: Pointer): Cardinal; cdecl;
begin
  Assert(TObject(UserData) is TestTSfmlShape);

  Result := 1;
end;

function GetPointCallback(Index: Cardinal; UserData: Pointer): TSfmlVector2f; cdecl;
begin
  Assert(TObject(UserData) is TestTSfmlShape);

  Result.X := 1;
  Result.Y := 2;
end;

procedure TestTSfmlShape.SetUp;
begin
  FSfmlShape := TSfmlShape.Create(GetPointCountCallback, GetPointCallback, Self);
end;

procedure TestTSfmlShape.TearDown;
begin
  FSfmlShape.Free;
  FSfmlShape := nil;
end;

procedure TestTSfmlShape.TestMove;
var
  Pos: array [0 .. 1] of TSfmlVector2f;
begin
  // get current position
  Pos[0] := FSfmlShape.Position;

  // move shape
  FSfmlShape.Move(SfmlVector2f(10, 10));

  // get current position
  Pos[1] := FSfmlShape.Position;

  // compare positions
  CheckEquals(Pos[0].X + 10, Pos[1].X);
  CheckEquals(Pos[0].Y + 10, Pos[1].Y);
end;

procedure TestTSfmlShape.TestRotate;
var
  Rotation: array [0 .. 1] of Single;
begin
  // get current rotation
  Rotation[0] := FSfmlShape.Rotation;

  // perform rotation
  FSfmlShape.Rotate(0.5);

  // get current rotation
  Rotation[1] := FSfmlShape.Rotation;

  // compare rotation
  CheckEquals(Rotation[0] + 0.5, Rotation[1]);
end;

procedure TestTSfmlShape.TestScale;
var
  Factor: array [0 .. 1] of TSfmlVector2f;
begin
  // get current scale factor
  Factor[0] := FSfmlShape.ScaleFactor;

  FSfmlShape.Scale(SfmlVector2f(2, 2));

  // get current scale factor
  Factor[1] := FSfmlShape.ScaleFactor;

  // compare scale factors
  CheckEquals(Factor[0].X * 2, Factor[1].X);
  CheckEquals(Factor[0].Y * 2, Factor[1].Y);
end;

procedure TestTSfmlShape.TestSetTexture;
var
  Texture: TSfmlTexture;
begin
  Assert(FileExists('../Resources/Sfml.png'));
  Texture := TSfmlTexture.Create('../Resources/Sfml.png');

  FSfmlShape.SetTexture(Texture.Handle, True);
  // TODO: Check results
end;

procedure TestTSfmlShape.TestUpdate;
begin
  FSfmlShape.Update;
  // TODO: Check results
end;


{ TestTSfmlSprite }

procedure TestTSfmlSprite.SetUp;
begin
  FSfmlSprite := TSfmlSprite.Create;
end;

procedure TestTSfmlSprite.TearDown;
begin
  FSfmlSprite.Free;
  FSfmlSprite := nil;
end;

procedure TestTSfmlSprite.TestCopy;
var
  ReturnValue: TSfmlSprite;
  Index: Integer;
begin
  ReturnValue := FSfmlSprite.Copy;

  CheckEquals(FSfmlSprite.GlobalBounds.Left, ReturnValue.GlobalBounds.Left);
  CheckEquals(FSfmlSprite.GlobalBounds.Top, ReturnValue.GlobalBounds.Top);
  CheckEquals(FSfmlSprite.GlobalBounds.Width, ReturnValue.GlobalBounds.Width);
  CheckEquals(FSfmlSprite.GlobalBounds.Height, ReturnValue.GlobalBounds.Height);
  for Index := 0 to 8 do
    CheckEquals(FSfmlSprite.InverseTransform.Matrix[Index], ReturnValue.InverseTransform.Matrix[Index]);
  CheckEquals(FSfmlSprite.LocalBounds.Left, ReturnValue.LocalBounds.Left);
  CheckEquals(FSfmlSprite.LocalBounds.Top, ReturnValue.LocalBounds.Top);
  CheckEquals(FSfmlSprite.LocalBounds.Width, ReturnValue.LocalBounds.Width);
  CheckEquals(FSfmlSprite.LocalBounds.Height, ReturnValue.LocalBounds.Height);
  CheckEquals(FSfmlSprite.Origin.X, ReturnValue.Origin.X);
  CheckEquals(FSfmlSprite.Origin.Y, ReturnValue.Origin.Y);
  CheckEquals(FSfmlSprite.Position.X, ReturnValue.Position.X);
  CheckEquals(FSfmlSprite.Position.Y, ReturnValue.Position.Y);
  CheckEquals(FSfmlSprite.Rotation, ReturnValue.Rotation);
  CheckEquals(FSfmlSprite.ScaleFactor.X, ReturnValue.ScaleFactor.X);
  CheckEquals(FSfmlSprite.ScaleFactor.Y, ReturnValue.ScaleFactor.Y);
  CheckEquals(Pointer(FSfmlSprite.Texture), Pointer(ReturnValue.Texture));
  CheckEquals(FSfmlSprite.TextureRect.Left, ReturnValue.TextureRect.Left);
  CheckEquals(FSfmlSprite.TextureRect.Top, ReturnValue.TextureRect.Top);
  CheckEquals(FSfmlSprite.TextureRect.Width, ReturnValue.TextureRect.Width);
  CheckEquals(FSfmlSprite.TextureRect.Height, ReturnValue.TextureRect.Height);
  for Index := 0 to 8 do
    CheckEquals(FSfmlSprite.Transform.Matrix[Index], ReturnValue.Transform.Matrix[Index]);
end;

procedure TestTSfmlSprite.TestMove;
var
  Pos: array [0 .. 1] of TSfmlVector2f;
begin
  // get current position
  Pos[0] := FSfmlSprite.Position;

  // move shape
  FSfmlSprite.Move(SfmlVector2f(10, 10));

  // get current position
  Pos[1] := FSfmlSprite.Position;

  // compare positions
  CheckEquals(Pos[0].X + 10, Pos[1].X);
  CheckEquals(Pos[0].Y + 10, Pos[1].Y);
end;

procedure TestTSfmlSprite.TestRotate;
var
  Rotation: array [0 .. 1] of Single;
begin
  // get current rotation
  Rotation[0] := FSfmlSprite.Rotation;

  // perform rotation
  FSfmlSprite.Rotate(0.5);

  // get current rotation
  Rotation[1] := FSfmlSprite.Rotation;

  // compare rotation
  CheckEquals(Rotation[0] + 0.5, Rotation[1]);
end;

procedure TestTSfmlSprite.TestScale;
var
  Factor: array [0 .. 1] of TSfmlVector2f;
begin
  // get current scale factor
  Factor[0] := FSfmlSprite.ScaleFactor;

  FSfmlSprite.Scale(SfmlVector2f(2, 2));

  // get current scale factor
  Factor[1] := FSfmlSprite.ScaleFactor;

  // compare scale factors
  CheckEquals(Factor[0].X * 2, Factor[1].X);
  CheckEquals(Factor[0].Y * 2, Factor[1].Y);
end;

procedure TestTSfmlSprite.TestSetTexture;
var
  Texture: TSfmlTexture;
begin
  Assert(FileExists('../Resources/Sfml.png'));
  Texture := TSfmlTexture.Create('../Resources/Sfml.png');

  FSfmlSprite.SetTexture(Texture.Handle, True);
  // TODO: Check results
end;


{ TestTSfmlText }

procedure TestTSfmlText.SetUp;
begin
  FSfmlText := TSfmlText.Create;
end;

procedure TestTSfmlText.TearDown;
begin
  FSfmlText.Free;
  FSfmlText := nil;
end;

procedure TestTSfmlText.TestCopy;
var
  ReturnValue: TSfmlText;
  Index: Integer;
begin
  ReturnValue := FSfmlText.Copy;

  CheckEquals(FSfmlText.CharacterSize, ReturnValue.CharacterSize);
  CheckEquals(FSfmlText.Color.Value, ReturnValue.Color.Value);
  CheckEquals(FSfmlText.GlobalBounds.Left, ReturnValue.GlobalBounds.Left);
  CheckEquals(FSfmlText.GlobalBounds.Top, ReturnValue.GlobalBounds.Top);
  CheckEquals(FSfmlText.GlobalBounds.Width, ReturnValue.GlobalBounds.Width);
  CheckEquals(FSfmlText.GlobalBounds.Height, ReturnValue.GlobalBounds.Height);
  for Index := 0 to 8 do
    CheckEquals(FSfmlText.InverseTransform.Matrix[Index], ReturnValue.InverseTransform.Matrix[Index]);
  CheckEquals(FSfmlText.LocalBounds.Left, ReturnValue.LocalBounds.Left);
  CheckEquals(FSfmlText.LocalBounds.Top, ReturnValue.LocalBounds.Top);
  CheckEquals(FSfmlText.LocalBounds.Width, ReturnValue.LocalBounds.Width);
  CheckEquals(FSfmlText.LocalBounds.Height, ReturnValue.LocalBounds.Height);
  CheckEquals(FSfmlText.Origin.X, ReturnValue.Origin.X);
  CheckEquals(FSfmlText.Origin.Y, ReturnValue.Origin.Y);
  CheckEquals(FSfmlText.Position.X, ReturnValue.Position.X);
  CheckEquals(FSfmlText.Position.Y, ReturnValue.Position.Y);
  CheckEquals(FSfmlText.Rotation, ReturnValue.Rotation);
  CheckEquals(FSfmlText.ScaleFactor.X, ReturnValue.ScaleFactor.X);
  CheckEquals(FSfmlText.ScaleFactor.Y, ReturnValue.ScaleFactor.Y);
  for Index := 0 to 8 do
    CheckEquals(FSfmlText.Transform.Matrix[Index], ReturnValue.Transform.Matrix[Index]);
end;

procedure TestTSfmlText.TestFindCharacterPos;
var
  ReturnValue: TSfmlVector2f;
  Index: NativeUInt;
begin
  for Index := $20 to $80 do
  begin
    ReturnValue := FSfmlText.FindCharacterPos(Index);
    // TODO: Check results
  end;
end;

procedure TestTSfmlText.TestMove;
var
  Pos: array [0 .. 1] of TSfmlVector2f;
begin
  // get current position
  Pos[0] := FSfmlText.Position;

  // move shape
  FSfmlText.Move(SfmlVector2f(10, 10));

  // get current position
  Pos[1] := FSfmlText.Position;

  // compare positions
  CheckEquals(Pos[0].X + 10, Pos[1].X);
  CheckEquals(Pos[0].Y + 10, Pos[1].Y);
end;

procedure TestTSfmlText.TestRotate;
var
  Rotation: array [0 .. 1] of Single;
begin
  // get current rotation
  Rotation[0] := FSfmlText.Rotation;

  // perform rotation
  FSfmlText.Rotate(0.5);

  // get current rotation
  Rotation[1] := FSfmlText.Rotation;

  // compare rotation
  CheckEquals(Rotation[0] + 0.5, Rotation[1]);
end;

procedure TestTSfmlText.TestScale;
var
  Factor: array [0 .. 1] of TSfmlVector2f;
begin
  // get current scale factor
  Factor[0] := FSfmlText.ScaleFactor;

  FSfmlText.Scale(SfmlVector2f(2, 2));

  // get current scale factor
  Factor[1] := FSfmlText.ScaleFactor;

  // compare scale factors
  CheckEquals(Factor[0].X * 2, Factor[1].X);
  CheckEquals(Factor[0].Y * 2, Factor[1].Y);
end;


{ TestTSfmlTexture }

procedure TestTSfmlTexture.SetUp;
begin
  Assert(FileExists('../Resources/Sfml.png'));
  FSfmlTexture := TSfmlTexture.Create('../Resources/Sfml.png');
end;

procedure TestTSfmlTexture.TearDown;
begin
  FSfmlTexture.Free;
  FSfmlTexture := nil;
end;

procedure TestTSfmlTexture.TestCopy;
var
  ReturnValue: TSfmlTexture;
begin
  ReturnValue := FSfmlTexture.Copy;

  CheckEquals(FSfmlTexture.Repeated, ReturnValue.Repeated);
  CheckEquals(FSfmlTexture.Smooth, ReturnValue.Smooth);
  CheckEquals(FSfmlTexture.Size.X, ReturnValue.Size.X);
  CheckEquals(FSfmlTexture.Size.Y, ReturnValue.Size.Y);
end;

procedure TestTSfmlTexture.TestCopyToImage;
var
  Original, Image: TSfmlImage;
  Data: array [0 .. 1] of PByte;
  Index: Integer;
begin
  FSfmlTexture.Smooth := False;
  FSfmlTexture.Repeated := False;
  Image := FSfmlTexture.CopyToImage;
  Assert(FileExists('../Resources/Sfml.png'));
  Original := TSfmlImage.Create('../Resources/Sfml.png');

  Data[0] := Original.GetPixelsPtr;
  Data[1] := Image.GetPixelsPtr;
  for Index := 0 to 4 * (FSfmlTexture.Size.X * FSfmlTexture.Size.Y) - 1 do
  begin
    CheckEquals(Data[0]^, Data[1]^);
    Inc(Data[0]);
    Inc(Data[1]);
  end;
end;

procedure TestTSfmlTexture.TestBind;
begin
  FSfmlTexture.Bind;
  // TODO: Check results
end;

procedure TestTSfmlTexture.TestUpdateFromImageAndPixels;
var
  Image: TSfmlImage;
begin
  Assert(FileExists('../Resources/Sfml.png'));
  Image := TSfmlImage.Create('../Resources/Sfml.png');

  FSfmlTexture.UpdateFromImage(Image, 0, 0);

  // TODO: Check results

  FSfmlTexture.UpdateFromPixels(Image.GetPixelsPtr, Image.Size.X - 1,
    Image.Size.Y - 1, 0, 0);

  // TODO: Check results
end;

procedure TestTSfmlTexture.TestUpdateFromWindow;
var
  Window: TSfmlWindow;
  RenderWindow: TSfmlRenderWindow;
begin
  Window := TSfmlWindow.Create(SfmlVideoMode(800, 600), 'Test',
    [sfTitleBar, sfClose]);
  try
    Window.Display;

    FSfmlTexture.UpdateFromWindow(Window.Handle, 0, 0);

    Window.Close;
  finally
    Window.Free;
  end;
  // TODO: Check results

  RenderWindow := TSfmlRenderWindow.Create(SfmlVideoMode(800, 600), 'Test',
    [sfTitleBar, sfClose]);
  try
    FSfmlTexture.UpdateFromRenderWindow(RenderWindow.Handle, 0, 0);

    RenderWindow.Close;
  finally
    RenderWindow.Free;
  end;
  // TODO: Check results
end;


{ TestTSfmlTransformable }

procedure TestTSfmlTransformable.SetUp;
begin
  FSfmlTransformable := TSfmlTransformable.Create;
end;

procedure TestTSfmlTransformable.TearDown;
begin
  FSfmlTransformable.Free;
  FSfmlTransformable := nil;
end;

procedure TestTSfmlTransformable.TestCopy;
var
  ReturnValue: TSfmlTransformable;
  Index: Integer;
begin
  ReturnValue := FSfmlTransformable.Copy;

  for Index := 0 to 8 do
    CheckEquals(FSfmlTransformable.InverseTransform.Matrix[Index], ReturnValue.InverseTransform.Matrix[Index]);
  CheckEquals(FSfmlTransformable.Origin.X, ReturnValue.Origin.X);
  CheckEquals(FSfmlTransformable.Origin.Y, ReturnValue.Origin.Y);
  CheckEquals(FSfmlTransformable.Position.X, ReturnValue.Position.X);
  CheckEquals(FSfmlTransformable.Position.Y, ReturnValue.Position.Y);
  CheckEquals(FSfmlTransformable.Rotation, ReturnValue.Rotation);
  CheckEquals(FSfmlTransformable.ScaleFactor.X, ReturnValue.ScaleFactor.X);
  CheckEquals(FSfmlTransformable.ScaleFactor.Y, ReturnValue.ScaleFactor.Y);
  for Index := 0 to 8 do
    CheckEquals(FSfmlTransformable.Transform.Matrix[Index], ReturnValue.Transform.Matrix[Index]);
end;

procedure TestTSfmlTransformable.TestMove;
var
  Pos: array [0 .. 1] of TSfmlVector2f;
begin
  // get current position
  Pos[0] := FSfmlTransformable.Position;

  // move shape
  FSfmlTransformable.Move(SfmlVector2f(10, 10));

  // get current position
  Pos[1] := FSfmlTransformable.Position;

  // compare positions
  CheckEquals(Pos[0].X + 10, Pos[1].X);
  CheckEquals(Pos[0].Y + 10, Pos[1].Y);
end;

procedure TestTSfmlTransformable.TestRotate;
var
  Rotation: array [0 .. 1] of Single;
begin
  // get current rotation
  Rotation[0] := FSfmlTransformable.Rotation;

  // perform rotation
  FSfmlTransformable.Rotate(0.5);

  // get current rotation
  Rotation[1] := FSfmlTransformable.Rotation;

  // compare rotation
  CheckEquals(Rotation[0] + 0.5, Rotation[1]);
end;

procedure TestTSfmlTransformable.TestScale;
var
  Factor: array [0 .. 1] of TSfmlVector2f;
begin
  // get current scale factor
  Factor[0] := FSfmlTransformable.ScaleFactor;

  FSfmlTransformable.Scale(SfmlVector2f(2, 2));

  // get current scale factor
  Factor[1] := FSfmlTransformable.ScaleFactor;

  // compare scale factors
  CheckEquals(Factor[0].X * 2, Factor[1].X);
  CheckEquals(Factor[0].Y * 2, Factor[1].Y);
end;


{ TestTSfmlVertexArray }

procedure TestTSfmlVertexArray.SetUp;
begin
  FSfmlVertexArray := TSfmlVertexArray.Create;
end;

procedure TestTSfmlVertexArray.TearDown;
begin
  FSfmlVertexArray.Free;
  FSfmlVertexArray := nil;
end;

procedure TestTSfmlVertexArray.TestCopy;
var
  ReturnValue: TSfmlVertexArray;
  Index: Integer;
begin
  ReturnValue := FSfmlVertexArray.Copy;

  CheckEquals(FSfmlVertexArray.Bounds.Left, ReturnValue.Bounds.Left);
  CheckEquals(FSfmlVertexArray.Bounds.Top, ReturnValue.Bounds.Top);
  CheckEquals(FSfmlVertexArray.Bounds.Width, ReturnValue.Bounds.Width);
  CheckEquals(FSfmlVertexArray.Bounds.Height, ReturnValue.Bounds.Height);
  CheckEquals(Integer(FSfmlVertexArray.PrimitiveType), Integer(ReturnValue.PrimitiveType));
  CheckEquals(FSfmlVertexArray.VertexCount, ReturnValue.VertexCount);
  for Index := 0 to FSfmlVertexArray.VertexCount - 1 do
  begin
    CheckEquals(FSfmlVertexArray.Vertex[Index].Position.X, ReturnValue.Vertex[Index].Position.X);
    CheckEquals(FSfmlVertexArray.Vertex[Index].Position.Y, ReturnValue.Vertex[Index].Position.Y);
    CheckEquals(FSfmlVertexArray.Vertex[Index].Color.Value, ReturnValue.Vertex[Index].Color.Value);
    CheckEquals(FSfmlVertexArray.Vertex[Index].TexCoords.X, ReturnValue.Vertex[Index].TexCoords.X);
    CheckEquals(FSfmlVertexArray.Vertex[Index].TexCoords.Y, ReturnValue.Vertex[Index].TexCoords.Y);
  end;
end;

procedure TestTSfmlVertexArray.TestAppendClearResize;
begin
  FSfmlVertexArray.Append(SfmlVertex(SfmlVector2f(2, 2), SfmlRed));
  FSfmlVertexArray.Append(SfmlVertex(SfmlVector2f(7, 5), SfmlGreen));
  FSfmlVertexArray.Append(SfmlVertex(SfmlVector2f(4, 9), SfmlBlue));
  CheckEquals(3, FSfmlVertexArray.VertexCount);

  FSfmlVertexArray.Resize(1);
  CheckEquals(1, FSfmlVertexArray.VertexCount);

  FSfmlVertexArray.Resize(2);
  CheckEquals(2, FSfmlVertexArray.VertexCount);

  FSfmlVertexArray.Vertex[1].Position := SfmlVector2f(10, 10);
  FSfmlVertexArray.Vertex[1].Color := SfmlRed;

  FSfmlVertexArray.Clear;
  CheckEquals(0, FSfmlVertexArray.VertexCount);
end;


{ TestTSfmlView }

procedure TestTSfmlView.SetUp;
begin
  FSfmlView := TSfmlView.Create;
end;

procedure TestTSfmlView.TearDown;
begin
  FSfmlView.Free;
  FSfmlView := nil;
end;

procedure TestTSfmlView.TestCopy;
var
  ReturnValue: TSfmlView;
begin
  ReturnValue := FSfmlView.Copy;

  CheckEquals(FSfmlView.Center.X, ReturnValue.Center.X);
  CheckEquals(FSfmlView.Center.Y, ReturnValue.Center.Y);
  CheckEquals(FSfmlView.Rotation, ReturnValue.Rotation);
  CheckEquals(FSfmlView.Size.X, ReturnValue.Size.X);
  CheckEquals(FSfmlView.Size.Y, ReturnValue.Size.Y);
  CheckEquals(FSfmlView.Viewport.Left, ReturnValue.Viewport.Left);
  CheckEquals(FSfmlView.Viewport.Top, ReturnValue.Viewport.Top);
  CheckEquals(FSfmlView.Viewport.Width, ReturnValue.Viewport.Width);
  CheckEquals(FSfmlView.Viewport.Height, ReturnValue.Viewport.Height);
end;

procedure TestTSfmlView.TestMove;
begin
  // move shape
  FSfmlView.Move(SfmlVector2f(10, 10));

  // check result
end;

procedure TestTSfmlView.TestReset;
var
  Rectangle: TSfmlFloatRect;
begin
  // TODO: Methodenaufrufparameter einrichten
  FSfmlView.Reset(Rectangle);
  // TODO: Check results
end;

procedure TestTSfmlView.TestRotate;
var
  Angle: Single;
begin
  Angle := 0.5;
  FSfmlView.Rotate(Angle);
  // TODO: Check results
end;

procedure TestTSfmlView.TestZoom;
var
  Factor: Single;
begin
  Factor := 2;
  FSfmlView.Zoom(Factor);
  // TODO: Check results
end;

initialization
  RegisterTest('SfmlGraphics', TestTSfmlCircleShape.Suite);
  RegisterTest('SfmlGraphics', TestTSfmlConvexShape.Suite);
  RegisterTest('SfmlGraphics', TestTSfmlFont.Suite);
  RegisterTest('SfmlGraphics', TestTSfmlImage.Suite);
  RegisterTest('SfmlGraphics', TestTSfmlRectangleShape.Suite);
  RegisterTest('SfmlGraphics', TestTSfmlRenderTexture.Suite);
  RegisterTest('SfmlGraphics', TestTSfmlRenderWindow.Suite);
  RegisterTest('SfmlGraphics', TestTSfmlShader.Suite);
  RegisterTest('SfmlGraphics', TestTSfmlShape.Suite);
  RegisterTest('SfmlGraphics', TestTSfmlSprite.Suite);
  RegisterTest('SfmlGraphics', TestTSfmlText.Suite);
  RegisterTest('SfmlGraphics', TestTSfmlTexture.Suite);
  RegisterTest('SfmlGraphics', TestTSfmlTransformable.Suite);
  RegisterTest('SfmlGraphics', TestTSfmlVertexArray.Suite);
  RegisterTest('SfmlGraphics', TestTSfmlView.Suite);
end.
