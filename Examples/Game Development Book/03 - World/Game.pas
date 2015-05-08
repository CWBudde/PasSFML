unit Game;

interface

uses
  SysUtils, World, SfmlGraphics, SfmlWindow, SfmlSystem;

type
  TGame = class
  const
    TimePerFrame: TSfmlTime = (MicroSeconds: 16667);  //SfSeconds(1.f/60.f);
  private
    FWindow: TSfmlRenderWindow;
    FWorld: TWorld;

    FFont: TSfmlFont;
    FStatisticsText: TSfmlText;
    FStatisticsUpdateTime: TSfmlTime;
    FStatisticsNumFrames: NativeUInt;

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
  FWindow := TSfmlRenderWindow.Create(SfmlVideoMode(640, 480), 'World', [sfClose]);
  FWorld := TWorld.Create(FWindow);
  FStatisticsUpdateTime.MicroSeconds := 0;
  FStatisticsNumFrames := 0;

  FFont := TSfmlFont.Create('../Resources/Sansation.ttf');

  FStatisticsText := TSfmlText.Create;
  FStatisticsText.Font := FFont.Handle;
  FStatisticsText.Position := SfmlVector2f(5, 5);
  FStatisticsText.CharacterSize := 10;
end;

procedure TGame.Run;
var
  Clock: TSfmlClock;
  TimeSinceLastUpdate: TSfmlTime;
  ElapsedTime: TSfmlTime;
begin
  TimeSinceLastUpdate := SfmlTimeZero;
  Clock := TSfmlClock.Create;
  try
    while FWindow.isOpen do
    begin
      ElapsedTime := Clock.Restart;
      TimeSinceLastUpdate := TimeSinceLastUpdate + ElapsedTime;
      while TimeSinceLastUpdate.MicroSeconds > TimePerFrame.MicroSeconds do
      begin
        TimeSinceLastUpdate := TimeSinceLastUpdate - TimePerFrame;

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
  Event: TSfmlEvent;
  Slf: TGame;
begin
  // damn workaround
  Slf := Self;

  while FWindow.PollEvent(Event) do
  begin

    // damn workaround
    if Self = nil then
      Self := Slf;

    case Event.EventType of
      sfEvtKeyPressed:
        HandlePlayerInput(Event.Key.Code, True);

      sfEvtKeyReleased:
        HandlePlayerInput(Event.Key.Code, False);

      sfEvtClosed:
        FWindow.Close;
    end;
  end;
end;

procedure TGame.update(ElapsedTime: TSfmlTime);
begin
  FWorld.Update(ElapsedTime);
end;

procedure TGame.Render;
begin
  FWindow.Clear;
  FWorld.Draw;

  FWindow.View := FWindow.DefaultView;
  FWindow.Draw(FStatisticsText);
  FWindow.Display;
end;

procedure TGame.UpdateStatistics(ElapsedTime: TSfmlTime);
begin
  FStatisticsUpdateTime := FStatisticsUpdateTime + ElapsedTime;
  FStatisticsNumFrames := FStatisticsNumFrames + 1;

  if FStatisticsUpdateTime.MicroSeconds >= SfmlSeconds(1.0).MicroSeconds then
  begin
    FStatisticsText.&String :=
      'Frames / Second = ' + AnsiString(IntToStr(FStatisticsNumFrames)) + #10 +
      'Time / Update = ' + AnsiString(FloatToStr(FStatisticsUpdateTime.Microseconds / FStatisticsNumFrames)) + 'us';

    FStatisticsUpdateTime := FStatisticsUpdateTime - Sfmlseconds(1);
    FStatisticsNumFrames := 0;
  end;
end;

procedure TGame.HandlePlayerInput(Key: TSfmlKeyCode; IsPressed: Boolean);
begin
end;

end.
