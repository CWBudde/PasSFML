program Pong;

uses
  SysUtils,
  SfmlAudio in '..\..\Source\SfmlAudio.pas',
  SfmlGraphics in '..\..\Source\SfmlGraphics.pas',
  SfmlNetwork in '..\..\Source\SfmlNetwork.pas',
  SfmlSystem in '..\..\Source\SfmlSystem.pas',
  SfmlWindow in '..\..\Source\SfmlWindow.pas';

// Define some constants
const
  Pi = 3.14159;
  GameWidth = 800;
  GameHeight = 600;
  PaddleSize: TSfmlVector2f = (X: 25; Y: 100);
  BallRadius: Single = 10;
  AITime : TSfmlTime = (MicroSeconds: 1000);
  PaddleSpeed: Single = 400;
  BallSpeed: Single = 400;
var
  Window: TSfmlRenderWindow;
  BallSoundBuffer: TSfmlSoundBuffer;
  BallSound: TSfmlSound;
  LeftPaddle, RightPaddle: TSfmlRectangleShape;
  Ball: TSfmlCircleShape;
  Font: TSfmlFont;
  PauseMessage: TSfmlText;
  AITimer, Clock: TSfmlClock;
  IsPlaying: Boolean;
  Event: TSfmlEvent;
  DeltaTime, Factor: Single;
  RightPaddleSpeed: Single = 0;
  BallAngle: Single = 0;
