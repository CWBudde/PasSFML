unit MainUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ComCtrls,
  Vcl.ExtCtrls, Vcl.ActnList, Vcl.ToolWin, Vcl.ImgList, Vcl.StdActns,
  SynEdit, SynEditHighlighter, SynHighlighterCpp,
  SfmlSystem, SfmlWindow, SfmlGraphics, SynEditPlugins, SynMacroRecorder,
  SynEditMiscClasses, SynEditSearch, SynHighlighterDWS, dwsComp, dwsExprs;

type
  TFormMain = class(TForm)
    ActionLink: TAction;
    ActionList: TActionList;
    MainMenu: TMainMenu;
    MenuItemFile: TMenuItem;
    PageControl: TPageControl;
    PanelOutput: TPanel;
    Splitter: TSplitter;
    StatusBar: TStatusBar;
    SynCppSyn: TSynCppSyn;
    SynEditFragmentShader: TSynEdit;
    SynEditVertexShader: TSynEdit;
    TabSheetFragmentShader: TTabSheet;
    TabSheetVertexShader: TTabSheet;
    ToolBar: TToolBar;
    ToolButtonCompileLink: TToolButton;
    SynMacroRecorder: TSynMacroRecorder;
    ImageList: TImageList;
    SynEditSearch: TSynEditSearch;
    ActionFileOpen: TFileOpen;
    ActionFileExit: TFileExit;
    ActionFileSaveAs: TFileSaveAs;
    ActionEditCut: TEditCut;
    ActionEditCopy: TEditCopy;
    ActionEditPaste: TEditPaste;
    ActionEditSelectAll: TEditSelectAll;
    ActionEditUndo: TEditUndo;
    ActionEditDelete: TEditDelete;
    TabSheetScript: TTabSheet;
    SynEditScript: TSynEdit;
    SynDWSSyn: TSynDWSSyn;
    MenuItemFileOpen: TMenuItem;
    MenuItemFileSaveAs: TMenuItem;
    MenuItemFileExit: TMenuItem;
    N1: TMenuItem;
    MenuItemEdit: TMenuItem;
    MenuItemEditCut: TMenuItem;
    MenuItemEditCopy: TMenuItem;
    MenuItemEditPaste: TMenuItem;
    MenuItemEditDelete: TMenuItem;
    MenuItemEditUndo: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    MenuItemEditSelectAll: TMenuItem;
    ToolButtonOpen: TToolButton;
    ToolButtonSaveAs: TToolButton;
    ToolButtonSeparator: TToolButton;
    DelphiWebScript: TDelphiWebScript;
    MenuItemRun: TMenuItem;
    MenuItemRunRun: TMenuItem;
    dwsUnitShader: TdwsUnit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ActionLinkExecute(Sender: TObject);
    procedure SynEditEnter(Sender: TObject);
    procedure SynEditGutterPaint(Sender: TObject; aLine, X,
      Y: Integer);
    procedure SynEditStatusChange(Sender: TObject;
      Changes: TSynStatusChanges);
    procedure PanelOutputResize(Sender: TObject);
    procedure dwsUnitShaderFunctionsSetParameter1Eval(info: TProgramInfo);
    procedure dwsUnitShaderFunctionsSetParameter2Eval(info: TProgramInfo);
    procedure dwsUnitShaderFunctionsSetParameter4Eval(info: TProgramInfo);
    procedure dwsUnitShaderFunctionsSetParameter3Eval(info: TProgramInfo);
    procedure dwsUnitShaderFunctionsSetColorEval(info: TProgramInfo);
    procedure dwsUnitShaderFunctionsClearEval(info: TProgramInfo);
  private
    FWindow: TSfmlRenderWindow;
    FRenderTarget: TSfmlRenderTexture;
    FStates: TSfmlRenderStates;
    FShader: TSfmlShader;
  public
    procedure UpdateWindow;
    procedure CompileAndLink;
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

procedure TFormMain.FormCreate(Sender: TObject);
begin
  FWindow := TSfmlRenderWindow.Create(TSfmlWindowHandle(PanelOutput.Handle));

  FStates.BlendMode := SfmlBlendAlpha;
  FStates.Transform := SfmlTransformIdentity;

  // Create the off-screen surface
  FRenderTarget := TSfmlRenderTexture.Create(200, 200);
end;

procedure TFormMain.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FWindow);
  FreeAndNil(FRenderTarget);
end;

procedure TFormMain.PanelOutputResize(Sender: TObject);
begin
  if Assigned(FWindow) then
    UpdateWindow;
end;

procedure TFormMain.SynEditEnter(Sender: TObject);
begin
//  SynMacroRecorder.Editor := Sender as TSynEdit;
end;

procedure TFormMain.SynEditGutterPaint(Sender: TObject; aLine, X,
  Y: Integer);
var
  StrLineNumber: string;
  LineNumberRect: TRect;
  GutterWidth, Offset: Integer;
  OldFont: TFont;
