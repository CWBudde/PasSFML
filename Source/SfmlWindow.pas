unit SfmlWindow;

////////////////////////////////////////////////////////////
//
// PasSFML - Simple and Fast Multimedia Library for Pascal
// Copyright (C) 2015 Christian-W. Budde (Christian@savioursofsoul.de)
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
  Windows, SfmlSystem;

const
  CSflmJoystickCount       = 8;
  CSflmJoystickButtonCount = 32;
  CSflmJoystickAxisCount   = 8;

type
  PSfmlContext = Pointer;
  PSfmlWindow = Pointer;

  TSfmlVideoMode = record
    Width, Height, BitsPerPixel: Cardinal;
  end;
  PSfmlVideoMode = ^TSfmlVideoMode;

  TSfmlWindowHandle = ^HWND; // Cardinal in linux, Pointer in OSX

  TSfmlWindowStyle = (sfNone, sfTitlebar, sfResize, sfClose, sfFullscreen);
  TSfmlWindowStyles = set of TSfmlWindowStyle;

  TSfmlContextSettings = record
    DepthBits: Cardinal;
    StencilBits: Cardinal;
    AntialiasingLevel: Cardinal;
    MajorVersion: Cardinal;
    MinorVersion: Cardinal;
  end;
  PSfmlContextSettings = ^TSfmlContextSettings;

  TSfmlEventType = (sfEvtClosed, sfEvtResized, sfEvtLostFocus,
    sfEvtGainedFocus, sfEvtTextEntered, sfEvtKeyPressed, sfEvtKeyReleased,
    sfEvtMouseWheelMoved, sfEvtMouseButtonPressed, sfEvtMouseButtonReleased,
    sfEvtMouseMoved, sfEvtMouseEntered, sfEvtMouseLeft,
    sfEvtJoystickButtonPressed, sfEvtJoystickButtonReleased,
    sfEvtJoystickMoved, sfEvtJoystickConnected, sfEvtJoystickDisconnected,
    sfEvtTouchBegan, sfEvtTouchMoved, sfEvtTouchEnded, sfEvtSensorChanged,
    sfEvtCount);

  TSfmlKeyCode = (sfKeyUnknown = -1, sfKeyA, sfKeyB, sfKeyC, sfKeyD,
    sfKeyE, sfKeyF, sfKeyG, sfKeyH, sfKeyI, sfKeyJ, sfKeyK, sfKeyL, sfKeyM,
    sfKeyN, sfKeyO, sfKeyP, sfKeyQ, sfKeyR, sfKeyS, sfKeyT, sfKeyU, sfKeyV,
    sfKeyW, sfKeyX, sfKeyY, sfKeyZ, sfKeyNum0, sfKeyNum1, sfKeyNum2,
    sfKeyNum3, sfKeyNum4, sfKeyNum5, sfKeyNum6, sfKeyNum7, sfKeyNum8,
    sfKeyNum9, sfKeyEscape, sfKeyLControl, sfKeyLShift, sfKeyLAlt,
    sfKeyLSystem, sfKeyRControl, sfKeyRShift, sfKeyRAlt, sfKeyRSystem,
    sfKeyMenu, sfKeyLBracket, sfKeyRBracket, sfKeySemiColon, sfKeyComma,
    sfKeyPeriod, sfKeyQuote, sfKeySlash, sfKeyBackSlash, sfKeyTilde,
    sfKeyEqual, sfKeyDash, sfKeySpace, sfKeyReturn, sfKeyBack, sfKeyTab,
    sfKeyPageUp, sfKeyPageDown, sfKeyEnd, sfKeyHome, sfKeyInsert, sfKeyDelete,
    sfKeyAdd, sfKeySubtract, sfKeyMultiply, sfKeyDivide, sfKeyLeft,
    sfKeyRight, sfKeyUp, sfKeyDown, sfKeyNumpad0, sfKeyNumpad1, sfKeyNumpad2,
    sfKeyNumpad3, sfKeyNumpad4, sfKeyNumpad5, sfKeyNumpad6, sfKeyNumpad7,
    sfKeyNumpad8, sfKeyNumpad9, sfKeyF1, sfKeyF2, sfKeyF3, sfKeyF4, sfKeyF5,
    sfKeyF6, sfKeyF7, sfKeyF8, sfKeyF9, sfKeyF10, sfKeyF11, sfKeyF12, sfKeyF13,
    sfKeyF14, sfKeyF15, sfKeyPause, sfKeyCount);

  TSfmlJoystickAxis = (sfJoystickX, sfJoystickY, sfJoystickZ, sfJoystickR,
    sfJoystickU, sfJoystickV, sfJoystickPovX, sfJoystickPovY);

  TSfmlMouseButton = (sfMouseLeft, sfMouseRight, sfMouseMiddle,
    sfMouseXButton1, sfMouseXButton2, sfMouseButtonCount);

  TSfmlSensorType = (sfSensorAccelerometer, sfSensorGyroscope,
    sfSensorMagnetometer, sfSensorGravity, sfSensorUserAcceleration,
    sfSensorOrientation, sfSensorCount);

  TSfmlKeyEvent = record
    EventType: TSfmlEventType;
    Code: TSfmlKeyCode;
    Alt: sfBool;
    Control: sfBool;
    Shift: sfBool;
    System: sfBool;
  end;

  TSfmlJoystickIdentification = record
    Name: PAnsiChar;
    VendorId: Cardinal;
    ProductId: Cardinal;
  end;

  TSfmlTextEvent = record
    EventType: TSfmlEventType;
    Unicode: sfUint32;
  end;

  TSfmlMouseMoveEvent = record
    EventType: TSfmlEventType;
    X, Y: LongInt;
  end;

  TSfmlMouseButtonEvent = record
    EventType: TSfmlEventType;
    Button: TSfmlMouseButton;
    X, Y: LongInt;
  end;

  TSfmlMouseWheelEvent = record
    EventType: TSfmlEventType;
    Delta, X, Y: LongInt;
  end;

  TSfmlJoystickMoveEvent = record
    EventType: TSfmlEventType;
    JoystickId: Cardinal;
    Axis: TSfmlJoystickAxis;
    Position: Single;
  end;

  TSfmlJoystickButtonEvent = record
    EventType: TSfmlEventType;
    JoystickId, Button: Cardinal;
  end;

  TSfmlJoystickConnectEvent = record
    EventType: TSfmlEventType;
    JoystickId: Cardinal;
  end;

  TSfmlSizeEvent = record
    EventType: TSfmlEventType;
    Width, Height: Cardinal;
  end;

  TSfmlTouchEvent = record
    EventType: TSfmlEventType;
    Finger: Cardinal;
    X, Y: Integer;
  end;

  TSfmlSensorEvent = record
    EventType: TSfmlEventType;
    SensorType: TSfmlSensorType;
    X, Y, Z: Single;
  end;

  TSfmlEvent = record
    case longint of
      0 : ( EventType: TSfmlEventType );
      1 : ( Size : TSfmlSizeEvent );
      2 : ( Key : TSfmlKeyEvent );
      3 : ( Text : TSfmlTextEvent );
      4 : ( MouseMove : TSfmlMouseMoveEvent );
      5 : ( MouseButton : TSfmlMouseButtonEvent );
      6 : ( MouseWheel : TSfmlMouseWheelEvent );
      7 : ( JoystickMove : TSfmlJoystickMoveEvent );
      8 : ( JoystickButton : TSfmlJoystickButtonEvent );
      9 : ( JoystickConnect : TSfmlJoystickConnectEvent );
      10 : ( Touch : TSfmlTouchEvent );
      11 : ( Sensor : TSfmlSensorEvent );
    end;


  TSfmlContextCreate = function : PSfmlContext; cdecl;
  TSfmlContextDestroy = procedure (Context: PSfmlContext); cdecl;
  TSfmlContextSetActive = procedure (Context: PSfmlContext; Active: sfBool); cdecl;

  TSfmlKeyboardIsKeyPressed = function (Key: TSfmlKeyCode): sfBool; cdecl;

  TSfmlJoystickIsConnected = function (Joystick: Cardinal): sfBool; cdecl;
  TSfmlJoystickGetButtonCount = function (Joystick: Cardinal): Cardinal; cdecl;
  TSfmlJoystickHasAxis = function (Joystick: Cardinal; Axis: TSfmlJoystickAxis): sfBool; cdecl;
  TSfmlJoystickIsButtonPressed = function (Joystick, button: Cardinal): sfBool; cdecl;
  TSfmlJoystickGetAxisPosition = function (Joystick: Cardinal; Axis: TSfmlJoystickAxis): Single; cdecl;
  TSfmlJoystickGetIdentification = function (Joystick: Cardinal): TSfmlJoystickIdentification; cdecl;
  TSfmlJoystickUpdate = procedure; cdecl;

  TSfmlMouseIsButtonPressed = function (Button: TSfmlMouseButton): sfBool; cdecl;
  TSfmlMouseGetPosition = function (const RelativeTo: PSfmlWindow): TSfmlVector2i; cdecl;
  TSfmlMouseSetPosition = procedure (Position: TSfmlVector2i; const RelativeTo: PSfmlWindow); cdecl;

  TSfmlSensorIsAvailable = function (Sensor: TSfmlSensorType): sfBool; cdecl;
  TSfmlSensorSetEnabled = procedure (Sensor: TSfmlSensorType; Enabled: sfBool); cdecl;
  TSfmlSensorGetValue = function (Sensor: TSfmlSensorType): TSfmlVector3f; cdecl;

  TSfmlTouchIsDown = function (Finger: Cardinal): sfBool; cdecl;
  TSfmlTouchGetPosition = function (Finger: Cardinal; const RelativeTo: PSfmlWindow): TSfmlVector2i; cdecl;

  TSfmlVideoModeGetDesktopMode = function: TSfmlVideoMode; cdecl;
  TSfmlVideoModeGetFullscreenModes = function (var Count: NativeUInt): PSfmlVideoMode; cdecl;
  TSfmlVideoModeIsValid = function (Mode: TSfmlVideoMode): sfBool; cdecl;

  TSfmlWindowCreate = function (Mode: TSfmlVideoMode; const Title: PAnsiChar; Style: TSfmlWindowStyles; const Settings: PSfmlContextSettings): PSfmlWindow; cdecl;
  TSfmlWindowCreateUnicode = function (Mode: TSfmlVideoMode; const Title: PCardinal; style: sfUint32; const Settings: PSfmlContextSettings): PSfmlWindow; cdecl;
  TSfmlWindowCreateFromHandle = function (Handle: TSfmlWindowHandle; const Settings: PSfmlContextSettings): PSfmlWindow; cdecl;
  TSfmlWindowDestroy = procedure (Window: PSfmlWindow); cdecl;
  TSfmlWindowClose = procedure (Window: PSfmlWindow); cdecl;
  TSfmlWindowIsOpen = function (const Window: PSfmlWindow): sfBool; cdecl;
  TSfmlWindowGetSettings = function (const Window: PSfmlWindow): TSfmlContextSettings; cdecl;
  TSfmlWindowPollEvent = function (Window: PSfmlWindow; var Event: TSfmlEvent): sfBool; cdecl;
  TSfmlWindowWaitEvent = function (Window: PSfmlWindow; var Event: TSfmlEvent): sfBool; cdecl;
  TSfmlWindowGetPosition = function (const Window: PSfmlWindow): TSfmlVector2i; cdecl;
  TSfmlWindowSetPosition = procedure (Window: PSfmlWindow; Position: TSfmlVector2i); cdecl;
  TSfmlWindowGetSize = function (const Window: PSfmlWindow): TSfmlVector2u; cdecl;
  TSfmlWindowSetSize = procedure (Window: PSfmlWindow; Size: TSfmlVector2u); cdecl;
  TSfmlWindowSetTitle = procedure (Window: PSfmlWindow; const Title: PAnsiChar); cdecl;
  TSfmlWindowSetUnicodeTitle = procedure (Window: PSfmlWindow; const Title: PCardinal); cdecl;
  TSfmlWindowSetIcon = procedure (Window: PSfmlWindow; Width, Height: Cardinal; const pixels: PByte); cdecl;
  TSfmlWindowSetVisible = procedure (Window: PSfmlWindow; Visible: sfBool); cdecl;
  TSfmlWindowSetMouseCursorVisible = procedure (Window: PSfmlWindow; Visible: sfBool); cdecl;
  TSfmlWindowSetVerticalSyncEnabled = procedure (Window: PSfmlWindow; Enabled: sfBool); cdecl;
  TSfmlWindowSetKeyRepeatEnabled = procedure (Window: PSfmlWindow; Enabled: sfBool); cdecl;
  TSfmlWindowSetActive = function (Window: PSfmlWindow; Active: sfBool): sfBool; cdecl;
  TSfmlWindowRequestFocus = procedure (Window: PSfmlWindow); cdecl;
  TSfmlWindowHasFocus = function (const Window: PSfmlWindow): sfBool; cdecl;
  TSfmlWindowDisplay = procedure (Window: PSfmlWindow); cdecl;
  TSfmlWindowSetFramerateLimit = procedure (Window: PSfmlWindow; limit: Cardinal); cdecl;
  TSfmlWindowSetJoystickThreshold = procedure (Window: PSfmlWindow; Threshold: Single); cdecl;
  TSfmlWindowGetSystemHandle = function (const Window: PSfmlWindow): TSfmlWindowHandle; cdecl;

