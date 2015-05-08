unit Game;

interface

uses
  SysUtils, SfmlGraphics, SfmlSystem, SfmlWindow;

type
  TGame = class
  const
    PlayerSpeed : Single = 100;
    TimePerFrame: TSfmlTime = (MicroSeconds: 16667);  //SfSeconds(1.f/60.f);
  private
    FWindow: TSfmlRenderWindow;
    FTexture: TSfmlTexture;
    FPlayer: TSfmlSprite;
    FFont: TSfmlFont;
    FStatisticsText: TSfmlText;
    FStatisticsUpdateTime: TSfmlTime;

    FStatisticsNumFrames: NativeUInt;
    FIsMovingUp: Boolean;
    FIsMovingDown: Boolean;
    FIsMovingRight: Boolean;
    FIsMovingLeft: Boolean;

    procedure ProcessEvents;
    procedure Update(ElapsedTime: TSfmlTime);
    procedure Render;

    procedure UpdateStatistics(ElapsedTime: TSfmlTime);
    procedure HandlePlayerInput(Key: TSfmlKeyCode; isPressed: Boolean);
  public
    constructor Create;
    procedure Run;
  end;

implementation

{ TGame }

constructor TGame.Create;
begin
  FWindow := TSfmlRenderWindow.Create(SfmlVideoMode(640, 480),
    'SFML Application', [sfClose]);

  Assert(FileExists('../Resources/Eagle.png'));
  FTexture := TSfmlTexture.Create('../Resources/Eagle.png');

  FPlayer := TSfmlSprite.Create(FTexture);
  FPlayer.Position := SfmlVector2f(100, 100);

  Assert(FileExists('../Resources/Sansation.ttf'));
  FFont := TSfmlFont.Create('../Resources/Sansation.ttf');

  FStatisticsText := TSfmlText.Create;
  FStatisticsText.Font := FFont.Handle;
  FStatisticsText.Position := SfmlVector2f(5, 5);
  FStatisticsText.CharacterSize := 10;
  FStatisticsText.Color := SfmlWhite;

  FStatisticsUpdateTime.MicroSeconds := 0;
  FStatisticsNumFrames := 0;
  FIsMovingUp := False;
  FIsMovingDown := False;
  FIsMovingRight := False;
  FIsMovingLeft := False;
end;

procedure TGame.Run;
var
  Clock: TSfmlClock;
  ElapsedTime, TimeSinceLastUpdate: TSfmlTime;
begin
  Clock := TSfmlClock.Create;
  try
    TimeSinceLastUpdate := SfmlTimeZero;
    while FWindow.isOpen do
    begin
      ElapsedTime := Clock.Restart;
      TimeSinceLastUpdate.MicroSeconds := TimeSinceLastUpdate.MicroSeconds + ElapsedTime.MicroSeconds;
      while TimeSinceLastUpdate.MicroSeconds > TimePerFrame.MicroSeconds do
      begin
        TimeSinceLastUpdate.MicroSeconds := TimeSinceLastUpdate.MicroSeconds - TimePerFrame.MicroSeconds;

        ProcessEvents;
        Update(TimePerFrame);
      end;

      UpdateStatistics(ElapsedTime);
      Render;
    end;
  finally
    Clock.Free;
  end;
end;

procedure TGame.ProcessEvents;
var
  Slf: TGame;
  Event: TSfmlEvent;
begin
  // Delphi compiler workaround
  Slf := Self;

  while FWindow.PollEvent(Event) do
  begin

    // Delphi compiler workaround
    if not Assigned(Self) then
      Self := Slf;

    case Event.EventType of
      sfEvtKeyPressed:
        begin
          HandlePlayerInput(Event.Key.Code, True);
          Break;
        end;

      sfEvtKeyReleased:
        begin
          HandlePlayerInput(Event.Key.Code, False);
          Break;
        end;

      sfEvtClosed:
        begin
          FWindow.Close;
          Break;
        end;
    end;
  end;
end;

procedure TGame.Update(ElapsedTime: TSfmlTime);
var
  Movement: TSfmlVector2f;
begin
  Movement := SfmlVector2f(0, 0);
  if FIsMovingUp then
    Movement.Y := Movement.Y - PlayerSpeed;
  if FIsMovingDown then
    Movement.Y := Movement.Y + PlayerSpeed;
  if FIsMovingLeft then
    Movement.X := Movement.X - PlayerSpeed;
  if FIsMovingRight then
    Movement.X := Movement.X + PlayerSpeed;

  FPlayer.Move(
    Movement.X * ElapsedTime.AsSeconds,
    Movement.Y * ElapsedTime.AsSeconds
  );
end;

procedure TGame.Render;
begin
  FWindow.Clear;
  FWindow.Draw(FPlayer);
  FWindow.Draw(FStatisticsText);
  FWindow.Display;
end;

procedure TGame.UpdateStatistics(ElapsedTime: TSfmlTime);
begin
  FStatisticsUpdateTime.MicroSeconds := FStatisticsUpdateTime.MicroSeconds + ElapsedTime.MicroSeconds;
  FStatisticsNumFrames := FStatisticsNumFrames + 1;

  if FStatisticsUpdateTime.MicroSeconds >= SfmlSeconds(1.0).MicroSeconds then
  begin
    FStatisticsText.&String :=
      'Frames / Second := ' + AnsiString(IntToStr(FStatisticsNumFrames)) + #10 +
      'Time / Update := ' + AnsiString(FloatToStr(FStatisticsUpdateTime.MicroSeconds / FStatisticsNumFrames)) + 'us';

    FStatisticsUpdateTime.MicroSeconds := FStatisticsUpdateTime.MicroSeconds - SfmlSeconds(1).MicroSeconds;
    FStatisticsNumFrames := 0;
  end;
end;

procedure TGame.HandlePlayerInput(Key: TSfmlKeyCode; IsPressed: Boolean);
begin
  if Key = sfKeyW then
    FIsMovingUp := isPressed
  else if Key = sfKeyS then
    FIsMovingDown := isPressed
  else if Key = sfKeyA then
    FIsMovingLeft := isPressed
  else if Key = sfKeyD then
    FIsMovingRight := isPressed;
end;

end.
