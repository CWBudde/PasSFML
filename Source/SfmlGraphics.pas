unit SfmlGraphics;

////////////////////////////////////////////////////////////////////////////////
//
// PasSFML - Simple and Fast Multimedia Library for Pascal
// Copyright (C) 2015-2017 Christian-W. Budde (Christian@pcjv.de)
//
// This software is provided 'as-is', without any express or implied warranty.
// In no event will the authors be held liable for any damages arising from the use of this software.
//
// Permission is granted to anyone to use this software for any purpose,
// including commercial applications, and to alter it and redistribute it freely,
// subject to the following restrictions:
//
// 1. The origin of this software must not be misrepresented;
//    you must not claim that you wrote the original software.
//    If you use this software in a product, an acknowledgment
//    in the product documentation would be appreciated but is not required.
//
// 2. Altered Source versions must be plainly marked as such,
//    and must not be misrepresented as being the original software.
//
// 3. This notice may not be removed or altered from any Source distribution.
//
////////////////////////////////////////////////////////////////////////////////

interface

{$I Sfml.inc}

uses
  SfmlWindow, SfmlSystem;

const
{$IF Defined(MSWINDOWS)}
  CSfmlGraphicsLibrary = 'csfml-graphics-2.dll';
{$ELSEIF Defined(DARWIN) or Defined(MACOS)}
  CSfmlGraphicsLibrary = 'csfml-graphics-2.dylib';
{$ELSEIF Defined(UNIX)}
  CSfmlGraphicsLibrary = 'csfml-graphics.so';
{$IFEND}

type
  // opaque structures
  TSfmlCircleShapeRecord = record end;
  TSfmlConvexShapeRecord = record end;
  TSfmlFontRecord = record end;
  TSfmlImageRecord = record end;
  TSfmlShaderRecord = record end;
  TSfmlRectangleShapeRecord = record end;
  TSfmlRenderTextureRecord = record end;
  TSfmlRenderWindowRecord = record end;
  TSfmlShapeRecord = record end;
  TSfmlSpriteRecord = record end;
  TSfmlTextRecord = record end;
  TSfmlTextureRecord = record end;
  TSfmlTransformableRecord = record end;
  TSfmlVertexArrayRecord = record end;
  TSfmlViewRecord = record end;

  // handles for opaque structures
  PSfmlCircleShape = ^TSfmlCircleShapeRecord;
  PSfmlConvexShape = ^TSfmlConvexShapeRecord;
  PSfmlFont = ^TSfmlFontRecord;
  PSfmlImage = ^TSfmlImageRecord;
  PSfmlShader = ^TSfmlShaderRecord;
  PSfmlRectangleShape = ^TSfmlRectangleShapeRecord;
  PSfmlRenderTexture = ^TSfmlRenderTextureRecord;
  PSfmlRenderWindow = ^TSfmlRenderWindowRecord;
  PSfmlShape = ^TSfmlShapeRecord;
  PSfmlSprite = ^TSfmlSpriteRecord;
  PSfmlText = ^TSfmlTextRecord;
  PSfmlTexture = ^TSfmlTextureRecord;
  PSfmlTransformable = ^TSfmlTransformableRecord;
  PSfmlVertexArray = ^TSfmlVertexArrayRecord;
  PSfmlView = ^TSfmlViewRecord;

  TSfmlBlendFactor = (sfBlendFactorZero, sfBlendFactorOne,
    sfBlendFactorSrcColor, sfBlendFactorOneMinusSrcColor,
    sfBlendFactorDstColor, sfBlendFactorOneMinusDstColor,
    sfBlendFactorSrcAlpha, sfBlendFactorOneMinusSrcAlpha,
    sfBlendFactorDstAlpha, sfBlendFactorOneMinusDstAlpha);

  TSfmlBlendEquation = (sfBlendEquationAdd, sfBlendEquationSubtract,
    sfBlendEquationReverseSubtract);

  TSfmlBlendMode = record
    ColorSrcFactor: TSfmlBlendFactor;
    ColorDstFactor: TSfmlBlendFactor;
    ColorEquation: TSfmlBlendEquation;
    AlphaSrcFactor: TSfmlBlendFactor;
    AlphaDstFactor: TSfmlBlendFactor;
    AlphaEquation: TSfmlBlendEquation;
  end;

  TSfmlColor = packed record
    case LongInt of
      0: (R, G, B, A: Byte);
      1: (Value: LongInt);
  end;

  TSfmlFontInfo = record
    Family: PAnsiChar;
  end;

  TSfmlFloatRect = record
    Left, Top, Width, Height: Single;
    {$IFDEF RecordConstructors}
    constructor Create(Left, Top, Width, Height: Single);
    {$ENDIF}
    {$IFDEF RecordOperators}
    class operator Equal(const Lhs, Rhs: TSfmlFloatRect): Boolean;
    {$ENDIF}
  end;

  TSfmlIntRect = record
    Left, Top, Width, Height: LongInt;
    {$IFDEF RecordConstructors}
    constructor Create(Left, Top, Width, Height: LongInt);
    {$ENDIF}
    {$IFDEF RecordOperators}
    class operator Equal(const Lhs, Rhs: TSfmlIntRect): Boolean;

    class operator Implicit(A: TSfmlFloatRect): TSfmlIntRect;
    class operator Implicit(A: TSfmlIntRect): TSfmlFloatRect;
    class operator Explicit(A: TSfmlFloatRect): TSfmlIntRect;
    class operator Explicit(A: TSfmlIntRect): TSfmlFloatRect;
    {$ENDIF}
  end;
  PSfmlIntRect = ^TSfmlIntRect;

  TSfmlGlyph = record
    Advance: Single;
    Bounds: TSfmlFloatRect;
    TextureRect: TSfmlIntRect;
  end;

  TSfmlPrimitiveType = (sfPoints, sfLines, sfLineStrip, sfTriangles,
    sfTriangleStrip, sfTriangleFan, sfQuads,

    sfLinesStrip, sfTrianglesStrip, sfTrianglesFan // deprecated (use version without plural 's'
  );

  TMatrixData = array [0 .. 8] of Single;

  // 2D vectors
  TSfmlGlslVec2 = TSfmlVector2f;
  PSfmlGlslVec2 = ^TSfmlGlslVec2;
  TSfmlGlslIvec2 = TSfmlVector2i;
  PSfmlGlslIvec2 = ^TSfmlGlslIvec2;

  TSfmlGlslBvec2 = record
    x, y: LongBool;
  end;
  PSfmlGlslBvec2 = ^TSfmlGlslBvec2;

  // 3D vectors
  TSfmlGlslVec3 = TSfmlVector3f;
  PSfmlGlslVec3 = ^TSfmlGlslVec3;
  TSfmlGlslIvec3 = record
    X, Y, Z: Integer;
  end;
  PSfmlGlslIvec3 = ^TSfmlGlslIvec3;
  TSfmlGlslBvec3 = record
    X, Y, Z: LongBool;
  end;
  PSfmlGlslBvec3 = ^TSfmlGlslBvec3;

  // 4D vectors
  TSfmlGlslVec4 = record
    X, Y, Z, W: Single;
  end;
  PSfmlGlslVec4 = ^TSfmlGlslVec4;

  TSfmlGlslIvec4 = record
    X, Y, Z, W: Integer;
  end;
  PSfmlGlslIvec4 = ^TSfmlGlslIvec4;

  TSfmlGlslBvec4 = record
    X, Y, Z, W: LongBool;
  end;
  PSfmlGlslBvec4 = ^TSfmlGlslBvec4;

  // matrices
  TSfmlGlslMat3 = array [0..2, 0..2] of Single;
  PSfmlGlslMat3 = ^TSfmlGlslMat3;
  TSfmlGlslMat4 = array [0..3, 0..3] of Single;
  PSfmlGlslMat4 = ^TSfmlGlslMat4;

  TSfmlTransform = record
    Matrix : TMatrixData;
    {$IFDEF RecordConstructors}
    constructor Create(Matrix : TMatrixData);
    {$ENDIF}
    {$IFDEF RecordOperators}
    class operator Equal(const Lhs, Rhs: TSfmlTransform): Boolean;
    class operator NotEqual(const Lhs, Rhs: TSfmlTransform): Boolean;
    class operator Multiply(const Lhs, Rhs: TSfmlTransform): TSfmlTransform; overload;
    class operator Multiply(const Lhs: TSfmlTransform; Rhs: TSfmlVector2f): TSfmlVector2f; overload;
    {$ENDIF}

    function GetInverse: TSfmlTransform;
    function TransformPoint(Point: TSfmlVector2f): TSfmlVector2f;
    function TransformRect(Rectangle: TSfmlFloatRect): TSfmlFloatRect;
    procedure Translate(X, Y: Single);
    procedure Rotate(Angle: Single);
    procedure RotateWithCenter(Angle: Single; centerX, centerY: Single);
    procedure Scale(ScaleX, ScaleY: Single);
    procedure ScaleWithCenter(ScaleX, ScaleY, CenterX, CenterY: Single);
  end;
  PSfmlTransform = ^TSfmlTransform;

  TSfmlRenderStates = record
    BlendMode: TSfmlBlendMode;
    Transform: TSfmlTransform;
    {$IFDEF CPUX64}
    Dummy: array [0..3] of Byte;
    {$ENDIF}
    Texture: PSfmlTexture;
    Shader: PSfmlShader;
  end;
  PSfmlRenderStates = ^TSfmlRenderStates;

  TSfmlShapeGetPointCountCallback = function (UserData: Pointer): NativeUInt; cdecl;
  TSfmlShapeGetPointCallback = function (Index: NativeUInt; UserData: Pointer): TSfmlVector2f; cdecl;

  TSfmlTextStyle = (sfTextBold, sfTextItalic, sfTextUnderlined,
    sfTextStrikeThrough);
  TSfmlTextStyles = set of TSfmlTextStyle;

  TSfmlVertex = record
    Position: TSfmlVector2f;
    Color: TSfmlColor;
    TexCoords: TSfmlVector2f;
  end;
  PSfmlVertex = ^TSfmlVertex;

{$IFDEF DynLink}
  TSfmlColorFromRGB = function (Red, Green, Blue: Byte): TSfmlColor; cdecl;
  TSfmlColorFromRGBA = function (Red, Green, Blue, Alpha: Byte): TSfmlColor; cdecl;

  TSfmlColorFromInteger = function (Color: Cardinal): TSfmlColor; cdecl;
  TSfmlColorToInteger = function (Color: TSfmlColor): Cardinal; cdecl;

  TSfmlColorAdd = function (color1, color2: TSfmlColor): TSfmlColor; cdecl;
  TSfmlColorSubtract = function (color1, color2: TSfmlColor): TSfmlColor; cdecl;
  TSfmlColorModulate = function (color1, color2: TSfmlColor): TSfmlColor; cdecl;

  TSfmlCircleShapeCreate = function : PSfmlCircleShape; cdecl;
  TSfmlCircleShapeCopy = function (const Shape: PSfmlCircleShape): PSfmlCircleShape; cdecl;
  TSfmlCircleShapeDestroy = procedure (Shape: PSfmlCircleShape); cdecl;
  TSfmlCircleShapeSetPosition = procedure (Shape: PSfmlCircleShape; Position: TSfmlVector2f); cdecl;
  TSfmlCircleShapeSetRotation = procedure (Shape: PSfmlCircleShape; Angle: Single); cdecl;
  TSfmlCircleShapeSetScale = procedure (Shape: PSfmlCircleShape; Scale: TSfmlVector2f); cdecl;
  TSfmlCircleShapeSetOrigin = procedure (Shape: PSfmlCircleShape; Origin: TSfmlVector2f); cdecl;
  TSfmlCircleShapeGetPosition = function (const Shape: PSfmlCircleShape): TSfmlVector2f; cdecl;
  TSfmlCircleShapeGetRotation = function (const Shape: PSfmlCircleShape): Single; cdecl;
  TSfmlCircleShapeGetScale = function (const Shape: PSfmlCircleShape): TSfmlVector2f; cdecl;
  TSfmlCircleShapeGetOrigin = function (const Shape: PSfmlCircleShape): TSfmlVector2f; cdecl;
  TSfmlCircleShapeMove = procedure (Shape: PSfmlCircleShape; Offset: TSfmlVector2f); cdecl;
  TSfmlCircleShapeRotate = procedure (Shape: PSfmlCircleShape; Angle: Single); cdecl;
  TSfmlCircleShapeScale = procedure (Shape: PSfmlCircleShape; Factors: TSfmlVector2f); cdecl;
  TSfmlCircleShapeGetTransform = function (const Shape: PSfmlCircleShape): TSfmlTransform; cdecl;
  TSfmlCircleShapeGetInverseTransform = function (const Shape: PSfmlCircleShape): TSfmlTransform; cdecl;
  TSfmlCircleShapeSetTexture = procedure (Shape: PSfmlCircleShape; const Texture: PSfmlTexture; ResetRect: LongBool); cdecl;
  TSfmlCircleShapeSetTextureRect = procedure (Shape: PSfmlCircleShape; Rect: TSfmlIntRect); cdecl;
  TSfmlCircleShapeSetFillColor = procedure (Shape: PSfmlCircleShape; Color: TSfmlColor); cdecl;
  TSfmlCircleShapeSetOutlineColor = procedure (Shape: PSfmlCircleShape; Color: TSfmlColor); cdecl;
  TSfmlCircleShapeSetOutlineThickness = procedure (Shape: PSfmlCircleShape; Thickness: Single); cdecl;
  TSfmlCircleShapeGetTexture = function (const Shape: PSfmlCircleShape): PSfmlTexture; cdecl;
  TSfmlCircleShapeGetTextureRect = function (const Shape: PSfmlCircleShape): TSfmlIntRect; cdecl;
  TSfmlCircleShapeGetFillColor = function (const Shape: PSfmlCircleShape): TSfmlColor; cdecl;
  TSfmlCircleShapeGetOutlineColor = function (const Shape: PSfmlCircleShape): TSfmlColor; cdecl;
  TSfmlCircleShapeGetOutlineThickness = function (const Shape: PSfmlCircleShape): Single; cdecl;
  TSfmlCircleShapeGetPointCount = function (const Shape: PSfmlCircleShape): NativeUInt; cdecl;
  TSfmlCircleShapeGetPoint = function (const Shape: PSfmlCircleShape; Index: NativeUInt): TSfmlVector2f; cdecl;
  TSfmlCircleShapeSetRadius = procedure (Shape: PSfmlCircleShape; Radius: Single); cdecl;
  TSfmlCircleShapeGetRadius = function (const Shape: PSfmlCircleShape): Single; cdecl;
  TSfmlCircleShapeSetPointCount = procedure (Shape: PSfmlCircleShape; Count: NativeUInt); cdecl;
  TSfmlCircleShapeGetLocalBounds = function (const Shape: PSfmlCircleShape): TSfmlFloatRect; cdecl;
  TSfmlCircleShapeGetGlobalBounds = function (const Shape: PSfmlCircleShape): TSfmlFloatRect; cdecl;

  TSfmlConvexShapeCreate = function : PSfmlConvexShape; cdecl;
  TSfmlConvexShapeCopy = function (const Shape: PSfmlConvexShape): PSfmlConvexShape; cdecl;
  TSfmlConvexShapeDestroy = procedure (Shape: PSfmlConvexShape); cdecl;
  TSfmlConvexShapeSetPosition = procedure (Shape: PSfmlConvexShape; Position: TSfmlVector2f); cdecl;
  TSfmlConvexShapeSetRotation = procedure (Shape: PSfmlConvexShape; Angle: Single); cdecl;
  TSfmlConvexShapeSetScale = procedure (Shape: PSfmlConvexShape; Scale: TSfmlVector2f); cdecl;
  TSfmlConvexShapeSetOrigin = procedure (Shape: PSfmlConvexShape; Origin: TSfmlVector2f); cdecl;
  TSfmlConvexShapeGetPosition = function (const Shape: PSfmlConvexShape): TSfmlVector2f; cdecl;
  TSfmlConvexShapeGetRotation = function (const Shape: PSfmlConvexShape): Single; cdecl;
  TSfmlConvexShapeGetScale = function (const Shape: PSfmlConvexShape): TSfmlVector2f; cdecl;
  TSfmlConvexShapeGetOrigin = function (const Shape: PSfmlConvexShape): TSfmlVector2f; cdecl;
  TSfmlConvexShapeMove = procedure (Shape: PSfmlConvexShape; Offset: TSfmlVector2f); cdecl;
  TSfmlConvexShapeRotate = procedure (Shape: PSfmlConvexShape; Angle: Single); cdecl;
  TSfmlConvexShapeScale = procedure (Shape: PSfmlConvexShape; Factors: TSfmlVector2f); cdecl;
  TSfmlConvexShapeGetTransform = function (const Shape: PSfmlConvexShape): TSfmlTransform; cdecl;
  TSfmlConvexShapeGetInverseTransform = function (const Shape: PSfmlConvexShape): TSfmlTransform; cdecl;
  TSfmlConvexShapeSetTexture = procedure (Shape: PSfmlConvexShape; const Texture: PSfmlTexture; ResetRect: LongBool); cdecl;
  TSfmlConvexShapeSetTextureRect = procedure (Shape: PSfmlConvexShape; Rect: TSfmlIntRect); cdecl;
  TSfmlConvexShapeSetFillColor = procedure (Shape: PSfmlConvexShape; Color: TSfmlColor); cdecl;
  TSfmlConvexShapeSetOutlineColor = procedure (Shape: PSfmlConvexShape; Color: TSfmlColor); cdecl;
  TSfmlConvexShapeSetOutlineThickness = procedure (Shape: PSfmlConvexShape; Thickness: Single); cdecl;
  TSfmlConvexShapeGetTexture = function (const Shape: PSfmlConvexShape): PSfmlTexture; cdecl;
  TSfmlConvexShapeGetTextureRect = function (const Shape: PSfmlConvexShape): TSfmlIntRect; cdecl;
  TSfmlConvexShapeGetFillColor = function (const Shape: PSfmlConvexShape): TSfmlColor; cdecl;
  TSfmlConvexShapeGetOutlineColor = function (const Shape: PSfmlConvexShape): TSfmlColor; cdecl;
  TSfmlConvexShapeGetOutlineThickness = function (const Shape: PSfmlConvexShape): Single; cdecl;
  TSfmlConvexShapeGetPointCount = function (const Shape: PSfmlConvexShape): NativeUInt; cdecl;
  TSfmlConvexShapeGetPoint = function (const Shape: PSfmlConvexShape; Index: NativeUInt): TSfmlVector2f; cdecl;
  TSfmlConvexShapeSetPointCount = procedure (Shape: PSfmlConvexShape; Count: NativeUInt); cdecl;
  TSfmlConvexShapeSetPoint = procedure (Shape: PSfmlConvexShape; Index: NativeUInt; Point: TSfmlVector2f); cdecl;
  TSfmlConvexShapeGetLocalBounds = function (const Shape: PSfmlConvexShape): TSfmlFloatRect; cdecl;
  TSfmlConvexShapeGetGlobalBounds = function (const Shape: PSfmlConvexShape): TSfmlFloatRect; cdecl;

  TSfmlFontCreateFromFile = function (const FileName: PAnsiChar): PSfmlFont; cdecl;
  TSfmlFontCreateFromMemory = function (const Data: Pointer; SizeInBytes: NativeUInt): PSfmlFont; cdecl;
  TSfmlFontCreateFromStream = function (const Stream: PSfmlInputStream): PSfmlFont; cdecl;
  TSfmlFontCopy = function (const Font: PSfmlFont): PSfmlFont; cdecl;
  TSfmlFontDestroy = procedure (Font: PSfmlFont); cdecl;
  TSfmlFontGetGlyph = function (const Font: PSfmlFont; CodePoint: Cardinal; CharacterSize: Cardinal; Bold: LongBool): TSfmlGlyph; cdecl;
  TSfmlFontGetKerning = function (const Font: PSfmlFont; First, Second: Cardinal; CharacterSize: Cardinal): Single; cdecl;
  TSfmlFontGetLineSpacing = function (const Font: PSfmlFont; CharacterSize: Cardinal): Single; cdecl;
  TSfmlFontGetUnderlinePosition = function (const Font: PSfmlFont; CharacterSize: Cardinal): Single; cdecl;
  TSfmlFontGetUnderlineThickness = function (const Font: PSfmlFont; CharacterSize: Cardinal): Single; cdecl;
  TSfmlFontGetTexture = function (Font: PSfmlFont; CharacterSize: Cardinal): PSfmlTexture; cdecl;
  TSfmlFontGetInfo = function (const Font: PSfmlFont): TSfmlFontInfo; cdecl;

  TSfmlImageCreate = function (Width, Height: Cardinal): PSfmlImage; cdecl;
  TSfmlImageCreateFromColor = function (Width, Height: Cardinal; Color: TSfmlColor): PSfmlImage; cdecl;
  TSfmlImageCreateFromPixels = function (Width, Height: Cardinal; const Pixels: PByte): PSfmlImage; cdecl;
  TSfmlImageCreateFromFile = function (const FileName: PAnsiChar): PSfmlImage; cdecl;
  TSfmlImageCreateFromMemory = function (const Data: Pointer; Size: NativeUInt): PSfmlImage; cdecl;
  TSfmlImageCreateFromStream = function (const Stream: PSfmlInputStream): PSfmlImage; cdecl;
  TSfmlImageCopy = function (const Image: PSfmlImage): PSfmlImage; cdecl;
  TSfmlImageDestroy = procedure (Image: PSfmlImage); cdecl;
  TSfmlImageSaveToFile = function (const Image: PSfmlImage; const FileName: PAnsiChar): LongBool; cdecl;
  TSfmlImageGetSize = function (const Image: PSfmlImage): TSfmlVector2u; cdecl;
  TSfmlImageCreateMaskFromColor = procedure (Image: PSfmlImage; Color: TSfmlColor; Alpha: Byte); cdecl;
  TSfmlImageCopyImage = procedure (Image: PSfmlImage; const Source: PSfmlImage; DestX, DestY: Cardinal; SourceRect: TSfmlIntRect; ApplyAlpha: LongBool); cdecl;
  TSfmlImageSetPixel = procedure (Image: PSfmlImage; X, Y: Cardinal; Color: TSfmlColor); cdecl;
  TSfmlImageGetPixel = function (const Image: PSfmlImage; X, Y: Cardinal): TSfmlColor; cdecl;
  TSfmlImageGetPixelsPtr = function (const Image: PSfmlImage): PByte; cdecl;
  TSfmlImageFlipHorizontally = procedure (Image: PSfmlImage); cdecl;
  TSfmlImageFlipVertically = procedure (Image: PSfmlImage); cdecl;

  TSfmlFloatRectContains = function (var Rect: TSfmlFloatRect; X, Y: Single): LongBool; cdecl;
  TSfmlIntRectContains = function (var Rect: TSfmlIntRect; X, Y: LongInt): LongBool; cdecl;
  TSfmlFloatRectIntersects = function (var rect1, rect2: TSfmlFloatRect; var Intersection: TSfmlFloatRect): LongBool; cdecl;
  TSfmlIntRectIntersects = function (var rect1, rect2: TSfmlIntRect; var Intersection: TSfmlFloatRect): LongBool; cdecl;

  TSfmlRectangleShapeCreate = function : PSfmlRectangleShape; cdecl;
  TSfmlRectangleShapeCopy = function (const Shape: PSfmlRectangleShape): PSfmlRectangleShape; cdecl;
  TSfmlRectangleShapeDestroy = procedure (Shape: PSfmlRectangleShape); cdecl;
  TSfmlRectangleShapeSetPosition = procedure (Shape: PSfmlRectangleShape; Position: TSfmlVector2f); cdecl;
  TSfmlRectangleShapeSetRotation = procedure (Shape: PSfmlRectangleShape; Angle: Single); cdecl;
  TSfmlRectangleShapeSetScale = procedure (Shape: PSfmlRectangleShape; Scale: TSfmlVector2f); cdecl;
  TSfmlRectangleShapeSetOrigin = procedure (Shape: PSfmlRectangleShape; Origin: TSfmlVector2f); cdecl;
  TSfmlRectangleShapeGetPosition = function (const Shape: PSfmlRectangleShape): TSfmlVector2f; cdecl;
  TSfmlRectangleShapeGetRotation = function (const Shape: PSfmlRectangleShape): Single; cdecl;
  TSfmlRectangleShapeGetScale = function (const Shape: PSfmlRectangleShape): TSfmlVector2f; cdecl;
  TSfmlRectangleShapeGetOrigin = function (const Shape: PSfmlRectangleShape): TSfmlVector2f; cdecl;
  TSfmlRectangleShapeMove = procedure (Shape: PSfmlRectangleShape; Offset: TSfmlVector2f); cdecl;
  TSfmlRectangleShapeRotate = procedure (Shape: PSfmlRectangleShape; Angle: Single); cdecl;
  TSfmlRectangleShapeScale = procedure (Shape: PSfmlRectangleShape; Factors: TSfmlVector2f); cdecl;
  TSfmlRectangleShapeGetTransform = function (const Shape: PSfmlRectangleShape): TSfmlTransform; cdecl;
  TSfmlRectangleShapeGetInverseTransform = function (const Shape: PSfmlRectangleShape): TSfmlTransform; cdecl;
  TSfmlRectangleShapeSetTexture = procedure (Shape: PSfmlRectangleShape; const Texture: PSfmlTexture; ResetRect: LongBool); cdecl;
  TSfmlRectangleShapeSetTextureRect = procedure (Shape: PSfmlRectangleShape; Rect: TSfmlIntRect); cdecl;
  TSfmlRectangleShapeSetFillColor = procedure (Shape: PSfmlRectangleShape; Color: TSfmlColor); cdecl;
  TSfmlRectangleShapeSetOutlineColor = procedure (Shape: PSfmlRectangleShape; Color: TSfmlColor); cdecl;
  TSfmlRectangleShapeSetOutlineThickness = procedure (Shape: PSfmlRectangleShape; Thickness: Single); cdecl;
  TSfmlRectangleShapeGetTexture = function (const Shape: PSfmlRectangleShape): PSfmlTexture; cdecl;
  TSfmlRectangleShapeGetTextureRect = function (const Shape: PSfmlRectangleShape): TSfmlIntRect; cdecl;
  TSfmlRectangleShapeGetFillColor = function (const Shape: PSfmlRectangleShape): TSfmlColor; cdecl;
  TSfmlRectangleShapeGetOutlineColor = function (const Shape: PSfmlRectangleShape): TSfmlColor; cdecl;
  TSfmlRectangleShapeGetOutlineThickness = function (const Shape: PSfmlRectangleShape): Single; cdecl;
  TSfmlRectangleShapeGetPointCount = function (const Shape: PSfmlRectangleShape): NativeUInt; cdecl;
  TSfmlRectangleShapeGetPoint = function (const Shape: PSfmlRectangleShape; Index: NativeUInt): TSfmlVector2f; cdecl;
  TSfmlRectangleShapeSetSize = procedure (Shape: PSfmlRectangleShape; Size: TSfmlVector2f); cdecl;
  TSfmlRectangleShapeGetSize = function (const Shape: PSfmlRectangleShape): TSfmlVector2f; cdecl;
  TSfmlRectangleShapeGetLocalBounds = function (const Shape: PSfmlRectangleShape): TSfmlFloatRect; cdecl;
  TSfmlRectangleShapeGetGlobalBounds = function (const Shape: PSfmlRectangleShape): TSfmlFloatRect; cdecl;

  TSfmlRenderTextureCreate = function (Width, Height: Cardinal; DepthBuffer: LongBool): PSfmlRenderTexture; cdecl;
  TSfmlRenderTextureDestroy = procedure (RenderTexture: PSfmlRenderTexture); cdecl;
  TSfmlRenderTextureGetSize = function (const RenderTexture: PSfmlRenderTexture): TSfmlVector2u; cdecl;
  TSfmlRenderTextureSetActive = function (RenderTexture: PSfmlRenderTexture; Active: LongBool): LongBool; cdecl;
  TSfmlRenderTextureDisplay = procedure (RenderTexture: PSfmlRenderTexture); cdecl;
  TSfmlRenderTextureClear = procedure (RenderTexture: PSfmlRenderTexture; Color: TSfmlColor); cdecl;
  TSfmlRenderTextureSetView = procedure (RenderTexture: PSfmlRenderTexture; const View: PSfmlView); cdecl;
  TSfmlRenderTextureGetView = function (const RenderTexture: PSfmlRenderTexture): PSfmlView; cdecl;
  TSfmlRenderTextureGetDefaultView = function (const RenderTexture: PSfmlRenderTexture): PSfmlView; cdecl;
  TSfmlRenderTextureGetViewport = function (const RenderTexture: PSfmlRenderTexture; const View: PSfmlView): TSfmlIntRect; cdecl;
  TSfmlRenderTextureMapPixelToCoords = function (const RenderTexture: PSfmlRenderTexture; Point: TSfmlVector2i; const View: PSfmlView): TSfmlVector2f; cdecl;
  TSfmlRenderTextureMapCoordsToPixel = function (const RenderTexture: PSfmlRenderTexture; Point: TSfmlVector2i; const View: PSfmlView): TSfmlVector2i; cdecl;
  TSfmlRenderTextureDrawSprite = procedure (RenderTexture: PSfmlRenderTexture; const &Object: PSfmlSprite; const States: PSfmlRenderStates); cdecl;
  TSfmlRenderTextureDrawText = procedure (RenderTexture: PSfmlRenderTexture; const &Object: PSfmlText; const States: PSfmlRenderStates); cdecl;
  TSfmlRenderTextureDrawShape = procedure (RenderTexture: PSfmlRenderTexture; const &Object: PSfmlShape; const States: PSfmlRenderStates); cdecl;
  TSfmlRenderTextureDrawCircleShape = procedure (RenderTexture: PSfmlRenderTexture; const &Object: PSfmlCircleShape; const States: PSfmlRenderStates); cdecl;
  TSfmlRenderTextureDrawConvexShape = procedure (RenderTexture: PSfmlRenderTexture; const &Object: PSfmlConvexShape; const States: PSfmlRenderStates); cdecl;
  TSfmlRenderTextureDrawRectangleShape = procedure (RenderTexture: PSfmlRenderTexture; const &Object: PSfmlRectangleShape; const States: PSfmlRenderStates); cdecl;
  TSfmlRenderTextureDrawVertexArray = procedure (RenderTexture: PSfmlRenderTexture; const &Object: PSfmlVertexArray; const States: PSfmlRenderStates); cdecl;
  TSfmlRenderTextureDrawPrimitives = procedure (RenderTexture: PSfmlRenderTexture; const Vertices: PSfmlVertex; VertexCount: NativeUInt; &Type: TSfmlPrimitiveType; const States: PSfmlRenderStates); cdecl;
  TSfmlRenderTexturePushGLStates = procedure (RenderTexture: PSfmlRenderTexture); cdecl;
  TSfmlRenderTexturePopGLStates = procedure (RenderTexture: PSfmlRenderTexture); cdecl;
  TSfmlRenderTextureResetGLStates = procedure (RenderTexture: PSfmlRenderTexture); cdecl;
  TSfmlRenderTextureGetTexture = function (const RenderTexture: PSfmlRenderTexture): PSfmlTexture ; cdecl;
  TSfmlRenderTextureSetSmooth = procedure (RenderTexture: PSfmlRenderTexture; Smooth: LongBool); cdecl;
  TSfmlRenderTextureIsSmooth = function (const RenderTexture: PSfmlRenderTexture): LongBool; cdecl;
  TSfmlRenderTextureSetRepeated = procedure (RenderTexture: PSfmlRenderTexture; Repeated: LongBool); cdecl;
  TSfmlRenderTextureIsRepeated = function (const RenderTexture: PSfmlRenderTexture): LongBool; cdecl;
  TSfmlRenderTextureGenerateMipmap = function (const RenderTexture: PSfmlRenderTexture): LongBool; cdecl;

  TSfmlRenderWindowCreate = function (Mode: TSfmlVideoMode; const Title: PAnsiChar; Style: TSfmlWindowStyles; const Settings: PSfmlContextSettings): PSfmlRenderWindow; cdecl;
  TSfmlRenderWindowCreateUnicode = function (Mode: TSfmlVideoMode; const Title: PUCS4Char; Style: TSfmlWindowStyles; const Settings: PSfmlContextSettings): PSfmlRenderWindow; cdecl;
  TSfmlRenderWindowCreateFromHandle = function (Handle: TSfmlWindowHandle; const Settings: PSfmlContextSettings): PSfmlRenderWindow; cdecl;
  TSfmlRenderWindowDestroy = procedure (RenderWindow: PSfmlRenderWindow); cdecl;
  TSfmlRenderWindowClose = procedure (RenderWindow: PSfmlRenderWindow); cdecl;
  TSfmlRenderWindowIsOpen = function (const RenderWindow: PSfmlRenderWindow): LongBool; cdecl;
  TSfmlRenderWindowGetSettings = function (const RenderWindow: PSfmlRenderWindow): TSfmlContextSettings; cdecl;
  TSfmlRenderWindowPollEvent = function (RenderWindow: PSfmlRenderWindow; out Event: TSfmlEvent): LongBool; cdecl;
  TSfmlRenderWindowWaitEvent = function (RenderWindow: PSfmlRenderWindow; out Event: TSfmlEvent): LongBool; cdecl;
  TSfmlRenderWindowGetPosition = function (const RenderWindow: PSfmlRenderWindow): TSfmlVector2i; cdecl;
  TSfmlRenderWindowSetPosition = procedure (RenderWindow: PSfmlRenderWindow; Position: TSfmlVector2i); cdecl;
  TSfmlRenderWindowGetSize = function (const RenderWindow: PSfmlRenderWindow): TSfmlVector2u; cdecl;
  TSfmlRenderWindowSetSize = procedure (RenderWindow: PSfmlRenderWindow; Size: TSfmlVector2u); cdecl;
  TSfmlRenderWindowSetTitle = procedure (RenderWindow: PSfmlRenderWindow; const Title: PAnsiChar); cdecl;
  TSfmlRenderWindowSetUnicodeTitle = procedure (RenderWindow: PSfmlRenderWindow; const Title: PUCS4Char); cdecl;
  TSfmlRenderWindowSetIcon = procedure (RenderWindow: PSfmlRenderWindow; Width, Height: Cardinal; const Pixels: PByte); cdecl;
  TSfmlRenderWindowSetVisible = procedure (RenderWindow: PSfmlRenderWindow; Visible: LongBool); cdecl;
  TSfmlRenderWindowSetVerticalSyncEnabled = procedure (RenderWindow: PSfmlRenderWindow; Enabled: LongBool); cdecl;
  TSfmlRenderWindowSetMouseCursorVisible = procedure (RenderWindow: PSfmlRenderWindow; Show: LongBool); cdecl;
  TSfmlRenderWindowSetMouseCursorGrabbed = procedure (RenderWindow: PSfmlRenderWindow; Grabbed: LongBool); cdecl;
  TSfmlRenderWindowSetKeyRepeatEnabled = procedure (RenderWindow: PSfmlRenderWindow; Enabled: LongBool); cdecl;
  TSfmlRenderWindowSetFramerateLimit = procedure (RenderWindow: PSfmlRenderWindow; Limit: Cardinal); cdecl;
  TSfmlRenderWindowSetJoystickThreshold = procedure (RenderWindow: PSfmlRenderWindow; Threshold: Single); cdecl;
  TSfmlRenderWindowSetActive = function (RenderWindow: PSfmlRenderWindow; Active: LongBool): LongBool; cdecl;
  TSfmlRenderWindowRequestFocus = procedure (RenderWindow: PSfmlRenderWindow); cdecl;
  TSfmlRenderWindowHasFocus = function (const RenderWindow: PSfmlRenderWindow): LongBool; cdecl;
  TSfmlRenderWindowDisplay = procedure (RenderWindow: PSfmlRenderWindow); cdecl;
  TSfmlRenderWindowGetSystemHandle = function (const RenderWindow: PSfmlRenderWindow): TSfmlWindowHandle; cdecl;
  TSfmlRenderWindowClear = procedure (RenderWindow: PSfmlRenderWindow; Color: TSfmlColor); cdecl;
  TSfmlRenderWindowSetView = procedure (RenderWindow: PSfmlRenderWindow; const View: PSfmlView); cdecl;
  TSfmlRenderWindowGetView = function (const RenderWindow: PSfmlRenderWindow): PSfmlView; cdecl;
  TSfmlRenderWindowGetDefaultView = function (const RenderWindow: PSfmlRenderWindow): PSfmlView; cdecl;
  TSfmlRenderWindowGetViewport = function (const RenderWindow: PSfmlRenderWindow; const View: PSfmlView): TSfmlIntRect; cdecl;
  TSfmlRenderWindowMapPixelToCoords = function (const RenderWindow: PSfmlRenderWindow; Point: TSfmlVector2i; const View: PSfmlView): TSfmlVector2f; cdecl;
  TSfmlRenderWindowMapCoordsToPixel = function (const RenderWindow: PSfmlRenderWindow; Point: TSfmlVector2i; const View: PSfmlView): TSfmlVector2i; cdecl;
  TSfmlRenderWindowDrawSprite = procedure (RenderWindow: PSfmlRenderWindow; const &Object: PSfmlSprite; const States: PSfmlRenderStates); cdecl;
  TSfmlRenderWindowDrawText = procedure (RenderWindow: PSfmlRenderWindow; const &Object: PSfmlText; const States: PSfmlRenderStates); cdecl;
  TSfmlRenderWindowDrawShape = procedure (RenderWindow: PSfmlRenderWindow; const &Object: PSfmlShape; const States: PSfmlRenderStates); cdecl;
  TSfmlRenderWindowDrawCircleShape = procedure (RenderWindow: PSfmlRenderWindow; const &Object: PSfmlCircleShape; const States: PSfmlRenderStates); cdecl;
  TSfmlRenderWindowDrawConvexShape = procedure (RenderWindow: PSfmlRenderWindow; const &Object: PSfmlConvexShape; const States: PSfmlRenderStates); cdecl;
  TSfmlRenderWindowDrawRectangleShape = procedure (RenderWindow: PSfmlRenderWindow; const &Object: PSfmlRectangleShape; const States: PSfmlRenderStates); cdecl;
  TSfmlRenderWindowDrawVertexArray = procedure (RenderWindow: PSfmlRenderWindow; const &Object: PSfmlVertexArray; const States: PSfmlRenderStates); cdecl;
  TSfmlRenderWindowDrawPrimitives = procedure (RenderWindow: PSfmlRenderWindow; const Vertices: PSfmlVertex; VertexCount: NativeUInt; &Type: TSfmlPrimitiveType; const States: PSfmlRenderStates); cdecl;
  TSfmlRenderWindowPushGLStates = procedure (RenderWindow: PSfmlRenderWindow); cdecl;
  TSfmlRenderWindowPopGLStates = procedure (RenderWindow: PSfmlRenderWindow); cdecl;
  TSfmlRenderWindowResetGLStates = procedure (RenderWindow: PSfmlRenderWindow); cdecl;
  TSfmlRenderWindowCapture = function (const RenderWindow: PSfmlRenderWindow): PSfmlImage; cdecl;
  TSfmlMouseGetPositionRenderWindow = function (const relativeTo: PSfmlRenderWindow): TSfmlVector2i; cdecl;
  TSfmlMouseSetPositionRenderWindow = procedure (position: TSfmlVector2i; const RelativeTo: PSfmlRenderWindow); cdecl;
  TSfmlTouchGetPositionRenderWindow = function (Finger: Cardinal; const RelativeTo: PSfmlRenderWindow): TSfmlVector2i; cdecl;

  TSfmlShaderCreateFromFile = function (const VertexShaderFilename: PAnsiChar; GeometryShaderFilename: PAnsiChar; const FragmentShaderFilename: PAnsiChar): PSfmlShader; cdecl;
  TSfmlShaderCreateFromMemory = function (const VertexShader: PAnsiChar; const GeometryShader: PAnsiChar; const FragmentShader: PAnsiChar): PSfmlShader; cdecl;
  TSfmlShaderCreateFromStream = function (VertexShaderStream: PSfmlInputStream; GeometryShaderStream: PSfmlInputStream; FragmentShaderStream: PSfmlInputStream): PSfmlShader; cdecl;
  TSfmlShaderDestroy = procedure (Shader: PSfmlShader); cdecl;
  TSfmlShaderSetFloatUniform = procedure (Shader: PSfmlShader; const Name: PAnsiChar; X: Single); cdecl;
  TSfmlShaderSetVec2Uniform = procedure (Shader: PSfmlShader; const Name: PAnsiChar; Vector: TSfmlGlslVec2); cdecl;
  TSfmlShaderSetVec3Uniform = procedure (Shader: PSfmlShader; const Name: PAnsiChar; Vector: TSfmlGlslVec3); cdecl;
  TSfmlShaderSetVec4Uniform = procedure (Shader: PSfmlShader; const Name: PAnsiChar; Vector: TSfmlGlslVec4); cdecl;
  TSfmlShaderSetColorUniform = procedure (Shader: PSfmlShader; const Name: PAnsiChar; Color: TSfmlColor); cdecl;
  TSfmlShaderSetIntUniform = procedure (Shader: PSfmlShader; const Name: PAnsiChar; X: Integer); cdecl;
  TSfmlShaderSetIvec2Uniform = procedure (Shader: PSfmlShader; const Name: PAnsiChar; Vector: TSfmlGlslIvec2); cdecl;
  TSfmlShaderSetIvec3Uniform = procedure (Shader: PSfmlShader; const Name: PAnsiChar; Vector: TSfmlGlslIvec3); cdecl;
  TSfmlShaderSetIvec4Uniform = procedure (Shader: PSfmlShader; const Name: PAnsiChar; Vector: TSfmlGlslIvec4); cdecl;
  TSfmlShaderSetIntColorUniform = procedure (Shader: PSfmlShader; const Name: PAnsiChar; Color: TSfmlColor); cdecl;
  TSfmlShaderSetBoolUniform = procedure (Shader: PSfmlShader; const Name: PAnsiChar; X: LongBool); cdecl;
  TSfmlShaderSetBvec2Uniform = procedure (Shader: PSfmlShader; const Name: PAnsiChar; Vector: TSfmlGlslBvec2); cdecl;
  TSfmlShaderSetBvec3Uniform = procedure (Shader: PSfmlShader; const Name: PAnsiChar; Vector: TSfmlGlslBvec3); cdecl;
  TSfmlShaderSetBvec4Uniform = procedure (Shader: PSfmlShader; const Name: PAnsiChar; Vector: TSfmlGlslBvec4); cdecl;
  TSfmlShaderSetMat3Uniform = procedure (Shader: PSfmlShader; const Name: PAnsiChar; const Matrix: PSfmlGlslMat3); cdecl;
  TSfmlShaderSetMat4Uniform = procedure (Shader: PSfmlShader; const Name: PAnsiChar; const Matrix: PSfmlGlslMat4); cdecl;
  TSfmlShaderSetTextureUniform = procedure (Shader: PSfmlShader; const Name: PAnsiChar; const Texture: PSfmlTexture); cdecl;
  TSfmlShaderSetCurrentTextureUniform = procedure (Shader: PSfmlShader; Name: PAnsiChar); cdecl;
  TSfmlShaderSetFloatUniformArray = procedure (Shader: PSfmlShader; const Name: PAnsiChar; const ScalarArray: PSingle; Length: NativeUInt); cdecl;
  TSfmlShaderSetVec2UniformArray = procedure (Shader: PSfmlShader; const Name: PAnsiChar; const VectorArray: PSfmlGlslVec2; Length: NativeUInt); cdecl;
  TSfmlShaderSetVec3UniformArray = procedure (Shader: PSfmlShader; const Name: PAnsiChar; const VectorArray: PSfmlGlslVec3; Length: NativeUInt); cdecl;
  TSfmlShaderSetVec4UniformArray = procedure (Shader: PSfmlShader; const Name: PAnsiChar; const VectorArray: PSfmlGlslVec4; Length: NativeUInt); cdecl;
  TSfmlShaderSetMat3UniformArray = procedure (Shader: PSfmlShader; const Name: PAnsiChar; const MatrixArray: PSfmlGlslMat3; Length: NativeUInt); cdecl;
  TSfmlShaderSetMat4UniformArray = procedure (Shader: PSfmlShader; const Name: PAnsiChar; const MatrixArray: PSfmlGlslMat4; Length: NativeUInt); cdecl;
  TSfmlShaderSetFloatParameter = procedure (Shader: PSfmlShader; const Name: PAnsiChar; X: Single); cdecl;
  TSfmlShaderSetFloat2Parameter = procedure (Shader: PSfmlShader; const Name: PAnsiChar; X, Y: Single); cdecl;
  TSfmlShaderSetFloat3Parameter = procedure (Shader: PSfmlShader; const Name: PAnsiChar; X, Y, Z: Single); cdecl;
  TSfmlShaderSetFloat4Parameter = procedure (Shader: PSfmlShader; const Name: PAnsiChar; X, Y, Z, W: Single); cdecl;
  TSfmlShaderSetVector2Parameter = procedure (Shader: PSfmlShader; const Name: PAnsiChar; Vector: TSfmlVector2f); cdecl;
  TSfmlShaderSetVector3Parameter = procedure (Shader: PSfmlShader; const Name: PAnsiChar; Vector: TSfmlVector3f); cdecl;
  TSfmlShaderSetColorParameter = procedure (Shader: PSfmlShader; const Name: PAnsiChar; Color: TSfmlColor); cdecl;
  TSfmlShaderSetTransformParameter = procedure (Shader: PSfmlShader; const Name: PAnsiChar; Transform: TSfmlTransform); cdecl;
  TSfmlShaderSetTextureParameter = procedure (Shader: PSfmlShader; const Name: PAnsiChar; const Texture: PSfmlTexture); cdecl;
  TSfmlShaderSetCurrentTextureParameter = procedure (Shader: PSfmlShader; const Name: PAnsiChar); cdecl;
  TSfmlShaderGetNativeHandle = function (Shader: PSfmlShader): Cardinal; cdecl;
  TSfmlShaderBind = procedure (const Shader: PSfmlShader); cdecl;
  TSfmlShaderIsAvailable = function : LongBool; cdecl;
  TSfmlShaderIsGeometryAvailable = function: LongBool; cdecl;


  TSfmlShapeCreate = function (GetPointCount: TSfmlShapeGetPointCountCallback; GetPoint: TSfmlShapeGetPointCallback; UserData: Pointer): PSfmlShape; cdecl;
  TSfmlShapeDestroy = procedure (Shape: PSfmlShape); cdecl;
  TSfmlShapeSetPosition = procedure (Shape: PSfmlShape; Position: TSfmlVector2f); cdecl;
  TSfmlShapeSetRotation = procedure (Shape: PSfmlShape; Angle: Single); cdecl;
  TSfmlShapeSetScale = procedure (Shape: PSfmlShape; Scale: TSfmlVector2f); cdecl;
  TSfmlShapeSetOrigin = procedure (Shape: PSfmlShape; Origin: TSfmlVector2f); cdecl;
  TSfmlShapeGetPosition = function (const Shape: PSfmlShape): TSfmlVector2f; cdecl;
  TSfmlShapeGetRotation = function (const Shape: PSfmlShape): Single; cdecl;
  TSfmlShapeGetScale = function (const Shape: PSfmlShape): TSfmlVector2f; cdecl;
  TSfmlShapeGetOrigin = function (const Shape: PSfmlShape): TSfmlVector2f; cdecl;
  TSfmlShapeMove = procedure (Shape: PSfmlShape; Offset: TSfmlVector2f); cdecl;
  TSfmlShapeRotate = procedure (Shape: PSfmlShape; Angle: Single); cdecl;
  TSfmlShapeScale = procedure (Shape: PSfmlShape; Factors: TSfmlVector2f); cdecl;
  TSfmlShapeGetTransform = function (const Shape: PSfmlShape): TSfmlTransform; cdecl;
  TSfmlShapeGetInverseTransform = function (const Shape: PSfmlShape): TSfmlTransform; cdecl;
  TSfmlShapeSetTexture = procedure (Shape: PSfmlShape; const Texture: PSfmlTexture; ResetRect: LongBool); cdecl;
  TSfmlShapeSetTextureRect = procedure (Shape: PSfmlShape; Rect: TSfmlIntRect); cdecl;
  TSfmlShapeSetFillColor = procedure (Shape: PSfmlShape; Color: TSfmlColor); cdecl;
  TSfmlShapeSetOutlineColor = procedure (Shape: PSfmlShape; Color: TSfmlColor); cdecl;
  TSfmlShapeSetOutlineThickness = procedure (Shape: PSfmlShape; Thickness: Single); cdecl;
  TSfmlShapeGetTexture = function (const Shape: PSfmlShape): PSfmlTexture; cdecl;
  TSfmlShapeGetTextureRect = function (const Shape: PSfmlShape): TSfmlIntRect; cdecl;
  TSfmlShapeGetFillColor = function (const Shape: PSfmlShape): TSfmlColor; cdecl;
  TSfmlShapeGetOutlineColor = function (const Shape: PSfmlShape): TSfmlColor; cdecl;
  TSfmlShapeGetOutlineThickness = function (const Shape: PSfmlShape): Single; cdecl;
  TSfmlShapeGetPointCount = function (const Shape: PSfmlShape): NativeUInt; cdecl;
  TSfmlShapeGetPoint = function (const Shape: PSfmlShape; Index: NativeUInt): TSfmlVector2f; cdecl;
  TSfmlShapeGetLocalBounds = function (const Shape: PSfmlShape): TSfmlFloatRect; cdecl;
  TSfmlShapeGetGlobalBounds = function (const Shape: PSfmlShape): TSfmlFloatRect; cdecl;
  TSfmlShapeUpdate = procedure (Shape: PSfmlShape); cdecl;

  TSfmlSpriteCreate = function : PSfmlSprite; cdecl;
  TSfmlSpriteCopy = function (const Sprite: PSfmlSprite): PSfmlSprite; cdecl;
  TSfmlSpriteDestroy = procedure (Sprite: PSfmlSprite); cdecl;
  TSfmlSpriteSetPosition = procedure (Sprite: PSfmlSprite; Position: TSfmlVector2f); cdecl;
  TSfmlSpriteSetRotation = procedure (Sprite: PSfmlSprite; Angle: Single); cdecl;
  TSfmlSpriteSetScale = procedure (Sprite: PSfmlSprite; Scale: TSfmlVector2f); cdecl;
  TSfmlSpriteSetOrigin = procedure (Sprite: PSfmlSprite; Origin: TSfmlVector2f); cdecl;
  TSfmlSpriteGetPosition = function (const Sprite: PSfmlSprite): TSfmlVector2f; cdecl;
  TSfmlSpriteGetRotation = function (const Sprite: PSfmlSprite): Single; cdecl;
  TSfmlSpriteGetScale = function (const Sprite: PSfmlSprite): TSfmlVector2f; cdecl;
  TSfmlSpriteGetOrigin = function (const Sprite: PSfmlSprite): TSfmlVector2f; cdecl;
  TSfmlSpriteMove = procedure (Sprite: PSfmlSprite; Offset: TSfmlVector2f); cdecl;
  TSfmlSpriteRotate = procedure (Sprite: PSfmlSprite; Angle: Single); cdecl;
  TSfmlSpriteScale = procedure (Sprite: PSfmlSprite; Factors: TSfmlVector2f); cdecl;
  TSfmlSpriteGetTransform = function (const Sprite: PSfmlSprite): TSfmlTransform; cdecl;
  TSfmlSpriteGetInverseTransform = function (const Sprite: PSfmlSprite): TSfmlTransform; cdecl;
  TSfmlSpriteSetTexture = procedure (Sprite: PSfmlSprite; const Texture: PSfmlTexture; ResetRect: LongBool); cdecl;
  TSfmlSpriteSetTextureRect = procedure (Sprite: PSfmlSprite; Rectangle: TSfmlIntRect); cdecl;
  TSfmlSpriteSetColor = procedure (Sprite: PSfmlSprite; Color: TSfmlColor); cdecl;
  TSfmlSpriteGetTexture = function (const Sprite: PSfmlSprite): PSfmlTexture; cdecl;
  TSfmlSpriteGetTextureRect = function (const Sprite: PSfmlSprite): TSfmlIntRect; cdecl;
  TSfmlSpriteGetColor = function (const Sprite: PSfmlSprite): TSfmlColor; cdecl;
  TSfmlSpriteGetLocalBounds = function (const Sprite: PSfmlSprite): TSfmlFloatRect; cdecl;
  TSfmlSpriteGetGlobalBounds = function (const Sprite: PSfmlSprite): TSfmlFloatRect; cdecl;

  TSfmlTextCreate = function : PSfmlText; cdecl;
  TSfmlTextCopy = function (const Text: PSfmlText): PSfmlText; cdecl;
  TSfmlTextDestroy = procedure (Text: PSfmlText); cdecl;
  TSfmlTextSetPosition = procedure (Text: PSfmlText; Position: TSfmlVector2f); cdecl;
  TSfmlTextSetRotation = procedure (Text: PSfmlText; Angle: Single); cdecl;
  TSfmlTextSetScale = procedure (Text: PSfmlText; Scale: TSfmlVector2f); cdecl;
  TSfmlTextSetOrigin = procedure (Text: PSfmlText; Origin: TSfmlVector2f); cdecl;
  TSfmlTextGetPosition = function (const Text: PSfmlText): TSfmlVector2f; cdecl;
  TSfmlTextGetRotation = function (const Text: PSfmlText): Single; cdecl;
  TSfmlTextGetScale = function (const Text: PSfmlText): TSfmlVector2f; cdecl;
  TSfmlTextGetOrigin = function (const Text: PSfmlText): TSfmlVector2f; cdecl;
  TSfmlTextMove = procedure (Text: PSfmlText; Offset: TSfmlVector2f); cdecl;
  TSfmlTextRotate = procedure (Text: PSfmlText; Angle: Single); cdecl;
  TSfmlTextScale = procedure (Text: PSfmlText; Factors: TSfmlVector2f); cdecl;
  TSfmlTextGetTransform = function (const Text: PSfmlText): TSfmlTransform; cdecl;
  TSfmlTextGetInverseTransform = function (const Text: PSfmlText): TSfmlTransform; cdecl;
  TSfmlTextSetString = procedure (Text: PSfmlText; const &String: PAnsiChar); cdecl;
  TSfmlTextSetUnicodeString = procedure (Text: PSfmlText; const &String: PUCS4Char); cdecl;
  TSfmlTextSetFont = procedure (Text: PSfmlText; const Font: PSfmlFont); cdecl;
  TSfmlTextSetCharacterSize = procedure (Text: PSfmlText; Size: Cardinal); cdecl;
  TSfmlTextSetStyle = procedure (Text: PSfmlText; Style: Cardinal); cdecl;
  TSfmlTextSetColor = procedure (Text: PSfmlText; Color: TSfmlColor); cdecl;
  TSfmlTextSetFillColor = procedure (Text: PSfmlText; Color: TSfmlColor); cdecl;
  TSfmlTextSetOutlineColor = procedure (Text: PSfmlText; Color: TSfmlColor); cdecl;
  TSfmlTextSetOutlineThickness = procedure (Text: PSfmlText; Thickness: Single); cdecl;
  TSfmlTextGetString = function (const Text: PSfmlText): PAnsiChar; cdecl;
  TSfmlTextGetUnicodeString = function (const Text: PSfmlText): PUCS4Char; cdecl;
  TSfmlTextGetFont = function (const Text: PSfmlText): PSfmlFont; cdecl;
  TSfmlTextGetCharacterSize = function (const Text: PSfmlText): Cardinal; cdecl;
  TSfmlTextGetStyle = function (const Text: PSfmlText): Cardinal; cdecl;
  TSfmlTextGetColor = function (const Text: PSfmlText): TSfmlColor; cdecl;
  TSfmlTextGetFillColor = function (const Text: PSfmlText): TSfmlColor; cdecl;
  TSfmlTextGetOutlineColor = function (const Text: PSfmlText): TSfmlColor; cdecl;
  TSfmlTextGetOutlineThickness = function (const Text: PSfmlText): Single; cdecl;
  TSfmlTextFindCharacterPos = function (const Text: PSfmlText; Index: NativeUInt): TSfmlVector2f; cdecl;
  TSfmlTextGetLocalBounds = function (const Text: PSfmlText): TSfmlFloatRect; cdecl;
  TSfmlTextGetGlobalBounds = function (const Text: PSfmlText): TSfmlFloatRect; cdecl;

  TSfmlTextureCreate = function (Width, Height: Cardinal): PSfmlTexture; cdecl;
  TSfmlTextureCreateFromFile = function (const FileName: PAnsiChar; const Area: PSfmlIntRect): PSfmlTexture; cdecl;
  TSfmlTextureCreateFromMemory = function (const Data: Pointer; SizeInBytes: NativeUInt; const Area: PSfmlIntRect): PSfmlTexture; cdecl;
  TSfmlTextureCreateFromStream = function (Stream: PSfmlInputStream; const Area: PSfmlIntRect): PSfmlTexture; cdecl;
  TSfmlTextureCreateFromImage = function (const Image: PSfmlImage; const Area: PSfmlIntRect): PSfmlTexture; cdecl;
  TSfmlTextureCopy = function (const Texture: PSfmlTexture): PSfmlTexture; cdecl;
  TSfmlTextureDestroy = procedure (Texture: PSfmlTexture); cdecl;
  TSfmlTextureGetSize = function (const Texture: PSfmlTexture): TSfmlVector2u; cdecl;
  TSfmlTextureCopyToImage = function (const Texture: PSfmlTexture): PSfmlImage; cdecl;
  TSfmlTextureUpdateFromPixels = procedure (Texture: PSfmlTexture; const Pixels: PByte; Width, Height, X, Y: Cardinal); cdecl;
  TSfmlTextureUpdateFromImage = procedure (Texture: PSfmlTexture; const Image: PSfmlImage; X, Y: Cardinal); cdecl;
  TSfmlTextureUpdateFromWindow = procedure (Texture: PSfmlTexture; const Window: PSfmlWindow; X, Y: Cardinal); cdecl;
  TSfmlTextureUpdateFromRenderWindow = procedure (Texture: PSfmlTexture; const RenderWindow: PSfmlRenderWindow; X, Y: Cardinal); cdecl;
  TSfmlTextureSetSmooth = procedure (Texture: PSfmlTexture; Smooth: LongBool); cdecl;
  TSfmlTextureIsSmooth = function (const Texture: PSfmlTexture): LongBool; cdecl;
  TSfmlTextureSetSrgb = procedure (const Texture: PSfmlTexture; sRgb: LongBool); cdecl;
  TSfmlTextureIsSrgb = function (const Texture: PSfmlTexture): LongBool; cdecl;
  TSfmlTextureSetRepeated = procedure (Texture: PSfmlTexture; Repeated: LongBool); cdecl;
  TSfmlTextureIsRepeated = function (const Texture: PSfmlTexture): LongBool; cdecl;
  TSfmlTextureGenerateMipmap = procedure (const Texture: PSfmlTexture); cdecl;
  TSfmlTextureGetNativeHandle = function (const Texture: PSfmlTexture): Cardinal; cdecl;
  TSfmlTextureBind = procedure (const Texture: PSfmlTexture); cdecl;
  TsfmlTextureGetMaximumSize = function : Cardinal; cdecl;

  TSfmlTransformFromMatrix = function (a00, a01, a02, a10, a11, a12, a20, a21, a22: Single): TSfmlTransform; cdecl;
  TSfmlTransformGetMatrix = procedure (const Transform: PSfmlTransform; Matrix: PSingle); cdecl;
  TSfmlTransformGetInverse = function (const Transform: PSfmlTransform): TSfmlTransform; cdecl;
  TSfmlTransformTransformPoint = function (const Transform: PSfmlTransform; Point: TSfmlVector2f): TSfmlVector2f; cdecl;
  TSfmlTransformTransformRect = function (const Transform: PSfmlTransform; Rectangle: TSfmlFloatRect): TSfmlFloatRect; cdecl;
  TSfmlTransformCombine = procedure (out Transform: TSfmlTransform; const Other: PSfmlTransform); cdecl;
  TSfmlTransformTranslate = procedure (Transform: PSfmlTransform; X, Y: Single); cdecl;
  TSfmlTransformRotate = procedure (Transform: PSfmlTransform; Angle: Single); cdecl;
  TSfmlTransformRotateWithCenter = procedure (Transform: PSfmlTransform; Angle: Single; centerX, centerY: Single); cdecl;
  TSfmlTransformScale = procedure (Transform: PSfmlTransform; ScaleX, ScaleY: Single); cdecl;
  TSfmlTransformScaleWithCenter = procedure (Transform: PSfmlTransform; ScaleX, ScaleY, CenterX, CenterY: Single); cdecl;

  TSfmlTransformableCreate = function : PSfmlTransformable; cdecl;
  TSfmlTransformableCopy = function (const Transformable: PSfmlTransformable): PSfmlTransformable; cdecl;
  TSfmlTransformableDestroy = procedure (Transformable: PSfmlTransformable); cdecl;
  TSfmlTransformableSetPosition = procedure (Transformable: PSfmlTransformable; Position: TSfmlVector2f); cdecl;
  TSfmlTransformableSetRotation = procedure (Transformable: PSfmlTransformable; Angle: Single); cdecl;
  TSfmlTransformableSetScale = procedure (Transformable: PSfmlTransformable; Scale: TSfmlVector2f); cdecl;
  TSfmlTransformableSetOrigin = procedure (Transformable: PSfmlTransformable; Origin: TSfmlVector2f); cdecl;
  TSfmlTransformableGetPosition = function (const Transformable: PSfmlTransformable): TSfmlVector2f; cdecl;
  TSfmlTransformableGetRotation = function (const Transformable: PSfmlTransformable): Single; cdecl;
  TSfmlTransformableGetScale = function (const Transformable: PSfmlTransformable): TSfmlVector2f; cdecl;
  TSfmlTransformableGetOrigin = function (const Transformable: PSfmlTransformable): TSfmlVector2f; cdecl;
  TSfmlTransformableMove = procedure (Transformable: PSfmlTransformable; Offset: TSfmlVector2f); cdecl;
  TSfmlTransformableRotate = procedure (Transformable: PSfmlTransformable; Angle: Single); cdecl;
  TSfmlTransformableScale = procedure (Transformable: PSfmlTransformable; Factors: TSfmlVector2f); cdecl;
  TSfmlTransformableGetTransform = function (const Transformable: PSfmlTransformable): TSfmlTransform; cdecl;
  TSfmlTransformableGetInverseTransform = function (const Transformable: PSfmlTransformable): TSfmlTransform; cdecl;

  TSfmlVertexArrayCreate = function : PSfmlVertexArray; cdecl;
  TSfmlVertexArrayCopy = function (const VertexArray: PSfmlVertexArray): PSfmlVertexArray; cdecl;
  TSfmlVertexArrayDestroy = procedure (VertexArray: PSfmlVertexArray); cdecl;
  TSfmlVertexArrayGetVertexCount = function (const VertexArray: PSfmlVertexArray): NativeUInt; cdecl;
  TSfmlVertexArrayGetVertex = function (VertexArray: PSfmlVertexArray; Index: NativeUInt): PSfmlVertex; cdecl;
  TSfmlVertexArrayClear = procedure (VertexArray: PSfmlVertexArray); cdecl;
  TSfmlVertexArrayResize = procedure (VertexArray: PSfmlVertexArray; VertexCount: NativeUInt); cdecl;
  TSfmlVertexArrayAppend = procedure (VertexArray: PSfmlVertexArray; Vertex: TSfmlVertex); cdecl;
  TSfmlVertexArraySetPrimitiveType = procedure (VertexArray: PSfmlVertexArray; &Type: TSfmlPrimitiveType); cdecl;
  TSfmlVertexArrayGetPrimitiveType = function (VertexArray: PSfmlVertexArray): TSfmlPrimitiveType; cdecl;
  TSfmlVertexArrayGetBounds = function (VertexArray: PSfmlVertexArray): TSfmlFloatRect; cdecl;

  TSfmlViewCreate = function : PSfmlView; cdecl;
  TSfmlViewCreateFromRect = function (Rectangle: TSfmlFloatRect): PSfmlView; cdecl;
  TSfmlViewCopy = function (const View: PSfmlView): PSfmlView; cdecl;
  TSfmlViewDestroy = procedure (View: PSfmlView); cdecl;
  TSfmlViewSetCenter = procedure (View: PSfmlView; Center: TSfmlVector2f); cdecl;
  TSfmlViewSetSize = procedure (View: PSfmlView; Size: TSfmlVector2f); cdecl;
  TSfmlViewSetRotation = procedure (View: PSfmlView; Angle: Single); cdecl;
  TSfmlViewSetViewport = procedure (View: PSfmlView; Viewport: TSfmlFloatRect); cdecl;
  TSfmlViewReset = procedure (View: PSfmlView; Rectangle: TSfmlFloatRect); cdecl;
  TSfmlViewGetCenter = function (const View: PSfmlView): TSfmlVector2f; cdecl;
  TSfmlViewGetSize = function (const View: PSfmlView): TSfmlVector2f; cdecl;
  TSfmlViewGetRotation = function (const View: PSfmlView): Single; cdecl;
  TSfmlViewGetViewport = function (const View: PSfmlView): TSfmlFloatRect; cdecl;
  TSfmlViewMove = procedure (View: PSfmlView; Offset: TSfmlVector2f); cdecl;
  TSfmlViewRotate = procedure (View: PSfmlView; Angle: Single); cdecl;
  TSfmlViewZoom = procedure (View: PSfmlView; Factor: Single); cdecl;

var
  SfmlBlendAlpha: TSfmlBlendMode;
  SfmlBlendAdd: TSfmlBlendMode;
  SfmlBlendMultiply: TSfmlBlendMode;
  SfmlBlendNone: TSfmlBlendMode;

  SfmlBlack: TSfmlColor;
  SfmlWhite: TSfmlColor;
  SfmlRed: TSfmlColor;
  SfmlGreen: TSfmlColor;
  SfmlBlue: TSfmlColor;
  SfmlYellow: TSfmlColor;
  SfmlMagenta: TSfmlColor;
  SfmlCyan: TSfmlColor;
  SfmlTransparent: TSfmlColor;

  SfmlColorFromRGB: TSfmlColorFromRGB;
  SfmlColorFromRGBA: TSfmlColorFromRGBA;
  SfmlColorFromInteger: TSfmlColorFromInteger;
  SfmlColorToInteger: TSfmlColorToInteger;
  SfmlColorAdd: TSfmlColorAdd;
  SfmlColorSubtract: TSfmlColorSubtract;
  SfmlColorModulate: TSfmlColorModulate;

  SfmlTransformIdentity: TSfmlTransform;

  SfmlCircleShapeCreate: TSfmlCircleShapeCreate;
  SfmlCircleShapeCopy: TSfmlCircleShapeCopy;
  SfmlCircleShapeDestroy: TSfmlCircleShapeDestroy;
  SfmlCircleShapeSetPosition: TSfmlCircleShapeSetPosition;
  SfmlCircleShapeSetRotation: TSfmlCircleShapeSetRotation;
  SfmlCircleShapeSetScale: TSfmlCircleShapeSetScale;
  SfmlCircleShapeSetOrigin: TSfmlCircleShapeSetOrigin;
  SfmlCircleShapeGetRotation: TSfmlCircleShapeGetRotation;
  SfmlCircleShapeMove: TSfmlCircleShapeMove;
  SfmlCircleShapeRotate: TSfmlCircleShapeRotate;
  SfmlCircleShapeScale: TSfmlCircleShapeScale;
  SfmlCircleShapeGetTransform: TSfmlCircleShapeGetTransform;
  SfmlCircleShapeGetInverseTransform: TSfmlCircleShapeGetInverseTransform;
  SfmlCircleShapeSetTexture: TSfmlCircleShapeSetTexture;
  SfmlCircleShapeSetTextureRect: TSfmlCircleShapeSetTextureRect;
  SfmlCircleShapeSetFillColor: TSfmlCircleShapeSetFillColor;
  SfmlCircleShapeSetOutlineColor: TSfmlCircleShapeSetOutlineColor;
  SfmlCircleShapeSetOutlineThickness: TSfmlCircleShapeSetOutlineThickness;
  SfmlCircleShapeGetTexture: TSfmlCircleShapeGetTexture;
  SfmlCircleShapeGetTextureRect: TSfmlCircleShapeGetTextureRect;
  SfmlCircleShapeGetFillColor: TSfmlCircleShapeGetFillColor;
  SfmlCircleShapeGetOutlineColor: TSfmlCircleShapeGetOutlineColor;
  SfmlCircleShapeGetOutlineThickness: TSfmlCircleShapeGetOutlineThickness;
  SfmlCircleShapeGetPointCount: TSfmlCircleShapeGetPointCount;
  SfmlCircleShapeSetRadius: TSfmlCircleShapeSetRadius;
  SfmlCircleShapeGetRadius: TSfmlCircleShapeGetRadius;
  SfmlCircleShapeSetPointCount: TSfmlCircleShapeSetPointCount;
  SfmlCircleShapeGetLocalBounds: TSfmlCircleShapeGetLocalBounds;
  SfmlCircleShapeGetGlobalBounds: TSfmlCircleShapeGetGlobalBounds;
{$IFNDEF INT64RETURNWORKAROUND}
  SfmlCircleShapeGetOrigin: TSfmlCircleShapeGetOrigin;
  SfmlCircleShapeGetPoint: TSfmlCircleShapeGetPoint;
  SfmlCircleShapeGetPosition: TSfmlCircleShapeGetPosition;
  SfmlCircleShapeGetScale: TSfmlCircleShapeGetScale;
{$ENDIF}

  SfmlConvexShapeCreate: TSfmlConvexShapeCreate;
  SfmlConvexShapeCopy: TSfmlConvexShapeCopy;
  SfmlConvexShapeDestroy: TSfmlConvexShapeDestroy;
  SfmlConvexShapeSetPosition: TSfmlConvexShapeSetPosition;
  SfmlConvexShapeSetRotation: TSfmlConvexShapeSetRotation;
  SfmlConvexShapeSetScale: TSfmlConvexShapeSetScale;
  SfmlConvexShapeSetOrigin: TSfmlConvexShapeSetOrigin;
  SfmlConvexShapeGetRotation: TSfmlConvexShapeGetRotation;
  SfmlConvexShapeMove: TSfmlConvexShapeMove;
  SfmlConvexShapeRotate: TSfmlConvexShapeRotate;
  SfmlConvexShapeScale: TSfmlConvexShapeScale;
  SfmlConvexShapeGetTransform: TSfmlConvexShapeGetTransform;
  SfmlConvexShapeGetInverseTransform: TSfmlConvexShapeGetInverseTransform;
  SfmlConvexShapeSetTexture: TSfmlConvexShapeSetTexture;
  SfmlConvexShapeSetTextureRect: TSfmlConvexShapeSetTextureRect;
  SfmlConvexShapeSetFillColor: TSfmlConvexShapeSetFillColor;
  SfmlConvexShapeSetOutlineColor: TSfmlConvexShapeSetOutlineColor;
  SfmlConvexShapeSetOutlineThickness: TSfmlConvexShapeSetOutlineThickness;
  SfmlConvexShapeGetTexture: TSfmlConvexShapeGetTexture;
  SfmlConvexShapeGetTextureRect: TSfmlConvexShapeGetTextureRect;
  SfmlConvexShapeGetFillColor: TSfmlConvexShapeGetFillColor;
  SfmlConvexShapeGetOutlineColor: TSfmlConvexShapeGetOutlineColor;
  SfmlConvexShapeGetOutlineThickness: TSfmlConvexShapeGetOutlineThickness;
  SfmlConvexShapeGetPointCount: TSfmlConvexShapeGetPointCount;
  SfmlConvexShapeSetPointCount: TSfmlConvexShapeSetPointCount;
  SfmlConvexShapeSetPoint: TSfmlConvexShapeSetPoint;
  SfmlConvexShapeGetLocalBounds: TSfmlConvexShapeGetLocalBounds;
  SfmlConvexShapeGetGlobalBounds: TSfmlConvexShapeGetGlobalBounds;
{$IFNDEF INT64RETURNWORKAROUND}
  SfmlConvexShapeGetOrigin: TSfmlConvexShapeGetOrigin;
  SfmlConvexShapeGetPoint: TSfmlConvexShapeGetPoint;
  SfmlConvexShapeGetPosition: TSfmlConvexShapeGetPosition;
  SfmlConvexShapeGetScale: TSfmlConvexShapeGetScale;
{$ENDIF}

  SfmlFontCreateFromFile: TSfmlFontCreateFromFile;
  SfmlFontCreateFromMemory: TSfmlFontCreateFromMemory;
  SfmlFontCreateFromStream: TSfmlFontCreateFromStream;
  SfmlFontCopy: TSfmlFontCopy;
  SfmlFontDestroy: TSfmlFontDestroy;
  SfmlFontGetGlyph: TSfmlFontGetGlyph;
  SfmlFontGetKerning: TSfmlFontGetKerning;
  SfmlFontGetLineSpacing: TSfmlFontGetLineSpacing;
  SfmlFontGetUnderlinePosition: TSfmlFontGetUnderlinePosition;
  SfmlFontGetUnderlineThickness: TSfmlFontGetUnderlineThickness;
  SfmlFontGetTexture: TSfmlFontGetTexture;
  SfmlFontGetInfo: TSfmlFontGetInfo;

  SfmlImageCreate: TSfmlImageCreate;
  SfmlImageCreateFromColor: TSfmlImageCreateFromColor;
  SfmlImageCreateFromPixels: TSfmlImageCreateFromPixels;
  SfmlImageCreateFromFile: TSfmlImageCreateFromFile;
  SfmlImageCreateFromMemory: TSfmlImageCreateFromMemory;
  SfmlImageCreateFromStream: TSfmlImageCreateFromStream;
  SfmlImageCopy: TSfmlImageCopy;
  SfmlImageDestroy: TSfmlImageDestroy;
  SfmlImageSaveToFile: TSfmlImageSaveToFile;
  SfmlImageCreateMaskFromColor: TSfmlImageCreateMaskFromColor;
  SfmlImageCopyImage: TSfmlImageCopyImage;
  SfmlImageSetPixel: TSfmlImageSetPixel;
  SfmlImageGetPixel: TSfmlImageGetPixel;
  SfmlImageGetPixelsPtr: TSfmlImageGetPixelsPtr;
  SfmlImageFlipHorizontally: TSfmlImageFlipHorizontally;
  SfmlImageFlipVertically: TSfmlImageFlipVertically;
{$IFNDEF INT64RETURNWORKAROUND}
  SfmlImageGetSize: TSfmlImageGetSize;
{$ENDIF}

  SfmlFloatRectContains: TSfmlFloatRectContains;
  SfmlIntRectContains: TSfmlIntRectContains;
  SfmlFloatRectIntersects: TSfmlFloatRectIntersects;
  SfmlIntRectIntersects: TSfmlIntRectIntersects;

  SfmlRectangleShapeCreate: TSfmlRectangleShapeCreate;
  SfmlRectangleShapeCopy: TSfmlRectangleShapeCopy;
  SfmlRectangleShapeDestroy: TSfmlRectangleShapeDestroy;
  SfmlRectangleShapeSetPosition: TSfmlRectangleShapeSetPosition;
  SfmlRectangleShapeSetRotation: TSfmlRectangleShapeSetRotation;
  SfmlRectangleShapeSetScale: TSfmlRectangleShapeSetScale;
  SfmlRectangleShapeSetOrigin: TSfmlRectangleShapeSetOrigin;
  SfmlRectangleShapeGetRotation: TSfmlRectangleShapeGetRotation;
  SfmlRectangleShapeMove: TSfmlRectangleShapeMove;
  SfmlRectangleShapeRotate: TSfmlRectangleShapeRotate;
  SfmlRectangleShapeScale: TSfmlRectangleShapeScale;
  SfmlRectangleShapeGetTransform: TSfmlRectangleShapeGetTransform;
  SfmlRectangleShapeGetInverseTransform: TSfmlRectangleShapeGetInverseTransform;
  SfmlRectangleShapeSetTexture: TSfmlRectangleShapeSetTexture;
  SfmlRectangleShapeSetTextureRect: TSfmlRectangleShapeSetTextureRect;
  SfmlRectangleShapeSetFillColor: TSfmlRectangleShapeSetFillColor;
  SfmlRectangleShapeSetOutlineColor: TSfmlRectangleShapeSetOutlineColor;
  SfmlRectangleShapeSetOutlineThickness: TSfmlRectangleShapeSetOutlineThickness;
  SfmlRectangleShapeGetTexture: TSfmlRectangleShapeGetTexture;
  SfmlRectangleShapeGetTextureRect: TSfmlRectangleShapeGetTextureRect;
  SfmlRectangleShapeGetFillColor: TSfmlRectangleShapeGetFillColor;
  SfmlRectangleShapeGetOutlineColor: TSfmlRectangleShapeGetOutlineColor;
  SfmlRectangleShapeGetOutlineThickness: TSfmlRectangleShapeGetOutlineThickness;
  SfmlRectangleShapeGetPointCount: TSfmlRectangleShapeGetPointCount;
  SfmlRectangleShapeSetSize: TSfmlRectangleShapeSetSize;
  SfmlRectangleShapeGetLocalBounds: TSfmlRectangleShapeGetLocalBounds;
  SfmlRectangleShapeGetGlobalBounds: TSfmlRectangleShapeGetGlobalBounds;
{$IFNDEF INT64RETURNWORKAROUND}
  SfmlRectangleShapeGetOrigin: TSfmlRectangleShapeGetOrigin;
  SfmlRectangleShapeGetPoint: TSfmlRectangleShapeGetPoint;
  SfmlRectangleShapeGetPosition: TSfmlRectangleShapeGetPosition;
  SfmlRectangleShapeGetScale: TSfmlRectangleShapeGetScale;
  SfmlRectangleShapeGetSize: TSfmlRectangleShapeGetSize;
{$ENDIF}

  SfmlRenderTextureCreate: TSfmlRenderTextureCreate;
  SfmlRenderTextureDestroy: TSfmlRenderTextureDestroy;
  SfmlRenderTextureSetActive: TSfmlRenderTextureSetActive;
  SfmlRenderTextureDisplay: TSfmlRenderTextureDisplay;
  SfmlRenderTextureClear: TSfmlRenderTextureClear;
  SfmlRenderTextureSetView: TSfmlRenderTextureSetView;
  SfmlRenderTextureGetView: TSfmlRenderTextureGetView;
  SfmlRenderTextureGetDefaultView: TSfmlRenderTextureGetDefaultView;
  SfmlRenderTextureGetViewport: TSfmlRenderTextureGetViewport;
  SfmlRenderTextureDrawSprite: TSfmlRenderTextureDrawSprite;
  SfmlRenderTextureDrawText: TSfmlRenderTextureDrawText;
  SfmlRenderTextureDrawShape: TSfmlRenderTextureDrawShape;
  SfmlRenderTextureDrawCircleShape: TSfmlRenderTextureDrawCircleShape;
  SfmlRenderTextureDrawConvexShape: TSfmlRenderTextureDrawConvexShape;
  SfmlRenderTextureDrawRectangleShape: TSfmlRenderTextureDrawRectangleShape;
  SfmlRenderTextureDrawVertexArray: TSfmlRenderTextureDrawVertexArray;
  SfmlRenderTextureDrawPrimitives: TSfmlRenderTextureDrawPrimitives;
  SfmlRenderTexturePushGLStates: TSfmlRenderTexturePushGLStates;
  SfmlRenderTexturePopGLStates: TSfmlRenderTexturePopGLStates;
  SfmlRenderTextureResetGLStates: TSfmlRenderTextureResetGLStates;
  SfmlRenderTextureGetTexture: TSfmlRenderTextureGetTexture;
  SfmlRenderTextureSetSmooth: TSfmlRenderTextureSetSmooth;
  SfmlRenderTextureIsSmooth: TSfmlRenderTextureIsSmooth;
  SfmlRenderTextureSetRepeated: TSfmlRenderTextureSetRepeated;
  SfmlRenderTextureIsRepeated: TSfmlRenderTextureIsRepeated;
  SfmlRenderTextureGenerateMipmap: TSfmlRenderTextureGenerateMipmap;

{$IFNDEF INT64RETURNWORKAROUND}
  SfmlRenderTextureMapPixelToCoords: TSfmlRenderTextureMapPixelToCoords;
  SfmlRenderTextureMapCoordsToPixel: TSfmlRenderTextureMapCoordsToPixel;
{$ENDIF}

  SfmlRenderWindowCreate: TSfmlRenderWindowCreate;
  SfmlRenderWindowCreateUnicode: TSfmlRenderWindowCreateUnicode;
  SfmlRenderWindowCreateFromHandle: TSfmlRenderWindowCreateFromHandle;
  SfmlRenderWindowDestroy: TSfmlRenderWindowDestroy;
  SfmlRenderWindowClose: TSfmlRenderWindowClose;
  SfmlRenderWindowIsOpen: TSfmlRenderWindowIsOpen;
  SfmlRenderWindowGetSettings: TSfmlRenderWindowGetSettings;
  SfmlRenderWindowPollEvent: TSfmlRenderWindowPollEvent;
  SfmlRenderWindowWaitEvent: TSfmlRenderWindowWaitEvent;
  SfmlRenderWindowGetPosition: TSfmlRenderWindowGetPosition;
  SfmlRenderWindowSetPosition: TSfmlRenderWindowSetPosition;
  SfmlRenderWindowSetSize: TSfmlRenderWindowSetSize;
  SfmlRenderWindowSetTitle: TSfmlRenderWindowSetTitle;
  SfmlRenderWindowSetUnicodeTitle: TSfmlRenderWindowSetUnicodeTitle;
  SfmlRenderWindowSetIcon: TSfmlRenderWindowSetIcon;
  SfmlRenderWindowSetVisible: TSfmlRenderWindowSetVisible;
  SfmlRenderWindowSetVerticalSyncEnabled: TSfmlRenderWindowSetVerticalSyncEnabled;
  SfmlRenderWindowSetMouseCursorVisible: TSfmlRenderWindowSetMouseCursorVisible;
  SfmlRenderWindowSetMouseCursorGrabbed: TSfmlRenderWindowSetMouseCursorGrabbed;
  SfmlRenderWindowSetFramerateLimit: TSfmlRenderWindowSetFramerateLimit;
  SfmlRenderWindowSetJoystickThreshold: TSfmlRenderWindowSetJoystickThreshold;
  SfmlRenderWindowSetKeyRepeatEnabled: TSfmlRenderWindowSetKeyRepeatEnabled;
  SfmlRenderWindowSetActive: TSfmlRenderWindowSetActive;
  SfmlRenderWindowRequestFocus: TSfmlRenderWindowRequestFocus;
  SfmlRenderWindowHasFocus: TSfmlRenderWindowHasFocus;
  SfmlRenderWindowDisplay: TSfmlRenderWindowDisplay;
  SfmlRenderWindowGetSystemHandle: TSfmlRenderWindowGetSystemHandle;
  SfmlRenderWindowClear: TSfmlRenderWindowClear;
  SfmlRenderWindowSetView: TSfmlRenderWindowSetView;
  SfmlRenderWindowGetView: TSfmlRenderWindowGetView;
  SfmlRenderWindowGetDefaultView: TSfmlRenderWindowGetDefaultView;
  SfmlRenderWindowGetViewport: TSfmlRenderWindowGetViewport;
  SfmlRenderWindowDrawSprite: TSfmlRenderWindowDrawSprite;
  SfmlRenderWindowDrawText: TSfmlRenderWindowDrawText;
  SfmlRenderWindowDrawShape: TSfmlRenderWindowDrawShape;
  SfmlRenderWindowDrawCircleShape: TSfmlRenderWindowDrawCircleShape;
  SfmlRenderWindowDrawConvexShape: TSfmlRenderWindowDrawConvexShape;
  SfmlRenderWindowDrawRectangleShape: TSfmlRenderWindowDrawRectangleShape;
  SfmlRenderWindowDrawVertexArray: TSfmlRenderWindowDrawVertexArray;
  SfmlRenderWindowDrawPrimitives: TSfmlRenderWindowDrawPrimitives;
  SfmlRenderWindowPushGLStates: TSfmlRenderWindowPushGLStates;
  SfmlRenderWindowPopGLStates: TSfmlRenderWindowPopGLStates;
  SfmlRenderWindowResetGLStates: TSfmlRenderWindowResetGLStates;
  SfmlRenderWindowCapture: TSfmlRenderWindowCapture;
  SfmlMouseSetPositionRenderWindow: TSfmlMouseSetPositionRenderWindow;
{$IFNDEF INT64RETURNWORKAROUND}
  SfmlRenderWindowMapPixelToCoords: TSfmlRenderWindowMapPixelToCoords;
  SfmlRenderWindowMapCoordsToPixel: TSfmlRenderWindowMapCoordsToPixel;
  SfmlMouseGetPositionRenderWindow: TSfmlMouseGetPositionRenderWindow;
  SfmlTouchGetPositionRenderWindow: TSfmlTouchGetPositionRenderWindow;
{$ENDIF}

  SfmlShaderCreateFromFile: TSfmlShaderCreateFromFile;
  SfmlShaderCreateFromMemory: TSfmlShaderCreateFromMemory;
  SfmlShaderCreateFromStream: TSfmlShaderCreateFromStream;
  SfmlShaderDestroy: TSfmlShaderDestroy;
  SfmlShaderSetFloatUniform: TSfmlShaderSetFloatUniform;
  SfmlShaderSetVec2Uniform: TSfmlShaderSetVec2Uniform;
  SfmlShaderSetVec3Uniform: TSfmlShaderSetVec3Uniform;
  SfmlShaderSetVec4Uniform: TSfmlShaderSetVec4Uniform;
  SfmlShaderSetColorUniform: TSfmlShaderSetColorUniform;
  SfmlShaderSetIntUniform: TSfmlShaderSetIntUniform;
  SfmlShaderSetIvec2Uniform: TSfmlShaderSetIvec2Uniform;
  SfmlShaderSetIvec3Uniform: TSfmlShaderSetIvec3Uniform;
  SfmlShaderSetIvec4Uniform: TSfmlShaderSetIvec4Uniform;
  SfmlShaderSetIntColorUniform: TSfmlShaderSetIntColorUniform;
  SfmlShaderSetBoolUniform: TSfmlShaderSetBoolUniform;
  SfmlShaderSetBvec2Uniform: TSfmlShaderSetBvec2Uniform;
  SfmlShaderSetBvec3Uniform: TSfmlShaderSetBvec3Uniform;
  SfmlShaderSetBvec4Uniform: TSfmlShaderSetBvec4Uniform;
  SfmlShaderSetMat3Uniform: TSfmlShaderSetMat3Uniform;
  SfmlShaderSetMat4Uniform: TSfmlShaderSetMat4Uniform;
  SfmlShaderSetTextureUniform: TSfmlShaderSetTextureUniform;
  SfmlShaderSetCurrentTextureUniform: TSfmlShaderSetCurrentTextureUniform;
  SfmlShaderSetFloatUniformArray: TSfmlShaderSetFloatUniformArray;
  SfmlShaderSetVec2UniformArray: TSfmlShaderSetVec2UniformArray;
  SfmlShaderSetVec3UniformArray: TSfmlShaderSetVec3UniformArray;
  SfmlShaderSetVec4UniformArray: TSfmlShaderSetVec4UniformArray;
  SfmlShaderSetMat3UniformArray: TSfmlShaderSetMat3UniformArray;
  SfmlShaderSetMat4UniformArray: TSfmlShaderSetMat4UniformArray;
  SfmlShaderSetFloatParameter: TSfmlShaderSetFloatParameter;
  SfmlShaderSetFloat2Parameter: TSfmlShaderSetFloat2Parameter;
  SfmlShaderSetFloat3Parameter: TSfmlShaderSetFloat3Parameter;
  SfmlShaderSetFloat4Parameter: TSfmlShaderSetFloat4Parameter;
  SfmlShaderSetVector2Parameter: TSfmlShaderSetVector2Parameter;
  SfmlShaderSetVector3Parameter: TSfmlShaderSetVector3Parameter;
  SfmlShaderSetColorParameter: TSfmlShaderSetColorParameter;
  SfmlShaderSetTransformParameter: TSfmlShaderSetTransformParameter;
  SfmlShaderSetTextureParameter: TSfmlShaderSetTextureParameter;
  SfmlShaderSetCurrentTextureParameter: TSfmlShaderSetCurrentTextureParameter;
  SfmlShaderGetNativeHandle: TSfmlShaderGetNativeHandle;
  SfmlShaderBind: TSfmlShaderBind;
  SfmlShaderIsAvailable: TSfmlShaderIsAvailable;
  SfmlShaderIsGeometryAvailable: TSfmlShaderIsGeometryAvailable;

  SfmlShapeCreate: TSfmlShapeCreate;
  SfmlShapeDestroy: TSfmlShapeDestroy;
  SfmlShapeSetPosition: TSfmlShapeSetPosition;
  SfmlShapeSetRotation: TSfmlShapeSetRotation;
  SfmlShapeSetScale: TSfmlShapeSetScale;
  SfmlShapeSetOrigin: TSfmlShapeSetOrigin;
  SfmlShapeGetRotation: TSfmlShapeGetRotation;
  SfmlShapeMove: TSfmlShapeMove;
  SfmlShapeRotate: TSfmlShapeRotate;
  SfmlShapeScale: TSfmlShapeScale;
  SfmlShapeGetTransform: TSfmlShapeGetTransform;
  SfmlShapeGetInverseTransform: TSfmlShapeGetInverseTransform;
  SfmlShapeSetTexture: TSfmlShapeSetTexture;
  SfmlShapeSetTextureRect: TSfmlShapeSetTextureRect;
  SfmlShapeSetFillColor: TSfmlShapeSetFillColor;
  SfmlShapeSetOutlineColor: TSfmlShapeSetOutlineColor;
  SfmlShapeSetOutlineThickness: TSfmlShapeSetOutlineThickness;
  SfmlShapeGetTexture: TSfmlShapeGetTexture;
  SfmlShapeGetTextureRect: TSfmlShapeGetTextureRect;
  SfmlShapeGetFillColor: TSfmlShapeGetFillColor;
  SfmlShapeGetOutlineColor: TSfmlShapeGetOutlineColor;
  SfmlShapeGetOutlineThickness: TSfmlShapeGetOutlineThickness;
  SfmlShapeGetPointCount: TSfmlShapeGetPointCount;
  SfmlShapeGetLocalBounds: TSfmlShapeGetLocalBounds;
  SfmlShapeGetGlobalBounds: TSfmlShapeGetGlobalBounds;
  SfmlShapeUpdate: TSfmlShapeUpdate;
{$IFNDEF INT64RETURNWORKAROUND}
  SfmlShapeGetOrigin: TSfmlShapeGetOrigin;
  SfmlShapeGetPoint: TSfmlShapeGetPoint;
  SfmlShapeGetPosition: TSfmlShapeGetPosition;
  SfmlShapeGetScale: TSfmlShapeGetScale;
{$ENDIF}

  SfmlSpriteCreate: TSfmlSpriteCreate;
  SfmlSpriteCopy: TSfmlSpriteCopy;
  SfmlSpriteDestroy: TSfmlSpriteDestroy;
  SfmlSpriteSetPosition: TSfmlSpriteSetPosition;
  SfmlSpriteSetRotation: TSfmlSpriteSetRotation;
  SfmlSpriteSetScale: TSfmlSpriteSetScale;
  SfmlSpriteSetOrigin: TSfmlSpriteSetOrigin;
  SfmlSpriteGetRotation: TSfmlSpriteGetRotation;
  SfmlSpriteMove: TSfmlSpriteMove;
  SfmlSpriteRotate: TSfmlSpriteRotate;
  SfmlSpriteScale: TSfmlSpriteScale;
  SfmlSpriteGetTransform: TSfmlSpriteGetTransform;
  SfmlSpriteGetInverseTransform: TSfmlSpriteGetInverseTransform;
  SfmlSpriteSetTexture: TSfmlSpriteSetTexture;
  SfmlSpriteSetTextureRect: TSfmlSpriteSetTextureRect;
  SfmlSpriteSetColor: TSfmlSpriteSetColor;
  SfmlSpriteGetTexture: TSfmlSpriteGetTexture;
  SfmlSpriteGetTextureRect: TSfmlSpriteGetTextureRect;
  SfmlSpriteGetColor: TSfmlSpriteGetColor;
  SfmlSpriteGetLocalBounds: TSfmlSpriteGetLocalBounds;
  SfmlSpriteGetGlobalBounds: TSfmlSpriteGetGlobalBounds;
{$IFNDEF INT64RETURNWORKAROUND}
  SfmlSpriteGetOrigin: TSfmlSpriteGetOrigin;
  SfmlSpriteGetPosition: TSfmlSpriteGetPosition;
  SfmlSpriteGetScale: TSfmlSpriteGetScale;
{$ENDIF}

  SfmlTextCreate: TSfmlTextCreate;
  SfmlTextCopy: TSfmlTextCopy;
  SfmlTextDestroy: TSfmlTextDestroy;
  SfmlTextSetPosition: TSfmlTextSetPosition;
  SfmlTextSetRotation: TSfmlTextSetRotation;
  SfmlTextSetScale: TSfmlTextSetScale;
  SfmlTextSetOrigin: TSfmlTextSetOrigin;
  SfmlTextGetRotation: TSfmlTextGetRotation;
  SfmlTextMove: TSfmlTextMove;
  SfmlTextRotate: TSfmlTextRotate;
  SfmlTextScale: TSfmlTextScale;
  SfmlTextGetTransform: TSfmlTextGetTransform;
  SfmlTextGetInverseTransform: TSfmlTextGetInverseTransform;
  SfmlTextSetString: TSfmlTextSetString;
  SfmlTextSetUnicodeString: TSfmlTextSetUnicodeString;
  SfmlTextSetFont: TSfmlTextSetFont;
  SfmlTextSetCharacterSize: TSfmlTextSetCharacterSize;
  SfmlTextSetStyle: TSfmlTextSetStyle;
  SfmlTextSetColor: TSfmlTextSetColor;
  SfmlTextSetFillColor: TSfmlTextSetFillColor;
  SfmlTextSetOutlineColor: TSfmlTextSetFillColor;
  SfmlTextSetOutlineThickness: TSfmlTextSetOutlineThickness;
  SfmlTextGetString: TSfmlTextGetString;
  SfmlTextGetUnicodeString: TSfmlTextGetUnicodeString;
  SfmlTextGetFont: TSfmlTextGetFont;
  SfmlTextGetCharacterSize: TSfmlTextGetCharacterSize;
  SfmlTextGetStyle: TSfmlTextGetStyle;
  SfmlTextGetColor: TSfmlTextGetColor;
  SfmlTextGetFillColor: TSfmlTextGetFillColor;
  SfmlTextGetOutlineColor: TSfmlTextGetOutlineColor;
  SfmlTextGetOutlineThickness: TSfmlTextGetOutlineThickness;
  SfmlTextGetLocalBounds: TSfmlTextGetLocalBounds;
  SfmlTextGetGlobalBounds: TSfmlTextGetGlobalBounds;
{$IFNDEF INT64RETURNWORKAROUND}
  SfmlTextGetOrigin: TSfmlTextGetOrigin;
  SfmlTextGetPosition: TSfmlTextGetPosition;
  SfmlTextGetScale: TSfmlTextGetScale;
  SfmlTextFindCharacterPos: TSfmlTextFindCharacterPos;
{$ENDIF}

  SfmlTextureCreate: TSfmlTextureCreate;
  SfmlTextureCreateFromFile: TSfmlTextureCreateFromFile;
  SfmlTextureCreateFromMemory: TSfmlTextureCreateFromMemory;
  SfmlTextureCreateFromStream: TSfmlTextureCreateFromStream;
  SfmlTextureCreateFromImage: TSfmlTextureCreateFromImage;
  SfmlTextureCopy: TSfmlTextureCopy;
  SfmlTextureDestroy: TSfmlTextureDestroy;
  SfmlTextureCopyToImage: TSfmlTextureCopyToImage;
  SfmlTextureUpdateFromPixels: TSfmlTextureUpdateFromPixels;
  SfmlTextureUpdateFromImage: TSfmlTextureUpdateFromImage;
  SfmlTextureUpdateFromWindow: TSfmlTextureUpdateFromWindow;
  SfmlTextureUpdateFromRenderWindow: TSfmlTextureUpdateFromRenderWindow;
  SfmlTextureSetSmooth: TSfmlTextureSetSmooth;
  SfmlTextureIsSmooth: TSfmlTextureIsSmooth;
  SfmlTextureSetSrgb: TSfmlTextureSetSrgb;
  SfmlTextureIsSrgb: TSfmlTextureIsSrgb;
  SfmlTextureSetRepeated: TSfmlTextureSetRepeated;
  SfmlTextureIsRepeated: TSfmlTextureIsRepeated;
  SfmlTextureGenerateMipmap: TSfmlTextureGenerateMipmap;
  SfmlTextureGetNativeHandle: TSfmlTextureGetNativeHandle;
  SfmlTextureBind: TSfmlTextureBind;
  SfmlTextureGetMaximumSize: TsfmlTextureGetMaximumSize;
{$IFNDEF INT64RETURNWORKAROUND}
  SfmlTextureGetSize: TSfmlTextureGetSize;
{$ENDIF}

  SfmlTransformFromMatrix: TSfmlTransformFromMatrix;
  SfmlTransformGetMatrix: TSfmlTransformGetMatrix;
  SfmlTransformGetInverse: TSfmlTransformGetInverse;
  SfmlTransformTransformRect: TSfmlTransformTransformRect;
  SfmlTransformCombine: TSfmlTransformCombine;
  SfmlTransformTranslate: TSfmlTransformTranslate;
  SfmlTransformRotate: TSfmlTransformRotate;
  SfmlTransformRotateWithCenter: TSfmlTransformRotateWithCenter;
  SfmlTransformScale: TSfmlTransformScale;
  SfmlTransformScaleWithCenter: TSfmlTransformScaleWithCenter;
{$IFNDEF INT64RETURNWORKAROUND}
  SfmlTransformTransformPoint: TSfmlTransformTransformPoint;
{$ENDIF}

  SfmlTransformableCreate: TSfmlTransformableCreate;
  SfmlTransformableCopy: TSfmlTransformableCopy;
  SfmlTransformableDestroy: TSfmlTransformableDestroy;
  SfmlTransformableSetPosition: TSfmlTransformableSetPosition;
  SfmlTransformableSetRotation: TSfmlTransformableSetRotation;
  SfmlTransformableSetScale: TSfmlTransformableSetScale;
  SfmlTransformableSetOrigin: TSfmlTransformableSetOrigin;
  SfmlTransformableGetRotation: TSfmlTransformableGetRotation;
  SfmlTransformableMove: TSfmlTransformableMove;
  SfmlTransformableRotate: TSfmlTransformableRotate;
  SfmlTransformableScale: TSfmlTransformableScale;
  SfmlTransformableGetTransform: TSfmlTransformableGetTransform;
  SfmlTransformableGetInverseTransform: TSfmlTransformableGetInverseTransform;
{$IFNDEF INT64RETURNWORKAROUND}
  SfmlTransformableGetOrigin: TSfmlTransformableGetOrigin;
  SfmlTransformableGetPosition: TSfmlTransformableGetPosition;
  SfmlTransformableGetScale: TSfmlTransformableGetScale;
{$ENDIF}

  SfmlVertexArrayCreate: TSfmlVertexArrayCreate;
  SfmlVertexArrayCopy: TSfmlVertexArrayCopy;
  SfmlVertexArrayDestroy: TSfmlVertexArrayDestroy;
  SfmlVertexArrayGetVertexCount: TSfmlVertexArrayGetVertexCount;
  SfmlVertexArrayGetVertex: TSfmlVertexArrayGetVertex;
  SfmlVertexArrayClear: TSfmlVertexArrayClear;
  SfmlVertexArrayResize: TSfmlVertexArrayResize;
  SfmlVertexArrayAppend: TSfmlVertexArrayAppend;
  SfmlVertexArraySetPrimitiveType: TSfmlVertexArraySetPrimitiveType;
  SfmlVertexArrayGetPrimitiveType: TSfmlVertexArrayGetPrimitiveType;
  SfmlVertexArrayGetBounds: TSfmlVertexArrayGetBounds;

  SfmlViewCreate: TSfmlViewCreate;
  SfmlViewCreateFromRect: TSfmlViewCreateFromRect;
  SfmlViewCopy: TSfmlViewCopy;
  SfmlViewDestroy: TSfmlViewDestroy;
  SfmlViewSetCenter: TSfmlViewSetCenter;
  SfmlViewSetSize: TSfmlViewSetSize;
  SfmlViewSetRotation: TSfmlViewSetRotation;
  SfmlViewSetViewport: TSfmlViewSetViewport;
  SfmlViewReset: TSfmlViewReset;
  SfmlViewGetRotation: TSfmlViewGetRotation;
  SfmlViewGetViewport: TSfmlViewGetViewport;
  SfmlViewMove: TSfmlViewMove;
  SfmlViewRotate: TSfmlViewRotate;
  SfmlViewZoom: TSfmlViewZoom;
{$IFNDEF INT64RETURNWORKAROUND}
  SfmlRenderTextureGetSize: TSfmlRenderTextureGetSize;
  SfmlRenderWindowGetSize: TSfmlRenderWindowGetSize;
  SfmlViewGetCenter: TSfmlViewGetCenter;
  SfmlViewGetSize: TSfmlViewGetSize;
{$ENDIF}

{$ELSE}

const
  SfmlBlack: TSfmlColor = (R: 0; G: 0; B: 0; A: $FF);
  SfmlWhite: TSfmlColor = (R: $FF; G: $FF; B: $FF; A: $FF);
  SfmlRed: TSfmlColor = (R: $FF; G: 0; B: 0; A: $FF);
  SfmlGreen: TSfmlColor = (R: 0; G: $FF; B: 0; A: $FF);
  SfmlBlue: TSfmlColor = (R: 0; G: 0; B: $FF; A: $FF);
  SfmlYellow: TSfmlColor = (R: $FF; G: $FF; B: 0; A: $FF);
  SfmlMagenta: TSfmlColor = (R: $FF; G: 0; B: $FF; A: $FF);
  SfmlCyan: TSfmlColor = (R: 0; G: $FF; B: $FF; A: $FF);
  SfmlTransparent: TSfmlColor = (R: 0; G: 0; B: 0; A: 0);

  SfmlTransformIdentity: TSfmlTransform = (Matrix: (1, 0, 0, 0, 1, 0, 0, 0, 1));

  SfmlBlendAlpha: TSfmlBlendMode = (
    ColorSrcFactor: sfBlendFactorSrcAlpha;
    ColorDstFactor: sfBlendFactorOneMinusSrcAlpha;
    ColorEquation: sfBlendEquationAdd;
    AlphaSrcFactor: sfBlendFactorOne;
    AlphaDstFactor: sfBlendFactorOneMinusSrcAlpha;
    AlphaEquation: sfBlendEquationAdd;
  );
  SfmlBlendAdd: TSfmlBlendMode = (
    ColorSrcFactor: sfBlendFactorSrcAlpha;
    ColorDstFactor: sfBlendFactorOne;
    ColorEquation: sfBlendEquationAdd;
    AlphaSrcFactor: sfBlendFactorOne;
    AlphaDstFactor: sfBlendFactorOne;
    AlphaEquation: sfBlendEquationAdd;
  );
  SfmlBlendMultiply: TSfmlBlendMode = (
    ColorSrcFactor: sfBlendFactorDstColor;
    ColorDstFactor: sfBlendFactorZero;
    ColorEquation: sfBlendEquationAdd;
    AlphaSrcFactor: sfBlendFactorDstColor;
    AlphaDstFactor: sfBlendFactorZero;
    AlphaEquation: sfBlendEquationAdd;
  );
  SfmlBlendNone: TSfmlBlendMode = (
    ColorSrcFactor: sfBlendFactorOne;
    ColorDstFactor: sfBlendFactorZero;
    ColorEquation: sfBlendEquationAdd;
    AlphaSrcFactor: sfBlendFactorOne;
    AlphaDstFactor: sfBlendFactorZero;
    AlphaEquation: sfBlendEquationAdd;
  );

  // static linking
  function SfmlColorFromRGB(Red, Green, Blue: Byte): TSfmlColor; cdecl; external CSfmlGraphicsLibrary name 'sfColor_fromRGB';
  function SfmlColorFromRGBA(Red, Green, Blue, Alpha: Byte): TSfmlColor; cdecl; external CSfmlGraphicsLibrary name 'sfColor_fromRGBA';

  function SfmlColorFromInteger(Color: Cardinal): TSfmlColor; cdecl; external CSfmlGraphicsLibrary name 'sfColor_fromInteger';
  function SfmlColorToInteger(Color: TSfmlColor): Cardinal; cdecl; external CSfmlGraphicsLibrary name 'sfColor_toInteger';

  function SfmlColorAdd(color1, color2: TSfmlColor): TSfmlColor; cdecl; external CSfmlGraphicsLibrary name 'sfColor_add';
  function SfmlColorSubtract(color1, color2: TSfmlColor): TSfmlColor; cdecl; external CSfmlGraphicsLibrary name 'sfColor_subtract';
  function SfmlColorModulate(color1, color2: TSfmlColor): TSfmlColor; cdecl; external CSfmlGraphicsLibrary name 'sfColor_modulate';

  function SfmlCircleShapeCreate: PSfmlCircleShape; cdecl; external CSfmlGraphicsLibrary name 'sfCircleShape_create';
  function SfmlCircleShapeCopy(const Shape: PSfmlCircleShape): PSfmlCircleShape; cdecl; external CSfmlGraphicsLibrary name 'sfCircleShape_copy';
  procedure SfmlCircleShapeDestroy(Shape: PSfmlCircleShape); cdecl; external CSfmlGraphicsLibrary name 'sfCircleShape_destroy';
  procedure SfmlCircleShapeSetPosition(Shape: PSfmlCircleShape; Position: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfCircleShape_setPosition';
  procedure SfmlCircleShapeSetRotation(Shape: PSfmlCircleShape; Angle: Single); cdecl; external CSfmlGraphicsLibrary name 'sfCircleShape_setRotation';
  procedure SfmlCircleShapeSetScale(Shape: PSfmlCircleShape; Scale: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfCircleShape_setScale';
  procedure SfmlCircleShapeSetOrigin(Shape: PSfmlCircleShape; Origin: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfCircleShape_setOrigin';
  function SfmlCircleShapeGetRotation(const Shape: PSfmlCircleShape): Single; cdecl; external CSfmlGraphicsLibrary name 'sfCircleShape_getRotation';
  procedure SfmlCircleShapeMove(Shape: PSfmlCircleShape; Offset: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfCircleShape_move';
  procedure SfmlCircleShapeRotate(Shape: PSfmlCircleShape; Angle: Single); cdecl; external CSfmlGraphicsLibrary name 'sfCircleShape_rotate';
  procedure SfmlCircleShapeScale(Shape: PSfmlCircleShape; Factors: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfCircleShape_scale';
  function SfmlCircleShapeGetTransform(const Shape: PSfmlCircleShape): TSfmlTransform; cdecl; external CSfmlGraphicsLibrary name 'sfCircleShape_getTransform';
  function SfmlCircleShapeGetInverseTransform(const Shape: PSfmlCircleShape): TSfmlTransform; cdecl; external CSfmlGraphicsLibrary name 'sfCircleShape_getInverseTransform';
  procedure SfmlCircleShapeSetTexture(Shape: PSfmlCircleShape; const Texture: PSfmlTexture; ResetRect: LongBool); cdecl; external CSfmlGraphicsLibrary name 'sfCircleShape_setTexture';
  procedure SfmlCircleShapeSetTextureRect(Shape: PSfmlCircleShape; Rect: TSfmlIntRect); cdecl; external CSfmlGraphicsLibrary name 'sfCircleShape_setTextureRect';
  procedure SfmlCircleShapeSetFillColor(Shape: PSfmlCircleShape; Color: TSfmlColor); cdecl; external CSfmlGraphicsLibrary name 'sfCircleShape_setFillColor';
  procedure SfmlCircleShapeSetOutlineColor(Shape: PSfmlCircleShape; Color: TSfmlColor); cdecl; external CSfmlGraphicsLibrary name 'sfCircleShape_setOutlineColor';
  procedure SfmlCircleShapeSetOutlineThickness(Shape: PSfmlCircleShape; Thickness: Single); cdecl; external CSfmlGraphicsLibrary name 'sfCircleShape_setOutlineThickness';
  function SfmlCircleShapeGetTexture(const Shape: PSfmlCircleShape): PSfmlTexture; cdecl; external CSfmlGraphicsLibrary name 'sfCircleShape_getTexture';
  function SfmlCircleShapeGetTextureRect(const Shape: PSfmlCircleShape): TSfmlIntRect; cdecl; external CSfmlGraphicsLibrary name 'sfCircleShape_getTextureRect';
  function SfmlCircleShapeGetFillColor(const Shape: PSfmlCircleShape): TSfmlColor; cdecl; external CSfmlGraphicsLibrary name 'sfCircleShape_getFillColor';
  function SfmlCircleShapeGetOutlineColor(const Shape: PSfmlCircleShape): TSfmlColor; cdecl; external CSfmlGraphicsLibrary name 'sfCircleShape_getOutlineColor';
  function SfmlCircleShapeGetOutlineThickness(const Shape: PSfmlCircleShape): Single; cdecl; external CSfmlGraphicsLibrary name 'sfCircleShape_getOutlineThickness';
  function SfmlCircleShapeGetPointCount(const Shape: PSfmlCircleShape): NativeUInt; cdecl; external CSfmlGraphicsLibrary name 'sfCircleShape_getPointCount';
  procedure SfmlCircleShapeSetRadius(Shape: PSfmlCircleShape; Radius: Single); cdecl; external CSfmlGraphicsLibrary name 'sfCircleShape_setRadius';
  function SfmlCircleShapeGetRadius(const Shape: PSfmlCircleShape): Single; cdecl; external CSfmlGraphicsLibrary name 'sfCircleShape_getRadius';
  procedure SfmlCircleShapeSetPointCount(Shape: PSfmlCircleShape; Count: NativeUInt); cdecl; external CSfmlGraphicsLibrary name 'sfCircleShape_setPointCount';
  function SfmlCircleShapeGetLocalBounds(const Shape: PSfmlCircleShape): TSfmlFloatRect; cdecl; external CSfmlGraphicsLibrary name 'sfCircleShape_getLocalBounds';
  function SfmlCircleShapeGetGlobalBounds(const Shape: PSfmlCircleShape): TSfmlFloatRect; cdecl; external CSfmlGraphicsLibrary name 'sfCircleShape_getGlobalBounds';
{$IFNDEF INT64RETURNWORKAROUND}
  function SfmlCircleShapeGetOrigin(const Shape: PSfmlCircleShape): TSfmlVector2f; cdecl; external CSfmlGraphicsLibrary name 'sfCircleShape_getOrigin';
  function SfmlCircleShapeGetPoint(const Shape: PSfmlCircleShape; Index: NativeUInt): TSfmlVector2f; cdecl; external CSfmlGraphicsLibrary name 'sfCircleShape_getPoint';
  function SfmlCircleShapeGetPosition(const Shape: PSfmlCircleShape): TSfmlVector2f; cdecl; external CSfmlGraphicsLibrary name 'sfCircleShape_getPosition';
  function SfmlCircleShapeGetScale(const Shape: PSfmlCircleShape): TSfmlVector2f; cdecl; external CSfmlGraphicsLibrary name 'sfCircleShape_getScale';
{$ENDIF}

  function SfmlConvexShapeCreate: PSfmlConvexShape; cdecl; external CSfmlGraphicsLibrary name 'sfConvexShape_create';
  function SfmlConvexShapeCopy(const Shape: PSfmlConvexShape): PSfmlConvexShape; cdecl; external CSfmlGraphicsLibrary name 'sfConvexShape_copy';
  procedure SfmlConvexShapeDestroy(Shape: PSfmlConvexShape); cdecl; external CSfmlGraphicsLibrary name 'sfConvexShape_destroy';
  procedure SfmlConvexShapeSetPosition(Shape: PSfmlConvexShape; Position: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfConvexShape_setPosition';
  procedure SfmlConvexShapeSetRotation(Shape: PSfmlConvexShape; Angle: Single); cdecl; external CSfmlGraphicsLibrary name 'sfConvexShape_setRotation';
  procedure SfmlConvexShapeSetScale(Shape: PSfmlConvexShape; Scale: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfConvexShape_setScale';
  procedure SfmlConvexShapeSetOrigin(Shape: PSfmlConvexShape; Origin: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfConvexShape_setOrigin';
  function SfmlConvexShapeGetRotation(const Shape: PSfmlConvexShape): Single; cdecl; external CSfmlGraphicsLibrary name 'sfConvexShape_getRotation';
  procedure SfmlConvexShapeMove(Shape: PSfmlConvexShape; Offset: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfConvexShape_move';
  procedure SfmlConvexShapeRotate(Shape: PSfmlConvexShape; Angle: Single); cdecl; external CSfmlGraphicsLibrary name 'sfConvexShape_rotate';
  procedure SfmlConvexShapeScale(Shape: PSfmlConvexShape; Factors: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfConvexShape_scale';
  function SfmlConvexShapeGetTransform(const Shape: PSfmlConvexShape): TSfmlTransform; cdecl; external CSfmlGraphicsLibrary name 'sfConvexShape_getTransform';
  function SfmlConvexShapeGetInverseTransform(const Shape: PSfmlConvexShape): TSfmlTransform; cdecl; external CSfmlGraphicsLibrary name 'sfConvexShape_getInverseTransform';
  procedure SfmlConvexShapeSetTexture(Shape: PSfmlConvexShape; const Texture: PSfmlTexture; ResetRect: LongBool); cdecl; external CSfmlGraphicsLibrary name 'sfConvexShape_setTexture';
  procedure SfmlConvexShapeSetTextureRect(Shape: PSfmlConvexShape; Rect: TSfmlIntRect); cdecl; external CSfmlGraphicsLibrary name 'sfConvexShape_setTextureRect';
  procedure SfmlConvexShapeSetFillColor(Shape: PSfmlConvexShape; Color: TSfmlColor); cdecl; external CSfmlGraphicsLibrary name 'sfConvexShape_setFillColor';
  procedure SfmlConvexShapeSetOutlineColor(Shape: PSfmlConvexShape; Color: TSfmlColor); cdecl; external CSfmlGraphicsLibrary name 'sfConvexShape_setOutlineColor';
  procedure SfmlConvexShapeSetOutlineThickness(Shape: PSfmlConvexShape; Thickness: Single); cdecl; external CSfmlGraphicsLibrary name 'sfConvexShape_setOutlineThickness';
  function SfmlConvexShapeGetTexture(const Shape: PSfmlConvexShape): PSfmlTexture; cdecl; external CSfmlGraphicsLibrary name 'sfConvexShape_getTexture';
  function SfmlConvexShapeGetTextureRect(const Shape: PSfmlConvexShape): TSfmlIntRect; cdecl; external CSfmlGraphicsLibrary name 'sfConvexShape_getTextureRect';
  function SfmlConvexShapeGetFillColor(const Shape: PSfmlConvexShape): TSfmlColor; cdecl; external CSfmlGraphicsLibrary name 'sfConvexShape_getFillColor';
  function SfmlConvexShapeGetOutlineColor(const Shape: PSfmlConvexShape): TSfmlColor; cdecl; external CSfmlGraphicsLibrary name 'sfConvexShape_getOutlineColor';
  function SfmlConvexShapeGetOutlineThickness(const Shape: PSfmlConvexShape): Single; cdecl; external CSfmlGraphicsLibrary name 'sfConvexShape_getOutlineThickness';
  function SfmlConvexShapeGetPointCount(const Shape: PSfmlConvexShape): NativeUInt; cdecl; external CSfmlGraphicsLibrary name 'sfConvexShape_getPointCount';
  procedure SfmlConvexShapeSetPointCount(Shape: PSfmlConvexShape; Count: NativeUInt); cdecl; external CSfmlGraphicsLibrary name 'sfConvexShape_setPointCount';
  procedure SfmlConvexShapeSetPoint(Shape: PSfmlConvexShape; Index: NativeUInt; Point: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfConvexShape_setPoint';
  function SfmlConvexShapeGetLocalBounds(const Shape: PSfmlConvexShape): TSfmlFloatRect; cdecl; external CSfmlGraphicsLibrary name 'sfConvexShape_getLocalBounds';
  function SfmlConvexShapeGetGlobalBounds(const Shape: PSfmlConvexShape): TSfmlFloatRect; cdecl; external CSfmlGraphicsLibrary name 'sfConvexShape_getGlobalBounds';
{$IFNDEF INT64RETURNWORKAROUND}
  function SfmlConvexShapeGetOrigin(const Shape: PSfmlConvexShape): TSfmlVector2f; cdecl; external CSfmlGraphicsLibrary name 'sfConvexShape_getOrigin';
  function SfmlConvexShapeGetPoint(const Shape: PSfmlConvexShape; Index: NativeUInt): TSfmlVector2f; cdecl; external CSfmlGraphicsLibrary name 'sfConvexShape_getPoint';
  function SfmlConvexShapeGetPosition(const Shape: PSfmlConvexShape): TSfmlVector2f; cdecl; external CSfmlGraphicsLibrary name 'sfConvexShape_getPosition';
  function SfmlConvexShapeGetScale(const Shape: PSfmlConvexShape): TSfmlVector2f; cdecl; external CSfmlGraphicsLibrary name 'sfConvexShape_getScale';
{$ENDIF}

  function SfmlFontCreateFromFile(const FileName: PAnsiChar): PSfmlFont; cdecl; external CSfmlGraphicsLibrary name 'sfFont_createFromFile';
  function SfmlFontCreateFromMemory(const Data: Pointer; SizeInBytes: NativeUInt): PSfmlFont; cdecl; external CSfmlGraphicsLibrary name 'sfFont_createFromMemory';
  function SfmlFontCreateFromStream(const Stream: PSfmlInputStream): PSfmlFont; cdecl; external CSfmlGraphicsLibrary name 'sfFont_createFromStream';
  function SfmlFontCopy(const Font: PSfmlFont): PSfmlFont; cdecl; external CSfmlGraphicsLibrary name 'sfFont_copy';
  procedure SfmlFontDestroy(Font: PSfmlFont); cdecl; external CSfmlGraphicsLibrary name 'sfFont_destroy';
  function SfmlFontGetGlyph(const Font: PSfmlFont; CodePoint: Cardinal; CharacterSize: Cardinal; Bold: LongBool): TSfmlGlyph; cdecl; external CSfmlGraphicsLibrary name 'sfFont_getGlyph';
  function SfmlFontGetKerning(const Font: PSfmlFont; First, Second: Cardinal; CharacterSize: Cardinal): Single; cdecl; external CSfmlGraphicsLibrary name 'sfFont_getKerning';
  function SfmlFontGetLineSpacing(const Font: PSfmlFont; CharacterSize: Cardinal): Single; cdecl; external CSfmlGraphicsLibrary name 'sfFont_getLineSpacing';
  function SfmlFontGetUnderlinePosition(const Font: PSfmlFont; CharacterSize: Cardinal): Single; cdecl; external CSfmlGraphicsLibrary name 'sfFont_getUnderlinePosition';
  function SfmlFontGetUnderlineThickness(const Font: PSfmlFont; CharacterSize: Cardinal): Single; cdecl; external CSfmlGraphicsLibrary name 'sfFont_getUnderlineThickness';
  function SfmlFontGetTexture(Font: PSfmlFont; CharacterSize: Cardinal): PSfmlTexture; cdecl; external CSfmlGraphicsLibrary name 'sfFont_getTexture';
  function SfmlFontGetInfo(const Font: PSfmlFont): TSfmlFontInfo; cdecl; external CSfmlGraphicsLibrary name 'sfFont_getInfo';

  function SfmlImageCreate(Width, Height: Cardinal): PSfmlImage; cdecl; external CSfmlGraphicsLibrary name 'sfImage_create';
  function SfmlImageCreateFromColor(Width, Height: Cardinal; Color: TSfmlColor): PSfmlImage; cdecl; external CSfmlGraphicsLibrary name 'sfImage_createFromColor';
  function SfmlImageCreateFromPixels(Width, Height: Cardinal; const Pixels: PByte): PSfmlImage; cdecl; external CSfmlGraphicsLibrary name 'sfImage_createFromPixels';
  function SfmlImageCreateFromFile(const FileName: PAnsiChar): PSfmlImage; cdecl; external CSfmlGraphicsLibrary name 'sfImage_createFromFile';
  function SfmlImageCreateFromMemory(const Data: Pointer; Size: NativeUInt): PSfmlImage; cdecl; external CSfmlGraphicsLibrary name 'sfImage_createFromMemory';
  function SfmlImageCreateFromStream(const Stream: PSfmlInputStream): PSfmlImage; cdecl; external CSfmlGraphicsLibrary name 'sfImage_createFromStream';
  function SfmlImageCopy(const Image: PSfmlImage): PSfmlImage; cdecl; external CSfmlGraphicsLibrary name 'sfImage_copy';
  procedure SfmlImageDestroy(Image: PSfmlImage); cdecl; external CSfmlGraphicsLibrary name 'sfImage_destroy';
  function SfmlImageSaveToFile(const Image: PSfmlImage; const FileName: PAnsiChar): LongBool; cdecl; external CSfmlGraphicsLibrary name 'sfImage_saveToFile';
  procedure SfmlImageCreateMaskFromColor(Image: PSfmlImage; Color: TSfmlColor; Alpha: Byte); cdecl; external CSfmlGraphicsLibrary name 'sfImage_createMaskFromColor';
  procedure SfmlImageCopyImage(Image: PSfmlImage; const Source: PSfmlImage; DestX, DestY: Cardinal; SourceRect: TSfmlIntRect; ApplyAlpha: LongBool); cdecl; external CSfmlGraphicsLibrary name 'sfImage_copyImage';
  procedure SfmlImageSetPixel(Image: PSfmlImage; X, Y: Cardinal; Color: TSfmlColor); cdecl; external CSfmlGraphicsLibrary name 'sfImage_setPixel';
  function SfmlImageGetPixel(const Image: PSfmlImage; X, Y: Cardinal): TSfmlColor; cdecl; external CSfmlGraphicsLibrary name 'sfImage_getPixel';
  function SfmlImageGetPixelsPtr(const Image: PSfmlImage): PByte; cdecl; external CSfmlGraphicsLibrary name 'sfImage_getPixelsPtr';
  procedure SfmlImageFlipHorizontally(Image: PSfmlImage); cdecl; external CSfmlGraphicsLibrary name 'sfImage_flipHorizontally';
  procedure SfmlImageFlipVertically(Image: PSfmlImage); cdecl; external CSfmlGraphicsLibrary name 'sfImage_flipVertically';
{$IFNDEF INT64RETURNWORKAROUND}
  function SfmlImageGetSize(const Image: PSfmlImage): TSfmlVector2u; cdecl; external CSfmlGraphicsLibrary name 'sfImage_getSize';
{$ENDIF}

  function SfmlFloatRectContains(var Rect: TSfmlFloatRect; X, Y: Single): LongBool; cdecl; external CSfmlGraphicsLibrary name 'sfFloatRect_contains';
  function SfmlIntRectContains(var Rect: TSfmlIntRect; X, Y: LongInt): LongBool; cdecl; external CSfmlGraphicsLibrary name 'sfIntRect_contains';
  function SfmlFloatRectIntersects(var rect1, rect2: TSfmlFloatRect; var Intersection: TSfmlFloatRect): LongBool; cdecl; external CSfmlGraphicsLibrary name 'sfFloatRect_intersects';
  function SfmlIntRectIntersects(var rect1, rect2: TSfmlIntRect; var Intersection: TSfmlFloatRect): LongBool; cdecl; external CSfmlGraphicsLibrary name 'sfIntRect_intersects';

  function SfmlRectangleShapeCreate: PSfmlRectangleShape; cdecl; external CSfmlGraphicsLibrary name 'sfRectangleShape_create';
  function SfmlRectangleShapeCopy(const Shape: PSfmlRectangleShape): PSfmlRectangleShape; cdecl; external CSfmlGraphicsLibrary name 'sfRectangleShape_copy';
  procedure SfmlRectangleShapeDestroy(Shape: PSfmlRectangleShape); cdecl; external CSfmlGraphicsLibrary name 'sfRectangleShape_destroy';
  procedure SfmlRectangleShapeSetPosition(Shape: PSfmlRectangleShape; Position: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfRectangleShape_setPosition';
  procedure SfmlRectangleShapeSetRotation(Shape: PSfmlRectangleShape; Angle: Single); cdecl; external CSfmlGraphicsLibrary name 'sfRectangleShape_setRotation';
  procedure SfmlRectangleShapeSetScale(Shape: PSfmlRectangleShape; Scale: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfRectangleShape_setScale';
  procedure SfmlRectangleShapeSetOrigin(Shape: PSfmlRectangleShape; Origin: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfRectangleShape_setOrigin';
  function SfmlRectangleShapeGetRotation(const Shape: PSfmlRectangleShape): Single; cdecl; external CSfmlGraphicsLibrary name 'sfRectangleShape_getRotation';
  procedure SfmlRectangleShapeMove(Shape: PSfmlRectangleShape; Offset: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfRectangleShape_move';
  procedure SfmlRectangleShapeRotate(Shape: PSfmlRectangleShape; Angle: Single); cdecl; external CSfmlGraphicsLibrary name 'sfRectangleShape_rotate';
  procedure SfmlRectangleShapeScale(Shape: PSfmlRectangleShape; Factors: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfRectangleShape_scale';
  function SfmlRectangleShapeGetTransform(const Shape: PSfmlRectangleShape): TSfmlTransform; cdecl; external CSfmlGraphicsLibrary name 'sfRectangleShape_getTransform';
  function SfmlRectangleShapeGetInverseTransform(const Shape: PSfmlRectangleShape): TSfmlTransform; cdecl; external CSfmlGraphicsLibrary name 'sfRectangleShape_getInverseTransform';
  procedure SfmlRectangleShapeSetTexture(Shape: PSfmlRectangleShape; const Texture: PSfmlTexture; ResetRect: LongBool); cdecl; external CSfmlGraphicsLibrary name 'sfRectangleShape_setTexture';
  procedure SfmlRectangleShapeSetTextureRect(Shape: PSfmlRectangleShape; Rect: TSfmlIntRect); cdecl; external CSfmlGraphicsLibrary name 'sfRectangleShape_setTextureRect';
  procedure SfmlRectangleShapeSetFillColor(Shape: PSfmlRectangleShape; Color: TSfmlColor); cdecl; external CSfmlGraphicsLibrary name 'sfRectangleShape_setFillColor';
  procedure SfmlRectangleShapeSetOutlineColor(Shape: PSfmlRectangleShape; Color: TSfmlColor); cdecl; external CSfmlGraphicsLibrary name 'sfRectangleShape_setOutlineColor';
  procedure SfmlRectangleShapeSetOutlineThickness(Shape: PSfmlRectangleShape; Thickness: Single); cdecl; external CSfmlGraphicsLibrary name 'sfRectangleShape_setOutlineThickness';
  function SfmlRectangleShapeGetTexture(const Shape: PSfmlRectangleShape): PSfmlTexture; cdecl; external CSfmlGraphicsLibrary name 'sfRectangleShape_getTexture';
  function SfmlRectangleShapeGetTextureRect(const Shape: PSfmlRectangleShape): TSfmlIntRect; cdecl; external CSfmlGraphicsLibrary name 'sfRectangleShape_getTextureRect';
  function SfmlRectangleShapeGetFillColor(const Shape: PSfmlRectangleShape): TSfmlColor; cdecl; external CSfmlGraphicsLibrary name 'sfRectangleShape_getFillColor';
  function SfmlRectangleShapeGetOutlineColor(const Shape: PSfmlRectangleShape): TSfmlColor; cdecl; external CSfmlGraphicsLibrary name 'sfRectangleShape_getOutlineColor';
  function SfmlRectangleShapeGetOutlineThickness(const Shape: PSfmlRectangleShape): Single; cdecl; external CSfmlGraphicsLibrary name 'sfRectangleShape_getOutlineThickness';
  function SfmlRectangleShapeGetPointCount(const Shape: PSfmlRectangleShape): NativeUInt; cdecl; external CSfmlGraphicsLibrary name 'sfRectangleShape_getPointCount';
  procedure SfmlRectangleShapeSetSize(Shape: PSfmlRectangleShape; Size: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfRectangleShape_setSize';
  function SfmlRectangleShapeGetLocalBounds(const Shape: PSfmlRectangleShape): TSfmlFloatRect; cdecl; external CSfmlGraphicsLibrary name 'sfRectangleShape_getLocalBounds';
  function SfmlRectangleShapeGetGlobalBounds(const Shape: PSfmlRectangleShape): TSfmlFloatRect; cdecl; external CSfmlGraphicsLibrary name 'sfRectangleShape_getGlobalBounds';
{$IFNDEF INT64RETURNWORKAROUND}
  function SfmlRectangleShapeGetOrigin(const Shape: PSfmlRectangleShape): TSfmlVector2f; cdecl; external CSfmlGraphicsLibrary name 'sfRectangleShape_getOrigin';
  function SfmlRectangleShapeGetPoint(const Shape: PSfmlRectangleShape; Index: NativeUInt): TSfmlVector2f; cdecl; external CSfmlGraphicsLibrary name 'sfRectangleShape_getPoint';
  function SfmlRectangleShapeGetPosition(const Shape: PSfmlRectangleShape): TSfmlVector2f; cdecl; external CSfmlGraphicsLibrary name 'sfRectangleShape_getPosition';
  function SfmlRectangleShapeGetScale(const Shape: PSfmlRectangleShape): TSfmlVector2f; cdecl; external CSfmlGraphicsLibrary name 'sfRectangleShape_getScale';
  function SfmlRectangleShapeGetSize(const Shape: PSfmlRectangleShape): TSfmlVector2f; cdecl; external CSfmlGraphicsLibrary name 'sfRectangleShape_getSize';
{$ENDIF}

  function SfmlRenderTextureCreate(Width, Height: Cardinal; DepthBuffer: LongBool): PSfmlRenderTexture; cdecl; external CSfmlGraphicsLibrary name 'sfRenderTexture_create';
  procedure SfmlRenderTextureDestroy(RenderTexture: PSfmlRenderTexture); cdecl; external CSfmlGraphicsLibrary name 'sfRenderTexture_destroy';
  function SfmlRenderTextureSetActive(RenderTexture: PSfmlRenderTexture; Active: LongBool): LongBool; cdecl; external CSfmlGraphicsLibrary name 'sfRenderTexture_setActive';
  procedure SfmlRenderTextureDisplay(RenderTexture: PSfmlRenderTexture); cdecl; external CSfmlGraphicsLibrary name 'sfRenderTexture_display';
  procedure SfmlRenderTextureClear(RenderTexture: PSfmlRenderTexture; Color: TSfmlColor); cdecl; external CSfmlGraphicsLibrary name 'sfRenderTexture_clear';
  procedure SfmlRenderTextureSetView(RenderTexture: PSfmlRenderTexture; const View: PSfmlView); cdecl; external CSfmlGraphicsLibrary name 'sfRenderTexture_setView';
  function SfmlRenderTextureGetView(const RenderTexture: PSfmlRenderTexture): PSfmlView; cdecl; external CSfmlGraphicsLibrary name 'sfRenderTexture_getView';
  function SfmlRenderTextureGetDefaultView(const RenderTexture: PSfmlRenderTexture): PSfmlView; cdecl; external CSfmlGraphicsLibrary name 'sfRenderTexture_getDefaultView';
  function SfmlRenderTextureGetViewport(const RenderTexture: PSfmlRenderTexture; const View: PSfmlView): TSfmlIntRect; cdecl; external CSfmlGraphicsLibrary name 'sfRenderTexture_getViewport';
  procedure SfmlRenderTextureDrawSprite(RenderTexture: PSfmlRenderTexture; const &Object: PSfmlSprite; const States: PSfmlRenderStates); cdecl; external CSfmlGraphicsLibrary name 'sfRenderTexture_drawSprite';
  procedure SfmlRenderTextureDrawText(RenderTexture: PSfmlRenderTexture; const &Object: PSfmlText; const States: PSfmlRenderStates); cdecl; external CSfmlGraphicsLibrary name 'sfRenderTexture_drawText';
  procedure SfmlRenderTextureDrawShape(RenderTexture: PSfmlRenderTexture; const &Object: PSfmlShape; const States: PSfmlRenderStates); cdecl; external CSfmlGraphicsLibrary name 'sfRenderTexture_drawShape';
  procedure SfmlRenderTextureDrawCircleShape(RenderTexture: PSfmlRenderTexture; const &Object: PSfmlCircleShape; const States: PSfmlRenderStates); cdecl; external CSfmlGraphicsLibrary name 'sfRenderTexture_drawCircleShape';
  procedure SfmlRenderTextureDrawConvexShape(RenderTexture: PSfmlRenderTexture; const &Object: PSfmlConvexShape; const States: PSfmlRenderStates); cdecl; external CSfmlGraphicsLibrary name 'sfRenderTexture_drawConvexShape';
  procedure SfmlRenderTextureDrawRectangleShape(RenderTexture: PSfmlRenderTexture; const &Object: PSfmlRectangleShape; const States: PSfmlRenderStates); cdecl; external CSfmlGraphicsLibrary name 'sfRenderTexture_drawRectangleShape';
  procedure SfmlRenderTextureDrawVertexArray(RenderTexture: PSfmlRenderTexture; const &Object: PSfmlVertexArray; const States: PSfmlRenderStates); cdecl; external CSfmlGraphicsLibrary name 'sfRenderTexture_drawVertexArray';
  procedure SfmlRenderTextureDrawPrimitives(RenderTexture: PSfmlRenderTexture; const Vertices: PSfmlVertex; VertexCount: NativeUInt; &Type: TSfmlPrimitiveType; const States: PSfmlRenderStates); cdecl; external CSfmlGraphicsLibrary name 'sfRenderTexture_drawPrimitives';
  procedure SfmlRenderTexturePushGLStates(RenderTexture: PSfmlRenderTexture); cdecl; external CSfmlGraphicsLibrary name 'sfRenderTexture_pushGLStates';
  procedure SfmlRenderTexturePopGLStates(RenderTexture: PSfmlRenderTexture); cdecl; external CSfmlGraphicsLibrary name 'sfRenderTexture_popGLStates';
  procedure SfmlRenderTextureResetGLStates(RenderTexture: PSfmlRenderTexture); cdecl; external CSfmlGraphicsLibrary name 'sfRenderTexture_resetGLStates';
  function SfmlRenderTextureGetTexture(const RenderTexture: PSfmlRenderTexture): PSfmlTexture ; cdecl; external CSfmlGraphicsLibrary name 'sfRenderTexture_getTexture';
  procedure SfmlRenderTextureSetSmooth(RenderTexture: PSfmlRenderTexture; Smooth: LongBool); cdecl; external CSfmlGraphicsLibrary name 'sfRenderTexture_setSmooth';
  function SfmlRenderTextureIsSmooth(const RenderTexture: PSfmlRenderTexture): LongBool; cdecl; external CSfmlGraphicsLibrary name 'sfRenderTexture_isSmooth';
  procedure SfmlRenderTextureSetRepeated(RenderTexture: PSfmlRenderTexture; Repeated: LongBool); cdecl; external CSfmlGraphicsLibrary name 'sfRenderTexture_setRepeated';
  function SfmlRenderTextureIsRepeated(const RenderTexture: PSfmlRenderTexture): LongBool; cdecl; external CSfmlGraphicsLibrary name 'sfRenderTexture_isRepeated';
  function SfmlRenderTextureGenerateMipmap(const RenderTexture: PSfmlRenderTexture): LongBool; cdecl; external CSfmlGraphicsLibrary name 'sfRenderTexture_generateMipmap';
{$IFNDEF INT64RETURNWORKAROUND}
  function SfmlRenderTextureGetSize(const RenderTexture: PSfmlRenderTexture): TSfmlVector2u; cdecl; external CSfmlGraphicsLibrary name 'sfRenderTexture_getSize';
  function SfmlRenderTextureMapPixelToCoords(const RenderTexture: PSfmlRenderTexture; Point: TSfmlVector2i; const View: PSfmlView): TSfmlVector2f; cdecl; external CSfmlGraphicsLibrary name 'sfRenderTexture_mapPixelToCoords';
  function SfmlRenderTextureMapCoordsToPixel(const RenderTexture: PSfmlRenderTexture; Point: TSfmlVector2i; const View: PSfmlView): TSfmlVector2i; cdecl; external CSfmlGraphicsLibrary name 'sfRenderTexture_mapCoordsToPixel';
{$ENDIF}

  function SfmlRenderWindowCreate(Mode: TSfmlVideoMode; const Title: PAnsiChar; Style: TSfmlWindowStyles; const Settings: PSfmlContextSettings): PSfmlRenderWindow; cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_create';
  function SfmlRenderWindowCreateUnicode(Mode: TSfmlVideoMode; const Title: PUCS4Char; Style: TSfmlWindowStyles; const Settings: PSfmlContextSettings): PSfmlRenderWindow; cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_createUnicode';
  function SfmlRenderWindowCreateFromHandle(Handle: TSfmlWindowHandle; const Settings: PSfmlContextSettings): PSfmlRenderWindow; cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_createFromHandle';
  procedure SfmlRenderWindowDestroy(RenderWindow: PSfmlRenderWindow); cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_destroy';
  procedure SfmlRenderWindowClose(RenderWindow: PSfmlRenderWindow); cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_close';
  function SfmlRenderWindowIsOpen(const RenderWindow: PSfmlRenderWindow): LongBool; cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_isOpen';
  function SfmlRenderWindowGetSettings(const RenderWindow: PSfmlRenderWindow): TSfmlContextSettings; cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_getSettings';
  function SfmlRenderWindowPollEvent(RenderWindow: PSfmlRenderWindow; out Event: TSfmlEvent): LongBool; cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_pollEvent';
  function SfmlRenderWindowWaitEvent(RenderWindow: PSfmlRenderWindow; out Event: TSfmlEvent): LongBool; cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_waitEvent';
  function SfmlRenderWindowGetPosition(const RenderWindow: PSfmlRenderWindow): TSfmlVector2i; cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_getPosition';
  procedure SfmlRenderWindowSetPosition(RenderWindow: PSfmlRenderWindow; Position: TSfmlVector2i); cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_setPosition';
  procedure SfmlRenderWindowSetSize(RenderWindow: PSfmlRenderWindow; Size: TSfmlVector2u); cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_setSize';
  procedure SfmlRenderWindowSetTitle(RenderWindow: PSfmlRenderWindow; const Title: PAnsiChar); cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_setTitle';
  procedure SfmlRenderWindowSetUnicodeTitle(RenderWindow: PSfmlRenderWindow; const Title: PUCS4Char); cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_setUnicodeTitle';
  procedure SfmlRenderWindowSetIcon(RenderWindow: PSfmlRenderWindow; Width, Height: Cardinal; const Pixels: PByte); cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_setIcon';
  procedure SfmlRenderWindowSetVisible(RenderWindow: PSfmlRenderWindow; Visible: LongBool); cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_setVisible';
  procedure SfmlRenderWindowSetVerticalSyncEnabled(RenderWindow: PSfmlRenderWindow; Enabled: LongBool); cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_setVerticalSyncEnabled';
  procedure SfmlRenderWindowSetMouseCursorVisible(RenderWindow: PSfmlRenderWindow; Show: LongBool); cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_setMouseCursorVisible';
  procedure SfmlRenderWindowSetMouseCursorGrabbed(RenderWindow: PSfmlRenderWindow; Grabbed: LongBool); cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_setMouseCursorGrabbed';
  procedure SfmlRenderWindowSetKeyRepeatEnabled(RenderWindow: PSfmlRenderWindow; Enabled: LongBool); cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_setKeyRepeatEnabled';
  procedure SfmlRenderWindowSetFramerateLimit(RenderWindow: PSfmlRenderWindow; Limit: Cardinal); cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_setFramerateLimit';
  procedure SfmlRenderWindowSetJoystickThreshold(RenderWindow: PSfmlRenderWindow; Threshold: Single); cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_setJoystickThreshold';
  function SfmlRenderWindowSetActive(RenderWindow: PSfmlRenderWindow; Active: LongBool): LongBool; cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_setActive';
  procedure SfmlRenderWindowRequestFocus(RenderWindow: PSfmlRenderWindow); cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_requestFocus';
  function SfmlRenderWindowHasFocus(const RenderWindow: PSfmlRenderWindow): LongBool; cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_hasFocus';
  procedure SfmlRenderWindowDisplay(RenderWindow: PSfmlRenderWindow); cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_display';
  function SfmlRenderWindowGetSystemHandle(const RenderWindow: PSfmlRenderWindow): TSfmlWindowHandle; cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_getSystemHandle';
  procedure SfmlRenderWindowClear(RenderWindow: PSfmlRenderWindow; Color: TSfmlColor); cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_clear';
  procedure SfmlRenderWindowSetView(RenderWindow: PSfmlRenderWindow; const View: PSfmlView); cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_setView';
  function SfmlRenderWindowGetView(const RenderWindow: PSfmlRenderWindow): PSfmlView; cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_getView';
  function SfmlRenderWindowGetDefaultView(const RenderWindow: PSfmlRenderWindow): PSfmlView; cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_getDefaultView';
  function SfmlRenderWindowGetViewport(const RenderWindow: PSfmlRenderWindow; const View: PSfmlView): TSfmlIntRect; cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_getViewport';
  procedure SfmlRenderWindowDrawSprite(RenderWindow: PSfmlRenderWindow; const &Object: PSfmlSprite; const States: PSfmlRenderStates); cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_drawSprite';
  procedure SfmlRenderWindowDrawText(RenderWindow: PSfmlRenderWindow; const &Object: PSfmlText; const States: PSfmlRenderStates); cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_drawText';
  procedure SfmlRenderWindowDrawShape(RenderWindow: PSfmlRenderWindow; const &Object: PSfmlShape; const States: PSfmlRenderStates); cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_drawShape';
  procedure SfmlRenderWindowDrawCircleShape(RenderWindow: PSfmlRenderWindow; const &Object: PSfmlCircleShape; const States: PSfmlRenderStates); cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_drawCircleShape';
  procedure SfmlRenderWindowDrawConvexShape(RenderWindow: PSfmlRenderWindow; const &Object: PSfmlConvexShape; const States: PSfmlRenderStates); cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_drawConvexShape';
  procedure SfmlRenderWindowDrawRectangleShape(RenderWindow: PSfmlRenderWindow; const &Object: PSfmlRectangleShape; const States: PSfmlRenderStates); cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_drawRectangleShape';
  procedure SfmlRenderWindowDrawVertexArray(RenderWindow: PSfmlRenderWindow; const &Object: PSfmlVertexArray; const States: PSfmlRenderStates); cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_drawVertexArray';
  procedure SfmlRenderWindowDrawPrimitives(RenderWindow: PSfmlRenderWindow; const Vertices: PSfmlVertex; VertexCount: NativeUInt; &Type: TSfmlPrimitiveType; const States: PSfmlRenderStates); cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_drawPrimitives';
  procedure SfmlRenderWindowPushGLStates(RenderWindow: PSfmlRenderWindow); cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_pushGLStates';
  procedure SfmlRenderWindowPopGLStates(RenderWindow: PSfmlRenderWindow); cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_popGLStates';
  procedure SfmlRenderWindowResetGLStates(RenderWindow: PSfmlRenderWindow); cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_resetGLStates';
  function SfmlRenderWindowCapture(const RenderWindow: PSfmlRenderWindow): PSfmlImage; cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_capture'; deprecated 'Use a sfTexture and its sfTexture_updateFromRenderWindow(sfTexture*, const sfRenderWindow*, unsigned int, unsigned int) function and copy its contents into an sfImage instead.';
{$IFNDEF INT64RETURNWORKAROUND}
  function SfmlRenderWindowGetSize(const RenderWindow: PSfmlRenderWindow): TSfmlVector2u; cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_getSize';
  function SfmlRenderWindowMapPixelToCoords(const RenderWindow: PSfmlRenderWindow; Point: TSfmlVector2i; const View: PSfmlView): TSfmlVector2f; cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_mapPixelToCoords';
  function SfmlRenderWindowMapCoordsToPixel(const RenderWindow: PSfmlRenderWindow; Point: TSfmlVector2i; const View: PSfmlView): TSfmlVector2i; cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_mapCoordsToPixel';
  function SfmlMouseGetPositionRenderWindow(const RelativeTo: PSfmlRenderWindow): TSfmlVector2i; cdecl; external CSfmlGraphicsLibrary name 'sfMouse_getPositionRenderWindow';
  function SfmlTouchGetPositionRenderWindow(Finger: Cardinal; const RelativeTo: PSfmlRenderWindow): TSfmlVector2i; cdecl; external CSfmlGraphicsLibrary name 'sfTouch_getPositionRenderWindow';
{$ENDIF}

  procedure SfmlMouseSetPositionRenderWindow(Position: TSfmlVector2i; const RelativeTo: PSfmlRenderWindow); cdecl; external CSfmlGraphicsLibrary name 'sfMouse_setPositionRenderWindow';

  function SfmlShaderCreateFromFile(const VertexShaderFilename: PAnsiChar; const GeometryShaderFilename: PAnsiChar; const FragmentShaderFilename: PAnsiChar): PSfmlShader; cdecl; external CSfmlGraphicsLibrary name 'sfShader_createFromFile';
  function SfmlShaderCreateFromMemory(const VertexShader: PAnsiChar; const GeometryShader: PAnsiChar; const FragmentShader: PAnsiChar): PSfmlShader; cdecl; external CSfmlGraphicsLibrary name 'sfShader_createFromMemory';
  function SfmlShaderCreateFromStream(VertexShaderStream: PSfmlInputStream; GeometryShaderStream: PSfmlInputStream; FragmentShaderStream: PSfmlInputStream): PSfmlShader; cdecl; external CSfmlGraphicsLibrary name 'sfShader_createFromStream';
  procedure SfmlShaderDestroy(Shader: PSfmlShader); cdecl; external CSfmlGraphicsLibrary name 'sfShader_destroy';
  procedure SfmlShaderSetFloatUniform(Shader: PSfmlShader; const Name: PAnsiChar; X: Single); cdecl; external CSfmlGraphicsLibrary name 'sfShader_setFloatUniform';
  procedure SfmlShaderSetVec2Uniform(Shader: PSfmlShader; const Name: PAnsiChar; Vector: TSfmlGlslVec2); cdecl; external CSfmlGraphicsLibrary name 'sfShader_setVec2Uniform';
  procedure SfmlShaderSetVec3Uniform(Shader: PSfmlShader; const Name: PAnsiChar; Vector: TSfmlGlslVec3); cdecl; external CSfmlGraphicsLibrary name 'sfShader_setVec3Uniform';
  procedure SfmlShaderSetVec4Uniform(Shader: PSfmlShader; const Name: PAnsiChar; Vector: TSfmlGlslVec4); cdecl; external CSfmlGraphicsLibrary name 'sfShader_setVec4Uniform';
  procedure SfmlShaderSetColorUniform(Shader: PSfmlShader; const Name: PAnsiChar; Color: TSfmlColor); cdecl; external CSfmlGraphicsLibrary name 'sfShader_setColorUniform';
  procedure SfmlShaderSetIntUniform(Shader: PSfmlShader; const Name: PAnsiChar; X: Integer); cdecl; external CSfmlGraphicsLibrary name 'sfShader_setIntUniform';
  procedure SfmlShaderSetIvec2Uniform(Shader: PSfmlShader; const Name: PAnsiChar; Vector: TSfmlGlslIvec2); cdecl; external CSfmlGraphicsLibrary name 'sfShader_setIvec2Uniform';
  procedure SfmlShaderSetIvec3Uniform(Shader: PSfmlShader; const Name: PAnsiChar; Vector: TSfmlGlslIvec3); cdecl; external CSfmlGraphicsLibrary name 'sfShader_setIvec3Uniform';
  procedure SfmlShaderSetIvec4Uniform(Shader: PSfmlShader; const Name: PAnsiChar; Vector: TSfmlGlslIvec4); cdecl; external CSfmlGraphicsLibrary name 'sfShader_setIvec4Uniform';
  procedure SfmlShaderSetIntColorUniform(Shader: PSfmlShader; const Name: PAnsiChar; Color: TSfmlColor); cdecl; external CSfmlGraphicsLibrary name 'sfShader_setIntColorUniform';
  procedure SfmlShaderSetBoolUniform(Shader: PSfmlShader; const Name: PAnsiChar; X: LongBool); cdecl; external CSfmlGraphicsLibrary name 'sfShader_setBoolUniform';
  procedure SfmlShaderSetBvec2Uniform(Shader: PSfmlShader; const Name: PAnsiChar; Vector: TSfmlGlslBvec2); cdecl; external CSfmlGraphicsLibrary name 'sfShader_setBvec2Uniform';
  procedure SfmlShaderSetBvec3Uniform(Shader: PSfmlShader; const Name: PAnsiChar; Vector: TSfmlGlslBvec3); cdecl; external CSfmlGraphicsLibrary name 'sfShader_setBvec3Uniform';
  procedure SfmlShaderSetBvec4Uniform(Shader: PSfmlShader; const Name: PAnsiChar; Vector: TSfmlGlslBvec4); cdecl; external CSfmlGraphicsLibrary name 'sfShader_setBvec4Uniform';
  procedure SfmlShaderSetMat3Uniform(Shader: PSfmlShader; const Name: PAnsiChar; const Matrix: PSfmlGlslMat3); cdecl; external CSfmlGraphicsLibrary name 'sfShader_setMat3Uniform';
  procedure SfmlShaderSetMat4Uniform(Shader: PSfmlShader; const Name: PAnsiChar; const Matrix: PSfmlGlslMat4); cdecl; external CSfmlGraphicsLibrary name 'sfShader_setMat4Uniform';
  procedure SfmlShaderSetTextureUniform(Shader: PSfmlShader; const Name: PAnsiChar; const Texture: PSfmlTexture); cdecl; external CSfmlGraphicsLibrary name 'sfShader_setTextureUniform';
  procedure SfmlShaderSetCurrentTextureUniform(Shader: PSfmlShader; Name: PAnsiChar); cdecl; external CSfmlGraphicsLibrary name 'sfShader_setCurrentTextureUniform';
  procedure SfmlShaderSetFloatUniformArray(Shader: PSfmlShader; const Name: PAnsiChar; const ScalarArray: PSingle; Length: NativeUInt); cdecl; external CSfmlGraphicsLibrary name 'sfShader_setFloatUniformArray';
  procedure SfmlShaderSetVec2UniformArray(Shader: PSfmlShader; const Name: PAnsiChar; const VectorArray: PSfmlGlslVec2; Length: NativeUInt); cdecl; external CSfmlGraphicsLibrary name 'sfShader_setVec2UniformArray';
  procedure SfmlShaderSetVec3UniformArray(Shader: PSfmlShader; const Name: PAnsiChar; const VectorArray: PSfmlGlslVec3; Length: NativeUInt); cdecl; external CSfmlGraphicsLibrary name 'sfShader_setVec3UniformArray';
  procedure SfmlShaderSetVec4UniformArray(Shader: PSfmlShader; const Name: PAnsiChar; const VectorArray: PSfmlGlslVec4; Length: NativeUInt); cdecl; external CSfmlGraphicsLibrary name 'sfShader_setVec4UniformArray';
  procedure SfmlShaderSetMat3UniformArray(Shader: PSfmlShader; const Name: PAnsiChar; const MatrixArray: PSfmlGlslMat3; Length: NativeUInt); cdecl; external CSfmlGraphicsLibrary name 'sfShader_setMat3UniformArray';
  procedure SfmlShaderSetMat4UniformArray(Shader: PSfmlShader; const Name: PAnsiChar; const MatrixArray: PSfmlGlslMat4; Length: NativeUInt); cdecl; external CSfmlGraphicsLibrary name 'sfShader_setMat4UniformArray';
  procedure SfmlShaderSetFloatParameter(Shader: PSfmlShader; const Name: PAnsiChar; X: Single); cdecl; external CSfmlGraphicsLibrary name 'sfShader_setFloatParameter'; deprecated;
  procedure SfmlShaderSetFloat2Parameter(Shader: PSfmlShader; const Name: PAnsiChar; X, Y: Single); cdecl; external CSfmlGraphicsLibrary name 'sfShader_setFloat2Parameter'; deprecated;
  procedure SfmlShaderSetFloat3Parameter(Shader: PSfmlShader; const Name: PAnsiChar; X, Y, Z: Single); cdecl; external CSfmlGraphicsLibrary name 'sfShader_setFloat3Parameter'; deprecated;
  procedure SfmlShaderSetFloat4Parameter(Shader: PSfmlShader; const Name: PAnsiChar; X, Y, Z, W: Single); cdecl; external CSfmlGraphicsLibrary name 'sfShader_setFloat4Parameter'; deprecated;
  procedure SfmlShaderSetVector2Parameter(Shader: PSfmlShader; const Name: PAnsiChar; Vector: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfShader_setVector2Parameter'; deprecated;
  procedure SfmlShaderSetVector3Parameter(Shader: PSfmlShader; const Name: PAnsiChar; Vector: TSfmlVector3f); cdecl; external CSfmlGraphicsLibrary name 'sfShader_setVector3Parameter'; deprecated;
  procedure SfmlShaderSetColorParameter(Shader: PSfmlShader; const Name: PAnsiChar; Color: TSfmlColor); cdecl; external CSfmlGraphicsLibrary name 'sfShader_setColorParameter'; deprecated;
  procedure SfmlShaderSetTransformParameter(Shader: PSfmlShader; const Name: PAnsiChar; Transform: TSfmlTransform); cdecl; external CSfmlGraphicsLibrary name 'sfShader_setTransformParameter'; deprecated;
  procedure SfmlShaderSetTextureParameter(Shader: PSfmlShader; const Name: PAnsiChar; const Texture: PSfmlTexture); cdecl; external CSfmlGraphicsLibrary name 'sfShader_setTextureParameter'; deprecated;
  procedure SfmlShaderSetCurrentTextureParameter(Shader: PSfmlShader; const Name: PAnsiChar); cdecl; external CSfmlGraphicsLibrary name 'sfShader_setCurrentTextureParameter';  deprecated;
  function SfmlShaderGetNativeHandle(Shader: PSfmlShader): Cardinal; cdecl; external CSfmlGraphicsLibrary name 'sfShader_getNativeHandle';
  procedure SfmlShaderBind(const Shader: PSfmlShader); cdecl; external CSfmlGraphicsLibrary name 'sfShader_bind';
  function SfmlShaderIsAvailable: LongBool; cdecl; external CSfmlGraphicsLibrary name 'sfShader_isAvailable';
  function SfmlShaderIsGeometryAvailable: LongBool; cdecl; external CSfmlGraphicsLibrary name 'sfShader_isGeometryAvailable';

  function SfmlShapeCreate(GetPointCount: TSfmlShapeGetPointCountCallback; GetPoint: TSfmlShapeGetPointCallback; UserData: Pointer): PSfmlShape; cdecl; external CSfmlGraphicsLibrary name 'sfShape_create';
  procedure SfmlShapeDestroy(Shape: PSfmlShape); cdecl; external CSfmlGraphicsLibrary name 'sfShape_destroy';
  procedure SfmlShapeSetPosition(Shape: PSfmlShape; Position: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfShape_setPosition';
  procedure SfmlShapeSetRotation(Shape: PSfmlShape; Angle: Single); cdecl; external CSfmlGraphicsLibrary name 'sfShape_setRotation';
  procedure SfmlShapeSetScale(Shape: PSfmlShape; Scale: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfShape_setScale';
  procedure SfmlShapeSetOrigin(Shape: PSfmlShape; Origin: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfShape_setOrigin';
  function SfmlShapeGetRotation(const Shape: PSfmlShape): Single; cdecl; external CSfmlGraphicsLibrary name 'sfShape_getRotation';
  procedure SfmlShapeMove(Shape: PSfmlShape; Offset: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfShape_move';
  procedure SfmlShapeRotate(Shape: PSfmlShape; Angle: Single); cdecl; external CSfmlGraphicsLibrary name 'sfShape_rotate';
  procedure SfmlShapeScale(Shape: PSfmlShape; Factors: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfShape_scale';
  function SfmlShapeGetTransform(const Shape: PSfmlShape): TSfmlTransform; cdecl; external CSfmlGraphicsLibrary name 'sfShape_getTransform';
  function SfmlShapeGetInverseTransform(const Shape: PSfmlShape): TSfmlTransform; cdecl; external CSfmlGraphicsLibrary name 'sfShape_getInverseTransform';
  procedure SfmlShapeSetTexture(Shape: PSfmlShape; const Texture: PSfmlTexture; ResetRect: LongBool); cdecl; external CSfmlGraphicsLibrary name 'sfShape_setTexture';
  procedure SfmlShapeSetTextureRect(Shape: PSfmlShape; Rect: TSfmlIntRect); cdecl; external CSfmlGraphicsLibrary name 'sfShape_setTextureRect';
  procedure SfmlShapeSetFillColor(Shape: PSfmlShape; Color: TSfmlColor); cdecl; external CSfmlGraphicsLibrary name 'sfShape_setFillColor';
  procedure SfmlShapeSetOutlineColor(Shape: PSfmlShape; Color: TSfmlColor); cdecl; external CSfmlGraphicsLibrary name 'sfShape_setOutlineColor';
  procedure SfmlShapeSetOutlineThickness(Shape: PSfmlShape; Thickness: Single); cdecl; external CSfmlGraphicsLibrary name 'sfShape_setOutlineThickness';
  function SfmlShapeGetTexture(const Shape: PSfmlShape): PSfmlTexture; cdecl; external CSfmlGraphicsLibrary name 'sfShape_getTexture';
  function SfmlShapeGetTextureRect(const Shape: PSfmlShape): TSfmlIntRect; cdecl; external CSfmlGraphicsLibrary name 'sfShape_getTextureRect';
  function SfmlShapeGetFillColor(const Shape: PSfmlShape): TSfmlColor; cdecl; external CSfmlGraphicsLibrary name 'sfShape_getFillColor';
  function SfmlShapeGetOutlineColor(const Shape: PSfmlShape): TSfmlColor; cdecl; external CSfmlGraphicsLibrary name 'sfShape_getOutlineColor';
  function SfmlShapeGetOutlineThickness(const Shape: PSfmlShape): Single; cdecl; external CSfmlGraphicsLibrary name 'sfShape_getOutlineThickness';
  function SfmlShapeGetPointCount(const Shape: PSfmlShape): NativeUInt; cdecl; external CSfmlGraphicsLibrary name 'sfShape_getPointCount';
  function SfmlShapeGetLocalBounds(const Shape: PSfmlShape): TSfmlFloatRect; cdecl; external CSfmlGraphicsLibrary name 'sfShape_getLocalBounds';
  function SfmlShapeGetGlobalBounds(const Shape: PSfmlShape): TSfmlFloatRect; cdecl; external CSfmlGraphicsLibrary name 'sfShape_getGlobalBounds';
  procedure SfmlShapeUpdate(Shape: PSfmlShape); cdecl; external CSfmlGraphicsLibrary name 'sfShape_update';
{$IFNDEF INT64RETURNWORKAROUND}
  function SfmlShapeGetOrigin(const Shape: PSfmlShape): TSfmlVector2f; cdecl; external CSfmlGraphicsLibrary name 'sfShape_getOrigin';
  function SfmlShapeGetPoint(const Shape: PSfmlShape; Index: NativeUInt): TSfmlVector2f; cdecl; external CSfmlGraphicsLibrary name 'sfShape_getPoint';
  function SfmlShapeGetPosition(const Shape: PSfmlShape): TSfmlVector2f; cdecl; external CSfmlGraphicsLibrary name 'sfShape_getPosition';
  function SfmlShapeGetScale(const Shape: PSfmlShape): TSfmlVector2f; cdecl; external CSfmlGraphicsLibrary name 'sfShape_getScale';
{$ENDIF}

  function SfmlSpriteCreate: PSfmlSprite; cdecl; external CSfmlGraphicsLibrary name 'sfSprite_create';
  function SfmlSpriteCopy(const Sprite: PSfmlSprite): PSfmlSprite; cdecl; external CSfmlGraphicsLibrary name 'sfSprite_copy';
  procedure SfmlSpriteDestroy(Sprite: PSfmlSprite); cdecl; external CSfmlGraphicsLibrary name 'sfSprite_destroy';
  procedure SfmlSpriteSetPosition(Sprite: PSfmlSprite; Position: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfSprite_setPosition';
  procedure SfmlSpriteSetRotation(Sprite: PSfmlSprite; Angle: Single); cdecl; external CSfmlGraphicsLibrary name 'sfSprite_setRotation';
  procedure SfmlSpriteSetScale(Sprite: PSfmlSprite; Scale: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfSprite_setScale';
  procedure SfmlSpriteSetOrigin(Sprite: PSfmlSprite; Origin: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfSprite_setOrigin';
  function SfmlSpriteGetRotation(const Sprite: PSfmlSprite): Single; cdecl; external CSfmlGraphicsLibrary name 'sfSprite_getRotation';
  procedure SfmlSpriteMove(Sprite: PSfmlSprite; Offset: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfSprite_move';
  procedure SfmlSpriteRotate(Sprite: PSfmlSprite; Angle: Single); cdecl; external CSfmlGraphicsLibrary name 'sfSprite_rotate';
  procedure SfmlSpriteScale(Sprite: PSfmlSprite; Factors: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfSprite_scale';
  function SfmlSpriteGetTransform(const Sprite: PSfmlSprite): TSfmlTransform; cdecl; external CSfmlGraphicsLibrary name 'sfSprite_getTransform';
  function SfmlSpriteGetInverseTransform(const Sprite: PSfmlSprite): TSfmlTransform; cdecl; external CSfmlGraphicsLibrary name 'sfSprite_getInverseTransform';
  procedure SfmlSpriteSetTexture(Sprite: PSfmlSprite; const Texture: PSfmlTexture; ResetRect: LongBool); cdecl; external CSfmlGraphicsLibrary name 'sfSprite_setTexture';
  procedure SfmlSpriteSetTextureRect(Sprite: PSfmlSprite; Rectangle: TSfmlIntRect); cdecl; external CSfmlGraphicsLibrary name 'sfSprite_setTextureRect';
  procedure SfmlSpriteSetColor(Sprite: PSfmlSprite; Color: TSfmlColor); cdecl; external CSfmlGraphicsLibrary name 'sfSprite_setColor';
  function SfmlSpriteGetTexture(const Sprite: PSfmlSprite): PSfmlTexture; cdecl; external CSfmlGraphicsLibrary name 'sfSprite_getTexture';
  function SfmlSpriteGetTextureRect(const Sprite: PSfmlSprite): TSfmlIntRect; cdecl; external CSfmlGraphicsLibrary name 'sfSprite_getTextureRect';
  function SfmlSpriteGetColor(const Sprite: PSfmlSprite): TSfmlColor; cdecl; external CSfmlGraphicsLibrary name 'sfSprite_getColor';
  function SfmlSpriteGetLocalBounds(const Sprite: PSfmlSprite): TSfmlFloatRect; cdecl; external CSfmlGraphicsLibrary name 'sfSprite_getLocalBounds';
  function SfmlSpriteGetGlobalBounds(const Sprite: PSfmlSprite): TSfmlFloatRect; cdecl; external CSfmlGraphicsLibrary name 'sfSprite_getGlobalBounds';
{$IFNDEF INT64RETURNWORKAROUND}
  function SfmlSpriteGetOrigin(const Sprite: PSfmlSprite): TSfmlVector2f; cdecl; external CSfmlGraphicsLibrary name 'sfSprite_getOrigin';
  function SfmlSpriteGetPosition(const Sprite: PSfmlSprite): TSfmlVector2f; cdecl; external CSfmlGraphicsLibrary name 'sfSprite_getPosition';
  function SfmlSpriteGetScale(const Sprite: PSfmlSprite): TSfmlVector2f; cdecl; external CSfmlGraphicsLibrary name 'sfSprite_getScale';
{$ENDIF}

  function SfmlTextCreate: PSfmlText; cdecl; external CSfmlGraphicsLibrary name 'sfText_create';
  function SfmlTextCopy(const Text: PSfmlText): PSfmlText; cdecl; external CSfmlGraphicsLibrary name 'sfText_copy';
  procedure SfmlTextDestroy(Text: PSfmlText); cdecl; external CSfmlGraphicsLibrary name 'sfText_destroy';
  procedure SfmlTextSetPosition(Text: PSfmlText; Position: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfText_setPosition';
  procedure SfmlTextSetRotation(Text: PSfmlText; Angle: Single); cdecl; external CSfmlGraphicsLibrary name 'sfText_setRotation';
  procedure SfmlTextSetScale(Text: PSfmlText; Scale: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfText_setScale';
  procedure SfmlTextSetOrigin(Text: PSfmlText; Origin: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfText_setOrigin';
  function SfmlTextGetRotation(const Text: PSfmlText): Single; cdecl; external CSfmlGraphicsLibrary name 'sfText_getRotation';
  procedure SfmlTextMove(Text: PSfmlText; Offset: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfText_move';
  procedure SfmlTextRotate(Text: PSfmlText; Angle: Single); cdecl; external CSfmlGraphicsLibrary name 'sfText_rotate';
  procedure SfmlTextScale(Text: PSfmlText; Factors: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfText_scale';
  function SfmlTextGetTransform(const Text: PSfmlText): TSfmlTransform; cdecl; external CSfmlGraphicsLibrary name 'sfText_getTransform';
  function SfmlTextGetInverseTransform(const Text: PSfmlText): TSfmlTransform; cdecl; external CSfmlGraphicsLibrary name 'sfText_getInverseTransform';
  procedure SfmlTextSetString(Text: PSfmlText; const &String: PAnsiChar); cdecl; external CSfmlGraphicsLibrary name 'sfText_setString';
  procedure SfmlTextSetUnicodeString(Text: PSfmlText; const &String: PUCS4Char); cdecl; external CSfmlGraphicsLibrary name 'sfText_setUnicodeString';
  procedure SfmlTextSetFont(Text: PSfmlText; const Font: PSfmlFont); cdecl; external CSfmlGraphicsLibrary name 'sfText_setFont';
  procedure SfmlTextSetCharacterSize(Text: PSfmlText; Size: Cardinal); cdecl; external CSfmlGraphicsLibrary name 'sfText_setCharacterSize';
  procedure SfmlTextSetStyle(Text: PSfmlText; Style: Cardinal); cdecl; external CSfmlGraphicsLibrary name 'sfText_setStyle';
  procedure SfmlTextSetColor(Text: PSfmlText; Color: TSfmlColor); cdecl; external CSfmlGraphicsLibrary name 'sfText_setColor'; deprecated 'Use sfText_setFillColor instead';
  procedure SfmlTextSetFillColor(Text: PSfmlText; Color: TSfmlColor); cdecl; external CSfmlGraphicsLibrary name 'sfText_setFillColor';
  procedure SfmlTextSetOutlineColor(Text: PSfmlText; Color: TSfmlColor); cdecl; external CSfmlGraphicsLibrary name 'sfText_setOutlineColor';
  procedure SfmlTextSetOutlineThickness(Text: PSfmlText; Thickness: Single); cdecl; external CSfmlGraphicsLibrary name 'sfText_setOutlineThickness';
  function SfmlTextGetString(const Text: PSfmlText): PAnsiChar; cdecl; external CSfmlGraphicsLibrary name 'sfText_getString';
  function SfmlTextGetUnicodeString(const Text: PSfmlText): PUCS4Char; cdecl; external CSfmlGraphicsLibrary name 'sfText_getUnicodeString';
  function SfmlTextGetFont(const Text: PSfmlText): PSfmlFont; cdecl; external CSfmlGraphicsLibrary name 'sfText_getFont';
  function SfmlTextGetCharacterSize(const Text: PSfmlText): Cardinal; cdecl; external CSfmlGraphicsLibrary name 'sfText_getCharacterSize';
  function SfmlTextGetStyle(const Text: PSfmlText): Cardinal; cdecl; external CSfmlGraphicsLibrary name 'sfText_getStyle';
  function SfmlTextGetColor(const Text: PSfmlText): TSfmlColor; cdecl; external CSfmlGraphicsLibrary name 'sfText_getColor'; deprecated 'Use sfText_getFillColor instead';
  function SfmlTextGetFillColor(const Text: PSfmlText): TSfmlColor; cdecl; external CSfmlGraphicsLibrary name 'sfText_getFillColor';
  function SfmlTextGetOutlineColor(const Text: PSfmlText): TSfmlColor; cdecl; external CSfmlGraphicsLibrary name 'sfText_getOutlineColor';
  function SfmlTextGetOutlineThickness(const Text: PSfmlText): Single; cdecl; external CSfmlGraphicsLibrary name 'sfText_getOutlineThickness';
  function SfmlTextGetLocalBounds(const Text: PSfmlText): TSfmlFloatRect; cdecl; external CSfmlGraphicsLibrary name 'sfText_getLocalBounds';
  function SfmlTextGetGlobalBounds(const Text: PSfmlText): TSfmlFloatRect; cdecl; external CSfmlGraphicsLibrary name 'sfText_getGlobalBounds';
{$IFNDEF INT64RETURNWORKAROUND}
  function SfmlTextFindCharacterPos(const Text: PSfmlText; Index: NativeUInt): TSfmlVector2f; cdecl; external CSfmlGraphicsLibrary name 'sfText_findCharacterPos';
  function SfmlTextGetOrigin(const Text: PSfmlText): TSfmlVector2f; cdecl; external CSfmlGraphicsLibrary name 'sfText_getOrigin';
  function SfmlTextGetPosition(const Text: PSfmlText): TSfmlVector2f; cdecl; external CSfmlGraphicsLibrary name 'sfText_getPosition';
  function SfmlTextGetScale(const Text: PSfmlText): TSfmlVector2f; cdecl; external CSfmlGraphicsLibrary name 'sfText_getScale';
{$ENDIF}

  function SfmlTextureCreate(Width, Height: Cardinal): PSfmlTexture; cdecl; external CSfmlGraphicsLibrary name 'sfTexture_create';
  function SfmlTextureCreateFromFile(const FileName: PAnsiChar; const Area: PSfmlIntRect): PSfmlTexture; cdecl; external CSfmlGraphicsLibrary name 'sfTexture_createFromFile';
  function SfmlTextureCreateFromMemory(const Data: Pointer; SizeInBytes: NativeUInt; const Area: PSfmlIntRect): PSfmlTexture; cdecl; external CSfmlGraphicsLibrary name 'sfTexture_createFromMemory';
  function SfmlTextureCreateFromStream(Stream: PSfmlInputStream; const Area: PSfmlIntRect): PSfmlTexture; cdecl; external CSfmlGraphicsLibrary name 'sfTexture_createFromStream';
  function SfmlTextureCreateFromImage(const Image: PSfmlImage; const Area: PSfmlIntRect): PSfmlTexture; cdecl; external CSfmlGraphicsLibrary name 'sfTexture_createFromImage';
  function SfmlTextureCopy(const Texture: PSfmlTexture): PSfmlTexture; cdecl; external CSfmlGraphicsLibrary name 'sfTexture_copy';
  procedure SfmlTextureDestroy(Texture: PSfmlTexture); cdecl; external CSfmlGraphicsLibrary name 'sfTexture_destroy';
  function SfmlTextureCopyToImage(const Texture: PSfmlTexture): PSfmlImage; cdecl; external CSfmlGraphicsLibrary name 'sfTexture_copyToImage';
  procedure SfmlTextureUpdateFromPixels(Texture: PSfmlTexture; const Pixels: PByte; Width, Height, X, Y: Cardinal); cdecl; external CSfmlGraphicsLibrary name 'sfTexture_updateFromPixels';
  procedure SfmlTextureUpdateFromImage(Texture: PSfmlTexture; const Image: PSfmlImage; X, Y: Cardinal); cdecl; external CSfmlGraphicsLibrary name 'sfTexture_updateFromImage';
  procedure SfmlTextureUpdateFromWindow(Texture: PSfmlTexture; const Window: PSfmlWindow; X, Y: Cardinal); cdecl; external CSfmlGraphicsLibrary name 'sfTexture_updateFromWindow';
  procedure SfmlTextureUpdateFromRenderWindow(Texture: PSfmlTexture; const RenderWindow: PSfmlRenderWindow; X, Y: Cardinal); cdecl; external CSfmlGraphicsLibrary name 'sfTexture_updateFromRenderWindow';
  procedure SfmlTextureSetSmooth(Texture: PSfmlTexture; Smooth: LongBool); cdecl; external CSfmlGraphicsLibrary name 'sfTexture_setSmooth';
  function SfmlTextureIsSmooth(const Texture: PSfmlTexture): LongBool; cdecl; external CSfmlGraphicsLibrary name 'sfTexture_isSmooth';
  procedure SfmlTextureSetSrgb(const Texture: PSfmlTexture; sRgb: LongBool); cdecl; external CSfmlGraphicsLibrary name 'sfTexture_setSrgb';
  function SfmlTextureIsSrgb(const Texture: PSfmlTexture): LongBool; cdecl; external CSfmlGraphicsLibrary name 'sfTexture_isSrgb';

  procedure SfmlTextureSetRepeated(Texture: PSfmlTexture; Repeated: LongBool); cdecl; external CSfmlGraphicsLibrary name 'sfTexture_setRepeated';
  function SfmlTextureIsRepeated(const Texture: PSfmlTexture): LongBool; cdecl; external CSfmlGraphicsLibrary name 'sfTexture_isRepeated';
  function SfmlTextureGenerateMipmap(const Texture: PSfmlTexture): LongBool; cdecl; external CSfmlGraphicsLibrary name 'sfTexture_generateMipmap';
  function SfmlTextureGetNativeHandle(const Texture: PSfmlTexture): Cardinal; cdecl; external CSfmlGraphicsLibrary name 'sfTexture_getNativeHandle';
  procedure SfmlTextureBind(const Texture: PSfmlTexture); cdecl; external CSfmlGraphicsLibrary name 'sfTexture_bind';
  function sfmlTextureGetMaximumSize: Cardinal; cdecl; external CSfmlGraphicsLibrary name 'sfTexture_getMaximumSize';
{$IFNDEF INT64RETURNWORKAROUND}
  function SfmlTextureGetSize(const Texture: PSfmlTexture): TSfmlVector2u; cdecl; external CSfmlGraphicsLibrary name 'sfTexture_getSize';
{$ENDIF}

  function SfmlTransformFromMatrix(a00, a01, a02, a10, a11, a12, a20, a21, a22: Single): TSfmlTransform; cdecl; external CSfmlGraphicsLibrary name 'sfTransform_fromMatrix';
  procedure SfmlTransformGetMatrix(const Transform: PSfmlTransform; Matrix: PSingle); cdecl; external CSfmlGraphicsLibrary name 'sfTransform_getMatrix';
  function SfmlTransformGetInverse(const Transform: PSfmlTransform): TSfmlTransform; cdecl; external CSfmlGraphicsLibrary name 'sfTransform_getInverse';
  function SfmlTransformTransformRect(const Transform: PSfmlTransform; Rectangle: TSfmlFloatRect): TSfmlFloatRect; cdecl; external CSfmlGraphicsLibrary name 'sfTransform_transformRect';
  procedure SfmlTransformCombine(out Transform: TSfmlTransform; const Other: PSfmlTransform); cdecl; external CSfmlGraphicsLibrary name 'sfTransform_combine';
  procedure SfmlTransformTranslate(Transform: PSfmlTransform; X, Y: Single); cdecl; external CSfmlGraphicsLibrary name 'sfTransform_translate';
  procedure SfmlTransformRotate(Transform: PSfmlTransform; Angle: Single); cdecl; external CSfmlGraphicsLibrary name 'sfTransform_rotate';
  procedure SfmlTransformRotateWithCenter(Transform: PSfmlTransform; Angle: Single; centerX, centerY: Single); cdecl; external CSfmlGraphicsLibrary name 'sfTransform_rotateWithCenter';
  procedure SfmlTransformScale(Transform: PSfmlTransform; ScaleX, ScaleY: Single); cdecl; external CSfmlGraphicsLibrary name 'sfTransform_scale';
  procedure SfmlTransformScaleWithCenter(Transform: PSfmlTransform; ScaleX, ScaleY, CenterX, CenterY: Single); cdecl; external CSfmlGraphicsLibrary name 'sfTransform_scaleWithCenter';
{$IFNDEF INT64RETURNWORKAROUND}
  function SfmlTransformTransformPoint(const Transform: PSfmlTransform; Point: TSfmlVector2f): TSfmlVector2f; cdecl; external CSfmlGraphicsLibrary name 'sfTransform_transformPoint';
{$ENDIF}

  function SfmlTransformableCreate: PSfmlTransformable; cdecl; external CSfmlGraphicsLibrary name 'sfTransformable_create';
  function SfmlTransformableCopy(const Transformable: PSfmlTransformable): PSfmlTransformable; cdecl; external CSfmlGraphicsLibrary name 'sfTransformable_copy';
  procedure SfmlTransformableDestroy(Transformable: PSfmlTransformable); cdecl; external CSfmlGraphicsLibrary name 'sfTransformable_destroy';
  procedure SfmlTransformableSetPosition(Transformable: PSfmlTransformable; Position: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfTransformable_setPosition';
  procedure SfmlTransformableSetRotation(Transformable: PSfmlTransformable; Angle: Single); cdecl; external CSfmlGraphicsLibrary name 'sfTransformable_setRotation';
  procedure SfmlTransformableSetScale(Transformable: PSfmlTransformable; Scale: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfTransformable_setScale';
  procedure SfmlTransformableSetOrigin(Transformable: PSfmlTransformable; Origin: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfTransformable_setOrigin';
  function SfmlTransformableGetRotation(const Transformable: PSfmlTransformable): Single; cdecl; external CSfmlGraphicsLibrary name 'sfTransformable_getRotation';
  procedure SfmlTransformableMove(Transformable: PSfmlTransformable; Offset: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfTransformable_move';
  procedure SfmlTransformableRotate(Transformable: PSfmlTransformable; Angle: Single); cdecl; external CSfmlGraphicsLibrary name 'sfTransformable_rotate';
  procedure SfmlTransformableScale(Transformable: PSfmlTransformable; Factors: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfTransformable_scale';
  function SfmlTransformableGetTransform(const Transformable: PSfmlTransformable): TSfmlTransform; cdecl; external CSfmlGraphicsLibrary name 'sfTransformable_getTransform';
  function SfmlTransformableGetInverseTransform(const Transformable: PSfmlTransformable): TSfmlTransform; cdecl; external CSfmlGraphicsLibrary name 'sfTransformable_getInverseTransform';
{$IFNDEF INT64RETURNWORKAROUND}
  function SfmlTransformableGetOrigin(const Transformable: PSfmlTransformable): TSfmlVector2f; cdecl; external CSfmlGraphicsLibrary name 'sfTransformable_getOrigin';
  function SfmlTransformableGetPosition(const Transformable: PSfmlTransformable): TSfmlVector2f; cdecl; external CSfmlGraphicsLibrary name 'sfTransformable_getPosition';
  function SfmlTransformableGetScale(const Transformable: PSfmlTransformable): TSfmlVector2f; cdecl; external CSfmlGraphicsLibrary name 'sfTransformable_getScale';
{$ENDIF}

  function SfmlVertexArrayCreate: PSfmlVertexArray; cdecl; external CSfmlGraphicsLibrary name 'sfVertexArray_create';
  function SfmlVertexArrayCopy(const VertexArray: PSfmlVertexArray): PSfmlVertexArray; cdecl; external CSfmlGraphicsLibrary name 'sfVertexArray_copy';
  procedure SfmlVertexArrayDestroy(VertexArray: PSfmlVertexArray); cdecl; external CSfmlGraphicsLibrary name 'sfVertexArray_destroy';
  function SfmlVertexArrayGetVertexCount(const VertexArray: PSfmlVertexArray): NativeUInt; cdecl; external CSfmlGraphicsLibrary name 'sfVertexArray_getVertexCount';
  function SfmlVertexArrayGetVertex(VertexArray: PSfmlVertexArray; Index: NativeUInt): PSfmlVertex; cdecl; external CSfmlGraphicsLibrary name 'sfVertexArray_getVertex';
  procedure SfmlVertexArrayClear(VertexArray: PSfmlVertexArray); cdecl; external CSfmlGraphicsLibrary name 'sfVertexArray_clear';
  procedure SfmlVertexArrayResize(VertexArray: PSfmlVertexArray; VertexCount: NativeUInt); cdecl; external CSfmlGraphicsLibrary name 'sfVertexArray_resize';
  procedure SfmlVertexArrayAppend(VertexArray: PSfmlVertexArray; Vertex: TSfmlVertex); cdecl; external CSfmlGraphicsLibrary name 'sfVertexArray_append';
  procedure SfmlVertexArraySetPrimitiveType(VertexArray: PSfmlVertexArray; &Type: TSfmlPrimitiveType); cdecl; external CSfmlGraphicsLibrary name 'sfVertexArray_setPrimitiveType';
  function SfmlVertexArrayGetPrimitiveType(VertexArray: PSfmlVertexArray): TSfmlPrimitiveType; cdecl; external CSfmlGraphicsLibrary name 'sfVertexArray_getPrimitiveType';
  function SfmlVertexArrayGetBounds(VertexArray: PSfmlVertexArray): TSfmlFloatRect; cdecl; external CSfmlGraphicsLibrary name 'sfVertexArray_getBounds';

  function SfmlViewCreate: PSfmlView; cdecl; external CSfmlGraphicsLibrary name 'sfView_create';
  function SfmlViewCreateFromRect(Rectangle: TSfmlFloatRect): PSfmlView; cdecl; external CSfmlGraphicsLibrary name 'sfView_createFromRect';
  function SfmlViewCopy(const View: PSfmlView): PSfmlView; cdecl; external CSfmlGraphicsLibrary name 'sfView_copy';
  procedure SfmlViewDestroy(View: PSfmlView); cdecl; external CSfmlGraphicsLibrary name 'sfView_destroy';
  procedure SfmlViewSetCenter(View: PSfmlView; Center: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfView_setCenter';
  procedure SfmlViewSetSize(View: PSfmlView; Size: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfView_setSize';
  procedure SfmlViewSetRotation(View: PSfmlView; Angle: Single); cdecl; external CSfmlGraphicsLibrary name 'sfView_setRotation';
  procedure SfmlViewSetViewport(View: PSfmlView; Viewport: TSfmlFloatRect); cdecl; external CSfmlGraphicsLibrary name 'sfView_setViewport';
  procedure SfmlViewReset(View: PSfmlView; Rectangle: TSfmlFloatRect); cdecl; external CSfmlGraphicsLibrary name 'sfView_reset';
  function SfmlViewGetRotation(const View: PSfmlView): Single; cdecl; external CSfmlGraphicsLibrary name 'sfView_getRotation';
  function SfmlViewGetViewport(const View: PSfmlView): TSfmlFloatRect; cdecl; external CSfmlGraphicsLibrary name 'sfView_getViewport';
  procedure SfmlViewMove(View: PSfmlView; Offset: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfView_move';
  procedure SfmlViewRotate(View: PSfmlView; Angle: Single); cdecl; external CSfmlGraphicsLibrary name 'sfView_rotate';
  procedure SfmlViewZoom(View: PSfmlView; Factor: Single); cdecl; external CSfmlGraphicsLibrary name 'sfView_zoom';
{$IFNDEF INT64RETURNWORKAROUND}
  function SfmlViewGetCenter(const View: PSfmlView): TSfmlVector2f; cdecl; external CSfmlGraphicsLibrary name 'sfView_getCenter';
  function SfmlViewGetSize(const View: PSfmlView): TSfmlVector2f; cdecl; external CSfmlGraphicsLibrary name 'sfView_getSize';
{$ENDIF}

{$ENDIF}

type
  TSfmlDrawable = class(TInterfacedObject)
  end;

  TSfmlTransformable = class(TSfmlDrawable)
  private
    FHandle: PSfmlTransformable;

    constructor Create(Handle: PSfmlTransformable); overload;
    function GetInverseTransform: TSfmlTransform; virtual;
    function GetOrigin: TSfmlVector2f; virtual;
    function GetPosition: TSfmlVector2f; virtual;
    function GetRotation: Single; virtual;
    function GetScale: TSfmlVector2f; virtual;
    function GetTransform: TSfmlTransform; virtual;
    procedure SetOrigin(Origin: TSfmlVector2f); virtual;
    procedure SetPosition(Position: TSfmlVector2f); virtual;
    procedure SetRotation(Angle: Single); virtual;
    procedure SetScale(Scale: TSfmlVector2f); virtual;
  public
    constructor Create; overload;
    destructor Destroy; override;

    function Copy: TSfmlTransformable;

    procedure Move(Offset: TSfmlVector2f); overload; virtual;
    procedure Move(X, Y: Single); overload;
    procedure Rotate(Angle: Single); virtual;
    procedure Scale(Factors: TSfmlVector2f); overload; virtual;
    procedure Scale(X, Y: Single); overload;

    property Handle: PSfmlTransformable read FHandle;
    property InverseTransform: TSfmlTransform read GetInverseTransform;
    property Origin: TSfmlVector2f read GetOrigin write SetOrigin;
    property Position: TSfmlVector2f read GetPosition write SetPosition;
    property Rotation: Single read GetRotation write SetRotation;
    property ScaleFactor: TSfmlVector2f read GetScale write SetScale;
    property Transform: TSfmlTransform read GetTransform;
  end;

  TSfmlShape = class(TSfmlTransformable)
  private
    FHandle: PSfmlShape;
  protected
    function GetFillColor: TSfmlColor; virtual;
    function GetGlobalBounds: TSfmlFloatRect; virtual;
    function GetInverseTransform: TSfmlTransform; override;
    function GetLocalBounds: TSfmlFloatRect; virtual;
    function GetOrigin: TSfmlVector2f; override;
    function GetOutlineColor: TSfmlColor; virtual;
    function GetOutlineThickness: Single; virtual;
    function GetPoint(Index: NativeUInt): TSfmlVector2f; virtual;
    function GetPointCount: NativeUInt; virtual;
    function GetPosition: TSfmlVector2f; override;
    function GetRotation: Single; override;
    function GetScale: TSfmlVector2f; override;
    function GetTexture: PSfmlTexture; virtual;
    function GetTextureRect: TSfmlIntRect; virtual;
    function GetTransform: TSfmlTransform; override;
    procedure SetFillColor(Color: TSfmlColor); virtual;
    procedure SetOrigin(Origin: TSfmlVector2f); override;
    procedure SetOutlineColor(Color: TSfmlColor); virtual;
    procedure SetOutlineThickness(Thickness: Single); virtual;
    procedure SetPosition(Position: TSfmlVector2f); override;
    procedure SetRotation(Angle: Single); override;
    procedure SetScale(Scale: TSfmlVector2f); override;
    procedure SetTextureRect(Rect: TSfmlIntRect); virtual;
  public
    constructor Create(GetPointCount: TSfmlShapeGetPointCountCallback; GetPoint: TSfmlShapeGetPointCallback; UserData: Pointer); overload;
    destructor Destroy; override;

    procedure Move(Offset: TSfmlVector2f); override;
    procedure Rotate(Angle: Single); override;
    procedure Scale(Factors: TSfmlVector2f); override;

    procedure SetTexture(const Texture: PSfmlTexture; ResetRect: Boolean);

    procedure Update;

    property FillColor: TSfmlColor read GetFillColor write SetFillColor;
    property GlobalBounds: TSfmlFloatRect read GetGlobalBounds;
    property Handle: PSfmlShape read FHandle;
    property LocalBounds: TSfmlFloatRect read GetLocalBounds;
    property OutlineColor: TSfmlColor read GetOutlineColor write SetOutlineColor;
    property OutlineThickness: Single read GetOutlineThickness write SetOutlineThickness;
    property Point[Index: NativeUInt]: TSfmlVector2f read GetPoint;
    property PointCount: NativeUInt read GetPointCount;
    property Texture: PSfmlTexture read GetTexture;
    property TextureRect: TSfmlIntRect read GetTextureRect write SetTextureRect;
  end;

  TSfmlCircleShape = class(TSfmlShape)
  private
    FHandle: PSfmlCircleShape;

    constructor Create(Handle: PSfmlCircleShape); overload;
    function GetRadius: Single;
    procedure SetRadius(Radius: Single);
    procedure SetPointCount(Count: NativeUInt);
  protected
    function GetFillColor: TSfmlColor; override;
    function GetGlobalBounds: TSfmlFloatRect; override;
    function GetInverseTransform: TSfmlTransform; override;
    function GetLocalBounds: TSfmlFloatRect; override;
    function GetOrigin: TSfmlVector2f; override;
    function GetOutlineColor: TSfmlColor; override;
    function GetOutlineThickness: Single; override;
    function GetPoint(Index: NativeUInt): TSfmlVector2f; override;
    function GetPointCount: NativeUInt; override;
    function GetPosition: TSfmlVector2f; override;
    function GetRotation: Single; override;
    function GetScale: TSfmlVector2f; override;
    function GetTexture: PSfmlTexture; override;
    function GetTextureRect: TSfmlIntRect; override;
    function GetTransform: TSfmlTransform; override;
    procedure SetFillColor(Color: TSfmlColor); override;
    procedure SetOrigin(Origin: TSfmlVector2f); override;
    procedure SetOutlineColor(Color: TSfmlColor); override;
    procedure SetOutlineThickness(Thickness: Single); override;
    procedure SetPosition(Position: TSfmlVector2f); override;
    procedure SetRotation(Angle: Single); override;
    procedure SetScale(Scale: TSfmlVector2f); override;
    procedure SetTextureRect(Rect: TSfmlIntRect); override;
  public
    constructor Create; overload;
    destructor Destroy; override;

    function Copy: TSfmlCircleShape;

    procedure Move(Offset: TSfmlVector2f); override;
    procedure Rotate(Angle: Single); override;
    procedure Scale(Factors: TSfmlVector2f); override;

    procedure SetTexture(const Texture: PSfmlTexture; ResetRect: Boolean);

    property Handle: PSfmlCircleShape read FHandle;
    property PointCount: NativeUInt read GetPointCount write SetPointCount;
    property Radius: Single read GetRadius write SetRadius;
  end;

  TSfmlConvexShape = class(TSfmlShape)
  private
    FHandle: PSfmlConvexShape;

    constructor Create(Handle: PSfmlConvexShape); overload;
    procedure SetPoint(Index: NativeUInt; Point: TSfmlVector2f);
    procedure SetPointCount(Count: NativeUInt);
  protected
    function GetFillColor: TSfmlColor; override;
    function GetGlobalBounds: TSfmlFloatRect; override;
    function GetInverseTransform: TSfmlTransform; override;
    function GetLocalBounds: TSfmlFloatRect; override;
    function GetOrigin: TSfmlVector2f; override;
    function GetOutlineColor: TSfmlColor; override;
    function GetOutlineThickness: Single; override;
    function GetPoint(Index: NativeUInt): TSfmlVector2f; override;
    function GetPointCount: NativeUInt; override;
    function GetPosition: TSfmlVector2f; override;
    function GetRotation: Single; override;
    function GetScale: TSfmlVector2f; override;
    function GetTexture: PSfmlTexture; override;
    function GetTextureRect: TSfmlIntRect; override;
    function GetTransform: TSfmlTransform; override;
    procedure SetFillColor(Color: TSfmlColor); override;
    procedure SetOrigin(Origin: TSfmlVector2f); override;
    procedure SetOutlineColor(Color: TSfmlColor); override;
    procedure SetOutlineThickness(Thickness: Single); override;
    procedure SetPosition(Position: TSfmlVector2f); override;
    procedure SetRotation(Angle: Single); override;
    procedure SetScale(Scale: TSfmlVector2f); override;
    procedure SetTextureRect(Rect: TSfmlIntRect); override;
  public
    constructor Create; overload;
    destructor Destroy; override;

    function Copy: TSfmlConvexShape;

    procedure Move(Offset: TSfmlVector2f); override;
    procedure Rotate(Angle: Single); override;
    procedure Scale(Factors: TSfmlVector2f); override;

    procedure SetTexture(const Texture: PSfmlTexture; ResetRect: Boolean);

    property Handle: PSfmlConvexShape read FHandle;
    property PointCount: NativeUInt read GetPointCount write SetPointCount;
    property Point[Index: NativeUInt]: TSfmlVector2f read GetPoint write SetPoint;
  end;

  TSfmlRectangleShape = class(TSfmlShape)
  private
    FHandle: PSfmlRectangleShape;

    constructor Create(Handle: PSfmlRectangleShape); overload;
    function GetSize: TSfmlVector2f;
    procedure SetSize(Size: TSfmlVector2f);
  protected
    function GetFillColor: TSfmlColor; override;
    function GetGlobalBounds: TSfmlFloatRect; override;
    function GetInverseTransform: TSfmlTransform; override;
    function GetLocalBounds: TSfmlFloatRect; override;
    function GetOrigin: TSfmlVector2f; override;
    function GetOutlineColor: TSfmlColor; override;
    function GetOutlineThickness: Single; override;
    function GetPoint(Index: NativeUInt): TSfmlVector2f; override;
    function GetPointCount: NativeUInt; override;
    function GetPosition: TSfmlVector2f; override;
    function GetRotation: Single; override;
    function GetScale: TSfmlVector2f; override;
    function GetTexture: PSfmlTexture; override;
    function GetTextureRect: TSfmlIntRect; override;
    function GetTransform: TSfmlTransform; override;
    procedure SetFillColor(Color: TSfmlColor); override;
    procedure SetOrigin(Origin: TSfmlVector2f); override;
    procedure SetOutlineColor(Color: TSfmlColor); override;
    procedure SetOutlineThickness(Thickness: Single); override;
    procedure SetPosition(Position: TSfmlVector2f); override;
    procedure SetRotation(Angle: Single); override;
    procedure SetScale(Scale: TSfmlVector2f); override;
    procedure SetTextureRect(Rect: TSfmlIntRect); override;
  public
    constructor Create; overload;
    destructor Destroy; override;

    function Copy: TSfmlRectangleShape;
    procedure Move(Offset: TSfmlVector2f); override;
    procedure Rotate(Angle: Single); override;
    procedure Scale(Factors: TSfmlVector2f); override;

    procedure SetTexture(const Texture: PSfmlTexture; ResetRect: Boolean);

    property Handle: PSfmlRectangleShape read FHandle;
    property PointCount: NativeUInt read GetPointCount;
    property Size: TSfmlVector2f read GetSize write SetSize;
  end;

  TSfmlImage = class
  private
    FHandle: PSfmlImage;

    constructor Create(Handle: PSfmlImage); overload;
    procedure SetPixel(X, Y: Cardinal; Color: TSfmlColor);
    function GetPixel(X, Y: Cardinal): TSfmlColor;
    function GetSize: TSfmlVector2u;
  public
    constructor Create(Width, Height: Cardinal); overload;
    constructor Create(Width, Height: Cardinal; Color: TSfmlColor); overload;
    constructor Create(Width, Height: Cardinal; const Pixels: PByte); overload;
    constructor Create(const FileName: AnsiString); overload;
    constructor Create(const Data: Pointer; Size: NativeUInt); overload;
    constructor Create(const Stream: PSfmlInputStream); overload;
    destructor Destroy; override;

    function Copy: TSfmlImage;
    function GetPixelsPtr: PByte;
    function SaveToFile(const FileName: AnsiString): Boolean;
    procedure CopyImage(const Source: PSfmlImage; DestX, DestY: Cardinal; SourceRect: TSfmlIntRect; ApplyAlpha: Boolean); overload;
    procedure CopyImage(const Source: TSfmlImage; DestX, DestY: Cardinal; SourceRect: TSfmlIntRect; ApplyAlpha: Boolean); overload;
    procedure CreateMaskFromColor(Color: TSfmlColor; Alpha: Byte);
    procedure FlipHorizontally;
    procedure FlipVertically;

    property Handle: PSfmlImage read FHandle;
    property Pixel[X, Y: Cardinal]: TSfmlColor read GetPixel write SetPixel;
    property Size: TSfmlVector2u read GetSize;
  end;

  TSfmlTexture = class
  private
    FHandle: PSfmlTexture;

    constructor Create(Handle: PSfmlTexture); overload;
    function GetNativeHandle: Cardinal;
    function GetRepeated: Boolean;
    function GetSmooth: Boolean;
    function GetSize: TSfmlVector2u;
    function IsSrgb: Boolean;
    procedure SetRepeated(Repeated: Boolean);
    procedure SetSmooth(Smooth: Boolean);
    procedure SetSrgb(Smooth: Boolean);
  public
    constructor Create(Width, Height: Cardinal); overload;
    constructor Create(const FileName: AnsiString; const Area: PSfmlIntRect = nil); overload;
    constructor Create(const Data: Pointer; SizeInBytes: NativeUInt; const Area: PSfmlIntRect = nil); overload;
    constructor Create(Stream: PSfmlInputStream; const Area: PSfmlIntRect = nil); overload;
    constructor Create(const Image: PSfmlImage; const Area: PSfmlIntRect = nil); overload;
    destructor Destroy; override;

    function Copy: TSfmlTexture;
    function CopyToImage: TSfmlImage; overload;
    procedure Bind;

    procedure UpdateFromImage(const Image: TSfmlImage; X, Y: Cardinal); overload;
    procedure UpdateFromImage(const Image: PSfmlImage; X, Y: Cardinal); overload;
    procedure UpdateFromPixels(const Pixels: PByte; Width, Height, X, Y: Cardinal);
    procedure UpdateFromRenderWindow(const RenderWindow: PSfmlRenderWindow; X, Y: Cardinal);
    procedure UpdateFromWindow(const Window: PSfmlWindow; X, Y: Cardinal);

    procedure GenerateMipmap;

    property Handle: PSfmlTexture read FHandle;
    property Repeated: Boolean read GetRepeated write SetRepeated;
    property Smooth: Boolean read GetSmooth write SetSmooth;
    property Srgb: Boolean read IsSrgb write SetSrgb;
    property Size: TSfmlVector2u read GetSize;
    property NativeHandle: Cardinal read GetNativeHandle;
  end;

  TSfmlSprite = class(TSfmlTransformable)
  private
    FHandle: PSfmlSprite;

    constructor Create(Handle: PSfmlSprite); overload;
    function GetColor: TSfmlColor;
    function GetGlobalBounds: TSfmlFloatRect;
    function GetLocalBounds: TSfmlFloatRect;
    function GetTexture: PSfmlTexture;
    function GetTextureRect: TSfmlIntRect;
    procedure SetColor(Color: TSfmlColor);
  protected
    function GetInverseTransform: TSfmlTransform; override;
    function GetOrigin: TSfmlVector2f; override;
    function GetPosition: TSfmlVector2f; override;
    function GetRotation: Single; override;
    function GetScale: TSfmlVector2f; override;
    function GetTransform: TSfmlTransform; override;
    procedure SetOrigin(Origin: TSfmlVector2f); override;
    procedure SetPosition(Position: TSfmlVector2f); override;
    procedure SetRotation(Angle: Single); override;
    procedure SetScale(Scale: TSfmlVector2f); override;
  public
    constructor Create; overload;
    constructor Create(Texture: TSfmlTexture); overload;
    constructor Create(Texture: TSfmlTexture; TextureRect: TSfmlIntRect); overload;
    destructor Destroy; override;

    function Copy: TSfmlSprite;

    procedure Move(Offset: TSfmlVector2f); override;
    procedure Rotate(Angle: Single); override;
    procedure Scale(Factors: TSfmlVector2f); override;

    procedure SetTexture(const Texture: TSfmlTexture; ResetRect: Boolean = False); overload;
    procedure SetTexture(const Texture: PSfmlTexture; ResetRect: Boolean = False); overload;
    procedure SetTextureRect(Rectangle: TSfmlIntRect);

    property Color: TSfmlColor read GetColor write SetColor;
    property GlobalBounds: TSfmlFloatRect read GetGlobalBounds;
    property Handle: PSfmlSprite read FHandle;
    property InverseTransform: TSfmlTransform read GetInverseTransform;
    property LocalBounds: TSfmlFloatRect read GetLocalBounds;
    property Origin: TSfmlVector2f read GetOrigin write SetOrigin;
    property Position: TSfmlVector2f read GetPosition write SetPosition;
    property Rotation: Single read GetRotation write SetRotation;
    property ScaleFactor: TSfmlVector2f read GetScale write SetScale;
    property Texture: PSfmlTexture read GetTexture;
    property TextureRect: TSfmlIntRect read GetTextureRect write SetTextureRect;
    property Transform: TSfmlTransform read GetTransform;
  end;

  TSfmlFont = class
  private
    FHandle: PSfmlFont;

    constructor Create(Handle: PSfmlFont); overload;
    function GetLineSpacing(CharacterSize: Cardinal): Single;
    function GetUnderlinePosition(CharacterSize: Cardinal): Single;
    function GetUnderlineThickness(CharacterSize: Cardinal): Single;
    function GetTexture(CharacterSize: Cardinal): PSfmlTexture;
  public
    constructor Create(const FileName: AnsiString); overload;
    constructor Create(const Data: Pointer; SizeInBytes: NativeUInt); overload;
    constructor Create(const Stream: PSfmlInputStream); overload;
    destructor Destroy; override;

    function Copy: TSfmlFont;
    function GetGlyph(CodePoint: Cardinal; CharacterSize: Cardinal; Bold: Boolean): TSfmlGlyph;
    function GetKerning(First, Second: Cardinal; CharacterSize: Cardinal): Single;
    function GetInfo: TSfmlFontInfo;

    property Handle: PSfmlFont read FHandle;
    property LineSpacing[CharacterSize: Cardinal]: Single read GetLineSpacing;
    property UnderlinePosition[CharacterSize: Cardinal]: Single read GetUnderlinePosition;
    property UnderlineThickness[CharacterSize: Cardinal]: Single read GetUnderlineThickness;
    property Texture[CharacterSize: Cardinal]: PSfmlTexture read GetTexture;
  end;

  TSfmlText = class(TSfmlTransformable)
  private
    FHandle: PSfmlText;

    constructor Create(Handle: PSfmlText); overload;
    function GetCharacterSize: Cardinal;
    function GetColor: TSfmlColor; deprecated;
    function GetFillColor: TSfmlColor;
    function GetOutlineColor: TSfmlColor;
    function GetOutlineThickness: Single;
    function GetFont: PSfmlFont;
    function GetGlobalBounds: TSfmlFloatRect;
    function GetLocalBounds: TSfmlFloatRect;
    function GetString: AnsiString;
    function GetStyle: Cardinal;
    function GetUnicodeString: UnicodeString;
    procedure SetCharacterSize(Size: Cardinal);
    procedure SetColor(Color: TSfmlColor); deprecated;
    procedure SetFillColor(Color: TSfmlColor);
    procedure SetOutlineColor(Color: TSfmlColor);
    procedure SetOutlineThickness(Thickness: Single);
    procedure SetFont(const Font: PSfmlFont);
    procedure SetString(const &String: AnsiString);
    procedure SetStyle(Style: Cardinal);
    procedure SetUnicodeString(const &String: UnicodeString);
  protected
    function GetInverseTransform: TSfmlTransform; override;
    function GetOrigin: TSfmlVector2f; override;
    function GetPosition: TSfmlVector2f; override;
    function GetRotation: Single; override;
    function GetScale: TSfmlVector2f; override;
    function GetTransform: TSfmlTransform; override;
    procedure SetOrigin(Origin: TSfmlVector2f); override;
    procedure SetPosition(Position: TSfmlVector2f); override;
    procedure SetRotation(Angle: Single); override;
    procedure SetScale(Scale: TSfmlVector2f); override;
  public
    constructor Create; overload;
    constructor Create(Text: UnicodeString); overload;
    constructor Create(Text: UnicodeString; Font: TSfmlFont); overload;
    constructor Create(Text: UnicodeString; Font: PSfmlFont); overload;
    constructor Create(Text: UnicodeString; Font: TSfmlFont; CharacterSize: Cardinal); overload;
    constructor Create(Text: UnicodeString; Font: PSfmlFont; CharacterSize: Cardinal); overload;
    destructor Destroy; override;

    function Copy: TSfmlText;
    function FindCharacterPos(Index: NativeUInt): TSfmlVector2f;

    procedure Move(Offset: TSfmlVector2f); override;
    procedure Rotate(Angle: Single); override;
    procedure Scale(Factors: TSfmlVector2f); override;

    property CharacterSize: Cardinal read GetCharacterSize write SetCharacterSize;
    property Color: TSfmlColor read GetColor write SetColor;
    property FillColor: TSfmlColor read GetFillColor write SetFillColor;
    property Font: PSfmlFont read GetFont write SetFont;
    property GlobalBounds: TSfmlFloatRect read GetGlobalBounds;
    property Handle: PSfmlText read FHandle;
    property InverseTransform: TSfmlTransform read GetInverseTransform;
    property LocalBounds: TSfmlFloatRect read GetLocalBounds;
    property Origin: TSfmlVector2f read GetOrigin write SetOrigin;
    property OutlineColor: TSfmlColor read GetOutlineColor write SetOutlineColor;
    property OutlineThickness: Single read GetOutlineThickness write SetOutlineThickness;
    property Position: TSfmlVector2f read GetPosition write SetPosition;
    property Rotation: Single read GetRotation write SetRotation;
    property ScaleFactor: TSfmlVector2f read GetScale write SetScale;
    property &String: AnsiString read GetString write SetString;
    property Style: Cardinal read GetStyle write SetStyle;
    property Transform: TSfmlTransform read GetTransform;
    property UnicodeString: UnicodeString read GetUnicodeString write SetUnicodeString;
  end;

  TSfmlVertexArray = class(TSfmlDrawable)
  private
    FHandle: PSfmlVertexArray;

    constructor Create(Handle: PSfmlVertexArray); overload;
    function GetBounds: TSfmlFloatRect;
    function GetPrimitiveType: TSfmlPrimitiveType;
    function GetVertex(Index: NativeUInt): PSfmlVertex;
    function GetVertexCount: NativeUInt;
    procedure SetPrimitiveType(&Type: TSfmlPrimitiveType);
  public
    constructor Create; overload;
    destructor Destroy; override;

    function Copy: TSfmlVertexArray;
    procedure Append(Vertex: TSfmlVertex);
    procedure Clear;
    procedure Resize(VertexCount: NativeUInt);

    property Bounds: TSfmlFloatRect read GetBounds;
    property Handle: PSfmlVertexArray read FHandle;
    property PrimitiveType: TSfmlPrimitiveType read GetPrimitiveType write SetPrimitiveType;
    property Vertex[Index: NativeUInt]: PSfmlVertex read GetVertex;
    property VertexCount: NativeUInt read GetVertexCount;
  end;

  TSfmlView = class
  private
    FHandle: PSfmlView;

    constructor Create(Handle: PSfmlView); overload;
    function GetCenter: TSfmlVector2f;
    function GetRotation: Single;
    function GetSize: TSfmlVector2f;
    function GetViewport: TSfmlFloatRect;
    procedure SetCenter(Center: TSfmlVector2f);
    procedure SetRotation(Angle: Single);
    procedure SetSize(Size: TSfmlVector2f);
    procedure SetViewport(Viewport: TSfmlFloatRect);
  public
    constructor Create; overload;
    constructor Create(Rectangle: TSfmlFloatRect); overload;
    destructor Destroy; override;

    function Copy: TSfmlView;
    procedure Move(Offset: TSfmlVector2f);
    procedure Reset(Rectangle: TSfmlFloatRect);
    procedure Rotate(Angle: Single);
    procedure Zoom(Factor: Single);

    property Center: TSfmlVector2f read GetCenter write SetCenter;
    property Handle: PSfmlView read FHandle;
    property Rotation: Single read GetRotation write SetRotation;
    property Size: TSfmlVector2f read GetSize write SetSize;
    property Viewport: TSfmlFloatRect read GetViewport write SetViewport;
  end;

  ISfmlRenderTarget = interface
    function GetDefaultView: TSfmlView;
    function GetView: TSfmlView;
    function GetSize: TSfmlVector2u;
    function GetViewport(const View: PSfmlView): TSfmlIntRect;
    procedure SetView(const View: TSfmlView);

    procedure Clear(Color: TSfmlColor);

    procedure Draw(const &Object: TSfmlCircleShape; const States: PSfmlRenderStates = nil); overload;
    procedure Draw(const &Object: TSfmlConvexShape; const States: PSfmlRenderStates = nil); overload;
    procedure Draw(const &Object: TSfmlRectangleShape; const States: PSfmlRenderStates = nil); overload;
    procedure Draw(const &Object: TSfmlShape; const States: PSfmlRenderStates = nil); overload;
    procedure Draw(const &Object: TSfmlSprite; const States: PSfmlRenderStates = nil); overload;
    procedure Draw(const &Object: TSfmlText; const States: PSfmlRenderStates = nil); overload;
    procedure Draw(const &Object: TSfmlVertexArray; const States: PSfmlRenderStates = nil); overload;

    procedure Display;

    function MapCoordsToPixel(Point: TSfmlVector2i; const View: PSfmlView = nil): TSfmlVector2i;
    function MapPixelToCoords(Point: TSfmlVector2i; const View: PSfmlView = nil): TSfmlVector2f;

    procedure PopGLStates;
    procedure PushGLStates;
    procedure ResetGLStates;

    property Size: TSfmlVector2u read GetSize;
  end;

  TSfmlRenderTarget = class(TInterfacedObject, ISfmlRenderTarget)
  protected
    function GetDefaultView: TSfmlView; virtual; abstract;
    function GetView: TSfmlView; virtual; abstract;
    function GetSize: TSfmlVector2u; virtual; abstract;
    function GetViewport(const View: PSfmlView): TSfmlIntRect; virtual; abstract;
    procedure SetView(const View: TSfmlView); virtual; abstract;
  public
    procedure Clear(Color: TSfmlColor); overload; virtual; abstract;
    procedure Clear; overload;

    procedure Draw(const &Object: TSfmlCircleShape; const States: PSfmlRenderStates = nil); overload; virtual; abstract;
    procedure Draw(const &Object: TSfmlConvexShape; const States: PSfmlRenderStates = nil); overload; virtual; abstract;
    procedure Draw(const &Object: TSfmlRectangleShape; const States: PSfmlRenderStates = nil); overload; virtual; abstract;
    procedure Draw(const &Object: TSfmlShape; const States: PSfmlRenderStates = nil); overload; virtual; abstract;
    procedure Draw(const &Object: TSfmlSprite; const States: PSfmlRenderStates = nil); overload; virtual; abstract;
    procedure Draw(const &Object: TSfmlText; const States: PSfmlRenderStates = nil); overload; virtual; abstract;
    procedure Draw(const &Object: TSfmlVertexArray; const States: PSfmlRenderStates = nil); overload; virtual; abstract;

    procedure Display; virtual; abstract;

    function MapCoordsToPixel(Point: TSfmlVector2i; const View: PSfmlView = nil): TSfmlVector2i; virtual; abstract;
    function MapPixelToCoords(Point: TSfmlVector2i; const View: PSfmlView = nil): TSfmlVector2f; virtual; abstract;

    procedure PopGLStates; virtual; abstract;
    procedure PushGLStates; virtual; abstract;
    procedure ResetGLStates; virtual; abstract;
  public
    property DefaultView: TSfmlView read GetDefaultView;
    property Size: TSfmlVector2u read GetSize;
    property View: TSfmlView read GetView write SetView;
  end;

  TSfmlRenderTexture = class(TSfmlRenderTarget)
  private
    FHandle: PSfmlRenderTexture;
    FTexture: TSfmlTexture;
    FView, FDefaultView: TSfmlView;
    function GetRepeated: Boolean;
    function GetSmooth: Boolean;
    function GetTexture: TSfmlTexture;
    procedure SetRepeated(Repeated: Boolean);
    procedure SetSmooth(Smooth: Boolean);
  protected
    function GetSize: TSfmlVector2u; override;
    function GetDefaultView: TSfmlView; override;
    function GetView: TSfmlView; override;
    procedure SetView(const View: TSfmlView); override;
  public
    constructor Create(Width, Height: Cardinal; DepthBuffer: Boolean = False);
    destructor Destroy; override;

    function GetViewport(const View: PSfmlView): TSfmlIntRect; override;
    function MapCoordsToPixel(Point: TSfmlVector2i; const View: PSfmlView = nil): TSfmlVector2i; override;
    function MapPixelToCoords(Point: TSfmlVector2i; const View: PSfmlView = nil): TSfmlVector2f; override;
    function SetActive(Active: Boolean): Boolean;

    procedure Clear(Color: TSfmlColor); override;
    procedure Display; override;

    procedure Draw(const &Object: TSfmlCircleShape; const States: PSfmlRenderStates = nil); overload; override;
    procedure Draw(const &Object: TSfmlConvexShape; const States: PSfmlRenderStates = nil); overload; override;
    procedure Draw(const &Object: TSfmlRectangleShape; const States: PSfmlRenderStates = nil);overload; override;
    procedure Draw(const &Object: TSfmlShape; const States: PSfmlRenderStates = nil); overload; override;
    procedure Draw(const &Object: TSfmlSprite; const States: PSfmlRenderStates = nil); overload; override;
    procedure Draw(const &Object: TSfmlText; const States: PSfmlRenderStates = nil); overload; override;
    procedure Draw(const &Object: TSfmlVertexArray; const States: PSfmlRenderStates = nil); overload; override;

    procedure DrawCircleShape(const &Object: PSfmlCircleShape; const States: PSfmlRenderStates = nil);
    procedure DrawConvexShape(const &Object: PSfmlConvexShape; const States: PSfmlRenderStates = nil);
    procedure DrawPrimitives(const Vertices: PSfmlVertex; VertexCount: NativeUInt; &Type: TSfmlPrimitiveType; const States: PSfmlRenderStates = nil);
    procedure DrawRectangleShape(const &Object: PSfmlRectangleShape; const States: PSfmlRenderStates = nil);
    procedure DrawShape(const &Object: PSfmlShape; const States: PSfmlRenderStates = nil);
    procedure DrawSprite(const &Object: PSfmlSprite; const States: PSfmlRenderStates = nil);
    procedure DrawText(const &Object: PSfmlText; const States: PSfmlRenderStates = nil);
    procedure DrawVertexArray(const &Object: PSfmlVertexArray; const States: PSfmlRenderStates = nil);

    procedure PopGLStates; override;
    procedure PushGLStates; override;
    procedure ResetGLStates; override;

    procedure GenerateMipmap;

    property Handle: PSfmlRenderTexture read FHandle;
    property Repeated: Boolean read GetRepeated write SetRepeated;
    property Smooth: Boolean read GetSmooth write SetSmooth;
    property Texture: TSfmlTexture read GetTexture;
  end;

  TSfmlRenderWindow = class(TSfmlRenderTarget, ISfmlWindow)
  private
    FHandle: PSfmlRenderWindow;
    FView, FDefaultView: TSfmlView;
    function GetMousePosition: TSfmlVector2i;
    function GetPosition: TSfmlVector2i;
    procedure SetMousePosition(Position: TSfmlVector2i);
    procedure SetPosition(Position: TSfmlVector2i);
  protected
    function GetSize: TSfmlVector2u; override;
    function GetDefaultView: TSfmlView; override;
    function GetView: TSfmlView; override;
    procedure SetView(const View: TSfmlView); override;
  public
    constructor Create(Mode: TSfmlVideoMode; const Title: AnsiString; Style: TSfmlWindowStyles = [sfTitleBar, sfClose]); overload;
    constructor Create(Mode: TSfmlVideoMode; const Title: UnicodeString; Style: TSfmlWindowStyles = [sfTitleBar, sfClose]); overload;
    constructor Create(Mode: TSfmlVideoMode; const Title: AnsiString; Style: TSfmlWindowStyles; const Settings: PSfmlContextSettings); overload;
    constructor Create(Mode: TSfmlVideoMode; const Title: UnicodeString; Style: TSfmlWindowStyles; const Settings: PSfmlContextSettings); overload;
    constructor Create(Handle: TSfmlWindowHandle; const Settings: PSfmlContextSettings = nil); overload;
    destructor Destroy; override;

    function GetSettings: TSfmlContextSettings;
    function GetSystemHandle: TSfmlWindowHandle;
    function GetViewport(const View: PSfmlView): TSfmlIntRect; override;

    function MapCoordsToPixel(Point: TSfmlVector2i; const View: PSfmlView = nil): TSfmlVector2i; override;
    function MapPixelToCoords(Point: TSfmlVector2i; const View: PSfmlView = nil): TSfmlVector2f; override;
    function PollEvent(out Event: TSfmlEvent): Boolean;
    function SetActive(Active: Boolean): Boolean;
    function WaitEvent(out Event: TSfmlEvent): Boolean;

    procedure Clear(Color: TSfmlColor); override;
    procedure Display; override;

    function Capture: PSfmlImage;
    procedure Close;
    procedure RequestFocus;
    function IsOpen: Boolean;
    function HasFocus: Boolean;

    procedure Draw(const &Object: TSfmlCircleShape; const States: PSfmlRenderStates = nil); overload; override;
    procedure Draw(const &Object: TSfmlConvexShape; const States: PSfmlRenderStates = nil); overload; override;
    procedure Draw(const &Object: TSfmlRectangleShape; const States: PSfmlRenderStates = nil);overload; override;
    procedure Draw(const &Object: TSfmlShape; const States: PSfmlRenderStates = nil); overload; override;
    procedure Draw(const &Object: TSfmlSprite; const States: PSfmlRenderStates = nil); overload; override;
    procedure Draw(const &Object: TSfmlText; const States: PSfmlRenderStates = nil); overload; override;
    procedure Draw(const &Object: TSfmlVertexArray; const States: PSfmlRenderStates = nil); overload; override;

    procedure DrawCircleShape(const &Object: PSfmlCircleShape; const States: PSfmlRenderStates = nil);
    procedure DrawConvexShape(const &Object: PSfmlConvexShape; const States: PSfmlRenderStates = nil);
    procedure DrawPrimitives(const Vertices: PSfmlVertex; VertexCount: NativeUInt; &Type: TSfmlPrimitiveType; const States: PSfmlRenderStates = nil);
    procedure DrawRectangleShape(const &Object: PSfmlRectangleShape; const States: PSfmlRenderStates = nil);overload;
    procedure DrawShape(const &Object: PSfmlShape; const States: PSfmlRenderStates = nil);
    procedure DrawSprite(const &Object: PSfmlSprite; const States: PSfmlRenderStates = nil);
    procedure DrawText(const &Object: PSfmlText; const States: PSfmlRenderStates = nil);
    procedure DrawVertexArray(const &Object: PSfmlVertexArray; const States: PSfmlRenderStates = nil);

    procedure PopGLStates; override;
    procedure PushGLStates; override;
    procedure ResetGLStates; override;

    procedure SetFramerateLimit(Limit: Cardinal);
    procedure SetIcon(Width, Height: Cardinal; const Pixels: PByte);
    procedure SetJoystickThreshold(Threshold: Single);
    procedure SetKeyRepeatEnabled(Enabled: Boolean);
    procedure SetMouseCursorVisible(Show: Boolean);
    procedure SetMouseCursorGrabbed(Grabbed: Boolean);
    procedure SetSize(Size: TSfmlVector2u);
    procedure SetTitle(const Title: AnsiString); overload;
    procedure SetTitle(const Title: UnicodeString); overload;
    procedure SetVerticalSyncEnabled(Enabled: Boolean);
    procedure SetVisible(Visible: Boolean);

    property Handle: PSfmlRenderWindow read FHandle;
    property MousePosition: TSfmlVector2i read GetMousePosition write SetMousePosition;
    property Position: TSfmlVector2i read GetPosition write SetPosition;
  end;

  TSfmlShader = class
  private
    FHandle: PSfmlShader;
    function GetNativeHandle: Cardinal;
  public
    constructor Create(const VertexShader, GeometryShader, FragmentShader: AnsiString); overload;
    constructor Create(VertexShaderStream, GeometryShaderStream, FragmentShaderStream: PSfmlInputStream); overload;
    constructor CreateFromFile(const VertexShaderFilename, GeometryShaderFilename, FragmentShaderFilename: AnsiString);
    destructor Destroy; override;

    procedure SetFloatUniform(const Name: AnsiString; X: Single);
    procedure SetVec2Uniform(const Name: AnsiString; Vector: TSfmlGlslVec2);
    procedure SetVec3Uniform(const Name: AnsiString; Vector: TSfmlGlslVec3);
    procedure SetVec4Uniform(const Name: AnsiString; Vector: TSfmlGlslVec4);
    procedure SetColorUniform(const Name: AnsiString; Color: TSfmlColor);
    procedure SetIntUniform(const Name: AnsiString; X: Integer);
    procedure SetIvec2Uniform(const Name: AnsiString; Vector: TSfmlGlslIvec2);
    procedure SetIvec3Uniform(const Name: AnsiString; Vector: TSfmlGlslIvec3);
    procedure SetIvec4Uniform(const Name: AnsiString; Vector: TSfmlGlslIvec4);
    procedure SetIntColorUniform(const Name: AnsiString; Color: TSfmlColor);
    procedure SetBoolUniform(const Name: AnsiString; X: LongBool);
    procedure SetBvec2Uniform(const Name: AnsiString; Vector: TSfmlGlslBvec2);
    procedure SetBvec3Uniform(const Name: AnsiString; Vector: TSfmlGlslBvec3);
    procedure SetBvec4Uniform(const Name: AnsiString; Vector: TSfmlGlslBvec4);
    procedure SetMat3Uniform(const Name: AnsiString; const Matrix: TSfmlGlslMat3);
    procedure SetMat4Uniform(const Name: AnsiString; const Matrix: TSfmlGlslMat4);
    procedure SetTextureUniform(const Name: AnsiString; const Texture: PSfmlTexture);
    procedure SetCurrentTextureUniform(const Name: AnsiString);
    procedure SetFloatUniformArray(const Name: AnsiString; const ScalarArray: array of Single);
    procedure SetVec2UniformArray(const Name: AnsiString; const VectorArray: array of TSfmlGlslVec2);
    procedure SetVec3UniformArray(const Name: AnsiString; const VectorArray: array of TSfmlGlslVec3);
    procedure SetVec4UniformArray(const Name: AnsiString; const VectorArray: array of TSfmlGlslVec4);
    procedure SetMat3UniformArray(const Name: AnsiString; const MatrixArray: array of TSfmlGlslMat3);
    procedure SetMat4UniformArray(const Name: AnsiString; const MatrixArray: array of TSfmlGlslMat4);

    procedure SetParameter(const Name: AnsiString; X: Single); overload;
    procedure SetParameter(const Name: AnsiString; X, Y: Single); overload;
    procedure SetParameter(const Name: AnsiString; X, Y, Z: Single); overload;
    procedure SetParameter(const Name: AnsiString; X, Y, Z, W: Single); overload;
    procedure SetParameter(const Name: AnsiString; Vector: TSfmlVector2f); overload;
    procedure SetParameter(const Name: AnsiString; Vector: TSfmlVector3f); overload;
    procedure SetParameter(const Name: AnsiString; Color: TSfmlColor); overload;
    procedure SetTransformParameter(const Name: AnsiString; Transform: TSfmlTransform);
    procedure SetTextureParameter(const Name: AnsiString; const Texture: PSfmlTexture);
    procedure SetCurrentTextureParameter(const Name: AnsiString);
    procedure Bind;

    property Handle: PSfmlShader read FHandle;
    property NativeHandle: Cardinal read GetNativeHandle;
  end;

{$IFDEF INT64RETURNWORKAROUND}
  function SfmlCircleShapeGetPoint(const Shape: PSfmlCircleShape; Index: NativeUInt): TSfmlVector2f; cdecl;
  function SfmlCircleShapeGetPosition(const Shape: PSfmlCircleShape): TSfmlVector2f; cdecl;
  function SfmlCircleShapeGetOrigin(const Shape: PSfmlCircleShape): TSfmlVector2f; cdecl;
  function SfmlCircleShapeGetScale(const Shape: PSfmlCircleShape): TSfmlVector2f; cdecl;
  function SfmlConvexShapeGetOrigin(const Shape: PSfmlConvexShape): TSfmlVector2f; cdecl;
  function SfmlConvexShapeGetPoint(const Shape: PSfmlConvexShape; Index: NativeUInt): TSfmlVector2f; cdecl;
  function SfmlConvexShapeGetPosition(const Shape: PSfmlConvexShape): TSfmlVector2f; cdecl;
  function SfmlConvexShapeGetScale(const Shape: PSfmlConvexShape): TSfmlVector2f; cdecl;
  function SfmlImageGetSize(const Image: PSfmlImage): TSfmlVector2u; cdecl;
  function SfmlRectangleShapeGetOrigin(const Shape: PSfmlRectangleShape): TSfmlVector2f; cdecl;
  function SfmlRectangleShapeGetPoint(const Shape: PSfmlRectangleShape; Index: NativeUInt): TSfmlVector2f; cdecl;
  function SfmlRectangleShapeGetPosition(const Shape: PSfmlRectangleShape): TSfmlVector2f; cdecl;
  function SfmlRectangleShapeGetScale(const Shape: PSfmlRectangleShape): TSfmlVector2f; cdecl;
  function SfmlRectangleShapeGetSize(const Shape: PSfmlRectangleShape): TSfmlVector2f; cdecl;
  function SfmlRenderTextureGetSize(const RenderTexture: PSfmlRenderTexture): TSfmlVector2u; cdecl;
  function SfmlRenderTextureMapPixelToCoords(const RenderTexture: PSfmlRenderTexture; Point: TSfmlVector2i; const View: PSfmlView): TSfmlVector2f; cdecl;
  function SfmlRenderTextureMapCoordsToPixel(const RenderTexture: PSfmlRenderTexture; Point: TSfmlVector2i; const View: PSfmlView): TSfmlVector2i; cdecl;
  function SfmlRenderWindowGetSize(const RenderWindow: PSfmlRenderWindow): TSfmlVector2u; cdecl;
  function SfmlRenderWindowMapPixelToCoords(const RenderWindow: PSfmlRenderWindow; Point: TSfmlVector2i; const View: PSfmlView): TSfmlVector2f; cdecl;
  function SfmlRenderWindowMapCoordsToPixel(const RenderWindow: PSfmlRenderWindow; Point: TSfmlVector2i; const View: PSfmlView): TSfmlVector2i; cdecl;
  function SfmlMouseGetPositionRenderWindow(const RelativeTo: PSfmlRenderWindow): TSfmlVector2i; cdecl;
  function SfmlTouchGetPositionRenderWindow(Finger: Cardinal; const RelativeTo: PSfmlRenderWindow): TSfmlVector2i; cdecl;
  function SfmlShapeGetOrigin(const Shape: PSfmlShape): TSfmlVector2f; cdecl;
  function SfmlShapeGetPoint(const Shape: PSfmlShape; Index: NativeUInt): TSfmlVector2f; cdecl;
  function SfmlShapeGetPosition(const Shape: PSfmlShape): TSfmlVector2f; cdecl;
  function SfmlShapeGetScale(const Shape: PSfmlShape): TSfmlVector2f; cdecl;
  function SfmlSpriteGetOrigin(const Sprite: PSfmlSprite): TSfmlVector2f; cdecl;
  function SfmlSpriteGetPosition(const Sprite: PSfmlSprite): TSfmlVector2f; cdecl;
  function SfmlSpriteGetScale(const Sprite: PSfmlSprite): TSfmlVector2f; cdecl;
  function SfmlTextFindCharacterPos(const Text: PSfmlText; Index: NativeUInt): TSfmlVector2f; cdecl;
  function SfmlTextGetOrigin(const Text: PSfmlText): TSfmlVector2f; cdecl;
  function SfmlTextGetPosition(const Text: PSfmlText): TSfmlVector2f; cdecl;
  function SfmlTextGetScale(const Text: PSfmlText): TSfmlVector2f; cdecl;
  function SfmlTextureGetSize(const Texture: PSfmlTexture): TSfmlVector2u; cdecl;
  function SfmlTransformTransformPoint(const Transform: PSfmlTransform; Point: TSfmlVector2f): TSfmlVector2f; cdecl;
  function SfmlTransformableGetOrigin(const Transformable: PSfmlTransformable): TSfmlVector2f; cdecl;
  function SfmlTransformableGetPosition(const Transformable: PSfmlTransformable): TSfmlVector2f; cdecl;
  function SfmlTransformableGetScale(const Transformable: PSfmlTransformable): TSfmlVector2f; cdecl;
  function SfmlViewGetCenter(const View: PSfmlView): TSfmlVector2f; cdecl;
  function SfmlViewGetSize(const View: PSfmlView): TSfmlVector2f; cdecl;
{$ENDIF}

function SfmlFloatRect(Left, Top, Width, Height: Single): TSfmlFloatRect; overload;
function SfmlFloatRect(TopLeft, Size: TSfmlVector2f): TSfmlFloatRect; overload;
function SfmlIntRect(Left, Top, Width, Height: LongInt): TSfmlIntRect; overload;
function SfmlIntRect(TopLeft, Size: TSfmlVector2i): TSfmlIntRect; overload;

function SfmlVertex(Position: TSfmlVector2f; Color: TSfmlColor;
  TexCoords: TSfmlVector2f): TSfmlVertex; overload;
function SfmlVertex(Position: TSfmlVector2f; Color: TSfmlColor): TSfmlVertex; overload;

implementation

{$IFDEF DynLink}
uses
{$IFDEF FPC}
  DynLibs;
{$ELSE}
{$IFDEF MSWindows}
  Windows;
{$ENDIF}
{$ENDIF}
{$ENDIF}

function SfmlVertex(Position: TSfmlVector2f; Color: TSfmlColor;
  TexCoords: TSfmlVector2f): TSfmlVertex;
begin
  Result.Position := Position;
  Result.Color := Color;
  Result.TexCoords := TexCoords;
end;

function SfmlVertex(Position: TSfmlVector2f; Color: TSfmlColor): TSfmlVertex;
begin
  Result.Position := Position;
  Result.Color := Color;
end;

function SfmlFloatRect(Left, Top, Width, Height: Single): TSfmlFloatRect;
begin
  Result.Left := Left;
  Result.Top := Top;
  Result.Width := Width;
  Result.Height := Height;
end;

function SfmlFloatRect(TopLeft, Size: TSfmlVector2f): TSfmlFloatRect; overload;
begin
  Result.Left := TopLeft.X;
  Result.Top := TopLeft.Y;
  Result.Width := Size.X;
  Result.Height := Size.Y;
end;

function SfmlIntRect(Left, Top, Width, Height: LongInt): TSfmlIntRect;
begin
  Result.Left := Left;
  Result.Top := Top;
  Result.Width := Width;
  Result.Height := Height;
end;

function SfmlIntRect(TopLeft, Size: TSfmlVector2i): TSfmlIntRect; overload;
begin
  Result.Left := TopLeft.X;
  Result.Top := TopLeft.Y;
  Result.Width := Size.X;
  Result.Height := Size.Y;
end;


{ TSfmlCircleShape }

constructor TSfmlCircleShape.Create;
begin
  FHandle := SfmlCircleShapeCreate;
end;

constructor TSfmlCircleShape.Create(Handle: PSfmlCircleShape);
begin
  FHandle := Handle;
end;

destructor TSfmlCircleShape.Destroy;
begin
  SfmlCircleShapeDestroy(FHandle);
  inherited;
end;

function TSfmlCircleShape.Copy: TSfmlCircleShape;
begin
  Result := TSfmlCircleShape.Create(SfmlCircleShapeCopy(FHandle));
end;

function TSfmlCircleShape.GetFillColor: TSfmlColor;
begin
  Result := SfmlCircleShapeGetFillColor(FHandle);
end;

function TSfmlCircleShape.GetGlobalBounds: TSfmlFloatRect;
begin
  Result := SfmlCircleShapeGetGlobalBounds(FHandle);
end;

function TSfmlCircleShape.GetInverseTransform: TSfmlTransform;
begin
  Result := SfmlCircleShapeGetInverseTransform(FHandle);
end;

function TSfmlCircleShape.GetLocalBounds: TSfmlFloatRect;
begin
  Result := SfmlCircleShapeGetLocalBounds(FHandle);
end;

function TSfmlCircleShape.GetOrigin: TSfmlVector2f;
begin
  Result := SfmlCircleShapeGetOrigin(FHandle);
end;

function TSfmlCircleShape.GetOutlineColor: TSfmlColor;
begin
  Result := SfmlCircleShapeGetOutlineColor(FHandle);
end;

function TSfmlCircleShape.GetOutlineThickness: Single;
begin
  Result := SfmlCircleShapeGetOutlineThickness(FHandle);
end;

function TSfmlCircleShape.GetPoint(Index: NativeUInt): TSfmlVector2f;
begin
  Result := SfmlCircleShapeGetPoint(FHandle, Index);
end;

function TSfmlCircleShape.GetPointCount: NativeUInt;
begin
  Result := SfmlCircleShapeGetPointCount(FHandle);
end;

function TSfmlCircleShape.GetPosition: TSfmlVector2f;
begin
  Result := SfmlCircleShapeGetPosition(FHandle);
end;

function TSfmlCircleShape.GetRadius: Single;
begin
  Result := SfmlCircleShapeGetRadius(FHandle);
end;

function TSfmlCircleShape.GetRotation: Single;
begin
  Result := SfmlCircleShapeGetRotation(FHandle);
end;

function TSfmlCircleShape.GetScale: TSfmlVector2f;
begin
  Result := SfmlCircleShapeGetScale(FHandle);
end;

function TSfmlCircleShape.GetTexture: PSfmlTexture;
begin
  Result := SfmlCircleShapeGetTexture(FHandle);
end;

function TSfmlCircleShape.GetTextureRect: TSfmlIntRect;
begin
  Result := SfmlCircleShapeGetTextureRect(FHandle);
end;

function TSfmlCircleShape.GetTransform: TSfmlTransform;
begin
  Result := SfmlCircleShapeGetTransform(FHandle);
end;

procedure TSfmlCircleShape.Move(Offset: TSfmlVector2f);
begin
  SfmlCircleShapeMove(FHandle, Offset);
end;

procedure TSfmlCircleShape.Rotate(Angle: Single);
begin
  SfmlCircleShapeRotate(FHandle, Angle);
end;

procedure TSfmlCircleShape.Scale(Factors: TSfmlVector2f);
begin
  SfmlCircleShapeScale(FHandle, Factors);
end;

procedure TSfmlCircleShape.SetFillColor(Color: TSfmlColor);
begin
  SfmlCircleShapeSetFillColor(FHandle, Color);
end;

procedure TSfmlCircleShape.SetOrigin(Origin: TSfmlVector2f);
begin
  SfmlCircleShapeSetOrigin(FHandle, Origin);
end;

procedure TSfmlCircleShape.SetOutlineColor(Color: TSfmlColor);
begin
  SfmlCircleShapeSetOutlineColor(FHandle, OutlineColor);
end;

procedure TSfmlCircleShape.SetOutlineThickness(Thickness: Single);
begin
  SfmlCircleShapeSetOutlineThickness(FHandle, OutlineThickness);
end;

procedure TSfmlCircleShape.SetPointCount(Count: NativeUInt);
begin
  SfmlCircleShapeSetPointCount(FHandle, Count);
end;

procedure TSfmlCircleShape.SetPosition(Position: TSfmlVector2f);
begin
  SfmlCircleShapeSetPosition(FHandle, Position);
end;

procedure TSfmlCircleShape.SetRadius(Radius: Single);
begin
  SfmlCircleShapeSetRadius(FHandle, Radius);
end;

procedure TSfmlCircleShape.SetRotation(Angle: Single);
begin
  SfmlCircleShapeSetRotation(FHandle, Angle);
end;

procedure TSfmlCircleShape.SetScale(Scale: TSfmlVector2f);
begin
  SfmlCircleShapeSetScale(FHandle, Scale);
end;

procedure TSfmlCircleShape.SetTexture(const Texture: PSfmlTexture;
  ResetRect: Boolean);
begin
  SfmlCircleShapeSetTexture(FHandle, Texture, ResetRect);
end;

procedure TSfmlCircleShape.SetTextureRect(Rect: TSfmlIntRect);
begin
  SfmlCircleShapeSetTextureRect(FHandle, Rect);
end;


{ TSfmlConvexShape }

constructor TSfmlConvexShape.Create;
begin
  FHandle := SfmlConvexShapeCreate;
end;

constructor TSfmlConvexShape.Create(Handle: PSfmlConvexShape);
begin
  FHandle := Handle;
end;

destructor TSfmlConvexShape.Destroy;
begin
  SfmlConvexShapeDestroy(FHandle);
  inherited;
end;

function TSfmlConvexShape.Copy: TSfmlConvexShape;
begin
  Result := TSfmlConvexShape.Create(SfmlConvexShapeCopy(FHandle));
end;

function TSfmlConvexShape.GetFillColor: TSfmlColor;
begin
  Result := SfmlConvexShapeGetFillColor(FHandle);
end;

function TSfmlConvexShape.GetGlobalBounds: TSfmlFloatRect;
begin
  Result := SfmlConvexShapeGetGlobalBounds(FHandle);
end;

function TSfmlConvexShape.GetInverseTransform: TSfmlTransform;
begin
  Result := SfmlConvexShapeGetInverseTransform(FHandle);
end;

function TSfmlConvexShape.GetLocalBounds: TSfmlFloatRect;
begin
  Result := SfmlConvexShapeGetLocalBounds(FHandle);
end;

function TSfmlConvexShape.GetOrigin: TSfmlVector2f;
begin
  Result := SfmlConvexShapeGetOrigin(FHandle);
end;

function TSfmlConvexShape.GetOutlineColor: TSfmlColor;
begin
  Result := SfmlConvexShapeGetOutlineColor(FHandle);
end;

function TSfmlConvexShape.GetOutlineThickness: Single;
begin
  Result := SfmlConvexShapeGetOutlineThickness(FHandle);
end;

function TSfmlConvexShape.GetPoint(Index: NativeUInt): TSfmlVector2f;
begin
  Result := SfmlConvexShapeGetPoint(FHandle, Index);
end;

function TSfmlConvexShape.GetPointCount: NativeUInt;
begin
  Result := SfmlConvexShapeGetPointCount(FHandle);
end;

function TSfmlConvexShape.GetPosition: TSfmlVector2f;
begin
  Result := SfmlConvexShapeGetPosition(FHandle);
end;

function TSfmlConvexShape.GetRotation: Single;
begin
  Result := SfmlConvexShapeGetRotation(FHandle);
end;

function TSfmlConvexShape.GetScale: TSfmlVector2f;
begin
  Result := SfmlConvexShapeGetScale(FHandle);
end;

function TSfmlConvexShape.GetTexture: PSfmlTexture;
begin
  Result := SfmlConvexShapeGetTexture(FHandle);
end;

function TSfmlConvexShape.GetTextureRect: TSfmlIntRect;
begin
  Result := SfmlConvexShapeGetTextureRect(FHandle);
end;

function TSfmlConvexShape.GetTransform: TSfmlTransform;
begin
  Result := SfmlConvexShapeGetTransform(FHandle);
end;

procedure TSfmlConvexShape.Move(Offset: TSfmlVector2f);
begin
  SfmlConvexShapeMove(FHandle, Offset);
end;

procedure TSfmlConvexShape.Rotate(Angle: Single);
begin
  SfmlConvexShapeRotate(FHandle, Angle);
end;

procedure TSfmlConvexShape.Scale(Factors: TSfmlVector2f);
begin
  SfmlConvexShapeScale(FHandle, Factors);
end;

procedure TSfmlConvexShape.SetFillColor(Color: TSfmlColor);
begin
  SfmlConvexShapeSetFillColor(FHandle, Color);
end;

procedure TSfmlConvexShape.SetOrigin(Origin: TSfmlVector2f);
begin
  SfmlConvexShapeSetOrigin(FHandle, Origin);
end;

procedure TSfmlConvexShape.SetOutlineColor(Color: TSfmlColor);
begin
  SfmlConvexShapeSetOutlineColor(FHandle, Color);
end;

procedure TSfmlConvexShape.SetOutlineThickness(Thickness: Single);
begin
  SfmlConvexShapeSetOutlineThickness(FHandle, Thickness);
end;

procedure TSfmlConvexShape.SetPoint(Index: NativeUInt; Point: TSfmlVector2f);
begin
  SfmlConvexShapeSetPoint(FHandle, Index, Point);
end;

procedure TSfmlConvexShape.SetPointCount(Count: NativeUInt);
begin
  SfmlConvexShapeSetPointCount(FHandle, Count);
end;

procedure TSfmlConvexShape.SetPosition(Position: TSfmlVector2f);
begin
  SfmlConvexShapeSetPosition(FHandle, Position);
end;

procedure TSfmlConvexShape.SetRotation(Angle: Single);
begin
  SfmlConvexShapeSetRotation(FHandle, Angle);
end;

procedure TSfmlConvexShape.SetScale(Scale: TSfmlVector2f);
begin
  SfmlConvexShapeSetScale(FHandle, Scale);
end;

procedure TSfmlConvexShape.SetTexture(const Texture: PSfmlTexture;
  ResetRect: Boolean);
begin
  SfmlConvexShapeSetTexture(FHandle, Texture, ResetRect);
end;

procedure TSfmlConvexShape.SetTextureRect(Rect: TSfmlIntRect);
begin
  SfmlConvexShapeSetTextureRect(FHandle, Rect);
end;


{ TSfmlFont }

constructor TSfmlFont.Create(const FileName: AnsiString);
begin
  FHandle := SfmlFontCreateFromFile(PAnsiChar(FileName));
end;

constructor TSfmlFont.Create(const Stream: PSfmlInputStream);
begin
  FHandle := SfmlFontCreateFromStream(Stream);
end;

constructor TSfmlFont.Create(Handle: PSfmlFont);
begin
  FHandle := Handle;
end;

constructor TSfmlFont.Create(const Data: Pointer; SizeInBytes: NativeUInt);
begin
  FHandle := SfmlFontCreateFromMemory(Data, SizeInBytes);
end;

destructor TSfmlFont.Destroy;
begin
  SfmlFontDestroy(FHandle);
  inherited;
end;

function TSfmlFont.Copy: TSfmlFont;
begin
  Result := TSfmlFont.Create(SfmlFontCopy(FHandle));
end;

function TSfmlFont.GetGlyph(CodePoint, CharacterSize: Cardinal;
  Bold: Boolean): TSfmlGlyph;
begin
  Result := SfmlFontGetGlyph(FHandle, CodePoint, CharacterSize, Bold);
end;

function TSfmlFont.GetInfo: TSfmlFontInfo;
begin
  Result := SfmlFontGetInfo(FHandle);
end;

function TSfmlFont.GetKerning(First, Second, CharacterSize: Cardinal): Single;
begin
  Result := SfmlFontGetKerning(FHandle, First, Second, CharacterSize);
end;

function TSfmlFont.GetLineSpacing(CharacterSize: Cardinal): Single;
begin
  Result := SfmlFontGetLineSpacing(FHandle, CharacterSize);
end;

function TSfmlFont.GetTexture(CharacterSize: Cardinal): PSfmlTexture;
begin
  Result := SfmlFontGetTexture(FHandle, CharacterSize);
end;

function TSfmlFont.GetUnderlinePosition(CharacterSize: Cardinal): Single;
begin
  Result := SfmlFontGetUnderlinePosition(FHandle, CharacterSize);
end;

function TSfmlFont.GetUnderlineThickness(CharacterSize: Cardinal): Single;
begin
  Result := SfmlFontGetUnderlineThickness(FHandle, CharacterSize);
end;


{ TSfmlImage }

constructor TSfmlImage.Create(Width, Height: Cardinal; const Pixels: PByte);
begin
  FHandle := SfmlImageCreateFromPixels(Width, Height, Pixels);
end;

constructor TSfmlImage.Create(Width, Height: Cardinal; Color: TSfmlColor);
begin
  FHandle := SfmlImageCreateFromColor(Width, Height, Color);
end;

constructor TSfmlImage.Create(Width, Height: Cardinal);
begin
  FHandle := SfmlImageCreate(Width, Height);
end;

constructor TSfmlImage.Create(const Stream: PSfmlInputStream);
begin
  FHandle := SfmlImageCreateFromStream(Stream);
end;

constructor TSfmlImage.Create(Handle: PSfmlImage);
begin
  FHandle := Handle;
end;

constructor TSfmlImage.Create(const Data: Pointer; Size: NativeUInt);
begin
  FHandle := SfmlImageCreateFromMemory(Data, Size);
end;

constructor TSfmlImage.Create(const FileName: AnsiString);
begin
  FHandle := SfmlImageCreateFromFile(PAnsiChar(FileName));
end;

procedure TSfmlImage.CreateMaskFromColor(Color: TSfmlColor; Alpha: Byte);
begin
  SfmlImageCreateMaskFromColor(FHandle, Color, Alpha);
end;

destructor TSfmlImage.Destroy;
begin
  SfmlImageDestroy(FHandle);
  inherited;
end;

function TSfmlImage.Copy: TSfmlImage;
begin
  Result := TSfmlImage.Create(SfmlImageCopy(FHandle));
end;

procedure TSfmlImage.CopyImage(const Source: PSfmlImage; DestX, DestY: Cardinal;
  SourceRect: TSfmlIntRect; ApplyAlpha: Boolean);
begin
  SfmlImageCopyImage(FHandle, Source, DestX, DestY, SourceRect, ApplyAlpha);
end;

procedure TSfmlImage.CopyImage(const Source: TSfmlImage; DestX, DestY: Cardinal;
  SourceRect: TSfmlIntRect; ApplyAlpha: Boolean);
begin
  SfmlImageCopyImage(FHandle, Source.FHandle, DestX, DestY, SourceRect, ApplyAlpha);
end;

procedure TSfmlImage.FlipHorizontally;
begin
  SfmlImageFlipHorizontally(FHandle);
end;

procedure TSfmlImage.FlipVertically;
begin
  SfmlImageFlipVertically(FHandle);
end;

function TSfmlImage.GetPixel(X, Y: Cardinal): TSfmlColor;
begin
  Result := SfmlImageGetPixel(FHandle, X, Y);
end;

function TSfmlImage.GetPixelsPtr: PByte;
begin
  Result := SfmlImageGetPixelsPtr(FHandle);
end;

function TSfmlImage.GetSize: TSfmlVector2u;
begin
  Result := SfmlImageGetSize(FHandle);
end;

function TSfmlImage.SaveToFile(const FileName: AnsiString): Boolean;
begin
  Result := SfmlImageSaveToFile(FHandle, PAnsiChar(FileName));
end;

procedure TSfmlImage.SetPixel(X, Y: Cardinal; Color: TSfmlColor);
begin
  SfmlImageSetPixel(FHandle, X, Y, Color);
end;


{ TSfmlRectangleShape }

constructor TSfmlRectangleShape.Create;
begin
  FHandle := SfmlRectangleShapeCreate;
end;

constructor TSfmlRectangleShape.Create(Handle: PSfmlRectangleShape);
begin
  FHandle := Handle;
end;

destructor TSfmlRectangleShape.Destroy;
begin
  SfmlRectangleShapeDestroy(FHandle);
  inherited;
end;

function TSfmlRectangleShape.Copy: TSfmlRectangleShape;
begin
  Result := TSfmlRectangleShape.Create(SfmlRectangleShapeCopy(FHandle));
end;

function TSfmlRectangleShape.GetFillColor: TSfmlColor;
begin
  Result := SfmlRectangleShapeGetFillColor(FHandle);
end;

function TSfmlRectangleShape.GetGlobalBounds: TSfmlFloatRect;
begin
  Result := SfmlRectangleShapeGetGlobalBounds(FHandle);
end;

function TSfmlRectangleShape.GetInverseTransform: TSfmlTransform;
begin
  Result := SfmlRectangleShapeGetInverseTransform(FHandle);
end;

function TSfmlRectangleShape.GetLocalBounds: TSfmlFloatRect;
begin
  Result := SfmlRectangleShapeGetLocalBounds(FHandle);
end;

function TSfmlRectangleShape.GetOrigin: TSfmlVector2f;
begin
  Result := SfmlRectangleShapeGetOrigin(FHandle);
end;

function TSfmlRectangleShape.GetOutlineColor: TSfmlColor;
begin
  Result := SfmlRectangleShapeGetOutlineColor(FHandle);
end;

function TSfmlRectangleShape.GetOutlineThickness: Single;
begin
  Result := SfmlRectangleShapeGetOutlineThickness(FHandle);
end;

function TSfmlRectangleShape.GetPoint(Index: NativeUInt): TSfmlVector2f;
begin
  Result := SfmlRectangleShapeGetPoint(FHandle, Index);
end;

function TSfmlRectangleShape.GetPointCount: NativeUInt;
begin
  Result := SfmlRectangleShapeGetPointCount(FHandle);
end;

function TSfmlRectangleShape.GetPosition: TSfmlVector2f;
begin
  Result := SfmlRectangleShapeGetPosition(FHandle);
end;

function TSfmlRectangleShape.GetRotation: Single;
begin
  Result := SfmlRectangleShapeGetRotation(FHandle);
end;

function TSfmlRectangleShape.GetScale: TSfmlVector2f;
begin
  Result := SfmlRectangleShapeGetScale(FHandle);
end;

function TSfmlRectangleShape.GetSize: TSfmlVector2f;
begin
  Result := SfmlRectangleShapeGetSize(FHandle);
end;

function TSfmlRectangleShape.GetTexture: PSfmlTexture;
begin
  Result := SfmlRectangleShapeGetTexture(FHandle);
end;

function TSfmlRectangleShape.GetTextureRect: TSfmlIntRect;
begin
  Result := SfmlRectangleShapeGetTextureRect(FHandle);
end;

function TSfmlRectangleShape.GetTransform: TSfmlTransform;
begin
  Result := SfmlRectangleShapeGetTransform(FHandle);
end;

procedure TSfmlRectangleShape.Move(Offset: TSfmlVector2f);
begin
  SfmlRectangleShapeMove(FHandle, Offset);
end;

procedure TSfmlRectangleShape.Rotate(Angle: Single);
begin
  SfmlRectangleShapeRotate(FHandle, Angle);
end;

procedure TSfmlRectangleShape.Scale(Factors: TSfmlVector2f);
begin
  SfmlRectangleShapeScale(FHandle, Factors);
end;

procedure TSfmlRectangleShape.SetFillColor(Color: TSfmlColor);
begin
  SfmlRectangleShapeSetFillColor(FHandle, Color);
end;

procedure TSfmlRectangleShape.SetOrigin(Origin: TSfmlVector2f);
begin
  SfmlRectangleShapeSetOrigin(FHandle, Origin);
end;

procedure TSfmlRectangleShape.SetOutlineColor(Color: TSfmlColor);
begin
  SfmlRectangleShapeSetOutlineColor(FHandle, Color);
end;

procedure TSfmlRectangleShape.SetOutlineThickness(Thickness: Single);
begin
  SfmlRectangleShapeSetOutlineThickness(FHandle, Thickness);
end;

procedure TSfmlRectangleShape.SetPosition(Position: TSfmlVector2f);
begin
  SfmlRectangleShapeSetPosition(FHandle, Position);
end;

procedure TSfmlRectangleShape.SetRotation(Angle: Single);
begin
  SfmlRectangleShapeSetRotation(FHandle, Angle);
end;

procedure TSfmlRectangleShape.SetScale(Scale: TSfmlVector2f);
begin
  SfmlRectangleShapeSetScale(FHandle, Scale);
end;

procedure TSfmlRectangleShape.SetSize(Size: TSfmlVector2f);
begin
  SfmlRectangleShapeSetSize(FHandle, Size);
end;

procedure TSfmlRectangleShape.SetTexture(const Texture: PSfmlTexture;
  ResetRect: Boolean);
begin
  SfmlRectangleShapeSetTexture(FHandle, Texture, ResetRect);
end;

procedure TSfmlRectangleShape.SetTextureRect(Rect: TSfmlIntRect);
begin
  SfmlRectangleShapeSetTextureRect(FHandle, Rect);
end;


{ TSfmlRenderTarget }

procedure TSfmlRenderTarget.Clear;
begin
  Clear(SfmlBlack);
end;


{ TSfmlRenderTexture }

constructor TSfmlRenderTexture.Create(Width, Height: Cardinal; DepthBuffer: Boolean = False);
begin
  FHandle := SfmlRenderTextureCreate(Width, Height, DepthBuffer);
end;

destructor TSfmlRenderTexture.Destroy;
begin
  SfmlRenderTextureDestroy(FHandle);
  inherited;
end;

procedure TSfmlRenderTexture.Clear(Color: TSfmlColor);
begin
  SfmlRenderTextureClear(FHandle, Color);
end;

procedure TSfmlRenderTexture.Display;
begin
  SfmlRenderTextureDisplay(FHandle);
end;

procedure TSfmlRenderTexture.Draw(const &Object: TSfmlRectangleShape;
  const States: PSfmlRenderStates);
begin
  SfmlRenderTextureDrawRectangleShape(FHandle, &Object.Handle, States);
end;

procedure TSfmlRenderTexture.Draw(const &Object: TSfmlConvexShape;
  const States: PSfmlRenderStates);
begin
  SfmlRenderTextureDrawConvexShape(FHandle, &Object.Handle, States);
end;

procedure TSfmlRenderTexture.Draw(const &Object: TSfmlCircleShape;
  const States: PSfmlRenderStates);
begin
  SfmlRenderTextureDrawCircleShape(FHandle, &Object.Handle, States);
end;

procedure TSfmlRenderTexture.Draw(const &Object: TSfmlShape;
  const States: PSfmlRenderStates);
begin
  SfmlRenderTextureDrawShape(FHandle, &Object.Handle, States);
end;

procedure TSfmlRenderTexture.Draw(const &Object: TSfmlVertexArray;
  const States: PSfmlRenderStates);
begin
  SfmlRenderTextureDrawVertexArray(FHandle, &Object.Handle, States);
end;

procedure TSfmlRenderTexture.Draw(const &Object: TSfmlText;
  const States: PSfmlRenderStates);
begin
  SfmlRenderTextureDrawText(FHandle, &Object.Handle, States);
end;

procedure TSfmlRenderTexture.Draw(const &Object: TSfmlSprite;
  const States: PSfmlRenderStates);
begin
  SfmlRenderTextureDrawSprite(FHandle, &Object.Handle, States);
end;

procedure TSfmlRenderTexture.DrawCircleShape(const &Object: PSfmlCircleShape;
  const States: PSfmlRenderStates);
begin
  SfmlRenderTextureDrawCircleShape(FHandle, &Object, States);
end;

procedure TSfmlRenderTexture.DrawConvexShape(const &Object: PSfmlConvexShape;
  const States: PSfmlRenderStates);
begin
  SfmlRenderTextureDrawConvexShape(FHandle, &Object, States);
end;

procedure TSfmlRenderTexture.DrawPrimitives(const Vertices: PSfmlVertex;
  VertexCount: NativeUInt; &Type: TSfmlPrimitiveType;
  const States: PSfmlRenderStates = nil);
begin
  SfmlRenderTextureDrawPrimitives(FHandle, Vertices, VertexCount, &Type, States);
end;

procedure TSfmlRenderTexture.DrawRectangleShape(
  const &Object: PSfmlRectangleShape; const States: PSfmlRenderStates);
begin
  SfmlRenderTextureDrawRectangleShape(FHandle, &Object, States);
end;

procedure TSfmlRenderTexture.DrawShape(const &Object: PSfmlShape;
  const States: PSfmlRenderStates);
begin
  SfmlRenderTextureDrawShape(FHandle, &Object, States);
end;

procedure TSfmlRenderTexture.DrawSprite(const &Object: PSfmlSprite;
  const States: PSfmlRenderStates);
begin
  SfmlRenderTextureDrawSprite(FHandle, &Object, States);
end;

procedure TSfmlRenderTexture.DrawText(const &Object: PSfmlText;
  const States: PSfmlRenderStates);
begin
  SfmlRenderTextureDrawText(FHandle, &Object, States);
end;

procedure TSfmlRenderTexture.DrawVertexArray(const &Object: PSfmlVertexArray;
  const States: PSfmlRenderStates);
begin
  SfmlRenderTextureDrawVertexArray(FHandle, &Object, States);
end;

procedure TSfmlRenderTexture.GenerateMipmap;
begin
  SfmlRenderTextureGenerateMipmap(FHandle);
end;

function TSfmlRenderTexture.GetDefaultView: TSfmlView;
var
  DefaultViewHandle: PSfmlView;
begin
  DefaultViewHandle := SfmlRenderTextureGetDefaultView(FHandle);

  // check if a texture object is already assigned
  if Assigned(FDefaultView) then
  begin
    // now check if the handle is identical
    if FDefaultView.Handle <> DefaultViewHandle then
    begin
      FDefaultView.Free;
      FDefaultView := nil;
    end;
  end;

  // create View object if not present already
  if not Assigned(FDefaultView) then
    FDefaultView := TSfmlView.Create(DefaultViewHandle);

  Result := FDefaultView;
end;

function TSfmlRenderTexture.GetSize: TSfmlVector2u;
begin
  Result := SfmlRenderTextureGetSize(FHandle);
end;

function TSfmlRenderTexture.GetTexture: TSfmlTexture;
var
  TextureHandle: PSfmlTexture;
begin
  TextureHandle := SfmlRenderTextureGetTexture(FHandle);

  // check if a texture object is already assigned
  if Assigned(FTexture) then
  begin
    // now check if the handle is identical
    if FTexture.Handle <> TextureHandle then
    begin
      FTexture.Free;
      FTexture := nil;
    end;
  end;

  // create texture object if not present already
  if not Assigned(FTexture) then
    FTexture := TSfmlTexture.Create(TextureHandle);

  Result := FTexture;
end;

function TSfmlRenderTexture.GetView: TSfmlView;
var
  ViewHandle: PSfmlView;
begin
  ViewHandle := SfmlRenderTextureGetView(FHandle);

  // check if a texture object is already assigned
  if Assigned(FDefaultView) then
  begin
    // now check if the handle is identical
    if FDefaultView.Handle <> ViewHandle then
    begin
      FDefaultView.Free;
      FDefaultView := nil;
    end;
  end;

  // create View object if not present already
  if not Assigned(FDefaultView) then
    FDefaultView := TSfmlView.Create(ViewHandle);

  Result := FDefaultView;
end;

function TSfmlRenderTexture.GetViewport(const View: PSfmlView): TSfmlIntRect;
begin
  Result := SfmlRenderTextureGetViewport(FHandle, View);
end;

function TSfmlRenderTexture.GetRepeated: Boolean;
begin
  Result := SfmlRenderTextureIsRepeated(FHandle);
end;

function TSfmlRenderTexture.GetSmooth: Boolean;
begin
  Result := SfmlRenderTextureIsSmooth(FHandle);
end;

function TSfmlRenderTexture.MapCoordsToPixel(Point: TSfmlVector2i;
  const View: PSfmlView = nil): TSfmlVector2i;
begin
  Result := SfmlRenderTextureMapCoordsToPixel(FHandle, Point, View);
end;

function TSfmlRenderTexture.MapPixelToCoords(Point: TSfmlVector2i;
  const View: PSfmlView = nil): TSfmlVector2f;
begin
  Result := SfmlRenderTextureMapPixelToCoords(FHandle, Point, View);
end;

procedure TSfmlRenderTexture.PopGLStates;
begin
  SfmlRenderTexturePopGLStates(FHandle);
end;

procedure TSfmlRenderTexture.PushGLStates;
begin
  SfmlRenderTexturePushGLStates(FHandle);
end;

procedure TSfmlRenderTexture.ResetGLStates;
begin
  SfmlRenderTextureResetGLStates(FHandle);
end;

function TSfmlRenderTexture.SetActive(Active: Boolean): Boolean;
begin
  Result := SfmlRenderTextureSetActive(FHandle, Active);
end;

procedure TSfmlRenderTexture.SetRepeated(Repeated: Boolean);
begin
  SfmlRenderTextureSetRepeated(FHandle, Repeated);
end;

procedure TSfmlRenderTexture.SetSmooth(Smooth: Boolean);
begin
  SfmlRenderTextureSetSmooth(FHandle, Smooth);
end;

procedure TSfmlRenderTexture.SetView(const View: TSfmlView);
begin
  if FView <> View then
  begin
    FView := View;
    SfmlRenderTextureSetView(FHandle, View.Handle);
  end;
end;


{ TSfmlRenderWindow }

constructor TSfmlRenderWindow.Create(Mode: TSfmlVideoMode;
  const Title: AnsiString; Style: TSfmlWindowStyles;
  const Settings: PSfmlContextSettings);
begin
  FHandle := SfmlRenderWindowCreate(Mode, PAnsiChar(Title), Style, Settings);
end;

constructor TSfmlRenderWindow.Create(Mode: TSfmlVideoMode;
  const Title: UnicodeString; Style: TSfmlWindowStyles;
  const Settings: PSfmlContextSettings);
begin
  FHandle := SfmlRenderWindowCreateUnicode(Mode,
    PUCS4Char(UnicodeStringToUCS4String(Title)), Style, Settings);
end;

constructor TSfmlRenderWindow.Create(Handle: TSfmlWindowHandle; const Settings: PSfmlContextSettings = nil);
begin
  FHandle := SfmlRenderWindowCreateFromHandle(Handle, Settings);
end;

constructor TSfmlRenderWindow.Create(Mode: TSfmlVideoMode;
  const Title: AnsiString; Style: TSfmlWindowStyles = [sfTitleBar, sfClose]);
begin
  FHandle := SfmlRenderWindowCreate(Mode, PAnsiChar(Title), Style, nil);
end;

constructor TSfmlRenderWindow.Create(Mode: TSfmlVideoMode;
  const Title: UnicodeString; Style: TSfmlWindowStyles = [sfTitleBar, sfClose]);
begin
  FHandle := SfmlRenderWindowCreateUnicode(Mode,
    PUCS4Char(UnicodeStringToUCS4String(Title)), Style, nil);
end;

destructor TSfmlRenderWindow.Destroy;
begin
  SfmlRenderWindowDestroy(FHandle);
  inherited;
end;

function TSfmlRenderWindow.Capture: PSfmlImage;
begin
  Result := SfmlRenderWindowCapture(FHandle);
end;

procedure TSfmlRenderWindow.Clear(Color: TSfmlColor);
begin
  SfmlRenderWindowClear(FHandle, Color);
end;

procedure TSfmlRenderWindow.Close;
begin
  SfmlRenderWindowClose(FHandle);
end;

procedure TSfmlRenderWindow.Display;
begin
  SfmlRenderWindowDisplay(FHandle);
end;

procedure TSfmlRenderWindow.DrawCircleShape(const &Object: PSfmlCircleShape;
  const States: PSfmlRenderStates = nil);
begin
  SfmlRenderWindowDrawCircleShape(FHandle, &Object, States);
end;

procedure TSfmlRenderWindow.DrawConvexShape(const &Object: PSfmlConvexShape;
  const States: PSfmlRenderStates = nil);
begin
  SfmlRenderWindowDrawConvexShape(FHandle, &Object, States);
end;

procedure TSfmlRenderWindow.DrawPrimitives(const Vertices: PSfmlVertex;
  VertexCount: NativeUInt; &Type: TSfmlPrimitiveType; const States: PSfmlRenderStates = nil);
begin
  SfmlRenderWindowDrawPrimitives(FHandle, Vertices, VertexCount, &Type, States);
end;

procedure TSfmlRenderWindow.Draw(const &Object: TSfmlRectangleShape;
  const States: PSfmlRenderStates = nil);
begin
  SfmlRenderWindowDrawRectangleShape(FHandle, &Object.FHandle, States);
end;

procedure TSfmlRenderWindow.DrawRectangleShape(
  const &Object: PSfmlRectangleShape; const States: PSfmlRenderStates = nil);
begin
  SfmlRenderWindowDrawRectangleShape(FHandle, &Object, States);
end;

procedure TSfmlRenderWindow.DrawShape(const &Object: PSfmlShape;
  const States: PSfmlRenderStates = nil);
begin
  SfmlRenderWindowDrawShape(FHandle, &Object, States);
end;

procedure TSfmlRenderWindow.DrawSprite(const &Object: PSfmlSprite;
  const States: PSfmlRenderStates = nil);
begin
  SfmlRenderWindowDrawSprite(FHandle, &Object, States);
end;

procedure TSfmlRenderWindow.DrawText(const &Object: PSfmlText;
  const States: PSfmlRenderStates = nil);
begin
  SfmlRenderWindowDrawText(FHandle, &Object, States);
end;

procedure TSfmlRenderWindow.DrawVertexArray(const &Object: PSfmlVertexArray;
  const States: PSfmlRenderStates = nil);
begin
  SfmlRenderWindowDrawVertexArray(FHandle, &Object, States);
end;

procedure TSfmlRenderWindow.Draw(const &Object: TSfmlCircleShape;
  const States: PSfmlRenderStates = nil);
begin
  SfmlRenderWindowDrawCircleShape(FHandle, &Object.Handle, States);
end;

procedure TSfmlRenderWindow.Draw(const &Object: TSfmlConvexShape;
  const States: PSfmlRenderStates = nil);
begin
  SfmlRenderWindowDrawConvexShape(FHandle, &Object.Handle, States);
end;

procedure TSfmlRenderWindow.Draw(const &Object: TSfmlShape;
  const States: PSfmlRenderStates = nil);
begin
  SfmlRenderWindowDrawShape(FHandle, &Object.Handle, States);
end;

procedure TSfmlRenderWindow.Draw(const &Object: TSfmlSprite;
  const States: PSfmlRenderStates = nil);
begin
  SfmlRenderWindowDrawSprite(FHandle, &Object.Handle, States);
end;

procedure TSfmlRenderWindow.Draw(const &Object: TSfmlText;
  const States: PSfmlRenderStates = nil);
begin
  SfmlRenderWindowDrawText(FHandle, &Object.Handle, States);
end;

procedure TSfmlRenderWindow.Draw(const &Object: TSfmlVertexArray;
  const States: PSfmlRenderStates = nil);
begin
  SfmlRenderWindowDrawVertexArray(FHandle, &Object.Handle, States);
end;

function TSfmlRenderWindow.GetDefaultView: TSfmlView;
var
  DefaultViewHandle: PSfmlView;
begin
  DefaultViewHandle := SfmlRenderWindowGetDefaultView(FHandle);

  // check if a texture object is already assigned
  if Assigned(FDefaultView) then
  begin
    // now check if the handle is identical
    if FDefaultView.Handle <> DefaultViewHandle then
    begin
      FDefaultView.Free;
      FDefaultView := nil;
    end;
  end;

  // create View object if not present already
  if not Assigned(FDefaultView) then
    FDefaultView := TSfmlView.Create(DefaultViewHandle);

  Result := FDefaultView;
end;

function TSfmlRenderWindow.GetMousePosition: TSfmlVector2i;
begin
  Result := SfmlMouseGetPositionRenderWindow(FHandle);
end;

function TSfmlRenderWindow.GetPosition: TSfmlVector2i;
begin
  Result := SfmlRenderWindowGetPosition(FHandle);
end;

function TSfmlRenderWindow.GetSettings: TSfmlContextSettings;
begin
  Result := SfmlRenderWindowGetSettings(FHandle);
end;

function TSfmlRenderWindow.GetSize: TSfmlVector2u;
begin
  Result := SfmlRenderWindowGetSize(FHandle);
end;

function TSfmlRenderWindow.GetSystemHandle: TSfmlWindowHandle;
begin
  Result := SfmlRenderWindowGetSystemHandle(FHandle);
end;

function TSfmlRenderWindow.GetView: TSfmlView;
var
  ViewHandle: PSfmlView;
begin
  ViewHandle := SfmlRenderWindowGetView(FHandle);

  // check if a texture object is already assigned
  if Assigned(FView) then
  begin
    // now check if the handle is identical
    if FView.Handle <> ViewHandle then
    begin
      FView.Free;
      FView := nil;
    end;
  end;

  // create View object if not present already
  if not Assigned(FView) then
    FView := TSfmlView.Create(ViewHandle);

  Result := FView;
end;

function TSfmlRenderWindow.GetViewport(const View: PSfmlView): TSfmlIntRect;
begin
  Result := SfmlRenderWindowGetViewport(FHandle, View);
end;

function TSfmlRenderWindow.HasFocus: Boolean;
begin
  Result := SfmlRenderWindowHasFocus(FHandle);
end;

function TSfmlRenderWindow.IsOpen: Boolean;
begin
  Result := SfmlRenderWindowIsOpen(FHandle);
end;

function TSfmlRenderWindow.MapCoordsToPixel(Point: TSfmlVector2i;
  const View: PSfmlView = nil): TSfmlVector2i;
begin
  Result := SfmlRenderWindowMapCoordsToPixel(FHandle, Point, View);
end;

function TSfmlRenderWindow.MapPixelToCoords(Point: TSfmlVector2i;
  const View: PSfmlView = nil): TSfmlVector2f;
begin
  Result := SfmlRenderWindowMapPixelToCoords(FHandle, Point, View);
end;

function TSfmlRenderWindow.PollEvent(out Event: TSfmlEvent): Boolean;
begin
  Result := SfmlRenderWindowPollEvent(FHandle, Event);
end;

procedure TSfmlRenderWindow.PopGLStates;
begin
  SfmlRenderWindowPopGLStates(FHandle);
end;

procedure TSfmlRenderWindow.PushGLStates;
begin
  SfmlRenderWindowPushGLStates(FHandle);
end;

procedure TSfmlRenderWindow.RequestFocus;
begin
  SfmlRenderWindowRequestFocus(FHandle);
end;

procedure TSfmlRenderWindow.ResetGLStates;
begin
  SfmlRenderWindowResetGLStates(FHandle);
end;

function TSfmlRenderWindow.SetActive(Active: Boolean): Boolean;
begin
  Result := SfmlRenderWindowSetActive(FHandle, Active);
end;

procedure TSfmlRenderWindow.SetFramerateLimit(Limit: Cardinal);
begin
  SfmlRenderWindowSetFramerateLimit(FHandle, Limit);
end;

procedure TSfmlRenderWindow.SetIcon(Width, Height: Cardinal;
  const Pixels: PByte);
begin
  SfmlRenderWindowSetIcon(FHandle, Width, Height, Pixels);
end;

procedure TSfmlRenderWindow.SetJoystickThreshold(Threshold: Single);
begin
  SfmlRenderWindowSetJoystickThreshold(FHandle, Threshold);
end;

procedure TSfmlRenderWindow.SetKeyRepeatEnabled(Enabled: Boolean);
begin
  SfmlRenderWindowSetKeyRepeatEnabled(FHandle, Enabled);
end;

procedure TSfmlRenderWindow.SetMouseCursorGrabbed(Grabbed: Boolean);
begin
  SfmlRenderWindowSetMouseCursorGrabbed(FHandle, Grabbed);
end;

procedure TSfmlRenderWindow.SetMouseCursorVisible(Show: Boolean);
begin
  SfmlRenderWindowSetMouseCursorVisible(FHandle, Show);
end;

procedure TSfmlRenderWindow.SetMousePosition(Position: TSfmlVector2i);
begin
  SfmlMouseSetPositionRenderWindow(Position, FHandle);
end;

procedure TSfmlRenderWindow.SetPosition(Position: TSfmlVector2i);
begin
  SfmlRenderWindowSetPosition(FHandle, Position);
end;

procedure TSfmlRenderWindow.SetSize(Size: TSfmlVector2u);
begin
  SfmlRenderWindowSetSize(FHandle, Size);
end;

procedure TSfmlRenderWindow.SetTitle(const Title: AnsiString);
begin
  SfmlRenderWindowSetTitle(FHandle, PAnsiChar(Title));
end;

procedure TSfmlRenderWindow.SetTitle(const Title: UnicodeString);
begin
  SfmlRenderWindowSetUnicodeTitle(FHandle,
    PUCS4Char(UnicodeStringToUCS4String(Title)));
end;

procedure TSfmlRenderWindow.SetVerticalSyncEnabled(Enabled: Boolean);
begin
  SfmlRenderWindowSetVerticalSyncEnabled(FHandle, Enabled);
end;

procedure TSfmlRenderWindow.SetView(const View: TSfmlView);
begin
  FView := View;
  SfmlRenderWindowSetView(FHandle, View.Handle);
end;

procedure TSfmlRenderWindow.SetVisible(Visible: Boolean);
begin
  SfmlRenderWindowSetVisible(FHandle, Visible);
end;

function TSfmlRenderWindow.WaitEvent(out Event: TSfmlEvent): Boolean;
begin
  Result := SfmlRenderWindowWaitEvent(FHandle, Event);
end;


{ TSfmlShader }

constructor TSfmlShader.Create(const VertexShader, GeometryShader, FragmentShader: AnsiString);
begin
  FHandle := SfmlShaderCreateFromMemory(PAnsiChar(VertexShader),
    PAnsiChar(GeometryShader), PAnsiChar(FragmentShader));
end;

constructor TSfmlShader.Create(VertexShaderStream, GeometryShaderStream, FragmentShaderStream: PSfmlInputStream);
begin
  FHandle := SfmlShaderCreateFromStream(VertexShaderStream, GeometryShaderStream, FragmentShaderStream);
end;

constructor TSfmlShader.CreateFromFile(const VertexShaderFilename, GeometryShaderFilename, FragmentShaderFilename: AnsiString);
var
  FileNames: array [0..2] of PAnsiChar;
begin
  FileNames[0] := nil;
  FileNames[1] := nil;
  FileNames[2] := nil;

  if VertexShaderFilename <> '' then
    FileNames[0] := PAnsiChar(VertexShaderFilename);

  if GeometryShaderFilename <> '' then
    FileNames[1] := PAnsiChar(GeometryShaderFilename);

  if FragmentShaderFilename <> '' then
    FileNames[2] := PAnsiChar(FragmentShaderFilename);

  FHandle := SfmlShaderCreateFromFile(FileNames[0], FileNames[1], FileNames[2]);
end;

destructor TSfmlShader.Destroy;
begin
  SfmlShaderDestroy(FHandle);
  inherited;
end;

function TSfmlShader.GetNativeHandle: Cardinal;
begin
  Result := SfmlShaderGetNativeHandle(FHandle);
end;

procedure TSfmlShader.Bind;
begin
  SfmlShaderBind(FHandle);
end;

procedure TSfmlShader.SetParameter(const Name: AnsiString;
  Color: TSfmlColor);
begin
  SfmlShaderSetColorParameter(FHandle, PAnsiChar(Name), Color);
end;

procedure TSfmlShader.SetBoolUniform(const Name: AnsiString; X: LongBool);
begin
  SfmlShaderSetBoolUniform(FHandle, PAnsiChar(Name), X);
end;

procedure TSfmlShader.SetBvec2Uniform(const Name: AnsiString;
  Vector: TSfmlGlslBvec2);
begin
  SfmlShaderSetBvec2Uniform(FHandle, PAnsiChar(Name), Vector);
end;

procedure TSfmlShader.SetBvec3Uniform(const Name: AnsiString;
  Vector: TSfmlGlslBvec3);
begin
  SfmlShaderSetBvec3Uniform(FHandle, PAnsiChar(Name), Vector);
end;

procedure TSfmlShader.SetBvec4Uniform(const Name: AnsiString;
  Vector: TSfmlGlslBvec4);
begin
  SfmlShaderSetBvec4Uniform(FHandle, PAnsiChar(Name), Vector);
end;

procedure TSfmlShader.SetColorUniform(const Name: AnsiString;
  Color: TSfmlColor);
begin
  SfmlShaderSetColorUniform(FHandle, PAnsiChar(Name), Color);
end;

procedure TSfmlShader.SetCurrentTextureParameter(const Name: AnsiString);
begin
  SfmlShaderSetCurrentTextureParameter(FHandle, PAnsiChar(Name));
end;

procedure TSfmlShader.SetCurrentTextureUniform(const Name: AnsiString);
begin
  SfmlShaderSetCurrentTextureUniform(FHandle, PAnsiChar(Name));
end;

procedure TSfmlShader.SetFloatUniform(const Name: AnsiString; X: Single);
begin
  SfmlShaderSetFloatUniform(FHandle, PAnsiChar(Name), X);
end;

procedure TSfmlShader.SetFloatUniformArray(const Name: AnsiString;
  const ScalarArray: array of Single);
begin
  SfmlShaderSetFloatUniformArray(FHandle, PAnsiChar(Name), @ScalarArray[0], Length(ScalarArray));
end;

procedure TSfmlShader.SetIntColorUniform(const Name: AnsiString;
  Color: TSfmlColor);
begin
  SfmlShaderSetIntColorUniform(FHandle, PAnsiChar(Name), Color);
end;

procedure TSfmlShader.SetIntUniform(const Name: AnsiString; X: Integer);
begin
  SfmlShaderSetIntUniform(FHandle, PAnsiChar(Name), X);
end;

procedure TSfmlShader.SetIvec2Uniform(const Name: AnsiString;
  Vector: TSfmlGlslIvec2);
begin
  SfmlShaderSetIvec2Uniform(FHandle, PAnsiChar(Name), Vector);
end;

procedure TSfmlShader.SetIvec3Uniform(const Name: AnsiString;
  Vector: TSfmlGlslIvec3);
begin
  SfmlShaderSetIvec3Uniform(FHandle, PAnsiChar(Name), Vector);
end;

procedure TSfmlShader.SetIvec4Uniform(const Name: AnsiString;
  Vector: TSfmlGlslIvec4);
begin
  SfmlShaderSetIvec4Uniform(FHandle, PAnsiChar(Name), Vector);
end;

procedure TSfmlShader.SetMat3Uniform(const Name: AnsiString;
  const Matrix: TSfmlGlslMat3);
begin
  SfmlShaderSetMat3Uniform(FHandle, PAnsiChar(Name), @Matrix);
end;

procedure TSfmlShader.SetMat3UniformArray(const Name: AnsiString;
  const MatrixArray: array of TSfmlGlslMat3);
begin
  SfmlShaderSetMat3UniformArray(FHandle, PAnsiChar(Name), @MatrixArray[0], Length(MatrixArray));
end;

procedure TSfmlShader.SetMat4Uniform(const Name: AnsiString;
  const Matrix: TSfmlGlslMat4);
begin
  SfmlShaderSetMat4Uniform(FHandle, PAnsiChar(Name), @Matrix);
end;

procedure TSfmlShader.SetMat4UniformArray(const Name: AnsiString;
  const MatrixArray: array of TSfmlGlslMat4);
begin
  SfmlShaderSetMat4UniformArray(FHandle, PAnsiChar(Name), @MatrixArray[0], Length(MatrixArray));
end;

procedure TSfmlShader.SetParameter(const Name: AnsiString; X, Y: Single);
begin
  SfmlShaderSetFloat2Parameter(FHandle, PAnsiChar(Name), X, Y);
end;

procedure TSfmlShader.SetParameter(const Name: AnsiString; X, Y,
  Z: Single);
begin
  SfmlShaderSetFloat3Parameter(FHandle, PAnsiChar(Name), X, Y, Z);
end;

procedure TSfmlShader.SetParameter(const Name: AnsiString; X, Y, Z,
  W: Single);
begin
  SfmlShaderSetFloat4Parameter(FHandle, PAnsiChar(Name), X, Y, Z, W);
end;

procedure TSfmlShader.SetParameter(const Name: AnsiString; X: Single);
begin
  SfmlShaderSetFloatParameter(FHandle, PAnsiChar(Name), X);
end;

procedure TSfmlShader.SetTextureParameter(const Name: AnsiString;
  const Texture: PSfmlTexture);
begin
  SfmlShaderSetTextureParameter(FHandle, PAnsiChar(Name), Texture);
end;

procedure TSfmlShader.SetTextureUniform(const Name: AnsiString;
  const Texture: PSfmlTexture);
begin
  SfmlShaderSetTextureUniform(FHandle, PAnsiChar(Name), Texture);
end;

procedure TSfmlShader.SetTransformParameter(const Name: AnsiString;
  Transform: TSfmlTransform);
begin
  SfmlShaderSetTransformParameter(FHandle, PAnsiChar(Name), Transform);
end;

procedure TSfmlShader.SetVec2Uniform(const Name: AnsiString;
  Vector: TSfmlGlslVec2);
begin
  SfmlShaderSetVec2Uniform(FHandle, PAnsiChar(Name), Vector);
end;

procedure TSfmlShader.SetVec2UniformArray(const Name: AnsiString;
  const VectorArray: array of TSfmlGlslVec2);
begin
  SfmlShaderSetVec2UniformArray(FHandle, PAnsiChar(Name), @VectorArray, Length(VectorArray));
end;

procedure TSfmlShader.SetVec3Uniform(const Name: AnsiString;
  Vector: TSfmlGlslVec3);
begin
  SfmlShaderSetVec3Uniform(FHandle, PAnsiChar(Name), Vector);
end;

procedure TSfmlShader.SetVec3UniformArray(const Name: AnsiString;
  const VectorArray: array of TSfmlGlslVec3);
begin
  SfmlShaderSetVec3UniformArray(FHandle, PAnsiChar(Name), @VectorArray, Length(VectorArray));
end;

procedure TSfmlShader.SetVec4Uniform(const Name: AnsiString;
  Vector: TSfmlGlslVec4);
begin
  SfmlShaderSetVec4Uniform(FHandle, PAnsiChar(Name), Vector);
end;

procedure TSfmlShader.SetVec4UniformArray(const Name: AnsiString;
  const VectorArray: array of TSfmlGlslVec4);
begin
  SfmlShaderSetVec4UniformArray(FHandle, PAnsiChar(Name), @VectorArray, Length(VectorArray));
end;

procedure TSfmlShader.SetParameter(const Name: AnsiString;
  Vector: TSfmlVector2f);
begin
  SfmlShaderSetVector2Parameter(FHandle, PAnsiChar(Name), Vector);
end;

procedure TSfmlShader.SetParameter(const Name: AnsiString;
  Vector: TSfmlVector3f);
begin
  SfmlShaderSetVector3Parameter(FHandle, PAnsiChar(Name), Vector);
end;


{ TSfmlShape }

constructor TSfmlShape.Create(GetPointCount: TSfmlShapeGetPointCountCallback;
  GetPoint: TSfmlShapeGetPointCallback; UserData: Pointer);
begin
  FHandle := SfmlShapeCreate(GetPointCount, GetPoint, UserData);
end;

destructor TSfmlShape.Destroy;
begin
  SfmlShapeDestroy(FHandle);
  inherited;
end;

function TSfmlShape.GetFillColor: TSfmlColor;
begin
  Result := SfmlShapeGetFillColor(FHandle);
end;

function TSfmlShape.GetGlobalBounds: TSfmlFloatRect;
begin
  Result := SfmlShapeGetGlobalBounds(FHandle);
end;

function TSfmlShape.GetInverseTransform: TSfmlTransform;
begin
  Result := SfmlShapeGetInverseTransform(FHandle);
end;

function TSfmlShape.GetLocalBounds: TSfmlFloatRect;
begin
  Result := SfmlShapeGetLocalBounds(FHandle);
end;

function TSfmlShape.GetOrigin: TSfmlVector2f;
begin
  Result := SfmlShapeGetOrigin(FHandle);
end;

function TSfmlShape.GetOutlineColor: TSfmlColor;
begin
  Result := SfmlShapeGetOutlineColor(FHandle);
end;

function TSfmlShape.GetOutlineThickness: Single;
begin
  Result := SfmlShapeGetOutlineThickness(FHandle);
end;

function TSfmlShape.GetPoint(Index: NativeUInt): TSfmlVector2f;
begin
  Result := SfmlShapeGetPoint(FHandle, Index);
end;

function TSfmlShape.GetPointCount: NativeUInt;
begin
  Result := SfmlShapeGetPointCount(FHandle);
end;

function TSfmlShape.GetPosition: TSfmlVector2f;
begin
  Result := SfmlShapeGetPosition(FHandle);
end;

function TSfmlShape.GetRotation: Single;
begin
  Result := SfmlShapeGetRotation(FHandle);
end;

function TSfmlShape.GetScale: TSfmlVector2f;
begin
  Result := SfmlShapeGetScale(FHandle);
end;

function TSfmlShape.GetTexture: PSfmlTexture;
begin
  Result := SfmlShapeGetTexture(FHandle);
end;

function TSfmlShape.GetTextureRect: TSfmlIntRect;
begin
  Result := SfmlShapeGetTextureRect(FHandle);
end;

function TSfmlShape.GetTransform: TSfmlTransform;
begin
  Result := SfmlShapeGetTransform(FHandle);
end;

procedure TSfmlShape.Move(Offset: TSfmlVector2f);
begin
  SfmlShapeMove(FHandle, Offset);
end;

procedure TSfmlShape.Rotate(Angle: Single);
begin
  SfmlShapeRotate(FHandle, Angle);
end;

procedure TSfmlShape.Scale(Factors: TSfmlVector2f);
begin
  SfmlShapeScale(FHandle, Factors);
end;

procedure TSfmlShape.SetFillColor(Color: TSfmlColor);
begin
  SfmlShapeSetFillColor(FHandle, Color);
end;

procedure TSfmlShape.SetOrigin(Origin: TSfmlVector2f);
begin
  SfmlShapeSetOrigin(FHandle, Origin);
end;

procedure TSfmlShape.SetOutlineColor(Color: TSfmlColor);
begin
  SfmlShapeSetOutlineColor(FHandle, Color);
end;

procedure TSfmlShape.SetOutlineThickness(Thickness: Single);
begin
  SfmlShapeSetOutlineThickness(FHandle, Thickness);
end;

procedure TSfmlShape.SetPosition(Position: TSfmlVector2f);
begin
  SfmlShapeSetPosition(FHandle, Position);
end;

procedure TSfmlShape.SetRotation(Angle: Single);
begin
  SfmlShapeSetRotation(FHandle, Angle);
end;

procedure TSfmlShape.SetScale(Scale: TSfmlVector2f);
begin
  SfmlShapeSetScale(FHandle, Scale);
end;

procedure TSfmlShape.SetTexture(const Texture: PSfmlTexture;
  ResetRect: Boolean);
begin
  SfmlShapeSetTexture(FHandle, Texture, ResetRect);
end;

procedure TSfmlShape.SetTextureRect(Rect: TSfmlIntRect);
begin
  SfmlShapeSetTextureRect(FHandle, Rect);
end;

procedure TSfmlShape.Update;
begin
  SfmlShapeUpdate(FHandle);
end;


{ TSfmlSprite }

constructor TSfmlSprite.Create;
begin
  FHandle := SfmlSpriteCreate;
end;

constructor TSfmlSprite.Create(Handle: PSfmlSprite);
begin
  FHandle := Handle;
end;

constructor TSfmlSprite.Create(Texture: TSfmlTexture);
begin
  Create;
  SetTexture(Texture);
end;

constructor TSfmlSprite.Create(Texture: TSfmlTexture;
  TextureRect: TSfmlIntRect);
begin
  Create(Texture);
  SetTextureRect(TextureRect);
end;

destructor TSfmlSprite.Destroy;
begin
  SfmlSpriteDestroy(FHandle);
  inherited;
end;

function TSfmlSprite.Copy: TSfmlSprite;
begin
  Result := TSfmlSprite.Create(SfmlSpriteCopy(FHandle));
end;

function TSfmlSprite.GetColor: TSfmlColor;
begin
  Result := SfmlSpriteGetColor(FHandle);
end;

function TSfmlSprite.GetGlobalBounds: TSfmlFloatRect;
begin
  Result := SfmlSpriteGetGlobalBounds(FHandle);
end;

function TSfmlSprite.GetInverseTransform: TSfmlTransform;
begin
  Result := SfmlSpriteGetInverseTransform(FHandle);
end;

function TSfmlSprite.GetLocalBounds: TSfmlFloatRect;
begin
  Result := SfmlSpriteGetLocalBounds(FHandle);
end;

function TSfmlSprite.GetOrigin: TSfmlVector2f;
begin
  Result := SfmlSpriteGetOrigin(FHandle);
end;

function TSfmlSprite.GetPosition: TSfmlVector2f;
begin
  Result := SfmlSpriteGetPosition(FHandle);
end;

function TSfmlSprite.GetRotation: Single;
begin
  Result := SfmlSpriteGetRotation(FHandle);
end;

function TSfmlSprite.GetScale: TSfmlVector2f;
begin
  Result := SfmlSpriteGetScale(FHandle);
end;

function TSfmlSprite.GetTexture: PSfmlTexture;
begin
  Result := SfmlSpriteGetTexture(FHandle);
end;

function TSfmlSprite.GetTextureRect: TSfmlIntRect;
begin
  Result := SfmlSpriteGetTextureRect(FHandle);
end;

function TSfmlSprite.GetTransform: TSfmlTransform;
begin
  Result := SfmlSpriteGetTransform(FHandle);
end;

procedure TSfmlSprite.Move(Offset: TSfmlVector2f);
begin
  SfmlSpriteMove(FHandle, Offset);
end;

procedure TSfmlSprite.Rotate(Angle: Single);
begin
  SfmlSpriteRotate(FHandle, Angle);
end;

procedure TSfmlSprite.Scale(Factors: TSfmlVector2f);
begin
  SfmlSpriteScale(FHandle, Factors);
end;

procedure TSfmlSprite.SetColor(Color: TSfmlColor);
begin
  SfmlSpriteSetColor(FHandle, Color);
end;

procedure TSfmlSprite.SetOrigin(Origin: TSfmlVector2f);
begin
  SfmlSpriteSetOrigin(FHandle, Origin);
end;

procedure TSfmlSprite.SetPosition(Position: TSfmlVector2f);
begin
  SfmlSpriteSetPosition(FHandle, Position);
end;

procedure TSfmlSprite.SetRotation(Angle: Single);
begin
  SfmlSpriteSetRotation(FHandle, Angle);
end;

procedure TSfmlSprite.SetScale(Scale: TSfmlVector2f);
begin
  SfmlSpriteSetScale(FHandle, Scale);
end;

procedure TSfmlSprite.SetTexture(const Texture: TSfmlTexture;
  ResetRect: Boolean = False);
begin
  SfmlSpriteSetTexture(FHandle, Texture.FHandle, ResetRect);
end;

procedure TSfmlSprite.SetTexture(const Texture: PSfmlTexture;
  ResetRect: Boolean = False);
begin
  SfmlSpriteSetTexture(FHandle, Texture, ResetRect);
end;

procedure TSfmlSprite.SetTextureRect(Rectangle: TSfmlIntRect);
begin
  SfmlSpriteSetTextureRect(FHandle, Rectangle);
end;


{ TSfmlText }

constructor TSfmlText.Create;
begin
  FHandle := SfmlTextCreate;
end;

constructor TSfmlText.Create(Text: UnicodeString; Font: TSfmlFont;
  CharacterSize: Cardinal);
begin
  Create;
  SetUnicodeString(Text);
  SetFont(Font.Handle);
  SetCharacterSize(CharacterSize);
end;

constructor TSfmlText.Create(Text: UnicodeString; Font: TSfmlFont);
begin
  Create;
  SetUnicodeString(Text);
  SetFont(Font.Handle);
end;

constructor TSfmlText.Create(Text: UnicodeString);
begin
  Create;
  SetUnicodeString(Text);
end;

constructor TSfmlText.Create(Text: UnicodeString; Font: PSfmlFont;
  CharacterSize: Cardinal);
begin
  Create;
  SetUnicodeString(Text);
  SetFont(Font);
  SetCharacterSize(CharacterSize);
end;

constructor TSfmlText.Create(Handle: PSfmlText);
begin
  FHandle := Handle;
end;

constructor TSfmlText.Create(Text: UnicodeString; Font: PSfmlFont);
begin
  Create;
  SetUnicodeString(Text);
  SetFont(Font);
end;

destructor TSfmlText.Destroy;
begin
  SfmlTextDestroy(FHandle);
  inherited;
end;

function TSfmlText.Copy: TSfmlText;
begin
  Result := TSfmlText.Create(SfmlTextCopy(FHandle));
end;

function TSfmlText.FindCharacterPos(Index: NativeUInt): TSfmlVector2f;
begin
  Result := SfmlTextFindCharacterPos(FHandle, Index);
end;

function TSfmlText.GetCharacterSize: Cardinal;
begin
  Result := SfmlTextGetCharacterSize(FHandle);
end;

function TSfmlText.GetColor: TSfmlColor;
begin
  Result := SfmlTextGetColor(FHandle);
end;

function TSfmlText.GetFillColor: TSfmlColor;
begin
  Result := SfmlTextGetFillColor(FHandle);
end;

function TSfmlText.GetFont: PSfmlFont;
begin
  Result := SfmlTextGetFont(FHandle);
end;

function TSfmlText.GetGlobalBounds: TSfmlFloatRect;
begin
  Result := SfmlTextGetGlobalBounds(FHandle);
end;

function TSfmlText.GetInverseTransform: TSfmlTransform;
begin
  Result := SfmlTextGetInverseTransform(FHandle);
end;

function TSfmlText.GetLocalBounds: TSfmlFloatRect;
begin
  Result := SfmlTextGetLocalBounds(FHandle);
end;

function TSfmlText.GetOrigin: TSfmlVector2f;
begin
  Result := SfmlTextGetOrigin(FHandle);
end;

function TSfmlText.GetOutlineColor: TSfmlColor;
begin
  Result := SfmlTextGetOutlineColor(FHandle);
end;

function TSfmlText.GetOutlineThickness: Single;
begin
  Result := SfmlTextGetOutlineThickness(FHandle);
end;

function TSfmlText.GetPosition: TSfmlVector2f;
begin
  Result := SfmlTextGetPosition(FHandle);
end;

function TSfmlText.GetRotation: Single;
begin
  Result := SfmlTextGetRotation(FHandle);
end;

function TSfmlText.GetScale: TSfmlVector2f;
begin
  Result := SfmlTextGetScale(FHandle);
end;

function TSfmlText.GetString: AnsiString;
begin
  Result := SfmlTextGetString(FHandle);
end;

function TSfmlText.GetStyle: Cardinal;
begin
  Result := SfmlTextGetStyle(FHandle);
end;

function TSfmlText.GetTransform: TSfmlTransform;
begin
  Result := SfmlTextGetTransform(FHandle);
end;

function TSfmlText.GetUnicodeString: UnicodeString;
begin
  Result := UCS4StringToUnicodeString(UCS4String(
    SfmlTextGetUnicodeString(FHandle)));
end;

procedure TSfmlText.Move(Offset: TSfmlVector2f);
begin
  SfmlTextMove(FHandle, Offset);
end;

procedure TSfmlText.Rotate(Angle: Single);
begin
  SfmlTextRotate(FHandle, Angle);
end;

procedure TSfmlText.Scale(Factors: TSfmlVector2f);
begin
  SfmlTextScale(FHandle, Factors);
end;

procedure TSfmlText.SetCharacterSize(Size: Cardinal);
begin
  SfmlTextSetCharacterSize(FHandle, Size);
end;

procedure TSfmlText.SetColor(Color: TSfmlColor);
begin
  SfmlTextSetColor(FHandle, Color);
end;

procedure TSfmlText.SetFillColor(Color: TSfmlColor);
begin
  SfmlTextSetFillColor(FHandle, Color);
end;

procedure TSfmlText.SetFont(const Font: PSfmlFont);
begin
  SfmlTextSetFont(FHandle, Font);
end;

procedure TSfmlText.SetOrigin(Origin: TSfmlVector2f);
begin
  SfmlTextSetOrigin(FHandle, Origin);
end;

procedure TSfmlText.SetOutlineColor(Color: TSfmlColor);
begin
  SfmlTextSetOutlineColor(FHandle, Color);
end;

procedure TSfmlText.SetOutlineThickness(Thickness: Single);
begin
  SfmlTextSetOutlineThickness(FHandle, Thickness);
end;

procedure TSfmlText.SetPosition(Position: TSfmlVector2f);
begin
  SfmlTextSetPosition(FHandle, Position);
end;

procedure TSfmlText.SetRotation(Angle: Single);
begin
  SfmlTextSetRotation(FHandle, Angle);
end;

procedure TSfmlText.SetScale(Scale: TSfmlVector2f);
begin
  SfmlTextSetScale(FHandle, Scale);
end;

procedure TSfmlText.SetString(const &String: AnsiString);
begin
  SfmlTextSetString(FHandle, PAnsiChar(&String));
end;

procedure TSfmlText.SetStyle(Style: Cardinal);
begin
  SfmlTextSetStyle(FHandle, Style);
end;

procedure TSfmlText.SetUnicodeString(const &String: UnicodeString);
begin
  SfmlTextSetUnicodeString(FHandle, PUCS4Char(UnicodeStringToUCS4String(&String)));
end;


{ TSfmlTexture }

constructor TSfmlTexture.Create(Width, Height: Cardinal);
begin
  FHandle := SfmlTextureCreate(Width, Height);
end;

constructor TSfmlTexture.Create(const Image: PSfmlImage;
  const Area: PSfmlIntRect = nil);
begin
  FHandle := SfmlTextureCreateFromImage(Image, Area);
end;

constructor TSfmlTexture.Create(Stream: PSfmlInputStream;
  const Area: PSfmlIntRect = nil);
begin
  FHandle := SfmlTextureCreateFromStream(Stream, Area);
end;

constructor TSfmlTexture.Create(const FileName: AnsiString;
  const Area: PSfmlIntRect = nil);
begin
  FHandle := SfmlTextureCreateFromFile(PAnsiChar(FileName), Area);
end;

constructor TSfmlTexture.Create(const Data: Pointer; SizeInBytes: NativeUInt;
  const Area: PSfmlIntRect = nil);
begin
  FHandle := SfmlTextureCreateFromMemory(Data, SizeInBytes, Area);
end;

constructor TSfmlTexture.Create(Handle: PSfmlTexture);
begin
  FHandle := Handle;
end;

destructor TSfmlTexture.Destroy;
begin
  SfmlTextureDestroy(FHandle);
  inherited;
end;

procedure TSfmlTexture.Bind;
begin
  SfmlTextureBind(FHandle);
end;

function TSfmlTexture.Copy: TSfmlTexture;
begin
  Result := TSfmlTexture.Create(SfmlTextureCopy(FHandle));
end;

function TSfmlTexture.CopyToImage: TSfmlImage;
begin
  Result := TSfmlImage.Create(SfmlTextureCopyToImage(FHandle));
end;

function TSfmlTexture.GetSize: TSfmlVector2u;
begin
  Result := SfmlTextureGetSize(FHandle);
end;

procedure TSfmlTexture.GenerateMipmap;
begin
  SfmlTextureGenerateMipmap(FHandle);
end;

function TSfmlTexture.GetNativeHandle: Cardinal;
begin
  Result := SfmlTextureGetNativeHandle(FHandle);
end;

function TSfmlTexture.GetRepeated: Boolean;
begin
  Result := SfmlTextureIsRepeated(FHandle);
end;

function TSfmlTexture.GetSmooth: Boolean;
begin
  Result := SfmlTextureIsSmooth(FHandle);
end;

function TSfmlTexture.IsSrgb: Boolean;
begin
  Result := SfmlTextureIsSrgb(FHandle);
end;

procedure TSfmlTexture.SetRepeated(Repeated: Boolean);
begin
  SfmlTextureSetRepeated(FHandle, Repeated);
end;

procedure TSfmlTexture.SetSmooth(Smooth: Boolean);
begin
  SfmlTextureSetSmooth(FHandle, Smooth);
end;

procedure TSfmlTexture.SetSrgb(Smooth: Boolean);
begin
  SfmlTextureSetSrgb(FHandle, Smooth);
end;

procedure TSfmlTexture.UpdateFromImage(const Image: PSfmlImage; X, Y: Cardinal);
begin
  SfmlTextureUpdateFromImage(FHandle, Image, X, Y);
end;

procedure TSfmlTexture.UpdateFromImage(const Image: TSfmlImage; X, Y: Cardinal);
begin
  SfmlTextureUpdateFromImage(FHandle, Image.Handle, X, Y);
end;

procedure TSfmlTexture.UpdateFromPixels(const Pixels: PByte; Width, Height, X,
  Y: Cardinal);
begin
  SfmlTextureUpdateFromPixels(FHandle, Pixels, Width, Height, X, Y);
end;

procedure TSfmlTexture.UpdateFromRenderWindow(
  const RenderWindow: PSfmlRenderWindow; X, Y: Cardinal);
begin
  SfmlTextureUpdateFromRenderWindow(FHandle, RenderWindow, X, Y);
end;

procedure TSfmlTexture.UpdateFromWindow(const Window: PSfmlWindow; X,
  Y: Cardinal);
begin
  SfmlTextureUpdateFromWindow(FHandle, Window, X, Y);
end;


{ TSfmlTransformable }

constructor TSfmlTransformable.Create;
begin
  FHandle := SfmlTransformableCreate;
end;

constructor TSfmlTransformable.Create(Handle: PSfmlTransformable);
begin
  FHandle := Handle;
end;

destructor TSfmlTransformable.Destroy;
begin
  SfmlTransformableDestroy(FHandle);
  inherited;
end;

function TSfmlTransformable.Copy: TSfmlTransformable;
begin
  Result := TSfmlTransformable.Create(SfmlTransformableCopy(FHandle));
end;

function TSfmlTransformable.GetInverseTransform: TSfmlTransform;
begin
  Result := SfmlTransformableGetInverseTransform(FHandle);
end;

function TSfmlTransformable.GetOrigin: TSfmlVector2f;
begin
  Result := SfmlTransformableGetOrigin(FHandle);
end;

function TSfmlTransformable.GetPosition: TSfmlVector2f;
begin
  Result := SfmlTransformableGetPosition(FHandle);
end;

function TSfmlTransformable.GetRotation: Single;
begin
  Result := SfmlTransformableGetRotation(FHandle);
end;

function TSfmlTransformable.GetScale: TSfmlVector2f;
begin
  Result := SfmlTransformableGetScale(FHandle);
end;

function TSfmlTransformable.GetTransform: TSfmlTransform;
begin
  Result := SfmlTransformableGetTransform(FHandle);
end;

procedure TSfmlTransformable.Move(X, Y: Single);
begin
  Move(SfmlVector2f(X, Y));
end;

procedure TSfmlTransformable.Move(Offset: TSfmlVector2f);
begin
  SfmlTransformableMove(FHandle, Offset);
end;

procedure TSfmlTransformable.Rotate(Angle: Single);
begin
  SfmlTransformableRotate(FHandle, Angle);
end;

procedure TSfmlTransformable.Scale(Factors: TSfmlVector2f);
begin
  SfmlTransformableScale(FHandle, Factors);
end;

procedure TSfmlTransformable.Scale(X, Y: Single);
begin
  Scale(SfmlVector2f(X, Y));
end;

procedure TSfmlTransformable.SetOrigin(Origin: TSfmlVector2f);
begin
  SfmlTransformableSetOrigin(FHandle, Origin);
end;

procedure TSfmlTransformable.SetPosition(Position: TSfmlVector2f);
begin
  SfmlTransformableSetPosition(FHandle, Position);
end;

procedure TSfmlTransformable.SetRotation(Angle: Single);
begin
  SfmlTransformableSetRotation(FHandle, Angle);
end;

procedure TSfmlTransformable.SetScale(Scale: TSfmlVector2f);
begin
  SfmlTransformableSetScale(FHandle, Scale);
end;


{ TSfmlVertexArray }

constructor TSfmlVertexArray.Create;
begin
  FHandle := SfmlVertexArrayCreate;
end;

constructor TSfmlVertexArray.Create(Handle: PSfmlVertexArray);
begin
  FHandle := Handle;
end;

destructor TSfmlVertexArray.Destroy;
begin
  SfmlVertexArrayDestroy(FHandle);
  inherited;
end;

procedure TSfmlVertexArray.Append(Vertex: TSfmlVertex);
begin
  SfmlVertexArrayAppend(FHandle, Vertex);
end;

procedure TSfmlVertexArray.Clear;
begin
  SfmlVertexArrayClear(FHandle);
end;

function TSfmlVertexArray.Copy: TSfmlVertexArray;
begin
  Result := TSfmlVertexArray.Create(SfmlVertexArrayCopy(FHandle));
end;

function TSfmlVertexArray.GetBounds: TSfmlFloatRect;
begin
  Result := SfmlVertexArrayGetBounds(FHandle);
end;

function TSfmlVertexArray.GetPrimitiveType: TSfmlPrimitiveType;
begin
  Result := SfmlVertexArrayGetPrimitiveType(FHandle);
end;

function TSfmlVertexArray.GetVertex(Index: NativeUInt): PSfmlVertex;
begin
  Result := SfmlVertexArrayGetVertex(FHandle, Index);
end;

function TSfmlVertexArray.GetVertexCount: NativeUInt;
begin
  Result := SfmlVertexArrayGetVertexCount(FHandle);
end;

procedure TSfmlVertexArray.Resize(VertexCount: NativeUInt);
begin
  SfmlVertexArrayResize(FHandle, VertexCount);
end;

procedure TSfmlVertexArray.SetPrimitiveType(&Type: TSfmlPrimitiveType);
begin
  SfmlVertexArraySetPrimitiveType(FHandle, &Type);
end;


{ TSfmlView }

constructor TSfmlView.Create;
begin
  FHandle := SfmlViewCreate;
end;

constructor TSfmlView.Create(Rectangle: TSfmlFloatRect);
begin
  FHandle := SfmlViewCreate;
end;

constructor TSfmlView.Create(Handle: PSfmlView);
begin
  FHandle := Handle;
end;

destructor TSfmlView.Destroy;
begin
  SfmlViewDestroy(FHandle);
  inherited;
end;

function TSfmlView.Copy: TSfmlView;
begin
  Result := TSfmlView.Create(SfmlViewCopy(FHandle));
end;

function TSfmlView.GetCenter: TSfmlVector2f;
begin
  Result := SfmlViewGetCenter(FHandle);
end;

function TSfmlView.GetRotation: Single;
begin
  Result := SfmlViewGetRotation(FHandle);
end;

function TSfmlView.GetSize: TSfmlVector2f;
begin
  Result := SfmlViewGetSize(FHandle);
end;

function TSfmlView.GetViewport: TSfmlFloatRect;
begin
  Result := SfmlViewGetViewport(FHandle);
end;

procedure TSfmlView.Move(Offset: TSfmlVector2f);
begin
  SfmlViewMove(FHandle, Offset);
end;

procedure TSfmlView.Reset(Rectangle: TSfmlFloatRect);
begin
  SfmlViewReset(FHandle, Rectangle);
end;

procedure TSfmlView.Rotate(Angle: Single);
begin
  SfmlViewRotate(FHandle, Angle);
end;

procedure TSfmlView.SetCenter(Center: TSfmlVector2f);
begin
  SfmlViewSetCenter(FHandle, Center);
end;

procedure TSfmlView.SetRotation(Angle: Single);
begin
  SfmlViewSetRotation(FHandle, Angle);
end;

procedure TSfmlView.SetSize(Size: TSfmlVector2f);
begin
  SfmlViewSetSize(FHandle, Size);
end;

procedure TSfmlView.SetViewport(Viewport: TSfmlFloatRect);
begin
  SfmlViewSetViewport(FHandle, Viewport);
end;

procedure TSfmlView.Zoom(Factor: Single);
begin
  SfmlViewZoom(FHandle, Factor);
end;

{$IFDEF DynLink}
var
  CSfmlGraphicsHandle: {$IFDEF FPC}TLibHandle{$ELSE}HINST{$ENDIF};
{$IFDEF INT64RETURNWORKAROUND}
  sfCircleShape_getPoint: function (const Shape: PSfmlCircleShape; Index: NativeUInt): Int64; cdecl;
  sfCircleShape_getPosition: function (const Shape: PSfmlCircleShape): Int64; cdecl;
  sfCircleShape_getOrigin: function (const Shape: PSfmlCircleShape): Int64; cdecl;
  sfCircleShape_getScale: function (const Shape: PSfmlCircleShape): Int64; cdecl;
  sfConvexShape_getOrigin: function (const Shape: PSfmlConvexShape): Int64; cdecl;
  sfConvexShape_getPoint: function (const Shape: PSfmlConvexShape; Index: NativeUInt): Int64; cdecl;
  sfConvexShape_getPosition: function (const Shape: PSfmlConvexShape): Int64; cdecl;
  sfConvexShape_getScale: function (const Shape: PSfmlConvexShape): Int64; cdecl;
  sfImage_getSize: function (const Image: PSfmlImage): Int64; cdecl;
  sfRectangleShape_getOrigin: function (const Shape: PSfmlRectangleShape): Int64; cdecl;
  sfRectangleShape_getPoint: function (const Shape: PSfmlRectangleShape; Index: NativeUInt): Int64; cdecl;
  sfRectangleShape_getPosition: function (const Shape: PSfmlRectangleShape): Int64; cdecl;
  sfRectangleShape_getScale: function (const Shape: PSfmlRectangleShape): Int64; cdecl;
  sfRectangleShape_getSize: function (const Shape: PSfmlRectangleShape): Int64; cdecl;
  sfRenderTexture_getSize: function(const RenderTexture: PSfmlRenderTexture): Int64; cdecl;
  sfRenderTexture_mapPixelToCoords: function (const RenderTexture: PSfmlRenderTexture; Point: TSfmlVector2i; const View: PSfmlView): Int64; cdecl;
  sfRenderTexture_mapCoordsToPixel: function (const RenderTexture: PSfmlRenderTexture; Point: TSfmlVector2i; const View: PSfmlView): Int64; cdecl;
  sfRenderWindow_getSize: function(const RenderWindow: PSfmlRenderWindow): Int64; cdecl;
  sfRenderWindow_mapPixelToCoords: function (const RenderWindow: PSfmlRenderWindow; Point: TSfmlVector2i; const View: PSfmlView): Int64; cdecl;
  sfRenderWindow_mapCoordsToPixel: function (const RenderWindow: PSfmlRenderWindow; Point: TSfmlVector2i; const View: PSfmlView): Int64; cdecl;
  sfMouse_getPositionRenderWindow: function (const RelativeTo: PSfmlRenderWindow): Int64; cdecl;
  sfTouch_getPositionRenderWindow: function (Finger: Cardinal; const RelativeTo: PSfmlRenderWindow): Int64; cdecl;
  sfShape_getOrigin: function (const Shape: PSfmlShape): Int64; cdecl;
  sfShape_getPoint: function (const Shape: PSfmlShape; Index: NativeUInt): Int64; cdecl;
  sfShape_getPosition: function (const Shape: PSfmlShape): Int64; cdecl;
  sfShape_getScale: function (const Shape: PSfmlShape): Int64; cdecl;
  sfSprite_getOrigin: function (const Sprite: PSfmlSprite): Int64; cdecl;
  sfSprite_getPosition: function (const Sprite: PSfmlSprite): Int64; cdecl;
  sfSprite_getScale: function (const Sprite: PSfmlSprite): Int64; cdecl;
  sfText_findCharacterPos: function (const Text: PSfmlText; Index: NativeUInt): Int64; cdecl;
  sfText_getOrigin: function (const Text: PSfmlText): Int64; cdecl;
  sfText_getPosition: function (const Text: PSfmlText): Int64; cdecl;
  sfText_getScale: function (const Text: PSfmlText): Int64; cdecl;
  sfTexture_getSize: function (const Texture: PSfmlTexture): Int64; cdecl;
  sfTransform_transformPoint: function (const Transform: PSfmlTransform; Point: TSfmlVector2f): Int64; cdecl;
  sfTransformable_getOrigin: function (const Transformable: PSfmlTransformable): Int64; cdecl;
  sfTransformable_getPosition: function (const Transformable: PSfmlTransformable): Int64; cdecl;
  sfTransformable_getScale: function (const Transformable: PSfmlTransformable): Int64; cdecl;
  sfView_getCenter: function (const View: PSfmlView): Int64; cdecl;
  sfView_getSize: function (const View: PSfmlView): Int64; cdecl;
{$ENDIF}

procedure InitDLL;

  function BindFunction(Name: AnsiString): Pointer;
  begin
    Result := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar(Name));
    Assert(Assigned(Result));
  end;

begin
  // dynamically load external library
  {$IFDEF FPC}
  CSfmlGraphicsHandle := LoadLibrary(CSfmlGraphicsLibrary);
  {$ELSE}
  CSfmlGraphicsHandle := LoadLibraryA(CSfmlGraphicsLibrary);
  {$ENDIF}

  if CSfmlGraphicsHandle <> 0 then
    try
      Move(GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfBlendAlpha'))^, SfmlBlendAlpha, SizeOf(TSfmlBlendMode));
      Move(GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfBlendAdd'))^, SfmlBlendAdd, SizeOf(TSfmlBlendMode));
      Move(GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfBlendMultiply'))^, SfmlBlendMultiply, SizeOf(TSfmlBlendMode));
      Move(GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfBlendNone'))^, SfmlBlendNone, SizeOf(TSfmlBlendMode));

      Move(GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfBlack'))^, SfmlBlack, SizeOf(TSfmlColor));
      Move(GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfWhite'))^, SfmlWhite, SizeOf(TSfmlColor));
      Move(GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRed'))^, SfmlRed, SizeOf(TSfmlColor));
      Move(GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfGreen'))^, SfmlGreen, SizeOf(TSfmlColor));
      Move(GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfBlue'))^, SfmlBlue, SizeOf(TSfmlColor));
      Move(GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfYellow'))^, SfmlYellow, SizeOf(TSfmlColor));
      Move(GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfMagenta'))^, SfmlMagenta, SizeOf(TSfmlColor));
      Move(GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfCyan'))^, SfmlCyan, SizeOf(TSfmlColor));
      Move(GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfTransparent'))^, SfmlTransparent, SizeOf(TSfmlColor));

      Move(GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfTransform_Identity'))^, SfmlTransformIdentity, SizeOf(TSfmlTransform));

      SfmlColorFromRGB := BindFunction('sfColor_fromRGB');
      SfmlColorFromRGBA := BindFunction('sfColor_fromRGBA');
      SfmlColorFromInteger := BindFunction('sfColor_fromInteger');
      SfmlColorToInteger := BindFunction('sfColor_toInteger');
      SfmlColorAdd := BindFunction('sfColor_add');
      SfmlColorSubtract := BindFunction('sfColor_subtract');
      SfmlColorModulate := BindFunction('sfColor_modulate');
      SfmlCircleShapeCreate := BindFunction('sfCircleShape_create');
      SfmlCircleShapeCopy := BindFunction('sfCircleShape_copy');
      SfmlCircleShapeDestroy := BindFunction('sfCircleShape_destroy');
      SfmlCircleShapeSetPosition := BindFunction('sfCircleShape_setPosition');
      SfmlCircleShapeSetRotation := BindFunction('sfCircleShape_setRotation');
      SfmlCircleShapeSetScale := BindFunction('sfCircleShape_setScale');
      SfmlCircleShapeSetOrigin := BindFunction('sfCircleShape_setOrigin');
      SfmlCircleShapeGetRotation := BindFunction('sfCircleShape_getRotation');
      SfmlCircleShapeMove := BindFunction('sfCircleShape_move');
      SfmlCircleShapeRotate := BindFunction('sfCircleShape_rotate');
      SfmlCircleShapeScale := BindFunction('sfCircleShape_scale');
      SfmlCircleShapeGetTransform := BindFunction('sfCircleShape_getTransform');
      SfmlCircleShapeGetInverseTransform := BindFunction('sfCircleShape_getInverseTransform');
      SfmlCircleShapeSetTexture := BindFunction('sfCircleShape_setTexture');
      SfmlCircleShapeSetTextureRect := BindFunction('sfCircleShape_setTextureRect');
      SfmlCircleShapeSetFillColor := BindFunction('sfCircleShape_setFillColor');
      SfmlCircleShapeSetOutlineColor := BindFunction('sfCircleShape_setOutlineColor');
      SfmlCircleShapeSetOutlineThickness := BindFunction('sfCircleShape_setOutlineThickness');
      SfmlCircleShapeGetTexture := BindFunction('sfCircleShape_getTexture');
      SfmlCircleShapeGetTextureRect := BindFunction('sfCircleShape_getTextureRect');
      SfmlCircleShapeGetFillColor := BindFunction('sfCircleShape_getFillColor');
      SfmlCircleShapeGetOutlineColor := BindFunction('sfCircleShape_getOutlineColor');
      SfmlCircleShapeGetOutlineThickness := BindFunction('sfCircleShape_getOutlineThickness');
      SfmlCircleShapeGetPointCount := BindFunction('sfCircleShape_getPointCount');
      SfmlCircleShapeSetRadius := BindFunction('sfCircleShape_setRadius');
      SfmlCircleShapeGetRadius := BindFunction('sfCircleShape_getRadius');
      SfmlCircleShapeSetPointCount := BindFunction('sfCircleShape_setPointCount');
      SfmlCircleShapeGetLocalBounds := BindFunction('sfCircleShape_getLocalBounds');
      SfmlCircleShapeGetGlobalBounds := BindFunction('sfCircleShape_getGlobalBounds');
      SfmlConvexShapeCreate:= BindFunction('sfConvexShape_create');
      SfmlConvexShapeCopy := BindFunction('sfConvexShape_copy');
      SfmlConvexShapeDestroy := BindFunction('sfConvexShape_destroy');
      SfmlConvexShapeSetPosition := BindFunction('sfConvexShape_setPosition');
      SfmlConvexShapeSetRotation := BindFunction('sfConvexShape_setRotation');
      SfmlConvexShapeSetScale := BindFunction('sfConvexShape_setScale');
      SfmlConvexShapeSetOrigin := BindFunction('sfConvexShape_setOrigin');
      SfmlConvexShapeGetRotation := BindFunction('sfConvexShape_getRotation');

      SfmlConvexShapeMove := BindFunction('sfConvexShape_move');
      SfmlConvexShapeRotate := BindFunction('sfConvexShape_rotate');
      SfmlConvexShapeScale := BindFunction('sfConvexShape_scale');
      SfmlConvexShapeGetTransform := BindFunction('sfConvexShape_getTransform');
      SfmlConvexShapeGetInverseTransform := BindFunction('sfConvexShape_getInverseTransform');
      SfmlConvexShapeSetTexture := BindFunction('sfConvexShape_setTexture');
      SfmlConvexShapeSetTextureRect := BindFunction('sfConvexShape_setTextureRect');
      SfmlConvexShapeSetFillColor := BindFunction('sfConvexShape_setFillColor');
      SfmlConvexShapeSetOutlineColor := BindFunction('sfConvexShape_setOutlineColor');
      SfmlConvexShapeSetOutlineThickness := BindFunction('sfConvexShape_setOutlineThickness');
      SfmlConvexShapeGetTexture := BindFunction('sfConvexShape_getTexture');
      SfmlConvexShapeGetTextureRect := BindFunction('sfConvexShape_getTextureRect');
      SfmlConvexShapeGetFillColor := BindFunction('sfConvexShape_getFillColor');
      SfmlConvexShapeGetOutlineColor := BindFunction('sfConvexShape_getOutlineColor');
      SfmlConvexShapeGetOutlineThickness := BindFunction('sfConvexShape_getOutlineThickness');
      SfmlConvexShapeGetPointCount := BindFunction('sfConvexShape_getPointCount');
      SfmlConvexShapeSetPointCount := BindFunction('sfConvexShape_setPointCount');
      SfmlConvexShapeSetPoint := BindFunction('sfConvexShape_setPoint');
      SfmlConvexShapeGetLocalBounds := BindFunction('sfConvexShape_getLocalBounds');
      SfmlConvexShapeGetGlobalBounds := BindFunction('sfConvexShape_getGlobalBounds');
      SfmlFontCreateFromFile := BindFunction('sfFont_createFromFile');
      SfmlFontCreateFromMemory := BindFunction('sfFont_createFromMemory');
      SfmlFontCreateFromStream := BindFunction('sfFont_createFromStream');
      SfmlFontCopy := BindFunction('sfFont_copy');
      SfmlFontDestroy := BindFunction('sfFont_destroy');
      SfmlFontGetGlyph := BindFunction('sfFont_getGlyph');
      SfmlFontGetKerning := BindFunction('sfFont_getKerning');
      SfmlFontGetLineSpacing := BindFunction('sfFont_getLineSpacing');
      SfmlFontGetUnderlinePosition := BindFunction('sfFont_getUnderlinePosition');
      SfmlFontGetUnderlineThickness := BindFunction('sfFont_getUnderlineThickness');
      SfmlFontGetTexture := BindFunction('sfFont_getTexture');
      SfmlFontGetInfo := BindFunction('sfFont_getInfo');
      SfmlImageCreate := BindFunction('sfImage_create');
      SfmlImageCreateFromColor := BindFunction('sfImage_createFromColor');
      SfmlImageCreateFromPixels := BindFunction('sfImage_createFromPixels');
      SfmlImageCreateFromFile := BindFunction('sfImage_createFromFile');
      SfmlImageCreateFromMemory := BindFunction('sfImage_createFromMemory');
      SfmlImageCreateFromStream := BindFunction('sfImage_createFromStream');
      SfmlImageCopy := BindFunction('sfImage_copy');
      SfmlImageDestroy := BindFunction('sfImage_destroy');
      SfmlImageSaveToFile := BindFunction('sfImage_saveToFile');
      SfmlImageCreateMaskFromColor := BindFunction('sfImage_createMaskFromColor');
      SfmlImageCopyImage := BindFunction('sfImage_copyImage');
      SfmlImageSetPixel := BindFunction('sfImage_setPixel');
      SfmlImageGetPixel := BindFunction('sfImage_getPixel');
      SfmlImageGetPixelsPtr := BindFunction('sfImage_getPixelsPtr');
      SfmlImageFlipHorizontally := BindFunction('sfImage_flipHorizontally');
      SfmlImageFlipVertically := BindFunction('sfImage_flipVertically');
      SfmlFloatRectContains := BindFunction('sfFloatRect_contains');
      SfmlIntRectContains := BindFunction('sfIntRect_contains');
      SfmlFloatRectIntersects := BindFunction('sfFloatRect_intersects');
      SfmlIntRectIntersects := BindFunction('sfIntRect_intersects');
      SfmlRectangleShapeCreate := BindFunction('sfRectangleShape_create');
      SfmlRectangleShapeCopy := BindFunction('sfRectangleShape_copy');
      SfmlRectangleShapeDestroy := BindFunction('sfRectangleShape_destroy');
      SfmlRectangleShapeSetPosition := BindFunction('sfRectangleShape_setPosition');
      SfmlRectangleShapeSetRotation := BindFunction('sfRectangleShape_setRotation');
      SfmlRectangleShapeSetScale := BindFunction('sfRectangleShape_setScale');
      SfmlRectangleShapeSetOrigin := BindFunction('sfRectangleShape_setOrigin');
      SfmlRectangleShapeGetRotation := BindFunction('sfRectangleShape_getRotation');
      SfmlRectangleShapeMove := BindFunction('sfRectangleShape_move');
      SfmlRectangleShapeRotate := BindFunction('sfRectangleShape_rotate');
      SfmlRectangleShapeScale := BindFunction('sfRectangleShape_scale');
      SfmlRectangleShapeGetTransform := BindFunction('sfRectangleShape_getTransform');
      SfmlRectangleShapeGetInverseTransform := BindFunction('sfRectangleShape_getInverseTransform');
      SfmlRectangleShapeSetTexture := BindFunction('sfRectangleShape_setTexture');
      SfmlRectangleShapeSetTextureRect := BindFunction('sfRectangleShape_setTextureRect');
      SfmlRectangleShapeSetFillColor := BindFunction('sfRectangleShape_setFillColor');
      SfmlRectangleShapeSetOutlineColor := BindFunction('sfRectangleShape_setOutlineColor');
      SfmlRectangleShapeSetOutlineThickness := BindFunction('sfRectangleShape_setOutlineThickness');
      SfmlRectangleShapeGetTexture := BindFunction('sfRectangleShape_getTexture');
      SfmlRectangleShapeGetTextureRect := BindFunction('sfRectangleShape_getTextureRect');
      SfmlRectangleShapeGetFillColor := BindFunction('sfRectangleShape_getFillColor');
      SfmlRectangleShapeGetOutlineColor := BindFunction('sfRectangleShape_getOutlineColor');
      SfmlRectangleShapeGetOutlineThickness := BindFunction('sfRectangleShape_getOutlineThickness');
      SfmlRectangleShapeGetPointCount := BindFunction('sfRectangleShape_getPointCount');
      SfmlRectangleShapeSetSize := BindFunction('sfRectangleShape_setSize');
      SfmlRectangleShapeGetLocalBounds := BindFunction('sfRectangleShape_getLocalBounds');
      SfmlRectangleShapeGetGlobalBounds := BindFunction('sfRectangleShape_getGlobalBounds');
      SfmlRenderTextureCreate := BindFunction('sfRenderTexture_create');
      SfmlRenderTextureDestroy := BindFunction('sfRenderTexture_destroy');
      SfmlRenderTextureSetActive := BindFunction('sfRenderTexture_setActive');
      SfmlRenderTextureDisplay := BindFunction('sfRenderTexture_display');
      SfmlRenderTextureClear := BindFunction('sfRenderTexture_clear');
      SfmlRenderTextureSetView := BindFunction('sfRenderTexture_setView');
      SfmlRenderTextureGetView := BindFunction('sfRenderTexture_getView');
      SfmlRenderTextureGetDefaultView := BindFunction('sfRenderTexture_getDefaultView');
      SfmlRenderTextureGetViewport := BindFunction('sfRenderTexture_getViewport');
      SfmlRenderTextureDrawSprite := BindFunction('sfRenderTexture_drawSprite');
      SfmlRenderTextureDrawText := BindFunction('sfRenderTexture_drawText');
      SfmlRenderTextureDrawShape := BindFunction('sfRenderTexture_drawShape');
      SfmlRenderTextureDrawCircleShape := BindFunction('sfRenderTexture_drawCircleShape');
      SfmlRenderTextureDrawConvexShape := BindFunction('sfRenderTexture_drawConvexShape');
      SfmlRenderTextureDrawRectangleShape := BindFunction('sfRenderTexture_drawRectangleShape');
      SfmlRenderTextureDrawVertexArray := BindFunction('sfRenderTexture_drawVertexArray');
      SfmlRenderTextureDrawPrimitives := BindFunction('sfRenderTexture_drawPrimitives');
      SfmlRenderTexturePushGLStates := BindFunction('sfRenderTexture_pushGLStates');
      SfmlRenderTexturePopGLStates := BindFunction('sfRenderTexture_popGLStates');
      SfmlRenderTextureResetGLStates := BindFunction('sfRenderTexture_resetGLStates');
      SfmlRenderTextureGetTexture := BindFunction('sfRenderTexture_getTexture');
      SfmlRenderTextureSetSmooth := BindFunction('sfRenderTexture_setSmooth');
      SfmlRenderTextureIsSmooth := BindFunction('sfRenderTexture_isSmooth');
      SfmlRenderTextureSetRepeated := BindFunction('sfRenderTexture_setRepeated');
      SfmlRenderTextureIsRepeated := BindFunction('sfRenderTexture_isRepeated');
      SfmlRenderTextureGenerateMipmap := BindFunction('sfRenderTexture_generateMipmap');
      SfmlRenderWindowCreate := BindFunction('sfRenderWindow_create');
      SfmlRenderWindowCreateUnicode := BindFunction('sfRenderWindow_createUnicode');
      SfmlRenderWindowCreateFromHandle := BindFunction('sfRenderWindow_createFromHandle');
      SfmlRenderWindowDestroy := BindFunction('sfRenderWindow_destroy');
      SfmlRenderWindowClose := BindFunction('sfRenderWindow_close');
      SfmlRenderWindowIsOpen := BindFunction('sfRenderWindow_isOpen');
      SfmlRenderWindowGetSettings := BindFunction('sfRenderWindow_getSettings');
      SfmlRenderWindowPollEvent := BindFunction('sfRenderWindow_pollEvent');
      SfmlRenderWindowWaitEvent := BindFunction('sfRenderWindow_waitEvent');
      SfmlRenderWindowGetPosition := BindFunction('sfRenderWindow_getPosition');
      SfmlRenderWindowSetPosition := BindFunction('sfRenderWindow_setPosition');
      SfmlRenderWindowSetSize := BindFunction('sfRenderWindow_setSize');
      SfmlRenderWindowSetTitle := BindFunction('sfRenderWindow_setTitle');
      SfmlRenderWindowSetUnicodeTitle := BindFunction('sfRenderWindow_setUnicodeTitle');
      SfmlRenderWindowSetIcon := BindFunction('sfRenderWindow_setIcon');
      SfmlRenderWindowSetVisible := BindFunction('sfRenderWindow_setVisible');
      SfmlRenderWindowSetVerticalSyncEnabled := BindFunction('sfRenderWindow_setVerticalSyncEnabled');
      SfmlRenderWindowSetMouseCursorGrabbed := BindFunction('sfRenderWindow_setMouseCursorGrabbed');
      SfmlRenderWindowSetKeyRepeatEnabled := BindFunction('sfRenderWindow_setKeyRepeatEnabled');
      SfmlRenderWindowSetFramerateLimit := BindFunction('sfRenderWindow_setFramerateLimit');
      SfmlRenderWindowSetJoystickThreshold := BindFunction('sfRenderWindow_setJoystickThreshold');
      SfmlRenderWindowSetActive := BindFunction('sfRenderWindow_setActive');
      SfmlRenderWindowRequestFocus := BindFunction('sfRenderWindow_requestFocus');
      SfmlRenderWindowHasFocus := BindFunction('sfRenderWindow_hasFocus');
      SfmlRenderWindowDisplay := BindFunction('sfRenderWindow_display');
      SfmlRenderWindowGetSystemHandle := BindFunction('sfRenderWindow_getSystemHandle');
      SfmlRenderWindowClear := BindFunction('sfRenderWindow_clear');
      SfmlRenderWindowSetView := BindFunction('sfRenderWindow_setView');
      SfmlRenderWindowGetView := BindFunction('sfRenderWindow_getView');
      SfmlRenderWindowGetDefaultView := BindFunction('sfRenderWindow_getDefaultView');
      SfmlRenderWindowGetViewport := BindFunction('sfRenderWindow_getViewport');
      SfmlRenderWindowDrawText := BindFunction('sfRenderWindow_drawText');
      SfmlRenderWindowDrawShape := BindFunction('sfRenderWindow_drawShape');
      SfmlRenderWindowDrawCircleShape := BindFunction('sfRenderWindow_drawCircleShape');
      SfmlRenderWindowDrawConvexShape := BindFunction('sfRenderWindow_drawConvexShape');
      SfmlRenderWindowDrawRectangleShape := BindFunction('sfRenderWindow_drawRectangleShape');
      SfmlRenderWindowDrawVertexArray := BindFunction('sfRenderWindow_drawVertexArray');
      SfmlRenderWindowDrawPrimitives := BindFunction('sfRenderWindow_drawPrimitives');
      SfmlRenderWindowDrawSprite := BindFunction('sfRenderWindow_drawSprite');
      SfmlRenderWindowPushGLStates := BindFunction('sfRenderWindow_pushGLStates');
      SfmlRenderWindowPopGLStates := BindFunction('sfRenderWindow_popGLStates');
      SfmlRenderWindowResetGLStates := BindFunction('sfRenderWindow_resetGLStates');
      SfmlRenderWindowCapture := BindFunction('sfRenderWindow_capture');
      SfmlMouseSetPositionRenderWindow := BindFunction('sfMouse_setPositionRenderWindow');
      SfmlShaderCreateFromFile := BindFunction('sfShader_createFromFile');
      SfmlShaderCreateFromMemory := BindFunction('sfShader_createFromMemory');
      SfmlShaderCreateFromStream := BindFunction('sfShader_createFromStream');
      SfmlShaderDestroy := BindFunction('sfShader_destroy');
      SfmlShaderSetFloatUniform := BindFunction('sfShader_setFloatUniform');
      SfmlShaderSetVec2Uniform := BindFunction('sfShader_setVec2Uniform');
      SfmlShaderSetVec3Uniform := BindFunction('sfShader_setVec3Uniform');
      SfmlShaderSetVec4Uniform := BindFunction('sfShader_setVec4Uniform');
      SfmlShaderSetColorUniform := BindFunction('sfShader_setColorUniform');
      SfmlShaderSetIntUniform := BindFunction('sfShader_setIntUniform');
      SfmlShaderSetIvec2Uniform := BindFunction('sfShader_setIvec2Uniform');
      SfmlShaderSetIvec3Uniform := BindFunction('sfShader_setIvec3Uniform');
      SfmlShaderSetIvec4Uniform := BindFunction('sfShader_setIvec4Uniform');
      SfmlShaderSetIntColorUniform := BindFunction('sfShader_setIntColorUniform');
      SfmlShaderSetBoolUniform := BindFunction('sfShader_setBoolUniform');
      SfmlShaderSetBvec2Uniform := BindFunction('sfShader_setBvec2Uniform');
      SfmlShaderSetBvec3Uniform := BindFunction('sfShader_setBvec3Uniform');
      SfmlShaderSetBvec4Uniform := BindFunction('sfShader_setBvec4Uniform');
      SfmlShaderSetMat3Uniform := BindFunction('sfShader_setMat3Uniform');
      SfmlShaderSetMat4Uniform := BindFunction('sfShader_setMat4Uniform');
      SfmlShaderSetTextureUniform := BindFunction('sfShader_setTextureUniform');
      SfmlShaderSetCurrentTextureUniform := BindFunction('sfShader_setCurrentTextureUniform');
      SfmlShaderSetFloatUniformArray := BindFunction('sfShader_setFloatUniformArray');
      SfmlShaderSetVec2UniformArray := BindFunction('sfShader_setVec2UniformArray');
      SfmlShaderSetVec3UniformArray := BindFunction('sfShader_setVec3UniformArray');
      SfmlShaderSetVec4UniformArray := BindFunction('sfShader_setVec4UniformArray');
      SfmlShaderSetMat3UniformArray := BindFunction('sfShader_setMat3UniformArray');
      SfmlShaderSetMat4UniformArray := BindFunction('sfShader_setMat4UniformArray');
      SfmlShadersetFloatParameter := BindFunction('sfShader_setFloatParameter');
      SfmlShaderSetFloat2Parameter := BindFunction('sfShader_setFloat2Parameter');
      SfmlShaderSetFloat3Parameter := BindFunction('sfShader_setFloat3Parameter');
      SfmlShaderSetFloat4Parameter := BindFunction('sfShader_setFloat4Parameter');
      SfmlShaderSetVector2Parameter := BindFunction('sfShader_setVector2Parameter');
      SfmlShaderSetVector3Parameter := BindFunction('sfShader_setVector3Parameter');
      SfmlShaderSetColorParameter := BindFunction('sfShader_setColorParameter');
      SfmlShaderSetTransformParameter := BindFunction('sfShader_setTransformParameter');
      SfmlShaderSetTextureParameter := BindFunction('sfShader_setTextureParameter');
      SfmlShaderSetCurrentTextureParameter := BindFunction('sfShader_setCurrentTextureParameter');
      SfmlShaderGetNativeHandle := BindFunction('sfShader_getNativeHandle');
      SfmlShaderBind := BindFunction('sfShader_bind');
      SfmlShaderIsAvailable := BindFunction('sfShader_isAvailable');
      SfmlShaderIsGeometryAvailable := BindFunction('sfShader_isGeometryAvailable');
      SfmlShapeCreate := BindFunction('sfShape_create');
      SfmlShapeDestroy := BindFunction('sfShape_destroy');
      SfmlShapeSetPosition := BindFunction('sfShape_setPosition');
      SfmlShapeSetRotation := BindFunction('sfShape_setRotation');
      SfmlShapeSetScale := BindFunction('sfShape_setScale');
      SfmlShapeSetOrigin := BindFunction('sfShape_setOrigin');
      SfmlShapeGetRotation := BindFunction('sfShape_getRotation');
      SfmlShapeMove := BindFunction('sfShape_move');
      SfmlShapeRotate := BindFunction('sfShape_rotate');
      SfmlShapeScale := BindFunction('sfShape_scale');
      SfmlShapeGetTransform := BindFunction('sfShape_getTransform');
      SfmlShapeGetInverseTransform := BindFunction('sfShape_getInverseTransform');
      SfmlShapeSetTexture := BindFunction('sfShape_setTexture');
      SfmlShapeSetTextureRect := BindFunction('sfShape_setTextureRect');
      SfmlShapeSetFillColor := BindFunction('sfShape_setFillColor');
      SfmlShapeSetOutlineColor := BindFunction('sfShape_setOutlineColor');
      SfmlShapeSetOutlineThickness := BindFunction('sfShape_setOutlineThickness');
      SfmlShapeGetTexture := BindFunction('sfShape_getTexture');
      SfmlShapeGetTextureRect := BindFunction('sfShape_getTextureRect');
      SfmlShapeGetFillColor := BindFunction('sfShape_getFillColor');
      SfmlShapeGetOutlineColor := BindFunction('sfShape_getOutlineColor');
      SfmlShapeGetOutlineThickness := BindFunction('sfShape_getOutlineThickness');
      SfmlShapeGetPointCount := BindFunction('sfShape_getPointCount');
      SfmlShapeGetLocalBounds := BindFunction('sfShape_getLocalBounds');
      SfmlShapeGetGlobalBounds := BindFunction('sfShape_getGlobalBounds');
      SfmlShapeUpdate := BindFunction('sfShape_update');
      SfmlSpriteCreate := BindFunction('sfSprite_create');
      SfmlSpriteCopy := BindFunction('sfSprite_copy');
      SfmlSpriteDestroy := BindFunction('sfSprite_destroy');
      SfmlSpriteSetPosition := BindFunction('sfSprite_setPosition');
      SfmlSpriteSetRotation := BindFunction('sfSprite_setRotation');
      SfmlSpriteSetScale := BindFunction('sfSprite_setScale');
      SfmlSpriteSetOrigin := BindFunction('sfSprite_setOrigin');
      SfmlSpriteGetRotation := BindFunction('sfSprite_getRotation');
      SfmlSpriteMove := BindFunction('sfSprite_move');
      SfmlSpriteRotate := BindFunction('sfSprite_rotate');
      SfmlSpriteScale := BindFunction('sfSprite_scale');
      SfmlSpriteGetTransform := BindFunction('sfSprite_getTransform');
      SfmlSpriteGetInverseTransform := BindFunction('sfSprite_getInverseTransform');
      SfmlSpriteSetTexture := BindFunction('sfSprite_setTexture');
      SfmlSpriteSetTextureRect := BindFunction('sfSprite_setTextureRect');
      SfmlSpriteSetColor := BindFunction('sfSprite_setColor');
      SfmlSpriteGetTexture := BindFunction('sfSprite_getTexture');
      SfmlSpriteGetTextureRect := BindFunction('sfSprite_getTextureRect');
      SfmlSpriteGetColor := BindFunction('sfSprite_getColor');
      SfmlSpriteGetLocalBounds := BindFunction('sfSprite_getLocalBounds');
      SfmlSpriteGetGlobalBounds := BindFunction('sfSprite_getGlobalBounds');
      SfmlTextCreate := BindFunction('sfText_create');
      SfmlTextCopy := BindFunction('sfText_copy');
      SfmlTextDestroy := BindFunction('sfText_destroy');
      SfmlTextSetPosition := BindFunction('sfText_setPosition');
      SfmlTextSetRotation := BindFunction('sfText_setRotation');
      SfmlTextSetScale := BindFunction('sfText_setScale');
      SfmlTextSetOrigin := BindFunction('sfText_setOrigin');
      SfmlTextGetRotation := BindFunction('sfText_getRotation');
      SfmlTextMove := BindFunction('sfText_move');
      SfmlTextRotate := BindFunction('sfText_rotate');
      SfmlTextScale := BindFunction('sfText_scale');
      SfmlTextGetTransform := BindFunction('sfText_getTransform');
      SfmlTextGetInverseTransform := BindFunction('sfText_getInverseTransform');
      SfmlTextSetString := BindFunction('sfText_setString');
      SfmlTextSetUnicodeString := BindFunction('sfText_setUnicodeString');
      SfmlTextSetFont := BindFunction('sfText_setFont');
      SfmlTextSetCharacterSize := BindFunction('sfText_setCharacterSize');
      SfmlTextSetStyle := BindFunction('sfText_setStyle');
      SfmlTextSetColor := BindFunction('sfText_setColor');
      SfmlTextSetFillColor := BindFunction('sfText_setFillColor');
      SfmlTextSetOutlineColor := BindFunction('sfText_setOutlineColor');
      SfmlTextGetString := BindFunction('sfText_getString');
      SfmlTextGetUnicodeString := BindFunction('sfText_getUnicodeString');
      SfmlTextGetFont := BindFunction('sfText_getFont');
      SfmlTextGetCharacterSize := BindFunction('sfText_getCharacterSize');
      SfmlTextGetStyle := BindFunction('sfText_getStyle');
      SfmlTextGetColor := BindFunction('sfText_getColor');
      SfmlTextGetLocalBounds := BindFunction('sfText_getLocalBounds');
      SfmlTextGetGlobalBounds := BindFunction('sfText_getGlobalBounds');
      SfmlTextureCreate := BindFunction('sfTexture_create');
      SfmlTextureCreateFromFile := BindFunction('sfTexture_createFromFile');
      SfmlTextureCreateFromMemory := BindFunction('sfTexture_createFromMemory');
      SfmlTextureCreateFromStream := BindFunction('sfTexture_createFromStream');
      SfmlTextureCreateFromImage := BindFunction('sfTexture_createFromImage');
      SfmlTextureCopy := BindFunction('sfTexture_copy');
      SfmlTextureDestroy := BindFunction('sfTexture_destroy');
      SfmlTextureCopyToImage := BindFunction('sfTexture_copyToImage');
      SfmlTextureUpdateFromPixels := BindFunction('sfTexture_updateFromPixels');
      SfmlTextureUpdateFromImage := BindFunction('sfTexture_updateFromImage');
      SfmlTextureUpdateFromWindow := BindFunction('sfTexture_updateFromWindow');
      SfmlTextureUpdateFromRenderWindow := BindFunction('sfTexture_updateFromRenderWindow');
      SfmlTextureSetSmooth := BindFunction('sfTexture_setSmooth');
      SfmlTextureIsSmooth := BindFunction('sfTexture_isSmooth');
      SfmlTextureSetSrgb := BindFunction('sfTexture_setSrgb');
      SfmlTextureIsSrgb := BindFunction('sfTexture_isSrgb');
      SfmlTextureSetRepeated := BindFunction('sfTexture_setRepeated');
      SfmlTextureIsRepeated := BindFunction('sfTexture_isRepeated');
      SfmlTextureGenerateMipmap := BindFunction('sfTexture_generateMipmap');
      SfmlTextureGetNativeHandle := BindFunction('sfTexture_getNativeHandle');
      SfmlTextureBind := BindFunction('sfTexture_bind');
      SfmlTextureGetMaximumSize := BindFunction('sfTexture_getMaximumSize');
      SfmlTransformFromMatrix := BindFunction('sfTransform_fromMatrix');
      SfmlTransformGetMatrix := BindFunction('sfTransform_getMatrix');
      SfmlTransformGetInverse := BindFunction('sfTransform_getInverse');
      SfmlTransformTransformRect := BindFunction('sfTransform_transformRect');
      SfmlTransformCombine := BindFunction('sfTransform_combine');
      SfmlTransformTranslate := BindFunction('sfTransform_translate');
      SfmlTransformRotate := BindFunction('sfTransform_rotate');
      SfmlTransformRotateWithCenter := BindFunction('sfTransform_rotateWithCenter');
      SfmlTransformScale := BindFunction('sfTransform_scale');
      SfmlTransformScaleWithCenter := BindFunction('sfTransform_scaleWithCenter');
      SfmlTransformableCreate := BindFunction('sfTransformable_create');
      SfmlTransformableCopy := BindFunction('sfTransformable_copy');
      SfmlTransformableDestroy := BindFunction('sfTransformable_destroy');
      SfmlTransformableSetPosition := BindFunction('sfTransformable_setPosition');
      SfmlTransformableSetRotation := BindFunction('sfTransformable_setRotation');
      SfmlTransformableSetScale := BindFunction('sfTransformable_setScale');
      SfmlTransformableSetOrigin := BindFunction('sfTransformable_setOrigin');
      SfmlTransformableGetRotation := BindFunction('sfTransformable_getRotation');
      SfmlTransformableMove := BindFunction('sfTransformable_move');
      SfmlTransformableRotate := BindFunction('sfTransformable_rotate');
      SfmlTransformableScale := BindFunction('sfTransformable_scale');
      SfmlTransformableGetTransform := BindFunction('sfTransformable_getTransform');
      SfmlTransformableGetInverseTransform := BindFunction('sfTransformable_getInverseTransform');
      SfmlVertexArrayCreate := BindFunction('sfVertexArray_create');
      SfmlVertexArrayCopy := BindFunction('sfVertexArray_copy');
      SfmlVertexArrayDestroy := BindFunction('sfVertexArray_destroy');
      SfmlVertexArrayGetVertexCount := BindFunction('sfVertexArray_getVertexCount');
      SfmlVertexArrayGetVertex := BindFunction('sfVertexArray_getVertex');
      SfmlVertexArrayClear := BindFunction('sfVertexArray_clear');
      SfmlVertexArrayResize := BindFunction('sfVertexArray_resize');
      SfmlVertexArrayAppend := BindFunction('sfVertexArray_append');
      SfmlVertexArraySetPrimitiveType := BindFunction('sfVertexArray_setPrimitiveType');
      SfmlVertexArrayGetPrimitiveType := BindFunction('sfVertexArray_getPrimitiveType');
      SfmlVertexArrayGetBounds := BindFunction('sfVertexArray_getBounds');
      SfmlViewCreate := BindFunction('sfView_create');
      SfmlViewCreateFromRect := BindFunction('sfView_createFromRect');
      SfmlViewCopy := BindFunction('sfView_copy');
      SfmlViewDestroy := BindFunction('sfView_destroy');
      SfmlViewSetCenter := BindFunction('sfView_setCenter');
      SfmlViewSetSize := BindFunction('sfView_setSize');
      SfmlViewSetRotation := BindFunction('sfView_setRotation');
      SfmlViewSetViewport := BindFunction('sfView_setViewport');
      SfmlViewReset := BindFunction('sfView_reset');
      SfmlViewGetRotation := BindFunction('sfView_getRotation');
      SfmlViewGetViewport := BindFunction('sfView_getViewport');
      SfmlViewMove := BindFunction('sfView_move');
      SfmlViewRotate := BindFunction('sfView_rotate');
      SfmlViewZoom := BindFunction('sfView_zoom');

{$IFDEF INT64RETURNWORKAROUND}
      sfCircleShape_getPosition := BindFunction('sfCircleShape_getPosition');
      sfCircleShape_getScale := BindFunction('sfCircleShape_getScale');
      sfCircleShape_getOrigin := BindFunction('sfCircleShape_getOrigin');
      sfCircleShape_getPoint := BindFunction('sfCircleShape_getPoint');
      sfConvexShape_getPosition := BindFunction('sfConvexShape_getPosition');
      sfConvexShape_getScale := BindFunction('sfConvexShape_getScale');
      sfConvexShape_getOrigin := BindFunction('sfConvexShape_getOrigin');
      sfConvexShape_getPoint := BindFunction('sfConvexShape_getPoint');
      sfImage_getSize := BindFunction('sfImage_getSize');
      sfRectangleShape_getPosition := BindFunction('sfRectangleShape_getPosition');
      sfRectangleShape_getScale := BindFunction('sfRectangleShape_getScale');
      sfRectangleShape_getOrigin := BindFunction('sfRectangleShape_getOrigin');
      sfRectangleShape_getPoint := BindFunction('sfRectangleShape_getPoint');
      sfRectangleShape_getSize := BindFunction('sfRectangleShape_getSize');
      sfRenderTexture_getSize := BindFunction('sfRenderTexture_getSize');
      sfRenderTexture_mapPixelToCoords := BindFunction('sfRenderTexture_mapPixelToCoords');
      sfRenderTexture_mapCoordsToPixel := BindFunction('sfRenderTexture_mapCoordsToPixel');
      sfRenderWindow_getSize := BindFunction('sfRenderWindow_getSize');
      sfRenderWindow_mapPixelToCoords := BindFunction('sfRenderWindow_mapPixelToCoords');
      sfRenderWindow_mapCoordsToPixel := BindFunction('sfRenderWindow_mapCoordsToPixel');
      sfMouse_getPositionRenderWindow := BindFunction('sfMouse_getPositionRenderWindow');
      sfTouch_getPositionRenderWindow := BindFunction('sfTouch_getPositionRenderWindow');
      sfShape_getPosition := BindFunction('sfShape_getPosition');
      sfShape_getScale := BindFunction('sfShape_getScale');
      sfShape_getOrigin := BindFunction('sfShape_getOrigin');
      sfShape_getPoint := BindFunction('sfShape_getPoint');
      sfSprite_getPosition := BindFunction('sfSprite_getPosition');
      sfSprite_getScale := BindFunction('sfSprite_getScale');
      sfSprite_getOrigin := BindFunction('sfSprite_getOrigin');
      sfText_getPosition := BindFunction('sfText_getPosition');
      sfText_getScale := BindFunction('sfText_getScale');
      sfText_getOrigin := BindFunction('sfText_getOrigin');
      sfText_findCharacterPos := BindFunction('sfText_findCharacterPos');
      sfTexture_getSize := BindFunction('sfTexture_getSize');
      sfTransform_transformPoint := BindFunction('sfTransform_transformPoint');
      sfTransformable_getPosition := BindFunction('sfTransformable_getPosition');
      sfTransformable_getScale := BindFunction('sfTransformable_getScale');
      sfTransformable_getOrigin := BindFunction('sfTransformable_getOrigin');
      sfView_getCenter := BindFunction('sfView_getCenter');
      sfView_getSize := BindFunction('sfView_getSize');
{$ELSE}
      SfmlCircleShapeGetPosition := BindFunction('sfCircleShape_getPosition');
      SfmlCircleShapeGetScale := BindFunction('sfCircleShape_getScale');
      SfmlCircleShapeGetOrigin := BindFunction('sfCircleShape_getOrigin');
      SfmlCircleShapeGetPoint := BindFunction('sfCircleShape_getPoint');
      SfmlConvexShapeGetPosition := BindFunction('sfConvexShape_getPosition');
      SfmlConvexShapeGetScale := BindFunction('sfConvexShape_getScale');
      SfmlConvexShapeGetOrigin := BindFunction('sfConvexShape_getOrigin');
      SfmlConvexShapeGetPoint := BindFunction('sfConvexShape_getPoint');
      SfmlImageGetSize := BindFunction('sfImage_getSize');
      SfmlRectangleShapeGetPosition := BindFunction('sfRectangleShape_getPosition');
      SfmlRectangleShapeGetScale := BindFunction('sfRectangleShape_getScale');
      SfmlRectangleShapeGetOrigin := BindFunction('sfRectangleShape_getOrigin');
      SfmlRectangleShapeGetPoint := BindFunction('sfRectangleShape_getPoint');
      SfmlRectangleShapeGetSize := BindFunction('sfRectangleShape_getSize');
      SfmlRenderTextureMapPixelToCoords := BindFunction('sfRenderTexture_mapPixelToCoords');
      SfmlRenderTextureMapCoordsToPixel := BindFunction('sfRenderTexture_mapCoordsToPixel');
      SfmlRenderWindowMapPixelToCoords := BindFunction('sfRenderWindow_mapPixelToCoords');
      SfmlRenderWindowMapCoordsToPixel := BindFunction('sfRenderWindow_mapCoordsToPixel');
      SfmlMouseGetPositionRenderWindow := BindFunction('sfMouse_getPositionRenderWindow');
      SfmlTouchGetPositionRenderWindow := BindFunction('sfTouch_getPositionRenderWindow');
      SfmlShapeGetPosition := BindFunction('sfShape_getPosition');
      SfmlShapeGetScale := BindFunction('sfShape_getScale');
      SfmlShapeGetOrigin := BindFunction('sfShape_getOrigin');
      SfmlShapeGetPoint := BindFunction('sfShape_getPoint');
      SfmlSpriteGetPosition := BindFunction('sfSprite_getPosition');
      SfmlSpriteGetScale := BindFunction('sfSprite_getScale');
      SfmlSpriteGetOrigin := BindFunction('sfSprite_getOrigin');
      SfmlTextGetPosition := BindFunction('sfText_getPosition');
      SfmlTextGetScale := BindFunction('sfText_getScale');
      SfmlTextGetOrigin := BindFunction('sfText_getOrigin');
      SfmlTextFindCharacterPos := BindFunction('sfText_findCharacterPos');
      SfmlTextureGetSize := BindFunction('sfTexture_getSize');
      SfmlTransformTransformPoint := BindFunction('sfTransform_transformPoint');
      SfmlTransformableGetPosition := BindFunction('sfTransformable_getPosition');
      SfmlTransformableGetScale := BindFunction('sfTransformable_getScale');
      SfmlTransformableGetOrigin := BindFunction('sfTransformable_getOrigin');
      SfmlViewGetCenter := BindFunction('sfView_getCenter');
      SfmlViewGetSize := BindFunction('sfView_getSize');
{$ENDIF}
    except
      FreeLibrary(CSfmlGraphicsHandle);
      CSfmlGraphicsHandle := 0;
    end;
end;

procedure FreeDLL;
begin
  if CSfmlGraphicsHandle <> 0 then
    FreeLibrary(CSfmlGraphicsHandle);
end;

{$ELSE}
{$IFDEF INT64RETURNWORKAROUND}
function sfCircleShape_getPoint(const Shape: PSfmlCircleShape; Index: NativeUInt): Int64; cdecl; external CSfmlGraphicsLibrary;
function sfCircleShape_getPosition(const Shape: PSfmlCircleShape): Int64; cdecl; external CSfmlGraphicsLibrary;
function sfCircleShape_getOrigin(const Shape: PSfmlCircleShape): Int64; cdecl; external CSfmlGraphicsLibrary;
function sfCircleShape_getScale(const Shape: PSfmlCircleShape): Int64; cdecl; external CSfmlGraphicsLibrary;
function sfConvexShape_getOrigin(const Shape: PSfmlConvexShape): Int64; cdecl; external CSfmlGraphicsLibrary;
function sfConvexShape_getPoint(const Shape: PSfmlConvexShape; Index: NativeUInt): Int64; cdecl; external CSfmlGraphicsLibrary;
function sfConvexShape_getPosition(const Shape: PSfmlConvexShape): Int64; cdecl; external CSfmlGraphicsLibrary;
function sfConvexShape_getScale(const Shape: PSfmlConvexShape): Int64; cdecl; external CSfmlGraphicsLibrary;
function sfImage_getSize(const Image: PSfmlImage): Int64; cdecl; external CSfmlGraphicsLibrary;
function sfRectangleShape_getOrigin(const Shape: PSfmlRectangleShape): Int64; cdecl; external CSfmlGraphicsLibrary;
function sfRectangleShape_getPoint(const Shape: PSfmlRectangleShape; Index: NativeUInt): Int64; cdecl; external CSfmlGraphicsLibrary;
function sfRectangleShape_getPosition(const Shape: PSfmlRectangleShape): Int64; cdecl; external CSfmlGraphicsLibrary;
function sfRectangleShape_getScale(const Shape: PSfmlRectangleShape): Int64; cdecl; external CSfmlGraphicsLibrary;
function sfRectangleShape_getSize(const Shape: PSfmlRectangleShape): Int64; cdecl; external CSfmlGraphicsLibrary;
function sfRenderTexture_getSize(const RenderTexture: PSfmlRenderTexture): Int64; cdecl; external CSfmlGraphicsLibrary;
function sfRenderTexture_mapPixelToCoords(const RenderTexture: PSfmlRenderTexture; Point: TSfmlVector2i; const View: PSfmlView): Int64; cdecl; external CSfmlGraphicsLibrary;
function sfRenderTexture_mapCoordsToPixel(const RenderTexture: PSfmlRenderTexture; Point: TSfmlVector2i; const View: PSfmlView): Int64; cdecl; external CSfmlGraphicsLibrary;
function sfRenderWindow_getSize(const RenderWindow: PSfmlRenderWindow): Int64; cdecl; external CSfmlGraphicsLibrary;
function sfRenderWindow_mapPixelToCoords(const RenderWindow: PSfmlRenderWindow; Point: TSfmlVector2i; const View: PSfmlView): Int64; cdecl; external CSfmlGraphicsLibrary;
function sfRenderWindow_mapCoordsToPixel(const RenderWindow: PSfmlRenderWindow; Point: TSfmlVector2i; const View: PSfmlView): Int64; cdecl; external CSfmlGraphicsLibrary;
function sfMouse_getPositionRenderWindow(const RelativeTo: PSfmlRenderWindow): Int64; cdecl; external CSfmlGraphicsLibrary;
function sfTouch_getPositionRenderWindow(Finger: Cardinal; const RelativeTo: PSfmlRenderWindow): Int64; cdecl; external CSfmlGraphicsLibrary;
function sfShape_getOrigin(const Shape: PSfmlShape): Int64; cdecl; external CSfmlGraphicsLibrary;
function sfShape_getPoint(const Shape: PSfmlShape; Index: Cardinal): Int64; cdecl; external CSfmlGraphicsLibrary;
function sfShape_getPosition(const Shape: PSfmlShape): Int64; cdecl; external CSfmlGraphicsLibrary;
function sfShape_getScale(const Shape: PSfmlShape): Int64; cdecl; external CSfmlGraphicsLibrary;
function sfSprite_getOrigin(const Sprite: PSfmlSprite): Int64; cdecl; external CSfmlGraphicsLibrary;
function sfSprite_getPosition(const Sprite: PSfmlSprite): Int64; cdecl; external CSfmlGraphicsLibrary;
function sfSprite_getScale(const Sprite: PSfmlSprite): Int64; cdecl; external CSfmlGraphicsLibrary;
function sfText_findCharacterPos(const Text: PSfmlText; Index: NativeUInt): Int64; cdecl; external CSfmlGraphicsLibrary;
function sfText_getOrigin(const Text: PSfmlText): Int64; cdecl; external CSfmlGraphicsLibrary;
function sfText_getPosition(const Text: PSfmlText): Int64; cdecl; external CSfmlGraphicsLibrary;
function sfText_getScale(const Text: PSfmlText): Int64; cdecl; external CSfmlGraphicsLibrary;
function sfTexture_getSize(const Texture: PSfmlTexture): Int64; cdecl; external CSfmlGraphicsLibrary;
function sfTransform_transformPoint(const Transform: PSfmlTransform; Point: TSfmlVector2f): Int64; cdecl; external CSfmlGraphicsLibrary;
function sfTransformable_getOrigin(const Transformable: PSfmlTransformable): Int64; cdecl; external CSfmlGraphicsLibrary;
function sfTransformable_getPosition(const Transformable: PSfmlTransformable): Int64; cdecl; external CSfmlGraphicsLibrary;
function sfTransformable_getScale(const Transformable: PSfmlTransformable): Int64; cdecl; external CSfmlGraphicsLibrary;
function sfView_getCenter(const View: PSfmlView): Int64; cdecl; external CSfmlGraphicsLibrary;
function sfView_getSize(const View: PSfmlView): Int64; cdecl; external CSfmlGraphicsLibrary;
{$ENDIF}
{$ENDIF}

{$IFDEF RecordConstructors}
constructor TSfmlFloatRect.Create(Left, Top, Width, Height: Single);
begin
  Self.Left := Left;
  Self.Top := Top;
  Self.Width := Width;
  Self.Height := Height;
end;

constructor TSfmlIntRect.Create(Left, Top, Width, Height: LongInt);
begin
  Self.Left := Left;
  Self.Top := Top;
  Self.Width := Width;
  Self.Height := Height;
end;

constructor TSfmlTransform.Create(Matrix: TMatrixData);
begin
  Move(Matrix[0], Self.Matrix[0], 9 * SizeOf(Single));
end;
{$ENDIF}

{$IFDEF RecordOperators}
class operator TSfmlIntRect.Equal(const Lhs, Rhs: TSfmlIntRect): Boolean;
begin
  Result := (Lhs.Left = Rhs.Left) and (Lhs.Top = Rhs.Top) and
    (Lhs.Width = Rhs.Width) and (Lhs.Height = Rhs.Height);
end;

class operator TSfmlIntRect.Explicit(A: TSfmlFloatRect): TSfmlIntRect;
begin
  Result.Left := Round(A.Left);
  Result.Top := Round(A.Top);
  Result.Width := Round(A.Width);
  Result.Height := Round(A.Height);
end;

class operator TSfmlIntRect.Explicit(A: TSfmlIntRect): TSfmlFloatRect;
begin
  Result.Left := A.Left;
  Result.Top := A.Top;
  Result.Width := A.Width;
  Result.Height := A.Height;
end;

class operator TSfmlIntRect.Implicit(A: TSfmlFloatRect): TSfmlIntRect;
begin
  Result.Left := Round(A.Left);
  Result.Top := Round(A.Top);
  Result.Width := Round(A.Width);
  Result.Height := Round(A.Height);
end;

class operator TSfmlIntRect.Implicit(A: TSfmlIntRect): TSfmlFloatRect;
begin
  Result.Left := A.Left;
  Result.Top := A.Top;
  Result.Width := A.Width;
  Result.Height := A.Height;
end;

class operator TSfmlFloatRect.Equal(const Lhs, Rhs: TSfmlFloatRect): Boolean;
begin
  Result := (Lhs.Left = Rhs.Left) and (Lhs.Top = Rhs.Top) and
    (Lhs.Width = Rhs.Width) and (Lhs.Height = Rhs.Height);
end;

class operator TSfmlTransform.Equal(const Lhs, Rhs: TSfmlTransform): Boolean;
begin
  Result := (Lhs.Matrix[0] = Rhs.Matrix[0]) and (Lhs.Matrix[1] = Rhs.Matrix[1])
    and (Lhs.Matrix[2] = Rhs.Matrix[2]) and (Lhs.Matrix[3] = Rhs.Matrix[3])
    and (Lhs.Matrix[4] = Rhs.Matrix[4]) and (Lhs.Matrix[5] = Rhs.Matrix[5])
    and (Lhs.Matrix[6] = Rhs.Matrix[6]) and (Lhs.Matrix[7] = Rhs.Matrix[7])
    and (Lhs.Matrix[8] = Rhs.Matrix[8]);
end;

class operator TSfmlTransform.NotEqual(const Lhs, Rhs: TSfmlTransform): Boolean;
begin
  Result := not (Lhs = Rhs);
end;

class operator TSfmlTransform.Multiply(const Lhs, Rhs: TSfmlTransform): TSfmlTransform;
begin
  Result := Lhs;
  SfmlTransformCombine(Result, @Rhs);
end;

class operator TSfmlTransform.Multiply(const Lhs: TSfmlTransform; Rhs: TSfmlVector2f): TSfmlVector2f;
begin
  Result := SfmlTransformTransformPoint(@Lhs, Rhs);
end;
{$ENDIF}

function TSfmlTransform.GetInverse: TSfmlTransform;
begin
  Result := SfmlTransformGetInverse(@Self);
end;

function TSfmlTransform.TransformPoint(Point: TSfmlVector2f): TSfmlVector2f;
begin
  Result := SfmlTransformTransformPoint(@Self, Point);
end;

function TSfmlTransform.TransformRect(Rectangle: TSfmlFloatRect): TSfmlFloatRect;
begin
  Result := SfmlTransformTransformRect(@Self, Rectangle);
end;

procedure TSfmlTransform.Translate(X, Y: Single);
begin
  SfmlTransformTranslate(@Self, X, Y);
end;

procedure TSfmlTransform.Rotate(Angle: Single);
begin
  SfmlTransformRotate(@Self, Angle);
end;

procedure TSfmlTransform.RotateWithCenter(Angle: Single; CenterX, CenterY: Single);
begin
  SfmlTransformRotateWithCenter(@Self, Angle, CenterX, CenterY);
end;

procedure TSfmlTransform.Scale(ScaleX, ScaleY: Single);
begin
  SfmlTransformScale(@Self, ScaleX, ScaleY);
end;

procedure TSfmlTransform.ScaleWithCenter(ScaleX, ScaleY, CenterX, CenterY: Single);
begin
  SfmlTransformScaleWithCenter(@Self, ScaleX, ScaleY, CenterX, CenterY);
end;


{$IFDEF INT64RETURNWORKAROUND}
function SfmlCircleShapeGetPoint(const Shape: PSfmlCircleShape; Index: NativeUInt): TSfmlVector2f; cdecl;
var
  Val: Int64 absolute Result;
begin
  Val := sfCircleShape_getPoint(Shape, Index);
end;

function SfmlCircleShapeGetPosition(const Shape: PSfmlCircleShape): TSfmlVector2f; cdecl;
var
  Val: Int64 absolute Result;
begin
  Val := sfCircleShape_getPosition(Shape);
end;

function SfmlCircleShapeGetOrigin(const Shape: PSfmlCircleShape): TSfmlVector2f; cdecl;
var
  Val: Int64 absolute Result;
begin
  Val := sfCircleShape_getOrigin(Shape);
end;

function SfmlCircleShapeGetScale(const Shape: PSfmlCircleShape): TSfmlVector2f; cdecl;
var
  Val: Int64 absolute Result;
begin
  Val := sfCircleShape_getScale(Shape);
end;

function SfmlConvexShapeGetOrigin(const Shape: PSfmlConvexShape): TSfmlVector2f; cdecl;
var
  Val: Int64 absolute Result;
begin
  Val := sfConvexShape_getOrigin(Shape);
end;

function SfmlConvexShapeGetPoint(const Shape: PSfmlConvexShape; Index: NativeUInt): TSfmlVector2f; cdecl;
var
  Val: Int64 absolute Result;
begin
  Val := sfConvexShape_getPoint(Shape, Index);
end;

function SfmlConvexShapeGetPosition(const Shape: PSfmlConvexShape): TSfmlVector2f; cdecl;
var
  Val: Int64 absolute Result;
begin
  Val := sfConvexShape_getPosition(Shape);
end;

function SfmlConvexShapeGetScale(const Shape: PSfmlConvexShape): TSfmlVector2f; cdecl;
var
  Val: Int64 absolute Result;
begin
  Val := sfConvexShape_getScale(Shape);
end;

function SfmlImageGetSize(const Image: PSfmlImage): TSfmlVector2u; cdecl;
var
  Val: Int64 absolute Result;
begin
  Val := sfImage_getSize(Image);
end;

function SfmlRectangleShapeGetOrigin(const Shape: PSfmlRectangleShape): TSfmlVector2f; cdecl;
var
  Val: Int64 absolute Result;
begin
  Val := sfRectangleShape_getOrigin(Shape);
end;

function SfmlRectangleShapeGetPoint(const Shape: PSfmlRectangleShape; Index: NativeUInt): TSfmlVector2f; cdecl;
var
  Val: Int64 absolute Result;
begin
  Val := sfRectangleShape_getPoint(Shape, Index);
end;

function SfmlRectangleShapeGetPosition(const Shape: PSfmlRectangleShape): TSfmlVector2f; cdecl;
var
  Val: Int64 absolute Result;
begin
  Val := sfRectangleShape_getPosition(Shape);
end;

function SfmlRectangleShapeGetScale(const Shape: PSfmlRectangleShape): TSfmlVector2f; cdecl;
var
  Val: Int64 absolute Result;
begin
  Val := sfRectangleShape_getScale(Shape);
end;

function SfmlRectangleShapeGetSize(const Shape: PSfmlRectangleShape): TSfmlVector2f; cdecl;
var
  Val: Int64 absolute Result;
begin
  Val := sfRectangleShape_getSize(Shape);
end;

function SfmlRenderTextureGetSize(const RenderTexture: PSfmlRenderTexture): TSfmlVector2u; cdecl;
var
  Val: Int64 absolute Result;
begin
  Val := sfRenderTexture_getSize(RenderTexture);
end;

function SfmlRenderTextureMapPixelToCoords(const RenderTexture: PSfmlRenderTexture; Point: TSfmlVector2i; const View: PSfmlView): TSfmlVector2f; cdecl;
var
  Val: Int64 absolute Result;
begin
  Val := sfRenderTexture_mapPixelToCoords(RenderTexture, Point, View);
end;

function SfmlRenderTextureMapCoordsToPixel(const RenderTexture: PSfmlRenderTexture; Point: TSfmlVector2i; const View: PSfmlView): TSfmlVector2i; cdecl;
var
  Val: Int64 absolute Result;
begin
  Val := sfRenderTexture_mapCoordsToPixel(RenderTexture, Point, View);
end;

function SfmlRenderWindowGetSize(const RenderWindow: PSfmlRenderWindow): TSfmlVector2u; cdecl;
var
  Val: Int64 absolute Result;
begin
  Val := sfRenderWindow_getSize(RenderWindow);
end;

function SfmlRenderWindowMapPixelToCoords(const RenderWindow: PSfmlRenderWindow; Point: TSfmlVector2i; const View: PSfmlView): TSfmlVector2f; cdecl;
var
  Val: Int64 absolute Result;
begin
  Val := sfRenderWindow_mapPixelToCoords(RenderWindow, Point, View);
end;

function SfmlRenderWindowMapCoordsToPixel(const RenderWindow: PSfmlRenderWindow; Point: TSfmlVector2i; const View: PSfmlView): TSfmlVector2i; cdecl;
var
  Val: Int64 absolute Result;
begin
  Val := sfRenderWindow_mapCoordsToPixel(RenderWindow, Point, View);
end;

function SfmlMouseGetPositionRenderWindow(const RelativeTo: PSfmlRenderWindow): TSfmlVector2i; cdecl;
var
  Val: Int64 absolute Result;
begin
  Val := sfMouse_getPositionRenderWindow(RelativeTo);
end;

function SfmlTouchGetPositionRenderWindow(Finger: Cardinal; const RelativeTo: PSfmlRenderWindow): TSfmlVector2i; cdecl;
var
  Val: Int64 absolute Result;
begin
  Val := sfTouch_getPositionRenderWindow(Finger, RelativeTo);
end;

function SfmlShapeGetOrigin(const Shape: PSfmlShape): TSfmlVector2f; cdecl;
var
  Val: Int64 absolute Result;
begin
  Val := sfShape_getOrigin(Shape);
end;

function SfmlShapeGetPoint(const Shape: PSfmlShape; Index: NativeUInt): TSfmlVector2f; cdecl;
var
  Val: Int64 absolute Result;
begin
  Val := sfShape_getPoint(Shape, Index);
end;

function SfmlShapeGetPosition(const Shape: PSfmlShape): TSfmlVector2f; cdecl;
var
  Val: Int64 absolute Result;
begin
  Val := sfShape_getPosition(Shape);
end;

function SfmlShapeGetScale(const Shape: PSfmlShape): TSfmlVector2f; cdecl;
var
  Val: Int64 absolute Result;
begin
  Val := sfShape_getScale(Shape);
end;

function SfmlSpriteGetOrigin(const Sprite: PSfmlSprite): TSfmlVector2f; cdecl;
var
  Val: Int64 absolute Result;
begin
  Val := sfSprite_getOrigin(Sprite);
end;

function SfmlSpriteGetPosition(const Sprite: PSfmlSprite): TSfmlVector2f; cdecl;
var
  Val: Int64 absolute Result;
begin
  Val := sfSprite_getPosition(Sprite);
end;

function SfmlSpriteGetScale(const Sprite: PSfmlSprite): TSfmlVector2f; cdecl;
var
  Val: Int64 absolute Result;
begin
  Val := sfSprite_getScale(Sprite);
end;

function SfmlTextFindCharacterPos(const Text: PSfmlText; Index: NativeUInt): TSfmlVector2f; cdecl;
var
  Val: Int64 absolute Result;
begin
  Val := sfText_findCharacterPos(Text, Index);
end;

function SfmlTextGetOrigin(const Text: PSfmlText): TSfmlVector2f; cdecl;
var
  Val: Int64 absolute Result;
begin
  Val := sfText_getOrigin(Text);
end;

function SfmlTextGetPosition(const Text: PSfmlText): TSfmlVector2f; cdecl;
var
  Val: Int64 absolute Result;
begin
  Val := sfText_getPosition(Text);
end;

function SfmlTextGetScale(const Text: PSfmlText): TSfmlVector2f; cdecl;
var
  Val: Int64 absolute Result;
begin
  Val := sfText_getScale(Text);
end;

function SfmlTextureGetSize(const Texture: PSfmlTexture): TSfmlVector2u; cdecl;
var
  Val: Int64 absolute Result;
begin
  Val := sfTexture_getSize(Texture);
end;

function SfmlTransformTransformPoint(const Transform: PSfmlTransform; Point: TSfmlVector2f): TSfmlVector2f; cdecl;
var
  Val: Int64 absolute Result;
begin
  Val := sfTransform_transformPoint(Transform, Point);
end;

function SfmlTransformableGetOrigin(const Transformable: PSfmlTransformable): TSfmlVector2f; cdecl;
var
  Val: Int64 absolute Result;
begin
  Val := sfTransformable_getOrigin(Transformable);
end;

function SfmlTransformableGetPosition(const Transformable: PSfmlTransformable): TSfmlVector2f; cdecl;
var
  Val: Int64 absolute Result;
begin
  Val := sfTransformable_getPosition(Transformable);
end;

function SfmlTransformableGetScale(const Transformable: PSfmlTransformable): TSfmlVector2f; cdecl;
var
  Val: Int64 absolute Result;
begin
  Val := sfTransformable_getScale(Transformable);
end;

function SfmlViewGetCenter(const View: PSfmlView): TSfmlVector2f; cdecl;
var
  Val: Int64 absolute Result;
begin
  Val := sfView_getCenter(View);
end;

function SfmlViewGetSize(const View: PSfmlView): TSfmlVector2f; cdecl;
var
  Val: Int64 absolute Result;
begin
  Val := sfView_getSize(View);
end;
{$ENDIF}

{$IFDEF DynLink}
initialization

InitDLL;

finalization

FreeDLL;

{$ENDIF}
end.
