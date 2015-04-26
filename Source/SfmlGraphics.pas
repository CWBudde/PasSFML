unit SfmlGraphics;

////////////////////////////////////////////////////////////
//
// SFML - Simple and Fast Multimedia Library
// Copyright (C) 2007-2015 Laurent Gomila (laurent@sfml-dev.org)
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
// 2. Altered source versions must be plainly marked as such,
//    and must not be misrepresented as being the original software.
//
// 3. This notice may not be removed or altered from any source distribution.
//
////////////////////////////////////////////////////////////

interface

{$I SFML.inc}

uses
  Windows, SfmlWindow, SfmlSystem;

type
  PSfmlCircleShape = Pointer;
  PSfmlConvexShape = Pointer;
  PSfmlFont = Pointer;
  PSfmlImage = Pointer;
  PSfmlShader = Pointer;
  PSfmlRectangleShape = Pointer;
  PSfmlRenderTexture = Pointer;
  PSfmlRenderWindow = Pointer;
  PSfmlShape = Pointer;
  PSfmlSprite = Pointer;
  PSfmlText = Pointer;
  PSfmlTexture = Pointer;
  PSfmlTransformable = Pointer;
  PSfmlVertexArray = Pointer;
  PSfmlView = Pointer;

  TSfmlBlendFactor = (sfBlendFactorZero, sfBlendFactorOne,
    sfBlendFactorSrcColor, sfBlendFactorOneMinusSrcColor,
    sfBlendFactorDstColor, sfBlendFactorOneMinusDstColor,
    sfBlendFactorSrcAlpha, sfBlendFactorOneMinusSrcAlpha,
    sfBlendFactorDstAlpha, sfBlendFactorOneMinusDstAlpha);

  TSfmlBlendEquation = (sfBlendEquationAdd, sfBlendEquationSubtract);

  TSfmlBlendMode = record
    colorSrcFactor: TSfmlBlendFactor;
    colorDstFactor: TSfmlBlendFactor;
    colorEquation: TSfmlBlendEquation;
    alphaSrcFactor: TSfmlBlendFactor;
    alphaDstFactor: TSfmlBlendFactor;
    alphaEquation: TSfmlBlendEquation;
  end;

  TSfmlColor = packed record
    r, g, b, a: sfUint8;
  end;

  TSfmlFontInfo = record
    Family: PAnsiChar;
  end;

  TSfmlFloatRect = record
    Left, Top, Width, Height: Single;
  end;

  TSfmlIntRect = record
    Left, Top, Width, Height: longint;
  end;
  PSfmlIntRect = ^TSfmlIntRect;

  TSfmlGlyph = record
    Advance: Single;
    Bounds: TSfmlFloatRect;
    TextureRect: TSfmlIntRect;
  end;

  TSfmlPrimitiveType = (sfPoints, sfLines, sfLinesStrip, sfTriangles,
    sfTrianglesStrip, sfTrianglesFan, sfQuads);

  TSfmlTransform = record
    Matrix : array [0 .. 8] of Single;
  end;
  PSfmlTransform = ^TSfmlTransform;

  TSfmlRenderStates = record
    BlendMode: TSfmlBlendMode;
    Transform: TSfmlTransform;
    Texture: PSfmlTexture;
    Shader: PSfmlShader;
  end;
  PSfmlRenderStates = ^TSfmlRenderStates;

  TSfmlShapeGetPointCountCallback = function (Para1: Pointer): Cardinal; cdecl;
  TSfmlShapeGetPointCallback = function (Para1: Cardinal; Para2: Pointer): TSfmlVector2f; cdecl;

  TSfmlTextStyle = (sfTextBold, sfTextItalic, sfTextUnderlined,
    sfTextStrikeThrough);
  TSfmlTextStyles = set of TSfmlTextStyle;

  TSfmlVertex = record
    Position: TSfmlVector2f;
    Color: TSfmlColor;
    TexCoords: TSfmlVector2f;
  end;
  PSfmlVertex = ^TSfmlVertex;

  TSfmlBlendAlpha = function : TSfmlBlendMode; cdecl;
  TSfmlBlendAdd = function : TSfmlBlendMode; cdecl;
  TSfmlBlendMultiply = function : TSfmlBlendMode; cdecl;
  TSfmlBlendNone = function : TSfmlBlendMode; cdecl;

  TSfmlColorFromRGB = function (Red, Green, Blue: sfUint8): TSfmlColor; cdecl;
  TSfmlColorFromRGBA = function (Red, Green, Blue, Alpha: sfUint8): TSfmlColor; cdecl;
  TSfmlColorAdd = function (color1, color2: TSfmlColor): TSfmlColor; cdecl;
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
  TSfmlCircleShapeSetTexture = procedure (Shape: PSfmlCircleShape; const Texture: PSfmlTexture; resetRect: sfBool); cdecl;
  TSfmlCircleShapeSetTextureRect = procedure (Shape: PSfmlCircleShape; Rect: TSfmlIntRect); cdecl;
  TSfmlCircleShapeSetFillColor = procedure (Shape: PSfmlCircleShape; Color: TSfmlColor); cdecl;
  TSfmlCircleShapeSetOutlineColor = procedure (Shape: PSfmlCircleShape; Color: TSfmlColor); cdecl;
  TSfmlCircleShapeSetOutlineThickness = procedure (Shape: PSfmlCircleShape; Thickness: Single); cdecl;
  TSfmlCircleShapeGetTexture = function (const Shape: PSfmlCircleShape): PSfmlTexture; cdecl;
  TSfmlCircleShapeGetTextureRect = function (const Shape: PSfmlCircleShape): TSfmlIntRect; cdecl;
  TSfmlCircleShapeGetFillColor = function (const Shape: PSfmlCircleShape): TSfmlColor; cdecl;
  TSfmlCircleShapeGetOutlineColor = function (const Shape: PSfmlCircleShape): TSfmlColor; cdecl;
  TSfmlCircleShapeGetOutlineThickness = function (const Shape: PSfmlCircleShape): Single; cdecl;
  TSfmlCircleShapeGetPointCount = function (const Shape: PSfmlCircleShape): Cardinal; cdecl;
  TSfmlCircleShapeGetPoint = function (const Shape: PSfmlCircleShape; Index: Cardinal): TSfmlVector2f; cdecl;
  TSfmlCircleShapeSetRadius = procedure (Shape: PSfmlCircleShape; Radius: Single); cdecl;
  TSfmlCircleShapeGetRadius = function (const Shape: PSfmlCircleShape): Single; cdecl;
  TSfmlCircleShapeSetPointCount = procedure (Shape: PSfmlCircleShape; Count: Cardinal); cdecl;
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
  TSfmlConvexShapeSetTexture = procedure (Shape: PSfmlConvexShape; const Texture: PSfmlTexture; ResetRect: sfBool); cdecl;
  TSfmlConvexShapeSetTextureRect = procedure (Shape: PSfmlConvexShape; Rect: TSfmlIntRect); cdecl;
  TSfmlConvexShapeSetFillColor = procedure (Shape: PSfmlConvexShape; Color: TSfmlColor); cdecl;
  TSfmlConvexShapeSetOutlineColor = procedure (Shape: PSfmlConvexShape; Color: TSfmlColor); cdecl;
  TSfmlConvexShapeSetOutlineThickness = procedure (Shape: PSfmlConvexShape; Thickness: Single); cdecl;
  TSfmlConvexShapeGetTexture = function (const Shape: PSfmlConvexShape): PSfmlTexture; cdecl;
  TSfmlConvexShapeGetTextureRect = function (const Shape: PSfmlConvexShape): TSfmlIntRect; cdecl;
  TSfmlConvexShapeGetFillColor = function (const Shape: PSfmlConvexShape): TSfmlColor; cdecl;
  TSfmlConvexShapeGetOutlineColor = function (const Shape: PSfmlConvexShape): TSfmlColor; cdecl;
  TSfmlConvexShapeGetOutlineThickness = function (const Shape: PSfmlConvexShape): Single; cdecl;
  TSfmlConvexShapeGetPointCount = function (const Shape: PSfmlConvexShape): Cardinal; cdecl;
  TSfmlConvexShapeGetPoint = function (const Shape: PSfmlConvexShape; Index: Cardinal): TSfmlVector2f; cdecl;
  TSfmlConvexShapeSetPointCount = procedure (Shape: PSfmlConvexShape; Count: Cardinal); cdecl;
  TSfmlConvexShapeSetPoint = procedure (Shape: PSfmlConvexShape; Index: Cardinal; Point: TSfmlVector2f); cdecl;
  TSfmlConvexShapeGetLocalBounds = function (const Shape: PSfmlConvexShape): TSfmlFloatRect; cdecl;
  TSfmlConvexShapeGetGlobalBounds = function (const Shape: PSfmlConvexShape): TSfmlFloatRect; cdecl;

  TSfmlFontCreateFromFile = function (const FileName: PAnsiChar): PSfmlFont; cdecl;
  TSfmlFontCreateFromMemory = function (const Data: Pointer; SizeInBytes: NativeUInt): PSfmlFont; cdecl;
  TSfmlFontCreateFromStream = function (const Stream: PSfmlInputStream): PSfmlFont; cdecl;
  TSfmlFontCopy = function (const Font: PSfmlFont): PSfmlFont; cdecl;
  TSfmlFontDestroy = procedure (Font: PSfmlFont); cdecl;
  TSfmlFontGetGlyph = function (Font: PSfmlFont; CodePoint: sfUint32; CharacterSize: Cardinal; Bold: sfBool): TSfmlGlyph; cdecl;
  TSfmlFontGetKerning = function (Font: PSfmlFont; First, second: sfUint32; CharacterSize: Cardinal): Single; cdecl;
  TSfmlFontGetLineSpacing = function (Font: PSfmlFont; CharacterSize: Cardinal): Single; cdecl;
  TSfmlFontGetUnderlinePosition = function (Font: PSfmlFont; CharacterSize: Cardinal): Single; cdecl;
  TSfmlFontGetUnderlineThickness = function (Font: PSfmlFont; CharacterSize: Cardinal): Single; cdecl;
  TSfmlFontGetTexture = function (Font: PSfmlFont; CharacterSize: Cardinal): PSfmlTexture; cdecl;
  TSfmlFontGetInfo = function (const Font: PSfmlFont): TSfmlFontInfo; cdecl;

  TSfmlImageCreate = function (Width, Height: Cardinal): PSfmlImage; cdecl;
  TSfmlImageCreateFromColor = function (Width, Height: Cardinal; Color: TSfmlColor): PSfmlImage; cdecl;
  TSfmlImageCreateFromPixels = function (Width, Height: Cardinal; const Pixels: PByte): PSfmlImage; cdecl;
  TSfmlImageCreateFromFile = function (const FileName: PAnsiChar): PSfmlImage; cdecl;
  TSfmlImageCreateFromMemory = function (const data: Pointer; Size: NativeUInt): PSfmlImage; cdecl;
  TSfmlImageCreateFromStream = function (const Stream: PSfmlInputStream): PSfmlImage; cdecl;
  TSfmlImageCopy = function (const Image: PSfmlImage): PSfmlImage; cdecl;
  TSfmlImageDestroy = procedure (Image: PSfmlImage); cdecl;
  TSfmlImageSaveToFile = function (const Image: PSfmlImage; const FileName: PAnsiChar): sfBool; cdecl;
  TSfmlImageGetSize = function (const Image: PSfmlImage): TSfmlVector2u; cdecl;
  TSfmlImageCreateMaskFromColor = procedure (Image: PSfmlImage; Color: TSfmlColor; Alpha: sfUint8); cdecl;
  TSfmlImageCopyImage = procedure (Image: PSfmlImage; const source: PSfmlImage; destX, destY: Cardinal; sourceRect: TSfmlIntRect; applyAlpha: sfBool); cdecl;
  TSfmlImageSetPixel = procedure (Image: PSfmlImage; X, Y: Cardinal; Color: TSfmlColor); cdecl;
  TSfmlImageGetPixel = function (const Image: PSfmlImage; X, Y: Cardinal): TSfmlColor; cdecl;
  TSfmlImageGetPixelsPtr = function (const Image: PSfmlImage): PByte; cdecl;
  TSfmlImageFlipHorizontally = procedure (Image: PSfmlImage); cdecl;
  TSfmlImageFlipVertically = procedure (Image: PSfmlImage); cdecl;

  TSfmlFloatRectContains = function (var Rect: TSfmlFloatRect; X, Y: Single): sfBool; cdecl;
  TSfmlIntRectContains = function (var Rect: TSfmlIntRect; X, Y: LongInt): sfBool; cdecl;
  TSfmlFloatRectIntersects = function (var rect1, rect2: TSfmlFloatRect; var Intersection: TSfmlFloatRect): sfBool; cdecl;
  TSfmlIntRectIntersects = function (var rect1, rect2: TSfmlIntRect; var Intersection: TSfmlFloatRect): sfBool; cdecl;

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
  TSfmlRectangleShapeSetTexture = procedure (Shape: PSfmlRectangleShape; const Texture: PSfmlTexture; resetRect: sfBool); cdecl;
  TSfmlRectangleShapeSetTextureRect = procedure (Shape: PSfmlRectangleShape; rect: TSfmlIntRect); cdecl;
  TSfmlRectangleShapeSetFillColor = procedure (Shape: PSfmlRectangleShape; Color: TSfmlColor); cdecl;
  TSfmlRectangleShapeSetOutlineColor = procedure (Shape: PSfmlRectangleShape; Color: TSfmlColor); cdecl;
  TSfmlRectangleShapeSetOutlineThickness = procedure (Shape: PSfmlRectangleShape; Thickness: Single); cdecl;
  TSfmlRectangleShapeGetTexture = function (const Shape: PSfmlRectangleShape): PSfmlTexture; cdecl;
  TSfmlRectangleShapeGetTextureRect = function (const Shape: PSfmlRectangleShape): TSfmlIntRect; cdecl;
  TSfmlRectangleShapeGetFillColor = function (const Shape: PSfmlRectangleShape): TSfmlColor; cdecl;
  TSfmlRectangleShapeGetOutlineColor = function (const Shape: PSfmlRectangleShape): TSfmlColor; cdecl;
  TSfmlRectangleShapeGetOutlineThickness = function (const Shape: PSfmlRectangleShape): Single; cdecl;
  TSfmlRectangleShapeGetPointCount = function (const Shape: PSfmlRectangleShape): Cardinal; cdecl;
  TSfmlRectangleShapeGetPoint = function (const Shape: PSfmlRectangleShape; Index: Cardinal): TSfmlVector2f; cdecl;
  TSfmlRectangleShapeSetSize = procedure (Shape: PSfmlRectangleShape; Size: TSfmlVector2f); cdecl;
  TSfmlRectangleShapeGetSize = function (const Shape: PSfmlRectangleShape): TSfmlVector2f; cdecl;
  TSfmlRectangleShapeGetLocalBounds = function (const Shape: PSfmlRectangleShape): TSfmlFloatRect; cdecl;
  TSfmlRectangleShapeGetGlobalBounds = function (const Shape: PSfmlRectangleShape): TSfmlFloatRect; cdecl;

  TSfmlRenderTextureCreate = function (Width, Height: Cardinal; depthBuffer: sfBool): PSfmlRenderTexture; cdecl;
  TSfmlRenderTextureDestroy = procedure (RenderTexture: PSfmlRenderTexture); cdecl;
  TSfmlRenderTextureGetSize = function (const RenderTexture: PSfmlRenderTexture): TSfmlVector2u; cdecl;
  TSfmlRenderTextureSetActive = function (RenderTexture: PSfmlRenderTexture; Active: sfBool): sfBool; cdecl;
  TSfmlRenderTextureDisplay = procedure (RenderTexture: PSfmlRenderTexture); cdecl;
  TSfmlRenderTextureClear = procedure (RenderTexture: PSfmlRenderTexture; Color: TSfmlColor); cdecl;
  TSfmlRenderTextureSetView = procedure (RenderTexture: PSfmlRenderTexture; const View: PSfmlView); cdecl;
  TSfmlRenderTextureGetView = function (const RenderTexture: PSfmlRenderTexture): PSfmlView; cdecl;
  TSfmlRenderTextureGetDefaultView = function (const RenderTexture: PSfmlRenderTexture): PSfmlView; cdecl;
  TSfmlRenderTextureGetViewport = function (const RenderTexture: PSfmlRenderTexture; const View: PSfmlView): TSfmlIntRect; cdecl;
  TSfmlRenderTextureMapPixelToCoords = function (const RenderTexture: PSfmlRenderTexture; point: TSfmlVector2i; const View: PSfmlView): TSfmlVector2f; cdecl;
  TSfmlRenderTextureMapCoordsToPixel = function (const RenderTexture: PSfmlRenderTexture; point: TSfmlVector2i; const View: PSfmlView): TSfmlVector2i; cdecl;
  TSfmlRenderTextureDrawSprite = procedure (RenderTexture: PSfmlRenderTexture; const &Object: PSfmlSprite; const States: PSfmlRenderStates); cdecl;
  TSfmlRenderTextureDrawText = procedure (RenderTexture: PSfmlRenderTexture; const &Object: PSfmlText; const States: PSfmlRenderStates); cdecl;
  TSfmlRenderTextureDrawShape = procedure (RenderTexture: PSfmlRenderTexture; const &Object: PSfmlShape; const States: PSfmlRenderStates); cdecl;
  TSfmlRenderTextureDrawCircleShape = procedure (RenderTexture: PSfmlRenderTexture; const &Object: PSfmlCircleShape; const States: PSfmlRenderStates); cdecl;
  TSfmlRenderTextureDrawConvexShape = procedure (RenderTexture: PSfmlRenderTexture; const &Object: PSfmlConvexShape; const States: PSfmlRenderStates); cdecl;
  TSfmlRenderTextureDrawRectangleShape = procedure (RenderTexture: PSfmlRenderTexture; const &Object: PSfmlRectangleShape; const States: PSfmlRenderStates); cdecl;
  TSfmlRenderTextureDrawVertexArray = procedure (RenderTexture: PSfmlRenderTexture; const &Object: PSfmlVertexArray; const States: PSfmlRenderStates); cdecl;
  TSfmlRenderTextureDrawPrimitives = procedure (RenderTexture: PSfmlRenderTexture); cdecl;
  TSfmlRenderTexturePushGLStates = procedure (RenderTexture: PSfmlRenderTexture); cdecl;
  TSfmlRenderTexturePopGLStates = procedure (RenderTexture: PSfmlRenderTexture); cdecl;
  TSfmlRenderTextureResetGLStates = procedure (RenderTexture: PSfmlRenderTexture); cdecl;
  TSfmlRenderTextureGetTexture = function (const RenderTexture: PSfmlRenderTexture): PSfmlTexture ; cdecl;
  TSfmlRenderTextureSetSmooth = procedure (RenderTexture: PSfmlRenderTexture; Smooth: sfBool); cdecl;
  TSfmlRenderTextureIsSmooth = function (const RenderTexture: PSfmlRenderTexture): sfBool; cdecl;
  TSfmlRenderTextureSetRepeated = procedure (RenderTexture: PSfmlRenderTexture; Repeated: sfBool); cdecl;
  TSfmlRenderTextureIsRepeated = function (const RenderTexture: PSfmlRenderTexture): sfBool; cdecl;

  TSfmlRenderWindowCreate = function (Mode: TSfmlVideoMode; const Title: PAnsiChar; Style: TSfmlWindowStyles; const Settings: PSfmlContextSettings): PSfmlRenderWindow; cdecl;
  TSfmlRenderWindowCreateUnicode = function (Mode: TSfmlVideoMode; const Title: PWideChar; Style: TSfmlWindowStyles; const Settings: PSfmlContextSettings): PSfmlRenderWindow; cdecl;
  TSfmlRenderWindowCreateFromHandle = function (Handle: TSfmlWindowHandle; const Settings: PSfmlContextSettings): PSfmlRenderWindow; cdecl;
  TSfmlRenderWindowDestroy = procedure (RenderWindow: PSfmlRenderWindow); cdecl;
  TSfmlRenderWindowClose = procedure (RenderWindow: PSfmlRenderWindow); cdecl;
  TSfmlRenderWindowIsOpen = function (const RenderWindow: PSfmlRenderWindow): sfBool; cdecl;
  TSfmlRenderWindowGetSettings = function (const RenderWindow: PSfmlRenderWindow): TSfmlContextSettings; cdecl;
  TSfmlRenderWindowPollEvent = function (RenderWindow: PSfmlRenderWindow; Event: PSfmlEvent): sfBool; cdecl;
  TSfmlRenderWindowWaitEvent = function (RenderWindow: PSfmlRenderWindow; Event: PSfmlEvent): sfBool; cdecl;
  TSfmlRenderWindowGetPosition = function (const RenderWindow: PSfmlRenderWindow): TSfmlVector2i; cdecl;
  TSfmlRenderWindowSetPosition = procedure (RenderWindow: PSfmlRenderWindow; Position: TSfmlVector2i); cdecl;
  TSfmlRenderWindowGetSize = function (const RenderWindow: PSfmlRenderWindow): TSfmlVector2u; cdecl;
  TSfmlRenderWindowSetSize = procedure (RenderWindow: PSfmlRenderWindow; Size: TSfmlVector2u); cdecl;
  TSfmlRenderWindowSetTitle = procedure (RenderWindow: PSfmlRenderWindow; const Title: PAnsiChar); cdecl;
  TSfmlRenderWindowSetUnicodeTitle = procedure (RenderWindow: PSfmlRenderWindow; const Title: PWideChar); cdecl;
  TSfmlRenderWindowSetIcon = procedure (RenderWindow: PSfmlRenderWindow; Width, Height: Cardinal; const Pixels: PByte); cdecl;
  TSfmlRenderWindowSetVisible = procedure (RenderWindow: PSfmlRenderWindow; Visible: sfBool); cdecl;
  TSfmlRenderWindowSetMouseCursorVisible = procedure (RenderWindow: PSfmlRenderWindow; show: sfBool); cdecl;
  TSfmlRenderWindowSetVerticalSyncEnabled = procedure (RenderWindow: PSfmlRenderWindow; enabled: sfBool); cdecl;
  TSfmlRenderWindowSetKeyRepeatEnabled = procedure (RenderWindow: PSfmlRenderWindow; enabled: sfBool); cdecl;
  TSfmlRenderWindowSetActive = function (RenderWindow: PSfmlRenderWindow; Active: sfBool): sfBool; cdecl;
  TSfmlRenderWindowRequestFocus = procedure (RenderWindow: PSfmlRenderWindow); cdecl;
  TSfmlRenderWindowHasFocus = function (const RenderWindow: PSfmlRenderWindow): sfBool; cdecl;
  TSfmlRenderWindowDisplay = procedure (RenderWindow: PSfmlRenderWindow); cdecl;
  TSfmlRenderWindowSetFramerateLimit = procedure (RenderWindow: PSfmlRenderWindow; Limit: Cardinal); cdecl;
  TSfmlRenderWindowSetJoystickThreshold = procedure (RenderWindow: PSfmlRenderWindow; Threshold: Single); cdecl;
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
  TSfmlRenderWindowDrawPrimitives = procedure (RenderWindow: PSfmlRenderWindow); cdecl;
  TSfmlRenderWindowPushGLStates = procedure (RenderWindow: PSfmlRenderWindow); cdecl;
  TSfmlRenderWindowPopGLStates = procedure (RenderWindow: PSfmlRenderWindow); cdecl;
  TSfmlRenderWindowResetGLStates = procedure (RenderWindow: PSfmlRenderWindow); cdecl;
  TSfmlRenderWindowCapture = function (const RenderWindow: PSfmlRenderWindow): PSfmlImage; cdecl;
  TSfmlMouseGetPositionRenderWindow = function (const relativeTo: PSfmlRenderWindow): TSfmlVector2i; cdecl;
  TSfmlMouseSetPositionRenderWindow = procedure (position: TSfmlVector2i; const RelativeTo: PSfmlRenderWindow); cdecl;
  TSfmlTouchGetPositionRenderWindow = function (Finger: Cardinal; const RelativeTo: PSfmlRenderWindow): TSfmlVector2i; cdecl;

  TSfmlShaderCreateFromFile = function (const VertexShaderFilename: PAnsiChar; const FragmentShaderFilename: PAnsiChar): PSfmlShader; cdecl;
  TSfmlShaderCreateFromMemory = function (const VertexShader: PAnsiChar; const FragmentShader: PAnsiChar): PSfmlShader; cdecl;
  TSfmlShaderCreateFromStream = function (VertexShaderStream: PSfmlInputStream; FragmentShaderStream: PSfmlInputStream): PSfmlShader; cdecl;
  TSfmlShaderDestroy = procedure (Shader: PSfmlShader); cdecl;
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
  TSfmlShaderBind = procedure (const Shader: PSfmlShader); cdecl;
  TSfmlShaderIsAvailable = function : sfBool; cdecl;

  TSfmlShapeCreate = function (getPointCount: TSfmlShapeGetPointCountCallback; GetPoint: TSfmlShapeGetPointCallback; userData: Pointer): PSfmlShape; cdecl;
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
  TSfmlShapeSetTexture = procedure (Shape: PSfmlShape; const Texture: PSfmlTexture; ResetRect: sfBool); cdecl;
  TSfmlShapeSetTextureRect = procedure (Shape: PSfmlShape; Rect: TSfmlIntRect); cdecl;
  TSfmlShapeSetFillColor = procedure (Shape: PSfmlShape; Color: TSfmlColor); cdecl;
  TSfmlShapeSetOutlineColor = procedure (Shape: PSfmlShape; Color: TSfmlColor); cdecl;
  TSfmlShapeSetOutlineThickness = procedure (Shape: PSfmlShape; Thickness: Single); cdecl;
  TSfmlShapeGetTexture = function (const Shape: PSfmlShape): PSfmlTexture; cdecl;
  TSfmlShapeGetTextureRect = function (const Shape: PSfmlShape): TSfmlIntRect; cdecl;
  TSfmlShapeGetFillColor = function (const Shape: PSfmlShape): TSfmlColor; cdecl;
  TSfmlShapeGetOutlineColor = function (const Shape: PSfmlShape): TSfmlColor; cdecl;
  TSfmlShapeGetOutlineThickness = function (const Shape: PSfmlShape): Single; cdecl;
  TSfmlShapeGetPointCount = function (const Shape: PSfmlShape): Cardinal; cdecl;
  TSfmlShapeGetPoint = function (const Shape: PSfmlShape; Index: Cardinal): TSfmlVector2f; cdecl;
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
  TSfmlSpriteSetTexture = procedure (Sprite: PSfmlSprite; const Texture: PSfmlTexture; resetRect: sfBool); cdecl;
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
  TSfmlTextSetString = procedure (Text: PSfmlText; const &string: PAnsiChar); cdecl;
  TSfmlTextSetUnicodeString = procedure (Text: PSfmlText; const &string: PWideChar); cdecl;
  TSfmlTextSetFont = procedure (Text: PSfmlText; const Font: PSfmlFont); cdecl;
  TSfmlTextSetCharacterSize = procedure (Text: PSfmlText; Size: Cardinal); cdecl;
  TSfmlTextSetStyle = procedure (Text: PSfmlText; Style: sfUint32); cdecl;
  TSfmlTextSetColor = procedure (Text: PSfmlText; Color: TSfmlColor); cdecl;
  TSfmlTextGetString = function (const Text: PSfmlText): PAnsiChar; cdecl;
  TSfmlTextGetUnicodeString = function (const Text: PSfmlText): PWideChar; cdecl;
  TSfmlTextGetFont = function (const Text: PSfmlText): PSfmlFont; cdecl;
  TSfmlTextGetCharacterSize = function (const Text: PSfmlText): Cardinal; cdecl;
  TSfmlTextGetStyle = function (const Text: PSfmlText): sfUint32; cdecl;
  TSfmlTextGetColor = function (const Text: PSfmlText): TSfmlColor; cdecl;
  TSfmlTextFindCharacterPos = function (const Text: PSfmlText; Index: NativeUInt): TSfmlVector2f; cdecl;
  TSfmlTextGetLocalBounds = function (const Text: PSfmlText): TSfmlFloatRect; cdecl;
  TSfmlTextGetGlobalBounds = function (const Text: PSfmlText): TSfmlFloatRect; cdecl;

  TSfmlTextureCreate = function (Width, Height: Cardinal): PSfmlTexture; cdecl;
  TSfmlTextureCreateFromFile = function (const FileName: PAnsiChar; const Area: PSfmlIntRect): PSfmlTexture; cdecl;
  TSfmlTextureCreateFromMemory = function (const data: Pointer; SizeInBytes: NativeUInt; const Area: PSfmlIntRect): PSfmlTexture; cdecl;
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
  TSfmlTextureSetSmooth = procedure (Texture: PSfmlTexture; Smooth: sfBool); cdecl;
  TSfmlTextureIsSmooth = function (const Texture: PSfmlTexture): sfBool; cdecl;
  TSfmlTextureSetRepeated = procedure (Texture: PSfmlTexture; Repeated: sfBool); cdecl;
  TSfmlTextureIsRepeated = function (const Texture: PSfmlTexture): sfBool; cdecl;
  TSfmlTextureBind = procedure (const Texture: PSfmlTexture); cdecl;
  TsfmlTextureGetMaximumSize = function : Cardinal; cdecl;

  TSfmlTransformIdentity = function : TSfmlTransform; cdecl;
  TSfmlTransformFromMatrix = function (a00, a01, a02, a10, a11, a12, a20, a21, a22: Single): TSfmlTransform; cdecl;
  TSfmlTransformGetMatrix = procedure (const Transform: PSfmlTransform; Matrix: PSingle); cdecl;
  TSfmlTransformGetInverse = function (const Transform: PSfmlTransform): TSfmlTransform; cdecl;
  TSfmlTransformTransformPoint = function (const Transform: PSfmlTransform; Point: TSfmlVector2f): TSfmlVector2f; cdecl;
  TSfmlTransformTransformRect = function (const Transform: PSfmlTransform; Rectangle: TSfmlFloatRect): TSfmlFloatRect; cdecl;
  TSfmlTransformCombine = procedure (Transform: PSfmlTransform; const Other: PSfmlTransform); cdecl;
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
  TSfmlVertexArrayGetVertexCount = function (const VertexArray: PSfmlVertexArray): Cardinal; cdecl;
  TSfmlVertexArrayGetVertex = function (VertexArray: PSfmlVertexArray; Index: Cardinal): PSfmlVertex; cdecl;
  TSfmlVertexArrayClear = procedure (VertexArray: PSfmlVertexArray); cdecl;
  TSfmlVertexArrayResize = procedure (VertexArray: PSfmlVertexArray; VertexCount: Cardinal); cdecl;
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
  SfmlBlendAlpha: TSfmlBlendAlpha;
  SfmlBlendAdd: TSfmlBlendAdd;
  SfmlBlendMultiply: TSfmlBlendMultiply;
  SfmlBlendNone: TSfmlBlendNone;

  SfmlBlack: TSfmlColor;
  SfmlWhite: TSfmlColor;
  SfmlRed: TSfmlColor;
  SfmlGreen: TSfmlColor;
  SfmlBlue: TSfmlColor;
  SfmlYellow: TSfmlColor;
  SfmlMagenta: TSfmlColor;
  SfmlCyan: TSfmlColor;
  SfmlTransparent: TSfmlColor;