begin
  with TSynEdit(Sender), Canvas do
  begin
    Brush.Style := bsClear;
    GutterWidth := Gutter.Width - 5;
    if (ALine = 1) or (ALine = CaretY) or ((ALine mod 10) = 0) then
    begin
      StrLineNumber := IntToStr(ALine);
      LineNumberRect := Rect(x, y, GutterWidth, y + LineHeight);
      OldFont := TFont.Create;
      try
        OldFont.Assign(Canvas.Font);
        Canvas.Font := Gutter.Font;
        Canvas.TextRect(LineNumberRect, StrLineNumber, [tfVerticalCenter,
          tfSingleLine, tfRight]);
        Canvas.Font := OldFont;
      finally
        OldFont.Free;
      end;
    end
    else
    begin
      Canvas.Pen.Color := Gutter.Font.Color;
      if (ALine mod 5) = 0 then
        Offset := 5
      else
        Offset := 2;
      Inc(y, LineHeight div 2);
      Canvas.MoveTo(GutterWidth - Offset, y);
      Canvas.LineTo(GutterWidth, y);
    end;
  end;
end;

procedure TFormMain.SynEditStatusChange(Sender: TObject;
  Changes: TSynStatusChanges);
begin
  if [scCaretX, scCaretY] * Changes <> [] then
  begin
    StatusBar.Panels[0].Text := Format('%d : %d', [TSynEdit(Sender).CaretX,
      TSynEdit(Sender).CaretY]);
  end;
end;

procedure TFormMain.ActionLinkExecute(Sender: TObject);
var
  OldShader, NewShader: TSfmlShader;
begin
  // create new shader
  NewShader := TSfmlShader.Create(AnsiString(SynEditVertexShader.Text),
    AnsiString(SynEditFragmentShader.Text));

  if NewShader.Handle = nil then
  begin
    // shader compilation failed
    StatusBar.Panels[1].Text := 'Failed';
    Exit;
  end;

  OldShader := FShader;
  FShader := NewShader;

  // eventually release existing shader
  if Assigned(OldShader) then
    OldShader.Free;

  CompileAndLink;
  StatusBar.Panels[1].Text := 'Success';
end;

procedure TFormMain.CompileAndLink;
var
  Prog: IdwsProgram;
begin
  Prog := DelphiWebScript.Compile(SynEditScript.Text);

  if Prog.Msgs.HasErrors then
    StatusBar.Panels[1].Text := Prog.Msgs.AsInfo;

  Prog.Execute;

  FStates.Shader := FShader.Handle;

  UpdateWindow;
end;

procedure TFormMain.dwsUnitShaderFunctionsClearEval(info: TProgramInfo);
begin
    FRenderTarget.Clear(SfmlBlack);
end;

procedure TFormMain.dwsUnitShaderFunctionsSetColorEval(info: TProgramInfo);
var
  Color: TSfmlColor;
begin
  if not Assigned(FShader) then
    Exit;

  Color := SfmlColorFromRGBA(
    Round($FF * Info.ParamAsFloat[1]),
    Round($FF * Info.ParamAsFloat[2]),
    Round($FF * Info.ParamAsFloat[3]),
    Round($FF * Info.ParamAsFloat[4]));

  FShader.SetParameter(AnsiString(Info.ParamAsString[0]), Color);
end;

procedure TFormMain.dwsUnitShaderFunctionsSetParameter1Eval(info: TProgramInfo);
begin
  if not Assigned(FShader) then
    Exit;

  FShader.SetParameter(AnsiString(Info.ParamAsString[0]),
    Info.ParamAsFloat[1]);
end;

procedure TFormMain.dwsUnitShaderFunctionsSetParameter2Eval(info: TProgramInfo);
begin
  if not Assigned(FShader) then
    Exit;

  FShader.SetParameter(AnsiString(Info.ParamAsString[0]),
    Info.ParamAsFloat[1], Info.ParamAsFloat[2]);
end;

procedure TFormMain.dwsUnitShaderFunctionsSetParameter3Eval(info: TProgramInfo);
begin
  if not Assigned(FShader) then
    Exit;

  FShader.SetParameter(AnsiString(Info.ParamAsString[0]),
    Info.ParamAsFloat[1], Info.ParamAsFloat[2], Info.ParamAsFloat[3]);
end;

procedure TFormMain.dwsUnitShaderFunctionsSetParameter4Eval(info: TProgramInfo);
begin
  if not Assigned(FShader) then
    Exit;

  FShader.SetParameter(AnsiString(Info.ParamAsString[0]),
    Info.ParamAsFloat[1], Info.ParamAsFloat[2], Info.ParamAsFloat[3],
    Info.ParamAsFloat[4]);
end;

procedure TFormMain.UpdateWindow;
var
  Sprite: TSfmlSprite;
begin
  FWindow.Clear(SfmlBlack);
  Sprite := TSfmlSprite.Create(FRenderTarget.Texture);
  try
    FRenderTarget.Draw(Sprite, @FStates);
  finally
    Sprite.Free;
  end;

  Sprite := TSfmlSprite.Create(FRenderTarget.Texture);
  try
    Sprite.Position := SfmlVector2f((PanelOutput.Width - 200) div 2,
      (PanelOutput.Height - 200) div 2);
    FWindow.Draw(Sprite);
  finally
    Sprite.Free;
  end;

  FWindow.Display;
end;

end.