var
  SfmlContextCreate: TSfmlContextCreate;
  SfmlContextDestroy: TSfmlContextDestroy;
  SfmlContextSetActive: TSfmlContextSetActive;

  SfmlKeyboardIsKeyPressed: TSfmlKeyboardIsKeyPressed;

  SfmlJoystickIsConnected: TSfmlJoystickIsConnected;
  SfmlJoystickGetButtonCount: TSfmlJoystickGetButtonCount;
  SfmlJoystickHasAxis: TSfmlJoystickHasAxis;
  SfmlJoystickIsButtonPressed: TSfmlJoystickIsButtonPressed;
  SfmlJoystickGetAxisPosition: TSfmlJoystickGetAxisPosition;
  SfmlJoystickGetIdentification: TSfmlJoystickGetIdentification;
  SfmlJoystickUpdate: TSfmlJoystickUpdate;

  SfmlMouseIsButtonPressed: TSfmlMouseIsButtonPressed;
  SfmlMouseGetPosition: TSfmlMouseGetPosition;
  SfmlMouseSetPosition: TSfmlMouseSetPosition;

  SfmlSensorIsAvailable: TSfmlSensorIsAvailable;
  SfmlSensorSetEnabled: TSfmlSensorSetEnabled;
  SfmlSensorGetValue: TSfmlSensorGetValue;

  SfmlTouchIsDown: TSfmlTouchIsDown;
  SfmlTouchGetPosition: TSfmlTouchGetPosition;

  SfmlVideoModeGetDesktopMode: TSfmlVideoModeGetDesktopMode;
  SfmlVideoModeGetFullscreenModes: TSfmlVideoModeGetFullscreenModes;
  SfmlVideoModeIsValid: TSfmlVideoModeIsValid;

  SfmlWindowCreate: TSfmlWindowCreate;
  SfmlWindowCreateUnicode: TSfmlWindowCreateUnicode;
  SfmlWindowCreateFromHandle: TSfmlWindowCreateFromHandle;
  SfmlWindowDestroy: TSfmlWindowDestroy;
  SfmlWindowClose: TSfmlWindowClose;
  SfmlWindowIsOpen: TSfmlWindowIsOpen;
  SfmlWindowGetSettings: TSfmlWindowGetSettings;
  SfmlWindowPollEvent: TSfmlWindowPollEvent;
  SfmlWindowWaitEvent: TSfmlWindowWaitEvent;
  SfmlWindowGetPosition: TSfmlWindowGetPosition;
  SfmlWindowSetPosition: TSfmlWindowSetPosition;
  SfmlWindowGetSize: TSfmlWindowGetSize;
  SfmlWindowSetSize: TSfmlWindowSetSize;
  SfmlWindowSetTitle: TSfmlWindowSetTitle;
  SfmlWindowSetUnicodeTitle: TSfmlWindowSetUnicodeTitle;
  SfmlWindowSetIcon: TSfmlWindowSetIcon;
  SfmlWindowSetVisible: TSfmlWindowSetVisible;
  SfmlWindowSetMouseCursorVisible: TSfmlWindowSetMouseCursorVisible;
  SfmlWindowSetVerticalSyncEnabled: TSfmlWindowSetVerticalSyncEnabled;
  SfmlWindowSetKeyRepeatEnabled: TSfmlWindowSetKeyRepeatEnabled;
  SfmlWindowSetActive: TSfmlWindowSetActive;
  SfmlWindowRequestFocus: TSfmlWindowRequestFocus;
  SfmlWindowHasFocus: TSfmlWindowHasFocus;
  SfmlWindowDisplay: TSfmlWindowDisplay;
  SfmlWindowSetFramerateLimit: TSfmlWindowSetFramerateLimit;
  SfmlWindowSetJoystickThreshold: TSfmlWindowSetJoystickThreshold;
  SfmlWindowGetSystemHandle: TSfmlWindowGetSystemHandle;