(*
  SfmlBlack: TSfmlBlack;
  SfmlWhite: TSfmlWhite;
  SfmlRed: TSfmlRed;
  SfmlGreen: TSfmlGreen;
  SfmlBlue: TSfmlBlue;
  SfmlYellow: TSfmlYellow;
  SfmlMagenta: TSfmlMagenta;
  SfmlCyan: TSfmlCyan;
  SfmlTransparent: TSfmlTransparent;
*)
  SfmlColorFromRGB: TSfmlColorFromRGB;
  SfmlColorFromRGBA: TSfmlColorFromRGBA;
  SfmlColorAdd: TSfmlColorAdd;
  SfmlColorModulate: TSfmlColorModulate;

  SfmlCircleShapeCreate: TSfmlCircleShapeCreate;
  SfmlCircleShapeCopy: TSfmlCircleShapeCopy;
  SfmlCircleShapeDestroy: TSfmlCircleShapeDestroy;
  SfmlCircleShapeSetPosition: TSfmlCircleShapeSetPosition;
  SfmlCircleShapeSetRotation: TSfmlCircleShapeSetRotation;
  SfmlCircleShapeSetScale: TSfmlCircleShapeSetScale;
  SfmlCircleShapeSetOrigin: TSfmlCircleShapeSetOrigin;
  SfmlCircleShapeGetPosition: TSfmlCircleShapeGetPosition;
  SfmlCircleShapeGetRotation: TSfmlCircleShapeGetRotation;
  SfmlCircleShapeGetScale: TSfmlCircleShapeGetScale;
  SfmlCircleShapeGetOrigin: TSfmlCircleShapeGetOrigin;
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
  SfmlCircleShapeGetPoint: TSfmlCircleShapeGetPoint;
  SfmlCircleShapeSetRadius: TSfmlCircleShapeSetRadius;
  SfmlCircleShapeGetRadius: TSfmlCircleShapeGetRadius;
  SfmlCircleShapeSetPointCount: TSfmlCircleShapeSetPointCount;
  SfmlCircleShapeGetLocalBounds: TSfmlCircleShapeGetLocalBounds;
  SfmlCircleShapeGetGlobalBounds: TSfmlCircleShapeGetGlobalBounds;

  SfmlConvexShapeCreate: TSfmlConvexShapeCreate;
  SfmlConvexShapeCopy: TSfmlConvexShapeCopy;
  SfmlConvexShapeDestroy: TSfmlConvexShapeDestroy;
  SfmlConvexShapeSetPosition: TSfmlConvexShapeSetPosition;
  SfmlConvexShapeSetRotation: TSfmlConvexShapeSetRotation;
  SfmlConvexShapeSetScale: TSfmlConvexShapeSetScale;
  SfmlConvexShapeSetOrigin: TSfmlConvexShapeSetOrigin;
  SfmlConvexShapeGetPosition: TSfmlConvexShapeGetPosition;
  SfmlConvexShapeGetRotation: TSfmlConvexShapeGetRotation;
  SfmlConvexShapeGetScale: TSfmlConvexShapeGetScale;
  SfmlConvexShapeGetOrigin: TSfmlConvexShapeGetOrigin;
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
  SfmlConvexShapeGetPoint: TSfmlConvexShapeGetPoint;
  SfmlConvexShapeSetPointCount: TSfmlConvexShapeSetPointCount;
  SfmlConvexShapeSetPoint: TSfmlConvexShapeSetPoint;
  SfmlConvexShapeGetLocalBounds: TSfmlConvexShapeGetLocalBounds;
  SfmlConvexShapeGetGlobalBounds: TSfmlConvexShapeGetGlobalBounds;

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
  SfmlImageGetSize: TSfmlImageGetSize;
  SfmlImageCreateMaskFromColor: TSfmlImageCreateMaskFromColor;
  SfmlImageCopyImage: TSfmlImageCopyImage;
  SfmlImageSetPixel: TSfmlImageSetPixel;
  SfmlImageGetPixel: TSfmlImageGetPixel;
  SfmlImageGetPixelsPtr: TSfmlImageGetPixelsPtr;
  SfmlImageFlipHorizontally: TSfmlImageFlipHorizontally;
  SfmlImageFlipVertically: TSfmlImageFlipVertically;

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
  SfmlRectangleShapeGetPosition: TSfmlRectangleShapeGetPosition;
  SfmlRectangleShapeGetRotation: TSfmlRectangleShapeGetRotation;
  SfmlRectangleShapeGetScale: TSfmlRectangleShapeGetScale;
  SfmlRectangleShapeGetOrigin: TSfmlRectangleShapeGetOrigin;
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
  SfmlRectangleShapeGetPoint: TSfmlRectangleShapeGetPoint;
  SfmlRectangleShapeSetSize: TSfmlRectangleShapeSetSize;
  SfmlRectangleShapeGetSize: TSfmlRectangleShapeGetSize;
  SfmlRectangleShapeGetLocalBounds: TSfmlRectangleShapeGetLocalBounds;
  SfmlRectangleShapeGetGlobalBounds: TSfmlRectangleShapeGetGlobalBounds;

  SfmlRenderTextureCreate: TSfmlRenderTextureCreate;
  SfmlRenderTextureDestroy: TSfmlRenderTextureDestroy;
  SfmlRenderTextureGetSize: TSfmlRenderTextureGetSize;
  SfmlRenderTextureSetActive: TSfmlRenderTextureSetActive;
  SfmlRenderTextureDisplay: TSfmlRenderTextureDisplay;
  SfmlRenderTextureClear: TSfmlRenderTextureClear;
  SfmlRenderTextureSetView: TSfmlRenderTextureSetView;
  SfmlRenderTextureGetView: TSfmlRenderTextureGetView;
  SfmlRenderTextureGetDefaultView: TSfmlRenderTextureGetDefaultView;
  SfmlRenderTextureGetViewport: TSfmlRenderTextureGetViewport;
  SfmlRenderTextureMapPixelToCoords: TSfmlRenderTextureMapPixelToCoords;
  SfmlRenderTextureMapCoordsToPixel: TSfmlRenderTextureMapCoordsToPixel;
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
  SfmlRenderWindowGetSize: TSfmlRenderWindowGetSize;
  SfmlRenderWindowSetSize: TSfmlRenderWindowSetSize;
  SfmlRenderWindowSetTitle: TSfmlRenderWindowSetTitle;
  SfmlRenderWindowSetUnicodeTitle: TSfmlRenderWindowSetUnicodeTitle;
  SfmlRenderWindowSetIcon: TSfmlRenderWindowSetIcon;
  SfmlRenderWindowSetVisible: TSfmlRenderWindowSetVisible;
  SfmlRenderWindowSetMouseCursorVisible: TSfmlRenderWindowSetMouseCursorVisible;
  SfmlRenderWindowSetVerticalSyncEnabled: TSfmlRenderWindowSetVerticalSyncEnabled;
  SfmlRenderWindowSetKeyRepeatEnabled: TSfmlRenderWindowSetKeyRepeatEnabled;
  SfmlRenderWindowSetActive: TSfmlRenderWindowSetActive;
  SfmlRenderWindowRequestFocus: TSfmlRenderWindowRequestFocus;
  SfmlRenderWindowHasFocus: TSfmlRenderWindowHasFocus;
  SfmlRenderWindowDisplay: TSfmlRenderWindowDisplay;
  SfmlRenderWindowSetFramerateLimit: TSfmlRenderWindowSetFramerateLimit;
  SfmlRenderWindowSetJoystickThreshold: TSfmlRenderWindowSetJoystickThreshold;
  SfmlRenderWindowGetSystemHandle: TSfmlRenderWindowGetSystemHandle;
  SfmlRenderWindowClear: TSfmlRenderWindowClear;
  SfmlRenderWindowSetView: TSfmlRenderWindowSetView;
  SfmlRenderWindowGetView: TSfmlRenderWindowGetView;
  SfmlRenderWindowGetDefaultView: TSfmlRenderWindowGetDefaultView;
  SfmlRenderWindowGetViewport: TSfmlRenderWindowGetViewport;
  SfmlRenderWindowMapPixelToCoords: TSfmlRenderWindowMapPixelToCoords;
  SfmlRenderWindowMapCoordsToPixel: TSfmlRenderWindowMapCoordsToPixel;
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
  SfmlMouseGetPositionRenderWindow: TSfmlMouseGetPositionRenderWindow;
  SfmlMouseSetPositionRenderWindow: TSfmlMouseSetPositionRenderWindow;
  SfmlTouchGetPositionRenderWindow: TSfmlTouchGetPositionRenderWindow;

  SfmlShaderCreateFromFile: TSfmlShaderCreateFromFile;
  SfmlShaderCreateFromMemory: TSfmlShaderCreateFromMemory;
  SfmlShaderCreateFromStream: TSfmlShaderCreateFromStream;
  SfmlShaderDestroy: TSfmlShaderDestroy;
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
  SfmlShaderBind: TSfmlShaderBind;
  SfmlShaderIsAvailable: TSfmlShaderIsAvailable;

  SfmlShapeCreate: TSfmlShapeCreate;
  SfmlShapeDestroy: TSfmlShapeDestroy;
  SfmlShapeSetPosition: TSfmlShapeSetPosition;
  SfmlShapeSetRotation: TSfmlShapeSetRotation;
  SfmlShapeSetScale: TSfmlShapeSetScale;
  SfmlShapeSetOrigin: TSfmlShapeSetOrigin;
  SfmlShapeGetPosition: TSfmlShapeGetPosition;
  SfmlShapeGetRotation: TSfmlShapeGetRotation;
  SfmlShapeGetScale: TSfmlShapeGetScale;
  SfmlShapeGetOrigin: TSfmlShapeGetOrigin;
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
  SfmlShapeGetPoint: TSfmlShapeGetPoint;
  SfmlShapeGetLocalBounds: TSfmlShapeGetLocalBounds;
  SfmlShapeGetGlobalBounds: TSfmlShapeGetGlobalBounds;
  SfmlShapeUpdate: TSfmlShapeUpdate;

  SfmlSpriteCreate: TSfmlSpriteCreate;
  SfmlSpriteCopy: TSfmlSpriteCopy;
  SfmlSpriteDestroy: TSfmlSpriteDestroy;
  SfmlSpriteSetPosition: TSfmlSpriteSetPosition;
  SfmlSpriteSetRotation: TSfmlSpriteSetRotation;
  SfmlSpriteSetScale: TSfmlSpriteSetScale;
  SfmlSpriteSetOrigin: TSfmlSpriteSetOrigin;
  SfmlSpriteGetPosition: TSfmlSpriteGetPosition;
  SfmlSpriteGetRotation: TSfmlSpriteGetRotation;
  SfmlSpriteGetScale: TSfmlSpriteGetScale;
  SfmlSpriteGetOrigin: TSfmlSpriteGetOrigin;
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

  SfmlTextCreate: TSfmlTextCreate;
  SfmlTextCopy: TSfmlTextCopy;
  SfmlTextDestroy: TSfmlTextDestroy;
  SfmlTextSetPosition: TSfmlTextSetPosition;
  SfmlTextSetRotation: TSfmlTextSetRotation;
  SfmlTextSetScale: TSfmlTextSetScale;
  SfmlTextSetOrigin: TSfmlTextSetOrigin;
  SfmlTextGetPosition: TSfmlTextGetPosition;
  SfmlTextGetRotation: TSfmlTextGetRotation;
  SfmlTextGetScale: TSfmlTextGetScale;
  SfmlTextGetOrigin: TSfmlTextGetOrigin;
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
  SfmlTextGetString: TSfmlTextGetString;
  SfmlTextGetUnicodeString: TSfmlTextGetUnicodeString;
  SfmlTextGetFont: TSfmlTextGetFont;
  SfmlTextGetCharacterSize: TSfmlTextGetCharacterSize;
  SfmlTextGetStyle: TSfmlTextGetStyle;
  SfmlTextGetColor: TSfmlTextGetColor;
  SfmlTextFindCharacterPos: TSfmlTextFindCharacterPos;
  SfmlTextGetLocalBounds: TSfmlTextGetLocalBounds;
  SfmlTextGetGlobalBounds: TSfmlTextGetGlobalBounds;

  SfmlTextureCreate: TSfmlTextureCreate;
  SfmlTextureCreateFromFile: TSfmlTextureCreateFromFile;
  SfmlTextureCreateFromMemory: TSfmlTextureCreateFromMemory;
  SfmlTextureCreateFromStream: TSfmlTextureCreateFromStream;
  SfmlTextureCreateFromImage: TSfmlTextureCreateFromImage;
  SfmlTextureCopy: TSfmlTextureCopy;
  SfmlTextureDestroy: TSfmlTextureDestroy;
  SfmlTextureGetSize: TSfmlTextureGetSize;
  SfmlTextureCopyToImage: TSfmlTextureCopyToImage;
  SfmlTextureUpdateFromPixels: TSfmlTextureUpdateFromPixels;
  SfmlTextureUpdateFromImage: TSfmlTextureUpdateFromImage;
  SfmlTextureUpdateFromWindow: TSfmlTextureUpdateFromWindow;
  SfmlTextureUpdateFromRenderWindow: TSfmlTextureUpdateFromRenderWindow;
  SfmlTextureSetSmooth: TSfmlTextureSetSmooth;
  SfmlTextureIsSmooth: TSfmlTextureIsSmooth;
  SfmlTextureSetRepeated: TSfmlTextureSetRepeated;
  SfmlTextureIsRepeated: TSfmlTextureIsRepeated;
  SfmlTextureBind: TSfmlTextureBind;
  SfmlTextureGetMaximumSize: TsfmlTextureGetMaximumSize;

  SfmlTransformIdentity: TSfmlTransformIdentity;
  SfmlTransformFromMatrix: TSfmlTransformFromMatrix;
  SfmlTransformGetMatrix: TSfmlTransformGetMatrix;
  SfmlTransformGetInverse: TSfmlTransformGetInverse;
  SfmlTransformTransformPoint: TSfmlTransformTransformPoint;
  SfmlTransformTransformRect: TSfmlTransformTransformRect;
  SfmlTransformCombine: TSfmlTransformCombine;
  SfmlTransformTranslate: TSfmlTransformTranslate;
  SfmlTransformRotate: TSfmlTransformRotate;
  SfmlTransformRotateWithCenter: TSfmlTransformRotateWithCenter;
  SfmlTransformScale: TSfmlTransformScale;
  SfmlTransformScaleWithCenter: TSfmlTransformScaleWithCenter;

  SfmlTransformableCreate: TSfmlTransformableCreate;
  SfmlTransformableCopy: TSfmlTransformableCopy;
  SfmlTransformableDestroy: TSfmlTransformableDestroy;
  SfmlTransformableSetPosition: TSfmlTransformableSetPosition;
  SfmlTransformableSetRotation: TSfmlTransformableSetRotation;
  SfmlTransformableSetScale: TSfmlTransformableSetScale;
  SfmlTransformableSetOrigin: TSfmlTransformableSetOrigin;
  SfmlTransformableGetPosition: TSfmlTransformableGetPosition;
  SfmlTransformableGetRotation: TSfmlTransformableGetRotation;
  SfmlTransformableGetScale: TSfmlTransformableGetScale;
  SfmlTransformableGetOrigin: TSfmlTransformableGetOrigin;
  SfmlTransformableMove: TSfmlTransformableMove;
  SfmlTransformableRotate: TSfmlTransformableRotate;
  SfmlTransformableScale: TSfmlTransformableScale;
  SfmlTransformableGetTransform: TSfmlTransformableGetTransform;
  SfmlTransformableGetInverseTransform: TSfmlTransformableGetInverseTransform;

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
  SfmlViewGetCenter: TSfmlViewGetCenter;
  SfmlViewGetSize: TSfmlViewGetSize;
  SfmlViewGetRotation: TSfmlViewGetRotation;
  SfmlViewGetViewport: TSfmlViewGetViewport;
  SfmlViewMove: TSfmlViewMove;
  SfmlViewRotate: TSfmlViewRotate;
  SfmlViewZoom: TSfmlViewZoom;

