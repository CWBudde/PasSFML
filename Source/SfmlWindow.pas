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

{$I Sfml.inc}

uses
  {$IFDEF MSWindows} Windows, {$ENDIF} SfmlSystem;

const
{$IF Defined(MSWINDOWS)}
  CSfmlWindowLibrary = 'csfml-window-2.dll';
{$ELSEIF Defined(DARWIN)}
  CSfmlWindowLibrary = 'csfml-window-2.dylib';
{$ELSEIF Defined(UNIX)}
  CSfmlWindowLibrary = 'csfml-window-2.so';
{$IFEND}

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

  TSfmlWindowStyle = (sfTitleBar, sfResize, sfClose, sfFullscreen);
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
  PSfmlEvent = ^TSfmlEvent;

{$IFDEF DynLink}
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
  TSfmlWindowCreateUnicode = function (Mode: TSfmlVideoMode; const Title: PWideChar; style: sfUint32; const Settings: PSfmlContextSettings): PSfmlWindow; cdecl;
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
  TSfmlWindowSetUnicodeTitle = procedure (Window: PSfmlWindow; const Title: PWideChar); cdecl;
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
{$ELSE}
  function SfmlContextCreate: PSfmlContext; cdecl; external CSfmlWindowLibrary name 'sfContext_create';
  procedure SfmlContextDestroy(Context: PSfmlContext); cdecl; external CSfmlWindowLibrary name 'sfContext_destroy';
  procedure SfmlContextSetActive(Context: PSfmlContext; Active: sfBool); cdecl; external CSfmlWindowLibrary name 'sfContext_setActive';

  function SfmlKeyboardIsKeyPressed(Key: TSfmlKeyCode): sfBool; cdecl; external CSfmlWindowLibrary name 'sfKeyboard_isKeyPressed';

  function SfmlJoystickIsConnected(Joystick: Cardinal): sfBool; cdecl; external CSfmlWindowLibrary name 'sfJoystick_isConnected';
  function SfmlJoystickGetButtonCount(Joystick: Cardinal): Cardinal; cdecl; external CSfmlWindowLibrary name 'sfJoystick_getButtonCount';
  function SfmlJoystickHasAxis(Joystick: Cardinal; Axis: TSfmlJoystickAxis): sfBool; cdecl; external CSfmlWindowLibrary name 'sfJoystick_hasAxis';
  function SfmlJoystickIsButtonPressed(Joystick, button: Cardinal): sfBool; cdecl; external CSfmlWindowLibrary name 'sfJoystick_isButtonPressed';
  function SfmlJoystickGetAxisPosition(Joystick: Cardinal; Axis: TSfmlJoystickAxis): Single; cdecl; external CSfmlWindowLibrary name 'sfJoystick_getAxisPosition';
  function SfmlJoystickGetIdentification(Joystick: Cardinal): TSfmlJoystickIdentification; cdecl; external CSfmlWindowLibrary name 'sfJoystick_getIdentification';
  procedure SfmlJoystickUpdate; cdecl; external CSfmlWindowLibrary name 'sfJoystickUpdate';

  function SfmlMouseIsButtonPressed(Button: TSfmlMouseButton): sfBool; cdecl; external CSfmlWindowLibrary name 'sfMouse_isButtonPressed';
  function SfmlMouseGetPosition(const RelativeTo: PSfmlWindow): TSfmlVector2i; cdecl; external CSfmlWindowLibrary name 'sfMouse_getPosition';
  procedure SfmlMouseSetPosition(Position: TSfmlVector2i; const RelativeTo: PSfmlWindow); cdecl; external CSfmlWindowLibrary name 'sfMouse_setPosition';

  function SfmlSensorIsAvailable(Sensor: TSfmlSensorType): sfBool; cdecl; external CSfmlWindowLibrary name 'sfSensor_isAvailable';
  procedure SfmlSensorSetEnabled(Sensor: TSfmlSensorType; Enabled: sfBool); cdecl; external CSfmlWindowLibrary name 'sfSensor_setEnabled';
  function SfmlSensorGetValue(Sensor: TSfmlSensorType): TSfmlVector3f; cdecl; external CSfmlWindowLibrary name 'sfSensor_getValue';

  function SfmlTouchIsDown(Finger: Cardinal): sfBool; cdecl; external CSfmlWindowLibrary name 'sfTouch_isDown';
  function SfmlTouchGetPosition(Finger: Cardinal; const RelativeTo: PSfmlWindow): TSfmlVector2i; cdecl; external CSfmlWindowLibrary name 'sfTouch_getPosition';

  function SfmlVideoModeGetDesktopMode: TSfmlVideoMode; cdecl; external CSfmlWindowLibrary name 'sfVideoMode_getDesktopMode';
  function SfmlVideoModeGetFullscreenModes(var Count: NativeUInt): PSfmlVideoMode; cdecl; external CSfmlWindowLibrary name 'sfVideoMode_getFullscreenModes';
  function SfmlVideoModeIsValid(Mode: TSfmlVideoMode): sfBool; cdecl; external CSfmlWindowLibrary name 'sfVideoMode_isValid';

  function SfmlWindowCreate(Mode: TSfmlVideoMode; const Title: PAnsiChar; Style: TSfmlWindowStyles; const Settings: PSfmlContextSettings): PSfmlWindow; cdecl; external CSfmlWindowLibrary name 'sfWindow_create';
  function SfmlWindowCreateUnicode(Mode: TSfmlVideoMode; const Title: PWideChar; style: sfUint32; const Settings: PSfmlContextSettings): PSfmlWindow; cdecl; external CSfmlWindowLibrary name 'sfWindow_createUnicode';
  function SfmlWindowCreateFromHandle(Handle: TSfmlWindowHandle; const Settings: PSfmlContextSettings): PSfmlWindow; cdecl; external CSfmlWindowLibrary name 'sfWindow_createFromHandle';
  procedure SfmlWindowDestroy(Window: PSfmlWindow); cdecl; external CSfmlWindowLibrary name 'sfWindow_destroy';
  procedure SfmlWindowClose(Window: PSfmlWindow); cdecl; external CSfmlWindowLibrary name 'sfWindow_close';
  function SfmlWindowIsOpen(const Window: PSfmlWindow): sfBool; cdecl; external CSfmlWindowLibrary name 'sfWindow_isOpen';
  function SfmlWindowGetSettings(const Window: PSfmlWindow): TSfmlContextSettings; cdecl; external CSfmlWindowLibrary name 'sfWindow_getSettings';
  function SfmlWindowPollEvent(Window: PSfmlWindow; var Event: TSfmlEvent): sfBool; cdecl; external CSfmlWindowLibrary name 'sfWindow_pollEvent';
  function SfmlWindowWaitEvent(Window: PSfmlWindow; var Event: TSfmlEvent): sfBool; cdecl; external CSfmlWindowLibrary name 'sfWindow_waitEvent';
  function SfmlWindowGetPosition(const Window: PSfmlWindow): TSfmlVector2i; cdecl; external CSfmlWindowLibrary name 'sfWindow_getPosition';
  procedure SfmlWindowSetPosition(Window: PSfmlWindow; Position: TSfmlVector2i); cdecl; external CSfmlWindowLibrary name 'sfWindow_setPosition';
  function SfmlWindowGetSize(const Window: PSfmlWindow): TSfmlVector2u; cdecl; external CSfmlWindowLibrary name 'sfWindow_getSize';
  procedure SfmlWindowSetSize(Window: PSfmlWindow; Size: TSfmlVector2u); cdecl; external CSfmlWindowLibrary name 'sfWindow_setSize';
  procedure SfmlWindowSetTitle(Window: PSfmlWindow; const Title: PAnsiChar); cdecl; external CSfmlWindowLibrary name 'sfWindow_setTitle';
  procedure SfmlWindowSetUnicodeTitle(Window: PSfmlWindow; const Title: PWideChar); cdecl; external CSfmlWindowLibrary name 'sfWindow_setUnicodeTitle';
  procedure SfmlWindowSetIcon(Window: PSfmlWindow; Width, Height: Cardinal; const pixels: PByte); cdecl; external CSfmlWindowLibrary name 'sfWindow_setIcon';
  procedure SfmlWindowSetVisible(Window: PSfmlWindow; Visible: sfBool); cdecl; external CSfmlWindowLibrary name 'sfWindow_setVisible';
  procedure SfmlWindowSetMouseCursorVisible(Window: PSfmlWindow; Visible: sfBool); cdecl; external CSfmlWindowLibrary name 'sfWindow_setMouseCursorVisible';
  procedure SfmlWindowSetVerticalSyncEnabled(Window: PSfmlWindow; Enabled: sfBool); cdecl; external CSfmlWindowLibrary name 'sfWindow_setVerticalSyncEnabled';
  procedure SfmlWindowSetKeyRepeatEnabled(Window: PSfmlWindow; Enabled: sfBool); cdecl; external CSfmlWindowLibrary name 'sfWindow_setKeyRepeatEnabled';
  function SfmlWindowSetActive(Window: PSfmlWindow; Active: sfBool): sfBool; cdecl; external CSfmlWindowLibrary name 'sfWindow_setActive';
  procedure SfmlWindowRequestFocus(Window: PSfmlWindow); cdecl; external CSfmlWindowLibrary name 'sfWindow_requestFocus';
  function SfmlWindowHasFocus(const Window: PSfmlWindow): sfBool; cdecl; external CSfmlWindowLibrary name 'sfWindow_hasFocus';
  procedure SfmlWindowDisplay(Window: PSfmlWindow); cdecl; external CSfmlWindowLibrary name 'sfWindow_display';
  procedure SfmlWindowSetFramerateLimit(Window: PSfmlWindow; limit: Cardinal); cdecl; external CSfmlWindowLibrary name 'sfWindow_setFramerateLimit';
  procedure SfmlWindowSetJoystickThreshold(Window: PSfmlWindow; Threshold: Single); cdecl; external CSfmlWindowLibrary name 'sfWindow_setJoystickThreshold';
  function SfmlWindowGetSystemHandle(const Window: PSfmlWindow): TSfmlWindowHandle; cdecl; external CSfmlWindowLibrary name 'sfWindow_getSystemHandle';
{$ENDIF}