implementation


var
  CSfmlWindowHandle: HINST;
{$IF Defined(MSWINDOWS)}
  CSfmlWindowLibrary: PAnsiChar = 'csfml-window-2.dll';
{$ELSEIF Defined(DARWIN)}
  error, not yet defined
{$ELSEIF Defined(UNIX)}
  error, not yet defined
{$IFEND}

procedure InitDLL;
begin
  CSfmlWindowHandle := LoadLibraryA(CSfmlWindowLibrary);
  if CSfmlWindowHandle <> 0 then
    try
      SfmlContextCreate := GetProcAddress(CSfmlWindowHandle, PAnsiChar('sfContext_create'));
      Assert(Assigned(SfmlContextCreate));

      SfmlContextDestroy := GetProcAddress(CSfmlWindowHandle, PAnsiChar('sfContext_destroy'));
      Assert(Assigned(SfmlContextDestroy));

      SfmlContextSetActive := GetProcAddress(CSfmlWindowHandle, PAnsiChar('sfContext_setActive'));
      Assert(Assigned(SfmlContextSetActive));

      SfmlKeyboardIsKeyPressed := GetProcAddress(CSfmlWindowHandle, PAnsiChar('sfKeyboard_isKeyPressed'));
      Assert(Assigned(SfmlKeyboardIsKeyPressed));

      SfmlJoystickIsConnected := GetProcAddress(CSfmlWindowHandle, PAnsiChar('sfJoystick_isConnected'));
      Assert(Assigned(SfmlJoystickIsConnected));

      SfmlJoystickGetButtonCount := GetProcAddress(CSfmlWindowHandle, PAnsiChar('sfJoystick_getButtonCount'));
      Assert(Assigned(SfmlJoystickGetButtonCount));

      SfmlJoystickHasAxis := GetProcAddress(CSfmlWindowHandle, PAnsiChar('sfJoystick_hasAxis'));
      Assert(Assigned(SfmlJoystickHasAxis));

      SfmlJoystickIsButtonPressed := GetProcAddress(CSfmlWindowHandle, PAnsiChar('sfJoystick_isButtonPressed'));
      Assert(Assigned(SfmlJoystickIsButtonPressed));

      SfmlJoystickGetAxisPosition := GetProcAddress(CSfmlWindowHandle, PAnsiChar('sfJoystick_getAxisPosition'));
      Assert(Assigned(SfmlJoystickGetAxisPosition));

      SfmlJoystickGetIdentification := GetProcAddress(CSfmlWindowHandle, PAnsiChar('sfJoystick_getIdentification'));
      Assert(Assigned(SfmlJoystickGetIdentification));

      SfmlJoystickUpdate := GetProcAddress(CSfmlWindowHandle, PAnsiChar('sfJoystick_update'));
      Assert(Assigned(SfmlJoystickUpdate));

      SfmlMouseIsButtonPressed := GetProcAddress(CSfmlWindowHandle, PAnsiChar('sfMouse_isButtonPressed'));
      Assert(Assigned(SfmlMouseIsButtonPressed));

      SfmlMouseGetPosition := GetProcAddress(CSfmlWindowHandle, PAnsiChar('sfMouse_getPosition'));
      Assert(Assigned(SfmlMouseGetPosition));

      SfmlMouseSetPosition := GetProcAddress(CSfmlWindowHandle, PAnsiChar('sfMouse_setPosition'));
      Assert(Assigned(SfmlMouseSetPosition));

      SfmlSensorIsAvailable := GetProcAddress(CSfmlWindowHandle, PAnsiChar('sfSensor_isAvailable'));
      Assert(Assigned(SfmlSensorIsAvailable));

      SfmlSensorSetEnabled := GetProcAddress(CSfmlWindowHandle, PAnsiChar('sfSensor_setEnabled'));
      Assert(Assigned(SfmlSensorSetEnabled));

      SfmlSensorGetValue := GetProcAddress(CSfmlWindowHandle, PAnsiChar('sfSensor_getValue'));
      Assert(Assigned(SfmlSensorGetValue));

      SfmlTouchIsDown := GetProcAddress(CSfmlWindowHandle, PAnsiChar('sfTouch_isDown'));
      Assert(Assigned(SfmlTouchIsDown));

      SfmlTouchGetPosition := GetProcAddress(CSfmlWindowHandle, PAnsiChar('sfTouch_getPosition'));
      Assert(Assigned(SfmlTouchGetPosition));

      SfmlVideoModeGetDesktopMode := GetProcAddress(CSfmlWindowHandle, PAnsiChar('sfVideoMode_getDesktopMode'));
      Assert(Assigned(SfmlVideoModeGetDesktopMode));

      SfmlVideoModeGetFullscreenModes := GetProcAddress(CSfmlWindowHandle, PAnsiChar('sfVideoMode_getFullscreenModes'));
      Assert(Assigned(SfmlVideoModeGetFullscreenModes));

      SfmlVideoModeIsValid := GetProcAddress(CSfmlWindowHandle, PAnsiChar('sfVideoMode_isValid'));
      Assert(Assigned(SfmlVideoModeIsValid));

      SfmlWindowCreate := GetProcAddress(CSfmlWindowHandle, PAnsiChar('sfWindow_create'));
      Assert(Assigned(SfmlWindowCreate));

      SfmlWindowCreateUnicode := GetProcAddress(CSfmlWindowHandle, PAnsiChar('sfWindow_createUnicode'));
      Assert(Assigned(SfmlWindowCreateUnicode));

      SfmlWindowCreateFromHandle := GetProcAddress(CSfmlWindowHandle, PAnsiChar('sfWindow_createFromHandle'));
      Assert(Assigned(SfmlWindowCreateFromHandle));

      SfmlWindowDestroy := GetProcAddress(CSfmlWindowHandle, PAnsiChar('sfWindow_destroy'));
      Assert(Assigned(SfmlWindowDestroy));

      SfmlWindowClose := GetProcAddress(CSfmlWindowHandle, PAnsiChar('sfWindow_close'));
      Assert(Assigned(SfmlWindowClose));

      SfmlWindowIsOpen := GetProcAddress(CSfmlWindowHandle, PAnsiChar('sfWindow_isOpen'));
      Assert(Assigned(SfmlWindowIsOpen));

      SfmlWindowGetSettings := GetProcAddress(CSfmlWindowHandle, PAnsiChar('sfWindow_getSettings'));
      Assert(Assigned(SfmlWindowGetSettings));

      SfmlWindowPollEvent := GetProcAddress(CSfmlWindowHandle, PAnsiChar('sfWindow_pollEvent'));
      Assert(Assigned(SfmlWindowPollEvent));

      SfmlWindowWaitEvent := GetProcAddress(CSfmlWindowHandle, PAnsiChar('sfWindow_waitEvent'));
      Assert(Assigned(SfmlWindowWaitEvent));

      SfmlWindowGetPosition := GetProcAddress(CSfmlWindowHandle, PAnsiChar('sfWindow_getPosition'));
      Assert(Assigned(SfmlWindowGetPosition));

      SfmlWindowSetPosition := GetProcAddress(CSfmlWindowHandle, PAnsiChar('sfWindow_setPosition'));
      Assert(Assigned(SfmlWindowSetPosition));

      SfmlWindowGetSize := GetProcAddress(CSfmlWindowHandle, PAnsiChar('sfWindow_getSize'));
      Assert(Assigned(SfmlWindowGetSize));

      SfmlWindowSetSize := GetProcAddress(CSfmlWindowHandle, PAnsiChar('sfWindow_setSize'));
      Assert(Assigned(SfmlWindowSetSize));

      SfmlWindowSetTitle := GetProcAddress(CSfmlWindowHandle, PAnsiChar('sfWindow_setTitle'));
      Assert(Assigned(SfmlWindowSetTitle));

      SfmlWindowSetUnicodeTitle := GetProcAddress(CSfmlWindowHandle, PAnsiChar('sfWindow_setUnicodeTitle'));
      Assert(Assigned(SfmlWindowSetUnicodeTitle));

      SfmlWindowSetIcon := GetProcAddress(CSfmlWindowHandle, PAnsiChar('sfWindow_setIcon'));
      Assert(Assigned(SfmlWindowSetIcon));

      SfmlWindowSetVisible := GetProcAddress(CSfmlWindowHandle, PAnsiChar('sfWindow_setVisible'));
      Assert(Assigned(SfmlWindowSetVisible));

      SfmlWindowSetMouseCursorVisible := GetProcAddress(CSfmlWindowHandle, PAnsiChar('sfWindow_setMouseCursorVisible'));
      Assert(Assigned(SfmlWindowSetMouseCursorVisible));

      SfmlWindowSetVerticalSyncEnabled := GetProcAddress(CSfmlWindowHandle, PAnsiChar('sfWindow_setVerticalSyncEnabled'));
      Assert(Assigned(SfmlWindowSetVerticalSyncEnabled));

      SfmlWindowSetKeyRepeatEnabled := GetProcAddress(CSfmlWindowHandle, PAnsiChar('sfWindow_setKeyRepeatEnabled'));
      Assert(Assigned(SfmlWindowSetKeyRepeatEnabled));

      SfmlWindowSetActive := GetProcAddress(CSfmlWindowHandle, PAnsiChar('sfWindow_setActive'));
      Assert(Assigned(SfmlWindowSetActive));

      SfmlWindowRequestFocus := GetProcAddress(CSfmlWindowHandle, PAnsiChar('sfWindow_requestFocus'));
      Assert(Assigned(SfmlWindowRequestFocus));

      SfmlWindowHasFocus := GetProcAddress(CSfmlWindowHandle, PAnsiChar('sfWindow_hasFocus'));
      Assert(Assigned(SfmlWindowHasFocus));

      SfmlWindowDisplay := GetProcAddress(CSfmlWindowHandle, PAnsiChar('sfWindow_display'));
      Assert(Assigned(SfmlWindowDisplay));

      SfmlWindowSetFramerateLimit := GetProcAddress(CSfmlWindowHandle, PAnsiChar('sfWindow_setFramerateLimit'));
      Assert(Assigned(SfmlWindowSetFramerateLimit));

      SfmlWindowSetJoystickThreshold := GetProcAddress(CSfmlWindowHandle, PAnsiChar('sfWindow_setJoystickThreshold'));
      Assert(Assigned(SfmlWindowSetJoystickThreshold));

      SfmlWindowGetSystemHandle := GetProcAddress(CSfmlWindowHandle, PAnsiChar('sfWindow_getSystemHandle'));
      Assert(Assigned(SfmlWindowGetSystemHandle));
    except
      FreeLibrary(CSfmlWindowHandle);
      CSfmlWindowHandle := 0;
    end;
end;

procedure FreeDLL;
begin
  if CSfmlWindowHandle <> 0 then
    FreeLibrary(CSfmlWindowHandle);
end;

initialization

InitDLL;

finalization

FreeDLL;

end.