implementation

var
  CSfmlGraphicsHandle: HINST;
{$IF Defined(MSWINDOWS)}
  CSfmlGraphicsLibrary: PAnsiChar = 'csfml-graphics-2.dll';
{$ELSEIF Defined(DARWIN)}
  error, not yet defined
{$ELSEIF Defined(UNIX)}
  error, not yet defined
{$IFEND}

procedure InitDLL;
begin
  CSfmlGraphicsHandle := LoadLibraryA(CSfmlGraphicsLibrary);
  if CSfmlGraphicsHandle <> 0 then
    try
      SfmlBlendAlpha := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfBlendAlpha'));
      Assert(Assigned(SfmlBlendAlpha));

      SfmlBlendAdd := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfBlendAdd'));
      Assert(Assigned(SfmlBlendAdd));

      SfmlBlendMultiply := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfBlendMultiply'));
      Assert(Assigned(SfmlBlendMultiply));

      SfmlBlendNone := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfBlendNone'));
      Assert(Assigned(SfmlBlendNone));

      Move(GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfBlack'))^, SfmlBlack, 4);
      Move(GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfWhite'))^, SfmlWhite, 4);
      Move(GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRed'))^, SfmlRed, 4);
      Move(GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfGreen'))^, SfmlGreen, 4);
      Move(GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfBlue'))^, SfmlBlue, 4);
      Move(GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfYellow'))^, SfmlYellow, 4);
      Move(GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfMagenta'))^, SfmlMagenta, 4);
      Move(GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfCyan'))^, SfmlCyan, 4);
      Move(GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfTransparent'))^, SfmlTransparent, 4);

      SfmlColorFromRGB := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfColor_fromRGB'));
      Assert(Assigned(SfmlColorFromRGB));

      SfmlColorFromRGBA := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfColor_fromRGBA'));
      Assert(Assigned(SfmlColorFromRGBA));

      SfmlColorAdd := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfColor_add'));
      Assert(Assigned(SfmlColorAdd));

      SfmlColorModulate := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfColor_modulate'));
      Assert(Assigned(SfmlColorModulate));

      SfmlCircleShapeCreate := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfCircleShape_create'));
      Assert(Assigned(SfmlCircleShapeCreate));

      SfmlCircleShapeCopy := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfCircleShape_copy'));
      Assert(Assigned(SfmlCircleShapeCopy));

      SfmlCircleShapeDestroy := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfCircleShape_destroy'));
      Assert(Assigned(SfmlCircleShapeDestroy));

      SfmlCircleShapeSetPosition := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfCircleShape_setPosition'));
      Assert(Assigned(SfmlCircleShapeSetPosition));

      SfmlCircleShapeSetRotation := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfCircleShape_setRotation'));
      Assert(Assigned(SfmlCircleShapeSetRotation));

      SfmlCircleShapeSetScale := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfCircleShape_setScale'));
      Assert(Assigned(SfmlCircleShapeSetScale));

      SfmlCircleShapeSetOrigin := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfCircleShape_setOrigin'));
      Assert(Assigned(SfmlCircleShapeSetOrigin));

      SfmlCircleShapeGetPosition := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfCircleShape_getPosition'));
      Assert(Assigned(SfmlCircleShapeGetPosition));

      SfmlCircleShapeGetRotation := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfCircleShape_getRotation'));
      Assert(Assigned(SfmlCircleShapeGetRotation));

      SfmlCircleShapeGetScale := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfCircleShape_getScale'));
      Assert(Assigned(SfmlCircleShapeGetScale));

      SfmlCircleShapeGetOrigin := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfCircleShape_getOrigin'));
      Assert(Assigned(SfmlCircleShapeGetOrigin));

      SfmlCircleShapeMove := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfCircleShape_move'));
      Assert(Assigned(SfmlCircleShapeMove));

      SfmlCircleShapeRotate := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfCircleShape_rotate'));
      Assert(Assigned(SfmlCircleShapeRotate));

      SfmlCircleShapeScale := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfCircleShape_scale'));
      Assert(Assigned(SfmlCircleShapeScale));

      SfmlCircleShapeGetTransform := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfCircleShape_getTransform'));
      Assert(Assigned(SfmlCircleShapeGetTransform));

      SfmlCircleShapeGetInverseTransform := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfCircleShape_getInverseTransform'));
      Assert(Assigned(SfmlCircleShapeGetInverseTransform));

      SfmlCircleShapeSetTexture := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfCircleShape_setTexture'));
      Assert(Assigned(SfmlCircleShapeSetTexture));

      SfmlCircleShapeSetTextureRect := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfCircleShape_setTextureRect'));
      Assert(Assigned(SfmlCircleShapeSetTextureRect));

      SfmlCircleShapeSetFillColor := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfCircleShape_setFillColor'));
      Assert(Assigned(SfmlCircleShapeSetFillColor));

      SfmlCircleShapeSetOutlineColor := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfCircleShape_setOutlineColor'));
      Assert(Assigned(SfmlCircleShapeSetOutlineColor));

      SfmlCircleShapeSetOutlineThickness := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfCircleShape_setOutlineThickness'));
      Assert(Assigned(SfmlCircleShapeSetOutlineThickness));

      SfmlCircleShapeGetTexture := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfCircleShape_getTexture'));
      Assert(Assigned(SfmlCircleShapeGetTexture));

      SfmlCircleShapeGetTextureRect := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfCircleShape_getTextureRect'));
      Assert(Assigned(SfmlCircleShapeGetTextureRect));

      SfmlCircleShapeGetFillColor := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfCircleShape_getFillColor'));
      Assert(Assigned(SfmlCircleShapeGetFillColor));

      SfmlCircleShapeGetOutlineColor := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfCircleShape_getOutlineColor'));
      Assert(Assigned(SfmlCircleShapeGetOutlineColor));

      SfmlCircleShapeGetOutlineThickness := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfCircleShape_getOutlineThickness'));
      Assert(Assigned(SfmlCircleShapeGetOutlineThickness));

      SfmlCircleShapeGetPointCount := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfCircleShape_getPointCount'));
      Assert(Assigned(SfmlCircleShapeGetPointCount));

      SfmlCircleShapeGetPoint := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfCircleShape_getPoint'));
      Assert(Assigned(SfmlCircleShapeGetPoint));

      SfmlCircleShapeSetRadius := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfCircleShape_setRadius'));
      Assert(Assigned(SfmlCircleShapeSetRadius));

      SfmlCircleShapeGetRadius := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfCircleShape_getRadius'));
      Assert(Assigned(SfmlCircleShapeGetRadius));

      SfmlCircleShapeSetPointCount := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfCircleShape_setPointCount'));
      Assert(Assigned(SfmlCircleShapeSetPointCount));

      SfmlCircleShapeGetLocalBounds := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfCircleShape_getLocalBounds'));
      Assert(Assigned(SfmlCircleShapeGetLocalBounds));

      SfmlCircleShapeGetGlobalBounds := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfCircleShape_getGlobalBounds'));
      Assert(Assigned(SfmlCircleShapeGetGlobalBounds));

      SfmlConvexShapeCreate:= GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfConvexShape_create'));
      Assert(Assigned(SfmlConvexShapeCreate));

      SfmlConvexShapeCopy := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfConvexShape_copy'));
      Assert(Assigned(SfmlConvexShapeCopy));

      SfmlConvexShapeDestroy := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfConvexShape_destroy'));
      Assert(Assigned(SfmlConvexShapeDestroy));

      SfmlConvexShapeSetPosition := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfConvexShape_setPosition'));
      Assert(Assigned(SfmlConvexShapeSetPosition));

      SfmlConvexShapeSetRotation := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfConvexShape_setRotation'));
      Assert(Assigned(SfmlConvexShapeSetRotation));

      SfmlConvexShapeSetScale := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfConvexShape_setScale'));
      Assert(Assigned(SfmlConvexShapeSetScale));

      SfmlConvexShapeSetOrigin := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfConvexShape_setOrigin'));
      Assert(Assigned(SfmlConvexShapeSetOrigin));

      SfmlConvexShapeGetPosition := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfConvexShape_getPosition'));
      Assert(Assigned(SfmlConvexShapeGetPosition));

      SfmlConvexShapeGetRotation := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfConvexShape_getRotation'));
      Assert(Assigned(SfmlConvexShapeGetRotation));

      SfmlConvexShapeGetScale := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfConvexShape_getScale'));
      Assert(Assigned(SfmlConvexShapeGetScale));

      SfmlConvexShapeGetOrigin := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfConvexShape_getOrigin'));
      Assert(Assigned(SfmlConvexShapeGetOrigin));

      SfmlConvexShapeMove := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfConvexShape_move'));
      Assert(Assigned(SfmlConvexShapeMove));

      SfmlConvexShapeRotate := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfConvexShape_rotate'));
      Assert(Assigned(SfmlConvexShapeRotate));

      SfmlConvexShapeScale := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfConvexShape_scale'));
      Assert(Assigned(SfmlConvexShapeScale));

      SfmlConvexShapeGetTransform := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfConvexShape_getTransform'));
      Assert(Assigned(SfmlConvexShapeGetTransform));

      SfmlConvexShapeGetInverseTransform := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfConvexShape_getInverseTransform'));
      Assert(Assigned(SfmlConvexShapeGetInverseTransform));

      SfmlConvexShapeSetTexture := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfConvexShape_setTexture'));
      Assert(Assigned(SfmlConvexShapeSetTexture));

      SfmlConvexShapeSetTextureRect := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfConvexShape_setTextureRect'));
      Assert(Assigned(SfmlConvexShapeSetTextureRect));

      SfmlConvexShapeSetFillColor := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfConvexShape_setFillColor'));
      Assert(Assigned(SfmlConvexShapeSetFillColor));

      SfmlConvexShapeSetOutlineColor := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfConvexShape_setOutlineColor'));
      Assert(Assigned(SfmlConvexShapeSetOutlineColor));

      SfmlConvexShapeSetOutlineThickness := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfConvexShape_setOutlineThickness'));
      Assert(Assigned(SfmlConvexShapeSetOutlineThickness));

      SfmlConvexShapeGetTexture := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfConvexShape_getTexture'));
      Assert(Assigned(SfmlConvexShapeGetTexture));

      SfmlConvexShapeGetTextureRect := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfConvexShape_getTextureRect'));
      Assert(Assigned(SfmlConvexShapeGetTextureRect));

      SfmlConvexShapeGetFillColor := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfConvexShape_getFillColor'));
      Assert(Assigned(SfmlConvexShapeGetFillColor));

      SfmlConvexShapeGetOutlineColor := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfConvexShape_getOutlineColor'));
      Assert(Assigned(SfmlConvexShapeGetOutlineColor));

      SfmlConvexShapeGetOutlineThickness := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfConvexShape_getOutlineThickness'));
      Assert(Assigned(SfmlConvexShapeGetOutlineThickness));

      SfmlConvexShapeGetPointCount := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfConvexShape_getPointCount'));
      Assert(Assigned(SfmlConvexShapeGetPointCount));

      SfmlConvexShapeGetPoint := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfConvexShape_getPoint'));
      Assert(Assigned(SfmlConvexShapeGetPoint));

      SfmlConvexShapeSetPointCount := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfConvexShape_setPointCount'));
      Assert(Assigned(SfmlConvexShapeSetPointCount));

      SfmlConvexShapeSetPoint := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfConvexShape_setPoint'));
      Assert(Assigned(SfmlConvexShapeSetPoint));

      SfmlConvexShapeGetLocalBounds := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfConvexShape_getLocalBounds'));
      Assert(Assigned(SfmlConvexShapeGetLocalBounds));

      SfmlConvexShapeGetGlobalBounds := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfConvexShape_getGlobalBounds'));
      Assert(Assigned(SfmlConvexShapeGetGlobalBounds));

      SfmlFontCreateFromFile := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfFont_createFromFile'));
      Assert(Assigned(SfmlFontCreateFromFile));

      SfmlFontCreateFromMemory := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfFont_createFromMemory'));
      Assert(Assigned(SfmlFontCreateFromMemory));

      SfmlFontCreateFromStream := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfFont_createFromStream'));
      Assert(Assigned(SfmlFontCreateFromStream));

      SfmlFontCopy := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfFont_copy'));
      Assert(Assigned(SfmlFontCopy));

      SfmlFontDestroy := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfFont_destroy'));
      Assert(Assigned(SfmlFontDestroy));

      SfmlFontGetGlyph := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfFont_getGlyph'));
      Assert(Assigned(SfmlFontGetGlyph));

      SfmlFontGetKerning := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfFont_getKerning'));
      Assert(Assigned(SfmlFontGetKerning));

      SfmlFontGetLineSpacing := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfFont_getLineSpacing'));
      Assert(Assigned(SfmlFontGetLineSpacing));

      SfmlFontGetUnderlinePosition := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfFont_getUnderlinePosition'));
      Assert(Assigned(SfmlFontGetUnderlinePosition));

      SfmlFontGetUnderlineThickness := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfFont_getUnderlineThickness'));
      Assert(Assigned(SfmlFontGetUnderlineThickness));

      SfmlFontGetTexture := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfFont_getTexture'));
      Assert(Assigned(SfmlFontGetTexture));

      SfmlFontGetInfo := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfFont_getInfo'));
      Assert(Assigned(SfmlFontGetInfo));

      SfmlImageCreate := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfImage_create'));
      Assert(Assigned(SfmlImageCreate));

      SfmlImageCreateFromColor := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfImage_createFromColor'));
      Assert(Assigned(SfmlImageCreateFromColor));

      SfmlImageCreateFromPixels := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfImage_createFromPixels'));
      Assert(Assigned(SfmlImageCreateFromPixels));

      SfmlImageCreateFromFile := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfImage_createFromFile'));
      Assert(Assigned(SfmlImageCreateFromFile));

      SfmlImageCreateFromMemory := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfImage_createFromMemory'));
      Assert(Assigned(SfmlImageCreateFromMemory));

      SfmlImageCreateFromStream := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfImage_createFromStream'));
      Assert(Assigned(SfmlImageCreateFromStream));

      SfmlImageCopy := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfImage_copy'));
      Assert(Assigned(SfmlImageCopy));

      SfmlImageDestroy := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfImage_destroy'));
      Assert(Assigned(SfmlImageDestroy));

      SfmlImageSaveToFile := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfImage_saveToFile'));
      Assert(Assigned(SfmlImageSaveToFile));

      SfmlImageGetSize := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfImage_getSize'));
      Assert(Assigned(SfmlImageGetSize));

      SfmlImageCreateMaskFromColor := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfImage_createMaskFromColor'));
      Assert(Assigned(SfmlImageCreateMaskFromColor));

      SfmlImageCopyImage := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfImage_copyImage'));
      Assert(Assigned(SfmlImageCopyImage));

      SfmlImageSetPixel := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfImage_setPixel'));
      Assert(Assigned(SfmlImageSetPixel));

      SfmlImageGetPixel := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfImage_getPixel'));
      Assert(Assigned(SfmlImageGetPixel));

      SfmlImageGetPixelsPtr := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfImage_getPixelsPtr'));
      Assert(Assigned(SfmlImageGetPixelsPtr));

      SfmlImageFlipHorizontally := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfImage_flipHorizontally'));
      Assert(Assigned(SfmlImageFlipHorizontally));

      SfmlImageFlipVertically := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfImage_flipVertically'));
      Assert(Assigned(SfmlImageFlipVertically));

      SfmlFloatRectContains := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfFloatRect_contains'));
      Assert(Assigned(SfmlFloatRectContains));

      SfmlIntRectContains := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfIntRect_contains'));
      Assert(Assigned(SfmlIntRectContains));

      SfmlFloatRectIntersects := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfFloatRect_intersects'));
      Assert(Assigned(SfmlFloatRectIntersects));

      SfmlIntRectIntersects := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfIntRect_intersects'));
      Assert(Assigned(SfmlIntRectIntersects));

      SfmlRectangleShapeCreate := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRectangleShape_create'));
      Assert(Assigned(SfmlRectangleShapeCreate));

      SfmlRectangleShapeCopy := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRectangleShape_copy'));
      Assert(Assigned(SfmlRectangleShapeCopy));

      SfmlRectangleShapeDestroy := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRectangleShape_destroy'));
      Assert(Assigned(SfmlRectangleShapeDestroy));

      SfmlRectangleShapeSetPosition := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRectangleShape_setPosition'));
      Assert(Assigned(SfmlRectangleShapeSetPosition));

      SfmlRectangleShapeSetRotation := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRectangleShape_setRotation'));
      Assert(Assigned(SfmlRectangleShapeSetRotation));

      SfmlRectangleShapeSetScale := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRectangleShape_setScale'));
      Assert(Assigned(SfmlRectangleShapeSetScale));

      SfmlRectangleShapeSetOrigin := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRectangleShape_setOrigin'));
      Assert(Assigned(SfmlRectangleShapeSetOrigin));

      SfmlRectangleShapeGetPosition := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRectangleShape_getPosition'));
      Assert(Assigned(SfmlRectangleShapeGetPosition));

      SfmlRectangleShapeGetRotation := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRectangleShape_getRotation'));
      Assert(Assigned(SfmlRectangleShapeGetRotation));

      SfmlRectangleShapeGetScale := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRectangleShape_getScale'));
      Assert(Assigned(SfmlRectangleShapeGetScale));

      SfmlRectangleShapeGetOrigin := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRectangleShape_getOrigin'));
      Assert(Assigned(SfmlRectangleShapeGetOrigin));

      SfmlRectangleShapeMove := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRectangleShape_move'));
      Assert(Assigned(SfmlRectangleShapeMove));

      SfmlRectangleShapeRotate := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRectangleShape_rotate'));
      Assert(Assigned(SfmlRectangleShapeRotate));

      SfmlRectangleShapeScale := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRectangleShape_scale'));
      Assert(Assigned(SfmlRectangleShapeScale));

      SfmlRectangleShapeGetTransform := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRectangleShape_getTransform'));
      Assert(Assigned(SfmlRectangleShapeGetTransform));

      SfmlRectangleShapeGetInverseTransform := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRectangleShape_getInverseTransform'));
      Assert(Assigned(SfmlRectangleShapeGetInverseTransform));

      SfmlRectangleShapeSetTexture := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRectangleShape_setTexture'));
      Assert(Assigned(SfmlRectangleShapeSetTexture));

      SfmlRectangleShapeSetTextureRect := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRectangleShape_setTextureRect'));
      Assert(Assigned(SfmlRectangleShapeSetTextureRect));

      SfmlRectangleShapeSetFillColor := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRectangleShape_setFillColor'));
      Assert(Assigned(SfmlRectangleShapeSetFillColor));

      SfmlRectangleShapeSetOutlineColor := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRectangleShape_setOutlineColor'));
      Assert(Assigned(SfmlRectangleShapeSetOutlineColor));

      SfmlRectangleShapeSetOutlineThickness := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRectangleShape_setOutlineThickness'));
      Assert(Assigned(SfmlRectangleShapeSetOutlineThickness));

      SfmlRectangleShapeGetTexture := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRectangleShape_getTexture'));
      Assert(Assigned(SfmlRectangleShapeGetTexture));

      SfmlRectangleShapeGetTextureRect := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRectangleShape_getTextureRect'));
      Assert(Assigned(SfmlRectangleShapeGetTextureRect));

      SfmlRectangleShapeGetFillColor := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRectangleShape_getFillColor'));
      Assert(Assigned(SfmlRectangleShapeGetFillColor));

      SfmlRectangleShapeGetOutlineColor := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRectangleShape_getOutlineColor'));
      Assert(Assigned(SfmlRectangleShapeGetOutlineColor));

      SfmlRectangleShapeGetOutlineThickness := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRectangleShape_getOutlineThickness'));
      Assert(Assigned(SfmlRectangleShapeGetOutlineThickness));

      SfmlRectangleShapeGetPointCount := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRectangleShape_getPointCount'));
      Assert(Assigned(SfmlRectangleShapeGetPointCount));

      SfmlRectangleShapeGetPoint := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRectangleShape_getPoint'));
      Assert(Assigned(SfmlRectangleShapeGetPoint));

      SfmlRectangleShapeSetSize := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRectangleShape_setSize'));
      Assert(Assigned(SfmlRectangleShapeSetSize));

      SfmlRectangleShapeGetSize := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRectangleShape_getSize'));
      Assert(Assigned(SfmlRectangleShapeGetSize));

      SfmlRectangleShapeGetLocalBounds := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRectangleShape_getLocalBounds'));
      Assert(Assigned(SfmlRectangleShapeGetLocalBounds));

      SfmlRectangleShapeGetGlobalBounds := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRectangleShape_getGlobalBounds'));
      Assert(Assigned(SfmlRectangleShapeGetGlobalBounds));

      SfmlRenderTextureCreate := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderTexture_create'));
      Assert(Assigned(SfmlRenderTextureCreate));

      SfmlRenderTextureDestroy := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderTexture_destroy'));
      Assert(Assigned(SfmlRenderTextureDestroy));

      SfmlRenderTextureGetSize := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderTexture_getSize'));
      Assert(Assigned(SfmlRenderTextureGetSize));

      SfmlRenderTextureSetActive := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderTexture_setActive'));
      Assert(Assigned(SfmlRenderTextureSetActive));

      SfmlRenderTextureDisplay := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderTexture_display'));
      Assert(Assigned(SfmlRenderTextureDisplay));

      SfmlRenderTextureClear := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderTexture_clear'));
      Assert(Assigned(SfmlRenderTextureClear));

      SfmlRenderTextureSetView := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderTexture_setView'));
      Assert(Assigned(SfmlRenderTextureSetView));

      SfmlRenderTextureGetView := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderTexture_getView'));
      Assert(Assigned(SfmlRenderTextureGetView));

      SfmlRenderTextureGetDefaultView := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderTexture_getDefaultView'));
      Assert(Assigned(SfmlRenderTextureGetDefaultView));

      SfmlRenderTextureGetViewport := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderTexture_getViewport'));
      Assert(Assigned(SfmlRenderTextureGetViewport));

      SfmlRenderTextureMapPixelToCoords := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderTexture_mapPixelToCoords'));
      Assert(Assigned(SfmlRenderTextureMapPixelToCoords));

      SfmlRenderTextureMapCoordsToPixel := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderTexture_mapCoordsToPixel'));
      Assert(Assigned(SfmlRenderTextureMapCoordsToPixel));

      SfmlRenderTextureDrawSprite := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderTexture_drawSprite'));
      Assert(Assigned(SfmlRenderTextureDrawSprite));

      SfmlRenderTextureDrawText := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderTexture_drawText'));
      Assert(Assigned(SfmlRenderTextureDrawText));

      SfmlRenderTextureDrawShape := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderTexture_drawShape'));
      Assert(Assigned(SfmlRenderTextureDrawShape));

      SfmlRenderTextureDrawCircleShape := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderTexture_drawCircleShape'));
      Assert(Assigned(SfmlRenderTextureDrawCircleShape));

      SfmlRenderTextureDrawConvexShape := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderTexture_drawConvexShape'));
      Assert(Assigned(SfmlRenderTextureDrawConvexShape));

      SfmlRenderTextureDrawRectangleShape := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderTexture_drawRectangleShape'));
      Assert(Assigned(SfmlRenderTextureDrawRectangleShape));

      SfmlRenderTextureDrawVertexArray := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderTexture_drawVertexArray'));
      Assert(Assigned(SfmlRenderTextureDrawVertexArray));

      SfmlRenderTextureDrawPrimitives := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderTexture_drawPrimitives'));
      Assert(Assigned(SfmlRenderTextureDrawPrimitives));

      SfmlRenderTexturePushGLStates := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderTexture_pushGLStates'));
      Assert(Assigned(SfmlRenderTexturePushGLStates));

      SfmlRenderTexturePopGLStates := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderTexture_popGLStates'));
      Assert(Assigned(SfmlRenderTexturePopGLStates));

      SfmlRenderTextureResetGLStates := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderTexture_resetGLStates'));
      Assert(Assigned(SfmlRenderTextureResetGLStates));

      SfmlRenderTextureGetTexture := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderTexture_getTexture'));
      Assert(Assigned(SfmlRenderTextureGetTexture));

      SfmlRenderTextureSetSmooth := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderTexture_setSmooth'));
      Assert(Assigned(SfmlRenderTextureSetSmooth));

      SfmlRenderTextureIsSmooth := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderTexture_isSmooth'));
      Assert(Assigned(SfmlRenderTextureIsSmooth));

      SfmlRenderTextureSetRepeated := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderTexture_setRepeated'));
      Assert(Assigned(SfmlRenderTextureSetRepeated));

      SfmlRenderTextureIsRepeated := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderTexture_isRepeated'));
      Assert(Assigned(SfmlRenderTextureIsRepeated));

      SfmlRenderWindowCreate := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderWindow_create'));
      Assert(Assigned(SfmlRenderWindowCreate));

      SfmlRenderWindowCreateUnicode := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderWindow_createUnicode'));
      Assert(Assigned(SfmlRenderWindowCreateUnicode));

      SfmlRenderWindowCreateFromHandle := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderWindow_createFromHandle'));
      Assert(Assigned(SfmlRenderWindowCreateFromHandle));

      SfmlRenderWindowDestroy := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderWindow_destroy'));
      Assert(Assigned(SfmlRenderWindowDestroy));

      SfmlRenderWindowClose := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderWindow_close'));
      Assert(Assigned(SfmlRenderWindowClose));

      SfmlRenderWindowIsOpen := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderWindow_isOpen'));
      Assert(Assigned(SfmlRenderWindowIsOpen));

      SfmlRenderWindowGetSettings := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderWindow_getSettings'));
      Assert(Assigned(SfmlRenderWindowGetSettings));

      SfmlRenderWindowPollEvent := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderWindow_pollEvent'));
      Assert(Assigned(SfmlRenderWindowPollEvent));

      SfmlRenderWindowWaitEvent := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderWindow_waitEvent'));
      Assert(Assigned(SfmlRenderWindowWaitEvent));

      SfmlRenderWindowGetPosition := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderWindow_getPosition'));
      Assert(Assigned(SfmlRenderWindowGetPosition));

      SfmlRenderWindowSetPosition := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderWindow_setPosition'));
      Assert(Assigned(SfmlRenderWindowSetPosition));

      SfmlRenderWindowGetSize := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderWindow_getSize'));
      Assert(Assigned(SfmlRenderWindowGetSize));

      SfmlRenderWindowSetSize := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderWindow_setSize'));
      Assert(Assigned(SfmlRenderWindowSetSize));

      SfmlRenderWindowSetTitle := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderWindow_setTitle'));
      Assert(Assigned(SfmlRenderWindowSetTitle));

      SfmlRenderWindowSetUnicodeTitle := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderWindow_setUnicodeTitle'));
      Assert(Assigned(SfmlRenderWindowSetUnicodeTitle));

      SfmlRenderWindowSetIcon := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderWindow_setIcon'));
      Assert(Assigned(SfmlRenderWindowSetIcon));

      SfmlRenderWindowSetVisible := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderWindow_setVisible'));
      Assert(Assigned(SfmlRenderWindowSetVisible));

      SfmlRenderWindowSetMouseCursorVisible := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderWindow_setMouseCursorVisible'));
      Assert(Assigned(SfmlRenderWindowSetMouseCursorVisible));

      SfmlRenderWindowSetVerticalSyncEnabled := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderWindow_setVerticalSyncEnabled'));
      Assert(Assigned(SfmlRenderWindowSetVerticalSyncEnabled));

      SfmlRenderWindowSetKeyRepeatEnabled := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderWindow_setKeyRepeatEnabled'));
      Assert(Assigned(SfmlRenderWindowSetKeyRepeatEnabled));

      SfmlRenderWindowSetActive := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderWindow_setActive'));
      Assert(Assigned(SfmlRenderWindowSetActive));

      SfmlRenderWindowRequestFocus := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderWindow_requestFocus'));
      Assert(Assigned(SfmlRenderWindowRequestFocus));

      SfmlRenderWindowHasFocus := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderWindow_hasFocus'));
      Assert(Assigned(SfmlRenderWindowHasFocus));

      SfmlRenderWindowDisplay := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderWindow_display'));
      Assert(Assigned(SfmlRenderWindowDisplay));

      SfmlRenderWindowSetFramerateLimit := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderWindow_setFramerateLimit'));
      Assert(Assigned(SfmlRenderWindowSetFramerateLimit));

      SfmlRenderWindowSetJoystickThreshold := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderWindow_setJoystickThreshold'));
      Assert(Assigned(SfmlRenderWindowSetJoystickThreshold));

      SfmlRenderWindowGetSystemHandle := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderWindow_getSystemHandle'));
      Assert(Assigned(SfmlRenderWindowGetSystemHandle));

      SfmlRenderWindowClear := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderWindow_clear'));
      Assert(Assigned(SfmlRenderWindowClear));

      SfmlRenderWindowSetView := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderWindow_setView'));
      Assert(Assigned(SfmlRenderWindowSetView));

      SfmlRenderWindowGetView := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderWindow_getView'));
      Assert(Assigned(SfmlRenderWindowGetView));

      SfmlRenderWindowGetDefaultView := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderWindow_getDefaultView'));
      Assert(Assigned(SfmlRenderWindowGetDefaultView));

      SfmlRenderWindowGetViewport := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderWindow_getViewport'));
      Assert(Assigned(SfmlRenderWindowGetViewport));

      SfmlRenderWindowMapPixelToCoords := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderWindow_mapPixelToCoords'));
      Assert(Assigned(SfmlRenderWindowMapPixelToCoords));

      SfmlRenderWindowMapCoordsToPixel := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderWindow_mapCoordsToPixel'));
      Assert(Assigned(SfmlRenderWindowMapCoordsToPixel));

      SfmlRenderWindowDrawSprite := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderWindow_drawSprite'));
      Assert(Assigned(SfmlRenderWindowDrawSprite));

      SfmlRenderWindowDrawText := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderWindow_drawText'));
      Assert(Assigned(SfmlRenderWindowDrawText));

      SfmlRenderWindowDrawShape := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderWindow_drawShape'));
      Assert(Assigned(SfmlRenderWindowDrawShape));

      SfmlRenderWindowDrawCircleShape := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderWindow_drawCircleShape'));
      Assert(Assigned(SfmlRenderWindowDrawCircleShape));

      SfmlRenderWindowDrawConvexShape := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderWindow_drawConvexShape'));
      Assert(Assigned(SfmlRenderWindowDrawConvexShape));

      SfmlRenderWindowDrawRectangleShape := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderWindow_drawRectangleShape'));
      Assert(Assigned(SfmlRenderWindowDrawRectangleShape));

      SfmlRenderWindowDrawVertexArray := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderWindow_drawVertexArray'));
      Assert(Assigned(SfmlRenderWindowDrawVertexArray));

      SfmlRenderWindowDrawPrimitives := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderWindow_drawPrimitives'));
      Assert(Assigned(SfmlRenderWindowDrawPrimitives));

      SfmlRenderWindowPushGLStates := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderWindow_pushGLStates'));
      Assert(Assigned(SfmlRenderWindowPushGLStates));

      SfmlRenderWindowPopGLStates := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderWindow_popGLStates'));
      Assert(Assigned(SfmlRenderWindowPopGLStates));

      SfmlRenderWindowResetGLStates := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderWindow_resetGLStates'));
      Assert(Assigned(SfmlRenderWindowResetGLStates));

      SfmlRenderWindowCapture := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRenderWindow_capture'));
      Assert(Assigned(SfmlRenderWindowCapture));

      SfmlMouseGetPositionRenderWindow := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfMouse_getPositionRenderWindow'));
      Assert(Assigned(SfmlMouseGetPositionRenderWindow));

      SfmlMouseSetPositionRenderWindow := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfMouse_setPositionRenderWindow'));
      Assert(Assigned(SfmlMouseSetPositionRenderWindow));

      SfmlTouchGetPositionRenderWindow := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfTouch_getPositionRenderWindow'));
      Assert(Assigned(SfmlTouchGetPositionRenderWindow));

      SfmlShaderCreateFromFile := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfShader_createFromFile'));
      Assert(Assigned(SfmlShaderCreateFromFile));

      SfmlShaderCreateFromMemory := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfShader_createFromMemory'));
      Assert(Assigned(SfmlShaderCreateFromMemory));

      SfmlShaderCreateFromStream := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfShader_createFromStream'));
      Assert(Assigned(SfmlShaderCreateFromStream));

      SfmlShaderDestroy := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfShader_destroy'));
      Assert(Assigned(SfmlShaderDestroy));

      SfmlShadersetFloatParameter := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfShader_setFloatParameter'));
      Assert(Assigned(SfmlShadersetFloatParameter));

      SfmlShaderSetFloat2Parameter := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfShader_setFloat2Parameter'));
      Assert(Assigned(SfmlShaderSetFloat2Parameter));

      SfmlShaderSetFloat3Parameter := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfShader_setFloat3Parameter'));
      Assert(Assigned(SfmlShaderSetFloat3Parameter));

      SfmlShaderSetFloat4Parameter := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfShader_setFloat4Parameter'));
      Assert(Assigned(SfmlShaderSetFloat4Parameter));

      SfmlShaderSetVector2Parameter := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfShader_setVector2Parameter'));
      Assert(Assigned(SfmlShaderSetVector2Parameter));

      SfmlShaderSetVector3Parameter := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfShader_setVector3Parameter'));
      Assert(Assigned(SfmlShaderSetVector3Parameter));

      SfmlShaderSetColorParameter := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfShader_setColorParameter'));
      Assert(Assigned(SfmlShaderSetColorParameter));

      SfmlShaderSetTransformParameter := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfShader_setTransformParameter'));
      Assert(Assigned(SfmlShaderSetTransformParameter));

      SfmlShaderSetTextureParameter := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfShader_setTextureParameter'));
      Assert(Assigned(SfmlShaderSetTextureParameter));

      SfmlShaderSetCurrentTextureParameter := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfShader_setCurrentTextureParameter'));
      Assert(Assigned(SfmlShaderSetCurrentTextureParameter));

      SfmlShaderBind := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfShader_bind'));
      Assert(Assigned(SfmlShaderBind));

      SfmlShaderIsAvailable := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfShader_isAvailable'));
      Assert(Assigned(SfmlShaderIsAvailable));

      SfmlShapeCreate := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfShape_create'));
      Assert(Assigned(SfmlShapeCreate));

      SfmlShapeDestroy := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfShape_destroy'));
      Assert(Assigned(SfmlShapeDestroy));

      SfmlShapeSetPosition := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfShape_setPosition'));
      Assert(Assigned(SfmlShapeSetPosition));

      SfmlShapeSetRotation := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfShape_setRotation'));
      Assert(Assigned(SfmlShapeSetRotation));

      SfmlShapeSetScale := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfShape_setScale'));
      Assert(Assigned(SfmlShapeSetScale));

      SfmlShapeSetOrigin := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfShape_setOrigin'));
      Assert(Assigned(SfmlShapeSetOrigin));

      SfmlShapeGetPosition := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfShape_getPosition'));
      Assert(Assigned(SfmlShapeGetPosition));

      SfmlShapeGetRotation := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfShape_getRotation'));
      Assert(Assigned(SfmlShapeGetRotation));

      SfmlShapeGetScale := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfShape_getScale'));
      Assert(Assigned(SfmlShapeGetScale));

      SfmlShapeGetOrigin := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfShape_getOrigin'));
      Assert(Assigned(SfmlShapeGetOrigin));

      SfmlShapeMove := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfShape_move'));
      Assert(Assigned(SfmlShapeMove));

      SfmlShapeRotate := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfShape_rotate'));
      Assert(Assigned(SfmlShapeRotate));

      SfmlShapeScale := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfShape_scale'));
      Assert(Assigned(SfmlShapeScale));

      SfmlShapeGetTransform := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfShape_getTransform'));
      Assert(Assigned(SfmlShapeGetTransform));

      SfmlShapeGetInverseTransform := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfShape_getInverseTransform'));
      Assert(Assigned(SfmlShapeGetInverseTransform));

      SfmlShapeSetTexture := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfShape_setTexture'));
      Assert(Assigned(SfmlShapeSetTexture));

      SfmlShapeSetTextureRect := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfShape_setTextureRect'));
      Assert(Assigned(SfmlShapeSetTextureRect));

      SfmlShapeSetFillColor := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfShape_setFillColor'));
      Assert(Assigned(SfmlShapeSetFillColor));

      SfmlShapeSetOutlineColor := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfShape_setOutlineColor'));
      Assert(Assigned(SfmlShapeSetOutlineColor));

      SfmlShapeSetOutlineThickness := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfShape_setOutlineThickness'));
      Assert(Assigned(SfmlShapeSetOutlineThickness));

      SfmlShapeGetTexture := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfShape_getTexture'));
      Assert(Assigned(SfmlShapeGetTexture));

      SfmlShapeGetTextureRect := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfShape_getTextureRect'));
      Assert(Assigned(SfmlShapeGetTextureRect));

      SfmlShapeGetFillColor := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfShape_getFillColor'));
      Assert(Assigned(SfmlShapeGetFillColor));

      SfmlShapeGetOutlineColor := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfShape_getOutlineColor'));
      Assert(Assigned(SfmlShapeGetOutlineColor));

      SfmlShapeGetOutlineThickness := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfShape_getOutlineThickness'));
      Assert(Assigned(SfmlShapeGetOutlineThickness));

      SfmlShapeGetPointCount := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfShape_getPointCount'));
      Assert(Assigned(SfmlShapeGetPointCount));

      SfmlShapeGetPoint := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfShape_getPoint'));
      Assert(Assigned(SfmlShapeGetPoint));

      SfmlShapeGetLocalBounds := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfShape_getLocalBounds'));
      Assert(Assigned(SfmlShapeGetLocalBounds));

      SfmlShapeGetGlobalBounds := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfShape_getGlobalBounds'));
      Assert(Assigned(SfmlShapeGetGlobalBounds));

      SfmlShapeUpdate := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfShape_update'));
      Assert(Assigned(SfmlShapeUpdate));

      SfmlSpriteCreate := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfSprite_create'));
      Assert(Assigned(SfmlSpriteCreate));

      SfmlSpriteCopy := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfSprite_copy'));
      Assert(Assigned(SfmlSpriteCopy));

      SfmlSpriteDestroy := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfSprite_destroy'));
      Assert(Assigned(SfmlSpriteDestroy));

      SfmlSpriteSetPosition := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfSprite_setPosition'));
      Assert(Assigned(SfmlSpriteSetPosition));

      SfmlSpriteSetRotation := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfSprite_setRotation'));
      Assert(Assigned(SfmlSpriteSetRotation));

      SfmlSpriteSetScale := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfSprite_setScale'));
      Assert(Assigned(SfmlSpriteSetScale));

      SfmlSpriteSetOrigin := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfSprite_setOrigin'));
      Assert(Assigned(SfmlSpriteSetOrigin));

      SfmlSpriteGetPosition := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfSprite_getPosition'));
      Assert(Assigned(SfmlSpriteGetPosition));

      SfmlSpriteGetRotation := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfSprite_getRotation'));
      Assert(Assigned(SfmlSpriteGetRotation));

      SfmlSpriteGetScale := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfSprite_getScale'));
      Assert(Assigned(SfmlSpriteGetScale));

      SfmlSpriteGetOrigin := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfSprite_getOrigin'));
      Assert(Assigned(SfmlSpriteGetOrigin));

      SfmlSpriteMove := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfSprite_move'));
      Assert(Assigned(SfmlSpriteMove));

      SfmlSpriteRotate := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfSprite_rotate'));
      Assert(Assigned(SfmlSpriteRotate));

      SfmlSpriteScale := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfSprite_scale'));
      Assert(Assigned(SfmlSpriteScale));

      SfmlSpriteGetTransform := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfSprite_getTransform'));
      Assert(Assigned(SfmlSpriteGetTransform));

      SfmlSpriteGetInverseTransform := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfSprite_getInverseTransform'));
      Assert(Assigned(SfmlSpriteGetInverseTransform));

      SfmlSpriteSetTexture := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfSprite_setTexture'));
      Assert(Assigned(SfmlSpriteSetTexture));

      SfmlSpriteSetTextureRect := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfSprite_setTextureRect'));
      Assert(Assigned(SfmlSpriteSetTextureRect));

      SfmlSpriteSetColor := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfSprite_setColor'));
      Assert(Assigned(SfmlSpriteSetColor));

      SfmlSpriteGetTexture := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfSprite_getTexture'));
      Assert(Assigned(SfmlSpriteGetTexture));

      SfmlSpriteGetTextureRect := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfSprite_getTextureRect'));
      Assert(Assigned(SfmlSpriteGetTextureRect));

      SfmlSpriteGetColor := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfSprite_getColor'));
      Assert(Assigned(SfmlSpriteGetColor));

      SfmlSpriteGetLocalBounds := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfSprite_getLocalBounds'));
      Assert(Assigned(SfmlSpriteGetLocalBounds));

      SfmlSpriteGetGlobalBounds := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfSprite_getGlobalBounds'));
      Assert(Assigned(SfmlSpriteGetGlobalBounds));

      SfmlTextCreate := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfText_create'));
      Assert(Assigned(SfmlTextCreate));

      SfmlTextCopy := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfText_copy'));
      Assert(Assigned(SfmlTextCopy));

      SfmlTextDestroy := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfText_destroy'));
      Assert(Assigned(SfmlTextDestroy));

      SfmlTextSetPosition := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfText_setPosition'));
      Assert(Assigned(SfmlTextSetPosition));

      SfmlTextSetRotation := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfText_setRotation'));
      Assert(Assigned(SfmlTextSetRotation));

      SfmlTextSetScale := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfText_setScale'));
      Assert(Assigned(SfmlTextSetScale));

      SfmlTextSetOrigin := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfText_setOrigin'));
      Assert(Assigned(SfmlTextSetOrigin));

      SfmlTextGetPosition := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfText_getPosition'));
      Assert(Assigned(SfmlTextGetPosition));

      SfmlTextGetRotation := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfText_getRotation'));
      Assert(Assigned(SfmlTextGetRotation));

      SfmlTextGetScale := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfText_getScale'));
      Assert(Assigned(SfmlTextGetScale));

      SfmlTextGetOrigin := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfText_getOrigin'));
      Assert(Assigned(SfmlTextGetOrigin));

      SfmlTextMove := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfText_move'));
      Assert(Assigned(SfmlTextMove));

      SfmlTextRotate := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfText_rotate'));
      Assert(Assigned(SfmlTextRotate));

      SfmlTextScale := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfText_scale'));
      Assert(Assigned(SfmlTextScale));

      SfmlTextGetTransform := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfText_getTransform'));
      Assert(Assigned(SfmlTextGetTransform));

      SfmlTextGetInverseTransform := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfText_getInverseTransform'));
      Assert(Assigned(SfmlTextGetInverseTransform));

      SfmlTextSetString := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfText_setString'));
      Assert(Assigned(SfmlTextSetString));

      SfmlTextSetUnicodeString := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfText_setUnicodeString'));
      Assert(Assigned(SfmlTextSetUnicodeString));

      SfmlTextSetFont := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfText_setFont'));
      Assert(Assigned(SfmlTextSetFont));

      SfmlTextSetCharacterSize := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfText_setCharacterSize'));
      Assert(Assigned(SfmlTextSetCharacterSize));

      SfmlTextSetStyle := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfText_setStyle'));
      Assert(Assigned(SfmlTextSetStyle));

      SfmlTextSetColor := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfText_setColor'));
      Assert(Assigned(SfmlTextSetColor));

      SfmlTextGetString := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfText_getString'));
      Assert(Assigned(SfmlTextGetString));

      SfmlTextGetUnicodeString := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfText_getUnicodeString'));
      Assert(Assigned(SfmlTextGetUnicodeString));

      SfmlTextGetFont := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfText_getFont'));
      Assert(Assigned(SfmlTextGetFont));

      SfmlTextGetCharacterSize := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfText_getCharacterSize'));
      Assert(Assigned(SfmlTextGetCharacterSize));

      SfmlTextGetStyle := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfText_getStyle'));
      Assert(Assigned(SfmlTextGetStyle));

      SfmlTextGetColor := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfText_getColor'));
      Assert(Assigned(SfmlTextGetColor));

      SfmlTextFindCharacterPos := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfText_findCharacterPos'));
      Assert(Assigned(SfmlTextFindCharacterPos));

      SfmlTextGetLocalBounds := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfText_getLocalBounds'));
      Assert(Assigned(SfmlTextGetLocalBounds));

      SfmlTextGetGlobalBounds := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfText_getGlobalBounds'));
      Assert(Assigned(SfmlTextGetGlobalBounds));

      SfmlTextureCreate := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfTexture_create'));
      Assert(Assigned(SfmlTextureCreate));

      SfmlTextureCreateFromFile := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfTexture_createFromFile'));
      Assert(Assigned(SfmlTextureCreateFromFile));

      SfmlTextureCreateFromMemory := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfTexture_createFromMemory'));
      Assert(Assigned(SfmlTextureCreateFromMemory));

      SfmlTextureCreateFromStream := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfTexture_createFromStream'));
      Assert(Assigned(SfmlTextureCreateFromStream));

      SfmlTextureCreateFromImage := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfTexture_createFromImage'));
      Assert(Assigned(SfmlTextureCreateFromImage));

      SfmlTextureCopy := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfTexture_copy'));
      Assert(Assigned(SfmlTextureCopy));

      SfmlTextureDestroy := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfTexture_destroy'));
      Assert(Assigned(SfmlTextureDestroy));

      SfmlTextureGetSize := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfTexture_getSize'));
      Assert(Assigned(SfmlTextureGetSize));

      SfmlTextureCopyToImage := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfTexture_copyToImage'));
      Assert(Assigned(SfmlTextureCopyToImage));

      SfmlTextureUpdateFromPixels := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfTexture_updateFromPixels'));
      Assert(Assigned(SfmlTextureUpdateFromPixels));

      SfmlTextureUpdateFromImage := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfTexture_updateFromImage'));
      Assert(Assigned(SfmlTextureUpdateFromImage));

      SfmlTextureUpdateFromWindow := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfTexture_updateFromWindow'));
      Assert(Assigned(SfmlTextureUpdateFromWindow));

      SfmlTextureUpdateFromRenderWindow := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfTexture_updateFromRenderWindow'));
      Assert(Assigned(SfmlTextureUpdateFromRenderWindow));

      SfmlTextureSetSmooth := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfTexture_setSmooth'));
      Assert(Assigned(SfmlTextureSetSmooth));

      SfmlTextureIsSmooth := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfTexture_isSmooth'));
      Assert(Assigned(SfmlTextureIsSmooth));

      SfmlTextureSetRepeated := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfTexture_setRepeated'));
      Assert(Assigned(SfmlTextureSetRepeated));

      SfmlTextureIsRepeated := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfTexture_isRepeated'));
      Assert(Assigned(SfmlTextureIsRepeated));

      SfmlTextureBind := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfTexture_bind'));
      Assert(Assigned(SfmlTextureBind));

      SfmlTextureGetMaximumSize := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfTexture_getMaximumSize'));
      Assert(Assigned(SfmlTextureGetMaximumSize));

      SfmlTransformidentity := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfTransform_Identity'));
      Assert(Assigned(SfmlTransformidentity));

      SfmlTransformFromMatrix := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfTransform_fromMatrix'));
      Assert(Assigned(SfmlTransformFromMatrix));

      SfmlTransformGetMatrix := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfTransform_getMatrix'));
      Assert(Assigned(SfmlTransformGetMatrix));

      SfmlTransformGetInverse := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfTransform_getInverse'));
      Assert(Assigned(SfmlTransformGetInverse));

      SfmlTransformTransformPoint := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfTransform_transformPoint'));
      Assert(Assigned(SfmlTransformTransformPoint));

      SfmlTransformTransformRect := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfTransform_transformRect'));
      Assert(Assigned(SfmlTransformTransformRect));

      SfmlTransformCombine := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfTransform_combine'));
      Assert(Assigned(SfmlTransformCombine));

      SfmlTransformTranslate := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfTransform_translate'));
      Assert(Assigned(SfmlTransformTranslate));

      SfmlTransformRotate := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfTransform_rotate'));
      Assert(Assigned(SfmlTransformRotate));

      SfmlTransformRotateWithCenter := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfTransform_rotateWithCenter'));
      Assert(Assigned(SfmlTransformRotateWithCenter));

      SfmlTransformScale := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfTransform_scale'));
      Assert(Assigned(SfmlTransformScale));

      SfmlTransformScaleWithCenter := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfTransform_scaleWithCenter'));
      Assert(Assigned(SfmlTransformScaleWithCenter));

      SfmlTransformableCreate := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfTransformable_create'));
      Assert(Assigned(SfmlTransformableCreate));

      SfmlTransformableCopy := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfTransformable_copy'));
      Assert(Assigned(SfmlTransformableCopy));

      SfmlTransformableDestroy := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfTransformable_destroy'));
      Assert(Assigned(SfmlTransformableDestroy));

      SfmlTransformableSetPosition := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfTransformable_setPosition'));
      Assert(Assigned(SfmlTransformableSetPosition));

      SfmlTransformableSetRotation := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfTransformable_setRotation'));
      Assert(Assigned(SfmlTransformableSetRotation));

      SfmlTransformableSetScale := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfTransformable_setScale'));
      Assert(Assigned(SfmlTransformableSetScale));

      SfmlTransformableSetOrigin := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfTransformable_setOrigin'));
      Assert(Assigned(SfmlTransformableSetOrigin));

      SfmlTransformableGetPosition := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfTransformable_getPosition'));
      Assert(Assigned(SfmlTransformableGetPosition));

      SfmlTransformableGetRotation := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfTransformable_getRotation'));
      Assert(Assigned(SfmlTransformableGetRotation));

      SfmlTransformableGetScale := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfTransformable_getScale'));
      Assert(Assigned(SfmlTransformableGetScale));

      SfmlTransformableGetOrigin := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfTransformable_getOrigin'));
      Assert(Assigned(SfmlTransformableGetOrigin));

      SfmlTransformableMove := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfTransformable_move'));
      Assert(Assigned(SfmlTransformableMove));

      SfmlTransformableRotate := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfTransformable_rotate'));
      Assert(Assigned(SfmlTransformableRotate));

      SfmlTransformableScale := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfTransformable_scale'));
      Assert(Assigned(SfmlTransformableScale));

      SfmlTransformableGetTransform := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfTransformable_getTransform'));
      Assert(Assigned(SfmlTransformableGetTransform));

      SfmlTransformableGetInverseTransform := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfTransformable_getInverseTransform'));
      Assert(Assigned(SfmlTransformableGetInverseTransform));

      SfmlVertexArrayCreate := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfVertexArray_create'));
      Assert(Assigned(SfmlVertexArrayCreate));

      SfmlVertexArrayCopy := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfVertexArray_copy'));
      Assert(Assigned(SfmlVertexArrayCopy));

      SfmlVertexArrayDestroy := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfVertexArray_destroy'));
      Assert(Assigned(SfmlVertexArrayDestroy));

      SfmlVertexArrayGetVertexCount := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfVertexArray_getVertexCount'));
      Assert(Assigned(SfmlVertexArrayGetVertexCount));

      SfmlVertexArrayGetVertex := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfVertexArray_getVertex'));
      Assert(Assigned(SfmlVertexArrayGetVertex));

      SfmlVertexArrayClear := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfVertexArray_clear'));
      Assert(Assigned(SfmlVertexArrayClear));

      SfmlVertexArrayResize := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfVertexArray_resize'));
      Assert(Assigned(SfmlVertexArrayResize));

      SfmlVertexArrayAppend := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfVertexArray_append'));
      Assert(Assigned(SfmlVertexArrayAppend));

      SfmlVertexArraySetPrimitiveType := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfVertexArray_setPrimitiveType'));
      Assert(Assigned(SfmlVertexArraySetPrimitiveType));

      SfmlVertexArrayGetPrimitiveType := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfVertexArray_getPrimitiveType'));
      Assert(Assigned(SfmlVertexArrayGetPrimitiveType));

      SfmlVertexArrayGetBounds := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfVertexArray_getBounds'));
      Assert(Assigned(SfmlVertexArrayGetBounds));

      SfmlViewCreate := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfView_create'));
      Assert(Assigned(SfmlViewCreate));

      SfmlViewCreateFromRect := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfView_createFromRect'));
      Assert(Assigned(SfmlViewCreateFromRect));

      SfmlViewCopy := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfView_copy'));
      Assert(Assigned(SfmlViewCopy));

      SfmlViewDestroy := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfView_destroy'));
      Assert(Assigned(SfmlViewDestroy));

      SfmlViewSetCenter := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfView_setCenter'));
      Assert(Assigned(SfmlViewSetCenter));

      SfmlViewSetSize := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfView_setSize'));
      Assert(Assigned(SfmlViewSetSize));

      SfmlViewSetRotation := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfView_setRotation'));
      Assert(Assigned(SfmlViewSetRotation));

      SfmlViewSetViewport := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfView_setViewport'));
      Assert(Assigned(SfmlViewSetViewport));

      SfmlViewReset := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfView_reset'));
      Assert(Assigned(SfmlViewReset));

      SfmlViewGetCenter := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfView_getCenter'));
      Assert(Assigned(SfmlViewGetCenter));

      SfmlViewGetSize := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfView_getSize'));
      Assert(Assigned(SfmlViewGetSize));

      SfmlViewGetRotation := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfView_getRotation'));
      Assert(Assigned(SfmlViewGetRotation));

      SfmlViewGetViewport := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfView_getViewport'));
      Assert(Assigned(SfmlViewGetViewport));

      SfmlViewMove := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfView_move'));
      Assert(Assigned(SfmlViewMove));

      SfmlViewRotate := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfView_rotate'));
      Assert(Assigned(SfmlViewRotate));

      SfmlViewZoom := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfView_zoom'));
      Assert(Assigned(SfmlViewZoom));
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

initialization

InitDLL;

finalization

FreeDLL;

end.
