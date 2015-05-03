unit Effect;

interface

uses
  SfmlSystem, SfmlGraphics;

type
  TEffect = class(TSfmlDrawable)
  private
    FName: string;
    FIsLoaded: Boolean;
    FFont: TSfmlFont;
  protected
    constructor Create(Name: string);

    function OnLoad: Boolean; virtual; abstract;
    procedure OnUpdate(Time, X, Y: Single); virtual; abstract;
    procedure OnDraw(Target: TSfmlRenderTarget; states: PSfmlRenderStates); virtual; abstract;
  public
    procedure Load;

    procedure Update(Time, X, Y: Single);
    procedure Draw(Target: TSfmlRenderTarget; States: PSfmlRenderStates);

    property Font: TSfmlFont read FFont write FFont;
    property Name: string read FName;
  end;

implementation

{ TEffect }

constructor TEffect.Create(Name: string);
begin
  FName := Name;
end;

procedure TEffect.Draw(Target: TSfmlRenderTarget; States: PSfmlRenderStates);
var
  Error: TSfmlText;
begin
  if FIsLoaded then
    OnDraw(Target, States)
  else
  begin
    Error := TSfmlText.Create;
    Error.&String := 'Shader not supported';
    Error.Position := SfmlVector2F(320, 200);
    Error.CharacterSize := 36;
    Target.Draw(error, states);
  end;
end;

procedure TEffect.Load;
begin
  FIsLoaded := SfmlShaderIsAvailable and OnLoad;;
end;

procedure TEffect.Update(Time, X, Y: Single);
begin
  if FIsLoaded then
    OnUpdate(time, x, y);
end;

end.