implementation

{$IFDEF DynLink}

var
  CSfmlWindowHandle: HINST;

procedure InitDLL;

  function BindFunction(Name: AnsiString): Pointer;
  begin
    Result := GetProcAddress(CSfmlWindowHandle, PAnsiChar(Name));
    Assert(Assigned(Result));
  end;

begin
  CSfmlWindowHandle := LoadLibraryA(CSfmlWindowLibrary);
  if CSfmlWindowHandle <> 0 then
    try
      SfmlContextCreate := BindFunction('sfContext_create');
      SfmlContextDestroy := BindFunction('sfContext_destroy');
      SfmlContextSetActive := BindFunction('sfContext_setActive');
      SfmlKeyboardIsKeyPressed := BindFunction('sfKeyboard_isKeyPressed');
      SfmlJoystickIsConnected := BindFunction('sfJoystick_isConnected');
      SfmlJoystickGetButtonCount := BindFunction('sfJoystick_getButtonCount');
      SfmlJoystickHasAxis := BindFunction('sfJoystick_hasAxis');
      SfmlJoystickIsButtonPressed := BindFunction('sfJoystick_isButtonPressed');
      SfmlJoystickGetAxisPosition := BindFunction('sfJoystick_getAxisPosition');
      SfmlJoystickGetIdentification := BindFunction('sfJoystick_getIdentification');
      SfmlJoystickUpdate := BindFunction('sfJoystick_update');
      SfmlMouseIsButtonPressed := BindFunction('sfMouse_isButtonPressed');
      SfmlMouseGetPosition := BindFunction('sfMouse_getPosition');
      SfmlMouseSetPosition := BindFunction('sfMouse_setPosition');
      SfmlSensorIsAvailable := BindFunction('sfSensor_isAvailable');
      SfmlSensorSetEnabled := BindFunction('sfSensor_setEnabled');
      SfmlSensorGetValue := BindFunction('sfSensor_getValue');
      SfmlTouchIsDown := BindFunction('sfTouch_isDown');
      SfmlTouchGetPosition := BindFunction('sfTouch_getPosition');
      SfmlVideoModeGetDesktopMode := BindFunction('sfVideoMode_getDesktopMode');
      SfmlVideoModeGetFullscreenModes := BindFunction('sfVideoMode_getFullscreenModes');
      SfmlVideoModeIsValid := BindFunction('sfVideoMode_isValid');
      SfmlWindowCreate := BindFunction('sfWindow_create');
      SfmlWindowCreateUnicode := BindFunction('sfWindow_createUnicode');
      SfmlWindowCreateFromHandle := BindFunction('sfWindow_createFromHandle');
      SfmlWindowDestroy := BindFunction('sfWindow_destroy');
      SfmlWindowClose := BindFunction('sfWindow_close');
      SfmlWindowIsOpen := BindFunction('sfWindow_isOpen');
      SfmlWindowGetSettings := BindFunction('sfWindow_getSettings');
      SfmlWindowPollEvent := BindFunction('sfWindow_pollEvent');
      SfmlWindowWaitEvent := BindFunction('sfWindow_waitEvent');
      SfmlWindowGetPosition := BindFunction('sfWindow_getPosition');
      SfmlWindowSetPosition := BindFunction('sfWindow_setPosition');
      SfmlWindowGetSize := BindFunction('sfWindow_getSize');
      SfmlWindowSetSize := BindFunction('sfWindow_setSize');
      SfmlWindowSetTitle := BindFunction('sfWindow_setTitle');
      SfmlWindowSetUnicodeTitle := BindFunction('sfWindow_setUnicodeTitle');
      SfmlWindowSetIcon := BindFunction('sfWindow_setIcon');
      SfmlWindowSetVisible := BindFunction('sfWindow_setVisible');
      SfmlWindowSetMouseCursorVisible := BindFunction('sfWindow_setMouseCursorVisible');
      SfmlWindowSetVerticalSyncEnabled := BindFunction('sfWindow_setVerticalSyncEnabled');
      SfmlWindowSetKeyRepeatEnabled := BindFunction('sfWindow_setKeyRepeatEnabled');
      SfmlWindowSetActive := BindFunction('sfWindow_setActive');
      SfmlWindowRequestFocus := BindFunction('sfWindow_requestFocus');
      SfmlWindowHasFocus := BindFunction('sfWindow_hasFocus');
      SfmlWindowDisplay := BindFunction('sfWindow_display');
      SfmlWindowSetFramerateLimit := BindFunction('sfWindow_setFramerateLimit');
      SfmlWindowSetJoystickThreshold := BindFunction('sfWindow_setJoystickThreshold');
      SfmlWindowGetSystemHandle := BindFunction('sfWindow_getSystemHandle');
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

{$ENDIF}

end.
