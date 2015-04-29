program Window;

uses
  SysUtils,
  {$IFDEF FPC}
  GL,
  {$ELSE}
  OpenGL,
  {$ENDIF}
  SfmlAudio in '..\..\Source\SfmlAudio.pas',
  SfmlGraphics in '..\..\Source\SfmlGraphics.pas',
  SfmlNetwork in '..\..\Source\SfmlNetwork.pas',
  SfmlSystem in '..\..\Source\SfmlSystem.pas',
  SfmlWindow in '..\..\Source\SfmlWindow.pas';

const
  CCube: array [0.. 251] of GLfloat = (
    // positions    // colors (r, g, b, a)
    -50, -50, -50,  0, 0, 1, 1,
    -50,  50, -50,  0, 0, 1, 1,
    -50, -50,  50,  0, 0, 1, 1,
    -50, -50,  50,  0, 0, 1, 1,
    -50,  50, -50,  0, 0, 1, 1,
    -50,  50,  50,  0, 0, 1, 1,

     50, -50, -50,  0, 1, 0, 1,
     50,  50, -50,  0, 1, 0, 1,
     50, -50,  50,  0, 1, 0, 1,
     50, -50,  50,  0, 1, 0, 1,
     50,  50, -50,  0, 1, 0, 1,
     50,  50,  50,  0, 1, 0, 1,

    -50, -50, -50,  1, 0, 0, 1,
     50, -50, -50,  1, 0, 0, 1,
    -50, -50,  50,  1, 0, 0, 1,
    -50, -50,  50,  1, 0, 0, 1,
     50, -50, -50,  1, 0, 0, 1,
     50, -50,  50,  1, 0, 0, 1,

    -50,  50, -50,  0, 1, 1, 1,
     50,  50, -50,  0, 1, 1, 1,
    -50,  50,  50,  0, 1, 1, 1,
    -50,  50,  50,  0, 1, 1, 1,
     50,  50, -50,  0, 1, 1, 1,
     50,  50,  50,  0, 1, 1, 1,

    -50, -50, -50,  1, 0, 1, 1,
     50, -50, -50,  1, 0, 1, 1,
    -50,  50, -50,  1, 0, 1, 1,
    -50,  50, -50,  1, 0, 1, 1,
     50, -50, -50,  1, 0, 1, 1,
     50,  50, -50,  1, 0, 1, 1,

    -50, -50,  50,  1, 1, 0, 1,
     50, -50,  50,  1, 1, 0, 1,
    -50,  50,  50,  1, 1, 0, 1,
    -50,  50,  50,  1, 1, 0, 1,
     50, -50,  50,  1, 1, 0, 1,
     50,  50,  50,  1, 1, 0, 1
  );

var
  ContextSettings: TSfmlContextSettings;
  OutputWindow: TSfmlWindow;
  Ratio: GLfloat;
  Clock: TSfmlClock;
  Event: TSfmlEvent;
begin
    // Request a 32-bits depth buffer when creating the window
    ContextSettings.DepthBits := 32;

    // Create the main window
    OutputWindow := TSfmlWindow.Create(SfmlVideoMode(640, 480),
      'SFML window with OpenGL', [sfTitleBar, sfClose], @ContextSettings);

    // Make it the active window for OpenGL calls
    OutputWindow.SetActive(True);

    // Set the color and depth clear values
    glClearDepth(1);
    glClearColor(0, 0, 0, 1);

    // Enable Z-buffer read and write
    glEnable(GL_DEPTH_TEST);
    glDepthMask(GL_TRUE);

    // Disable lighting and texturing
    glDisable(GL_LIGHTING);
    glDisable(GL_TEXTURE_2D);

    // Configure the viewport (the same size as the window)
    glViewport(0, 0, OutputWindow.Size.X, OutputWindow.Size.Y);

    // Setup a perspective projection
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity;
    Ratio := OutputWindow.Size.X / OutputWindow.Size.Y;
    glFrustum(-Ratio, Ratio, -1, 1, 1, 500);

    // Enable position and color vertex components
    glEnableClientState(GL_VERTEX_ARRAY);
    glEnableClientState(GL_COLOR_ARRAY);
    glVertexPointer(3, GL_FLOAT, 7 * sizeof(GLfloat), @CCube);
    glColorPointer(4, GL_FLOAT, 7 * sizeof(GLfloat), @CCube[3]);

    // Disable normal and texture coordinates vertex components
    glDisableClientState(GL_NORMAL_ARRAY);
    glDisableClientState(GL_TEXTURE_COORD_ARRAY);

    // Create a clock for measuring the time elapsed
    Clock := TSfmlClock.Create;

    // Start the game loop
    while OutputWindow.IsOpen do
    begin
      // Process events
      while OutputWindow.PollEvent(Event) do
      begin
        // Close window: exit
        if Event.EventType = sfEvtClosed then
          OutputWindow.Close;

        // Escape key: exit
        if (Event.EventType = sfEvtKeyPressed) and (Event.key.code = sfKeyEscape) then
          OutputWindow.Close;

        // Resize event: adjust the viewport
        if (Event.EventType = sfEvtResized) then
          glViewport(0, 0, Event.Size.Width, Event.Size.Height);
      end;

      // Clear the color and depth buffers
      glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);

      // Apply some transformations to rotate the cube
      glMatrixMode(GL_MODELVIEW);
      glLoadIdentity();
      glTranslatef(0, 0, -200);
      glRotatef(Clock.GetElapsedTime.AsSeconds * 50, 1, 0, 0);
      glRotatef(Clock.GetElapsedTime.AsSeconds * 30, 0, 1, 0);
      glRotatef(Clock.GetElapsedTime.AsSeconds * 90, 0, 0, 1);

      // Draw the cube
      glDrawArrays(GL_TRIANGLES, 0, 36);

      // Finally, display the rendered frame on screen
      OutputWindow.Display;
    end;
end.