begin
  Randomize;

  // Create the window of the application
  Window := TSfmlRenderWindow.Create(SfmlVideoMode(GameWidth, GameHeight, 32),
    AnsiString('SFML Pong'), [sfTitleBar, sfClose], nil);
  Window.SetVerticalSyncEnabled(True);

  // Load the sounds used in the game
  BallSoundBuffer := TSfmlSoundBuffer.Create('../Resources/Ball.wav');
  BallSound := TSfmlSound.Create;
  BallSound.SetBuffer(BallSoundBuffer);

  // Create the left paddle
  LeftPaddle := TSfmlRectangleShape.Create;
  LeftPaddle.Size := SfmlVector2f(PaddleSize.X - 3, PaddleSize.Y - 3);
  LeftPaddle.OutlineThickness := 3;
  LeftPaddle.OutlineColor := SfmlBlack;
  LeftPaddle.FillColor := SfmlColorFromRGB(100, 100, 200);
  LeftPaddle.Origin := SfmlVector2f(0.5 * PaddleSize.X, 0.5 * PaddleSize.Y);

  // Create the right paddle
  RightPaddle := TSfmlRectangleShape.Create;
  RightPaddle.Size := SfmlVector2f(PaddleSize.X - 3, PaddleSize.Y - 3);
  RightPaddle.OutlineThickness := 3;
  RightPaddle.OutlineColor := SfmlBlack;
  RightPaddle.FillColor := SfmlColorFromRGB(200, 100, 100);
  RightPaddle.Origin := SfmlVector2f(0.5 * PaddleSize.X, 0.5 * PaddleSize.Y);

  // Create the ball
  Ball := TSfmlCircleShape.Create;
  Ball.Radius := BallRadius - 3;
  Ball.OutlineThickness := 3;
  Ball.OutlineColor := SfmlBlack;
  Ball.FillColor := SfmlWhite;
  Ball.Origin := SfmlVector2f(0.5 * BallRadius, 0.5 * BallRadius);

  // Load the text font
  Font := TSfmlFont.Create('../Resources/Sansation.ttf');

  // Initialize the pause message
  PauseMessage := TSfmlText.Create;
  PauseMessage.Font := Font.Handle;
  PauseMessage.CharacterSize := 40;
  PauseMessage.Position := SfmlVector2f(170, 150);
  PauseMessage.Color := SfmlWhite;
  PauseMessage.&String := 'Welcome to SFML pong!'#10 +
    'Press space to start the game';

  // Define the paddles properties
  AITimer := TSfmlClock.Create;
  Clock := TSfmlClock.Create;

  IsPlaying := False;
  while Window.isOpen do
  begin
    // Handle events
    while Window.PollEvent(Event) do
    begin
      // Window closed or escape key pressed: exit
      if (Event.EventType = sfEvtClosed) or
        ((Event.EventType = sfEvtKeyPressed) and (Event.Key.Code = sfKeyEscape)) then
      begin
        Window.Close;
        Break;
      end;

      // Space key pressed: play
      if (Event.EventType = sfEvtKeyPressed) and (Event.Key.Code = sfKeySpace) then
      begin
        if not IsPlaying then
        begin
          // (re)start the game
          IsPlaying := True;
          Clock.Restart;

          // Reset the position of the paddles and Ball
          LeftPaddle.Position := SfmlVector2f(10 + 0.5 * PaddleSize.X, 0.5 * GameHeight);
          RightPaddle.Position := SfmlVector2f(GameWidth - 10 - 0.5 * PaddleSize.X, 0.5 * GameHeight);
          Ball.Position := SfmlVector2f(0.5 * GameWidth, 0.5 * GameHeight);

          // Reset the Ball angle
          repeat
            // Make sure the ball initial angle is not too much vertical
            BallAngle := Random * 2 * Pi;
          until Abs(Cos(BallAngle)) >= 0.7;
        end;
      end;
    end;

    if IsPlaying then
    begin
      DeltaTime := Clock.Restart.AsSeconds;

      // Move the player's paddle
      if SfmlKeyboardIsKeyPressed(sfKeyUp) and
        (LeftPaddle.Position.Y - 0.5 * PaddleSize.Y > 5) then
        LeftPaddle.Move(0, -PaddleSpeed * DeltaTime);

      if SfmlKeyboardIsKeyPressed(sfKeyDown) and
        (LeftPaddle.Position.Y + 0.5 * PaddleSize.Y < GameHeight - 5) then
        LeftPaddle.Move(0, PaddleSpeed * DeltaTime);

      // Move the computer's paddle
      if ((RightPaddleSpeed < 0) and (RightPaddle.Position.Y - 0.5 * PaddleSize.Y > 5)) or
        ((RightPaddleSpeed > 0) and (RightPaddle.Position.Y + 0.5 * PaddleSize.Y < GameHeight - 5)) then
        RightPaddle.Move(0, RightPaddleSpeed * DeltaTime);

      // Update the computer's paddle direction according to the ball position
      if AITimer.ElapsedTime.MicroSeconds > AITime.MicroSeconds then
      begin
        AITimer.Restart;
        if (Ball.Position.Y + BallRadius > RightPaddle.Position.Y + 0.5 * PaddleSize.Y) then
          RightPaddleSpeed := PaddleSpeed
        else if (Ball.Position.Y - BallRadius < RightPaddle.Position.Y - 0.5 * PaddleSize.Y) then
          RightPaddleSpeed := -PaddleSpeed
        else
          RightPaddleSpeed := 0;
      end;

      // Move the ball
      Factor := BallSpeed * DeltaTime;
      Ball.Move(Cos(BallAngle) * Factor, Sin(BallAngle) * Factor);

      // Check collisions between the ball and the screen
      if Ball.Position.X - BallRadius < 0 then
      begin
        IsPlaying := False;
        PauseMessage.&String := 'You lost!'#10'Press space to restart or'#10
          + 'escape to exit';
      end
      else if Ball.Position.X + BallRadius > GameWidth then
      begin
        IsPlaying := False;
        PauseMessage.&String := 'You won!'#10'Press space to restart or'#10
          + 'escape to exit';
      end;

      if (Ball.Position.Y - BallRadius < 0) then
      begin
        BallSound.Play;
        BallAngle := -BallAngle;
        Ball.Position := SfmlVector2f(Ball.Position.X, BallRadius + 0.1);
      end
      else if (Ball.Position.Y + BallRadius > GameHeight) then
      begin
        BallSound.Play;
        BallAngle := -BallAngle;
        Ball.Position := SfmlVector2f(Ball.Position.X, GameHeight - BallRadius - 0.1);
      end;

      // Check the collisions between the Ball and the paddles
      // Left Paddle
      if (Ball.Position.X - BallRadius < LeftPaddle.Position.X + 0.5 * PaddleSize.X) and
        (Ball.Position.X - BallRadius > LeftPaddle.Position.X) and
        (Ball.Position.Y + BallRadius >= LeftPaddle.Position.Y - 0.5 * PaddleSize.Y) and
        (Ball.Position.Y - BallRadius <= LeftPaddle.Position.Y + 0.5 * PaddleSize.Y) then
      begin
        if (Ball.Position.Y > LeftPaddle.Position.Y) then
          BallAngle := Pi - BallAngle + Random * Pi / 9
        else
          BallAngle := Pi - BallAngle - Random * pi / 9;

        BallSound.Play;
        Ball.Position := SfmlVector2f(
          LeftPaddle.Position.X + BallRadius +
          0.5 * PaddleSize.X + 0.1, Ball.Position.Y);
      end;

      // Right Paddle
      if (Ball.Position.X + BallRadius > RightPaddle.Position.X - 0.5 * PaddleSize.X) and
        (Ball.Position.X + BallRadius < RightPaddle.Position.X) and
        (Ball.Position.Y + BallRadius >= RightPaddle.Position.Y - 0.5 * PaddleSize.Y) and
        (Ball.Position.Y - BallRadius <= RightPaddle.Position.Y + 0.5 * PaddleSize.Y) then
      begin
        if (Ball.Position.Y > RightPaddle.Position.Y) then
          BallAngle := Pi - BallAngle + Random * Pi / 9
        else
          BallAngle := Pi - BallAngle - Random * Pi / 9;

        BallSound.Play;
        Ball.Position := SfmlVector2f(
          RightPaddle.Position.X - BallRadius - 0.5 * PaddleSize.X - 0.1,
          Ball.Position.Y);
      end;
    end; // isPlaying

    // Clear the window
    Window.Clear(SfmlColorFromRGB(50, 200, 50));

    if IsPlaying then
    begin
      // Draw the paddles and the Ball
      Window.Draw(LeftPaddle);
      Window.Draw(RightPaddle);
      Window.Draw(Ball);
    end
    else
    begin
      // Draw the pause message
      Window.Draw(PauseMessage);
    end;

    // Display things on screen
    Window.Display;
  end;
end.
