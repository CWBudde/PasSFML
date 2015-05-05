program Win32;

uses
  SysUtils, Windows, Messages,
  SfmlGraphics in '..\..\Source\SfmlGraphics.pas',
  SfmlSystem in '..\..\Source\SfmlSystem.pas',
  SfmlWindow in '..\..\Source\SfmlWindow.pas';

var
  Button: HWND;

function OnEvent(Handle: HWND; &Message: Cardinal; WParam: WPARAM;
  LParam: LPARAM): LRESULT;
begin
  Result := 0;
  case (message) of
    // Quit when we close the main Window
    WM_CLOSE:
      begin
        PostQuitMessage(0);
        Exit;
      end;

    // Quit when we click the "quit" button
    WM_COMMAND:
      if HWND(lParam) = Button then
      begin
        PostQuitMessage(0);
        Exit;
      end;
  end;

  Result := DefWindowProc(Handle, Message, WParam, LParam);
end;


var
  WindowClass: WNDCLASS;
  Window: HWND;
  View1, View2: HWND;
  SfmlView1, SfmlView2: TSfmlRenderWindow;
  Texture1, Texture2: TSfmlTexture;
  Sprite1, Sprite2: TSfmlSprite;
  Clock: TSfmlClock;
  &Message: MSG;
  Time: Single;
begin
  // Define a class for our main Window
  WindowClass.style         := 0;
  WindowClass.lpfnWndProc   := @OnEvent;
  WindowClass.cbClsExtra    := 0;
  WindowClass.cbWndExtra    := 0;
  WindowClass.hInstance     := hInstance;
  WindowClass.hIcon         := 0;
  WindowClass.hCursor       := 0;
  WindowClass.hbrBackground := HBRUSH(COLOR_BACKGROUND);
  WindowClass.lpszMenuName  := nil;
  WindowClass.lpszClassName := 'SFML App';
  RegisterClass(WindowClass);

  // Let's create the main window
  Window := CreateWindow('SFML App', 'SFML Win32', WS_SYSMENU or WS_VISIBLE,
    200, 200, 660, 520, 0, 0, hInstance, nil);

  // Add a button for exiting
  Button := CreateWindow('BUTTON', 'Quit', WS_CHILD or WS_VISIBLE, 560, 440, 80,
    40, Window, 0, hInstance, nil);

  // Let's create two SFML views
  View1 := CreateWindow('STATIC', nil, WS_CHILD or WS_VISIBLE or WS_CLIPSIBLINGS,
    20,  20, 300, 400, Window, 0, hInstance, nil);
  View2 := CreateWindow('STATIC', nil, WS_CHILD or WS_VISIBLE or WS_CLIPSIBLINGS,
    340, 20, 300, 400, Window, 0, hInstance, nil);
  SfmlView1 := TSfmlRenderWindow.Create(TSfmlWindowHandle(View1));
  SfmlView2 := TSfmlRenderWindow.Create(TSfmlWindowHandle(View2));

  // Load some textures to display
  Texture1 := TSfmlTexture.Create('../Resources/Image1.jpg');
  Texture2 := TSfmlTexture.Create('../Resources/Image2.jpg');
  Sprite1 := TSfmlSprite.Create(Texture1);
  Sprite2 := TSfmlSprite.Create(Texture2);
  Sprite1.Origin := SfmlVector2f(Texture1.Size.X, Texture1.Size.Y);
  Sprite1.Position := Sprite1.Origin;

  // Create a clock for measuring elapsed time
  Clock := TSfmlClock.Create;

  // Loop until a WM_QUIT message is received
  repeat
    if (PeekMessage(&Message, 0, 0, 0, PM_REMOVE)) then
    begin
      // If a message was waiting in the message queue, process it
      TranslateMessage(&Message);
      DispatchMessage(&Message);
    end
    else
    begin
      Time := Clock.ElapsedTime.asSeconds;

      // Clear views
      SfmlView1.Clear;
      SfmlView2.Clear;

      // Draw sprite 1 on view 1
      Sprite1.Rotation := Time * 100;
      SfmlView1.Draw(Sprite1);

      // Draw sprite 2 on view 2
      Sprite2.Position := SfmlVector2f(Cos(time) * 100, 0);
      SfmlView2.Draw(Sprite2);

      // Display each view on screen
      SfmlView1.Display;
      SfmlView2.Display;
    end;
  until &Message.&Message = WM_QUIT;

  // Destroy the main Window (all its child controls will be destroyed)
  DestroyWindow(Window);

  // Don't forget to unregister the window class
  UnregisterClass('SFML App', hInstance);
end.
