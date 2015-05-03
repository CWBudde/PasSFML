unit TestSfmlNetwork;

{$I ..\Source\Sfml.inc}

interface

uses
{$IFNDEF FPC}
  TestFramework,
  IdFtpServer, IdFTPList, IdFTPListOutput, Windows, SysUtils, Classes,
{$ELSE}
  FPCUnit, TestUtils, TestRegistry,
{$ENDIF}
  SfmlSystem, SfmlNetwork;

type
  TestTSfmlFtp = class(TTestCase)
  strict private
    FSfmlFtp: TSfmlFtp;
{$IFNDEF FPC}
    FFtpServer: TIdFTPServer;
{$ENDIF}
  private
{$IFNDEF FPC}
    procedure FtpUserLoginHandler(ASender: TIdFTPServerContext; const AUsername,
      APassword: string; var AAuthenticated: Boolean);
    procedure FtpListDirectoryHandler(ASender: TIdFTPServerContext;
      const APath: TIdFTPFileName; ADirectoryListing: TIdFTPListOutput;
      const ACmd: string; const ASwitches: string);
    procedure FtpRenameFileHandler(ASender: TIdFTPServerContext;
      const ARenameFromFile, ARenameToFile: string);
    procedure FtpRetrieveFileHandler(ASender: TIdFTPServerContext;
      const AFilename: string; var AStream: TStream);
    procedure FtpStoreFileHandler(ASender: TIdFTPServerContext;
      const AFilename: string; AAppend: Boolean; var AStream: TStream);
    procedure FtpChangeDirectoryHandler(ASender: TIdFTPServerContext;
      var ADirectory: string);
    procedure FtpDeleteFileHandler(ASender: TIdFTPServerContext;
      const APathName: string);
    procedure FtpGetFileSizeHandler(ASender: TIdFTPServerContext;
      const AFilename: string; var AFileSize: Int64);
    procedure FtpMakeDirectoryHandler(ASender: TIdFTPServerContext;
      var ADirectory: string);
    procedure FtpRemoveDirectoryHandler(ASender: TIdFTPServerContext;
      var ADirectory: string);
{$ENDIF}
  public
{$IFNDEF FPC}
    constructor Create(MethodName: string); override;
    destructor Destroy; override;
{$ENDIF}

    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestBasics;
  end;

  TestTSfmlHttpRequest = class(TTestCase)
  strict private
    FSfmlHttpRequest: TSfmlHttpRequest;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestSetField;
    procedure TestSetMethod;
    procedure TestSetUri;
    procedure TestSetHttpVersion;
    procedure TestSetBody;
  end;

  TestTSfmlHttp = class(TTestCase)
  strict private
    FSfmlHttp: TSfmlHttp;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestBasics;
  end;

  TestTSfmlPacket = class(TTestCase)
  strict private
    FSfmlPacket: TSfmlPacket;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestCopy;
    procedure TestAppend;
    procedure TestClear;
    procedure TestGetData;
    procedure TestGetDataSize;
    procedure TestEndOfPacket;
    procedure TestCanRead;
    procedure TestReadBool;
    procedure TestReadInt8;
    procedure TestReadUint8;
    procedure TestReadInt16;
    procedure TestReadUint16;
    procedure TestReadInt32;
    procedure TestReadUint32;
    procedure TestReadFloat;
    procedure TestReadDouble;
    procedure TestReadString;
    procedure TestReadWideString;
    procedure TestWriteBool;
    procedure TestWriteInt8;
    procedure TestWriteUint8;
    procedure TestWriteInt16;
    procedure TestWriteUint16;
    procedure TestWriteInt32;
    procedure TestWriteUint32;
    procedure TestWriteFloat;
    procedure TestWriteDouble;
    procedure TestWriteString;
    procedure TestWriteWideString;
  end;

  TestTSfmlSocketSelector = class(TTestCase)
  strict private
    FSfmlSocketSelector: TSfmlSocketSelector;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestCopy;
    procedure TestAddTcpListener;
    procedure TestRemoveTcpListener;
    procedure TestClear;
    procedure TestWait;
    procedure TestIsTcpListenerReady;
    procedure TestIsTcpSocketReady;
    procedure TestIsUdpSocketReady;
  end;

  TestTSfmlTcpListener = class(TTestCase)
  strict private
    FSfmlTcpListener: TSfmlTcpListener;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestListen;
    procedure TestAccept;
  end;

  TestTSfmlTcpSocket = class(TTestCase)
  strict private
    FSfmlTcpSocket: TSfmlTcpSocket;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestGetRemoteAddress;
    procedure TestGetRemotePort;
    procedure TestConnect;
    procedure TestDisconnect;
    procedure TestSend;
    procedure TestReceive;
    procedure TestSendPacket;
    procedure TestReceivePacket;
  end;

  TestTSfmlUdpSocket = class(TTestCase)
  strict private
    FSfmlUdpSocket: TSfmlUdpSocket;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestBind;
    procedure TestUnbind;
    procedure TestSend;
    procedure TestReceive;
    procedure TestSendPacket;
    procedure TestReceivePacket;
  end;

implementation

{ TestTSfmlFtp }

{$IFNDEF FPC}
constructor TestTSfmlFtp.Create(MethodName: string);
begin
  inherited;
  FFtpServer := TIdFTPServer.Create(nil);
  FFtpServer.DefaultPort := 21;
  FFtpServer.AllowAnonymousLogin := True;
  FFtpServer.OnGetFileSize := FtpGetFileSizeHandler;
  FFtpServer.OnChangeDirectory := FtpChangeDirectoryHandler;
  FFtpServer.OnGetFileSize := FtpGetFileSizeHandler;
  FFtpServer.OnListDirectory := FtpListDirectoryHandler;
  FFtpServer.OnUserLogin := FtpUserLoginHandler;
  FFtpServer.OnRenameFile := FtpRenameFileHandler;
  FFtpServer.OnDeleteFile := FtpDeleteFileHandler;
  FFtpServer.OnRetrieveFile := FtpRetrieveFileHandler;
  FFtpServer.OnStoreFile := FtpStoreFileHandler;
  FFtpServer.OnMakeDirectory := FtpMakeDirectoryHandler;
  FFtpServer.OnRemoveDirectory := FtpRemoveDirectoryHandler;
  FFtpServer.Greeting.NumericCode := 220;
end;

destructor TestTSfmlFtp.Destroy;
begin
  FFtpServer.Free;
  inherited;
end;

procedure TestTSfmlFtp.FtpListDirectoryHandler(ASender: TIdFTPServerContext;
  const APath: TIdFTPFileName; ADirectoryListing: TIdFTPListOutput; const ACmd,
  ASwitches: string);

  procedure AddListItem(ADirectoryListing: TIdFTPListItems; Filename: string;
    ItemType: TIdDirItemType; Size: Int64; Date: TDateTime);
  var
    ListItem: TIdFTPListItem;
  begin
    ListItem := ADirectoryListing.Add;
    ListItem.ItemType := ItemType;
    ListItem.FileName := Filename;
    ListItem.Size := Size;
    ListItem.ModifiedDate := Date;
  end;

var
  f: TSearchRec;
  a: Integer;
begin
(*
  ADirectoryListing.DirectoryName := APath;

  a := FindFirst(TransLatePath(APath, ASender.HomeDir) + '*.*', faAnyFile, f) ;
  while (a = 0) do
  begin
    if (f.Attr and faDirectory > 0) then
      AddlistItem(ADirectoryListing, f.Name, ditDirectory, f.size, FileDateToDateTime(f.Time))
    else
      AddlistItem(ADirectoryListing, f.Name, ditFile, f.size, FileDateToDateTime(f.Time)) ;
    a := FindNext(f) ;
  end;


  FindClose(f) ;
*)
end;

procedure TestTSfmlFtp.FtpUserLoginHandler(ASender: TIdFTPServerContext;
  const AUsername, APassword: string; var AAuthenticated: Boolean);
begin
  AAuthenticated := (AUsername = 'Test') and (APassword = 'Test') ;
  if not AAuthenticated then
    Exit;
  ASender.HomeDir := '/';
  ASender.CurrentDir := '/';
end;

procedure TestTSfmlFtp.FtpRenameFileHandler(ASender: TIdFTPServerContext;
  const ARenameFromFile, ARenameToFile: string);
begin
end;

procedure TestTSfmlFtp.FtpRetrieveFileHandler(ASender: TIdFTPServerContext;
  const AFilename: string; var AStream: TStream);
begin
end;


procedure TestTSfmlFtp.FtpStoreFileHandler(ASender: TIdFTPServerContext;
  const AFilename: string; AAppend: Boolean; var AStream: TStream);
begin
end;


procedure TestTSfmlFtp.FtpRemoveDirectoryHandler(ASender: TIdFTPServerContext;
  var ADirectory: string);
begin
end;


procedure TestTSfmlFtp.FtpMakeDirectoryHandler(ASender: TIdFTPServerContext;
  var ADirectory: string);
begin
end;


procedure TestTSfmlFtp.FtpGetFileSizeHandler(ASender: TIdFTPServerContext;
  const AFilename: string; var AFileSize: Int64);
begin
end;


procedure TestTSfmlFtp.FtpDeleteFileHandler(ASender: TIdFTPServerContext;
  const APathname: string);
begin
end;


procedure TestTSfmlFtp.FtpChangeDirectoryHandler(ASender: TIdFTPServerContext;
  var ADirectory: string);
begin
end;
{$ENDIF}

procedure TestTSfmlFtp.SetUp;
begin
  FSfmlFtp := TSfmlFtp.Create;
{$IFNDEF FPC}
  FFtpServer.Active := True;
{$ENDIF}
end;

procedure TestTSfmlFtp.TearDown;
begin
{$IFNDEF FPC}
  FFtpServer.Active := False;
{$ENDIF}
  FSfmlFtp.Free;
  FSfmlFtp := nil;
end;

procedure TestTSfmlFtp.TestBasics;
var
  Response: TSfmlFtpResponse;
  DirectoryResponse: TSfmlFtpDirectoryResponse;
  ListingResponse: TSfmlFtpListingResponse;
begin
{$IFDEF FPC}
  Response := FSfmlFtp.Connect(SfmlIpAddressLocalHost, 21, SfmlSeconds(1));
  CheckTrue(Response.Status = sfFtpConnectionFailed);
  CheckFalse(Response.IsOk);
{$ELSE}
  // connect
  Response := FSfmlFtp.Connect(SfmlIpAddressLocalHost, FFtpServer.DefaultPort,
    SfmlSeconds(5));
  CheckTrue(Response.Status = sfFtpOk);
  CheckTrue(Response.IsOk);

  // login anonymously
  Response := FSfmlFtp.LoginAnonymous;
  CheckTrue(Response.IsOk);

  // keep alive
  Response := FSfmlFtp.KeepAlive;
  CheckTrue(Response.IsOk);

  // login
  Response := FSfmlFtp.Login('Test', 'Test');
  CheckTrue(Response.IsOk);

  // get working directory
  DirectoryResponse := FSfmlFtp.GetWorkingDirectory;
  CheckTrue(DirectoryResponse.IsOK);

  // list directory
  ListingResponse := FSfmlFtp.GetDirectoryListing('.');
  CheckTrue(ListingResponse.IsOK);

  // change directory
  Response := FSfmlFtp.GetDirectoryListing('..');
  CheckTrue(Response.IsOK);

  // parent directory
  Response := FSfmlFtp.ParentDirectory;
  CheckTrue(Response.IsOK);

  // create directory
  Response := FSfmlFtp.CreateDirectory('NewDir');
  CheckTrue(Response.IsOK);

  // delete directory
  Response := FSfmlFtp.DeleteDirectory('NewDir');
  CheckTrue(Response.IsOK);

  Response := FSfmlFtp.Upload('../Resources/Sfml.png', 'NewFile.png', sfFtpBinary);
  CheckTrue(Response.IsOK);

  Response := FSfmlFtp.Download('NewFile.png', '../Resources/New.png', sfFtpBinary);
  CheckTrue(Response.IsOK);

  Response := FSfmlFtp.RenameFile('NewFile.png', 'RenamedFile.png');
  CheckTrue(Response.IsOK);

  Response := FSfmlFtp.DeleteFile('RenamedFile.png');
  CheckTrue(Response.IsOK);

  // disconnect
  Response := FSfmlFtp.Disconnect;
  CheckTrue(Response.IsOk);
{$ENDIF}
end;


{ TestTSfmlHttpRequest }

procedure TestTSfmlHttpRequest.SetUp;
begin
  FSfmlHttpRequest := TSfmlHttpRequest.Create;
end;

procedure TestTSfmlHttpRequest.TearDown;
begin
  FSfmlHttpRequest.Free;
  FSfmlHttpRequest := nil;
end;

procedure TestTSfmlHttpRequest.TestSetField;
var
  Value: AnsiString;
  Field: AnsiString;
begin
  // TODO: Methodenaufrufparameter einrichten
  FSfmlHttpRequest.SetField(Field, Value);
  // TODO: check return values
end;

procedure TestTSfmlHttpRequest.TestSetMethod;
var
  Method: TSfmlHttpMethod;
begin
  // TODO: Methodenaufrufparameter einrichten
  FSfmlHttpRequest.SetMethod(Method);
  // TODO: check return values
end;

procedure TestTSfmlHttpRequest.TestSetUri;
var
  Uri: AnsiString;
begin
  // TODO: Methodenaufrufparameter einrichten
  FSfmlHttpRequest.SetUri(Uri);
  // TODO: check return values
end;

procedure TestTSfmlHttpRequest.TestSetHttpVersion;
var
  Minor: Cardinal;
  Major: Cardinal;
begin
  // TODO: Methodenaufrufparameter einrichten
  FSfmlHttpRequest.SetHttpVersion(Major, Minor);
  // TODO: check return values
end;

procedure TestTSfmlHttpRequest.TestSetBody;
var
  Body: AnsiString;
begin
  // TODO: Methodenaufrufparameter einrichten
  FSfmlHttpRequest.SetBody(Body);
  // TODO: check return values
end;


{ TestTSfmlHttp }

procedure TestTSfmlHttp.SetUp;
begin
  FSfmlHttp := TSfmlHttp.Create;
end;

procedure TestTSfmlHttp.TearDown;
begin
  FSfmlHttp.Free;
  FSfmlHttp := nil;
end;

procedure TestTSfmlHttp.TestBasics;
var
  Host: AnsiString;
  Request: TSfmlHttpRequest;
  ReturnValue: TSfmlHttpResponse;
begin
  FSfmlHttp.SetHost('localhost', 80);

  ReturnValue := FSfmlHttp.SendRequest(Request, SfmlSeconds(5));
  CheckTrue(ReturnValue.GetStatus = sfHttpOk);
  // TODO: check return values
end;


{ TestTSfmlPacket }

procedure TestTSfmlPacket.SetUp;
begin
  FSfmlPacket := TSfmlPacket.Create;
end;

procedure TestTSfmlPacket.TearDown;
begin
  FSfmlPacket.Free;
  FSfmlPacket := nil;
end;

procedure TestTSfmlPacket.TestCopy;
var
  ReturnValue: TSfmlPacket;
begin
  ReturnValue := FSfmlPacket.Copy;
  CheckEquals(FSfmlPacket.GetDataSize, ReturnValue.GetDataSize);
  CheckEquals(FSfmlPacket.EndOfPacket, ReturnValue.EndOfPacket);
  CheckEquals(FSfmlPacket.CanRead, ReturnValue.CanRead);
end;

procedure TestTSfmlPacket.TestAppend;
var
  SizeInBytes: NativeUInt;
  Data: Pointer;
begin
  // TODO: Methodenaufrufparameter einrichten
  FSfmlPacket.Append(Data, SizeInBytes);
  // TODO: check return values
end;

procedure TestTSfmlPacket.TestClear;
begin
  FSfmlPacket.Clear;
  // TODO: check return values
end;

procedure TestTSfmlPacket.TestGetData;
var
  ReturnValue: Pointer;
begin
  ReturnValue := FSfmlPacket.GetData;
  // TODO: check return values
end;

procedure TestTSfmlPacket.TestGetDataSize;
var
  ReturnValue: NativeUInt;
begin
  ReturnValue := FSfmlPacket.GetDataSize;
  // TODO: check return values
end;

procedure TestTSfmlPacket.TestEndOfPacket;
var
  ReturnValue: Boolean;
begin
  ReturnValue := FSfmlPacket.EndOfPacket;
  // TODO: check return values
end;

procedure TestTSfmlPacket.TestCanRead;
var
  ReturnValue: Boolean;
begin
  ReturnValue := FSfmlPacket.CanRead;
  // TODO: check return values
end;

procedure TestTSfmlPacket.TestReadBool;
var
  ReturnValue: Boolean;
begin
  ReturnValue := FSfmlPacket.ReadBool;
  // TODO: check return values
end;

procedure TestTSfmlPacket.TestReadInt8;
var
  ReturnValue: Shortint;
begin
  ReturnValue := FSfmlPacket.ReadInt8;
  // TODO: check return values
end;

procedure TestTSfmlPacket.TestReadUint8;
var
  ReturnValue: Byte;
begin
  ReturnValue := FSfmlPacket.ReadUint8;
  // TODO: check return values
end;

procedure TestTSfmlPacket.TestReadInt16;
var
  ReturnValue: Smallint;
begin
  ReturnValue := FSfmlPacket.ReadInt16;
  // TODO: check return values
end;

procedure TestTSfmlPacket.TestReadUint16;
var
  ReturnValue: Word;
begin
  ReturnValue := FSfmlPacket.ReadUint16;
  // TODO: check return values
end;

procedure TestTSfmlPacket.TestReadInt32;
var
  ReturnValue: System.Integer;
begin
  ReturnValue := FSfmlPacket.ReadInt32;
  // TODO: check return values
end;

procedure TestTSfmlPacket.TestReadUint32;
var
  ReturnValue: Cardinal;
begin
  ReturnValue := FSfmlPacket.ReadUint32;
  // TODO: check return values
end;

procedure TestTSfmlPacket.TestReadFloat;
var
  ReturnValue: Single;
begin
  ReturnValue := FSfmlPacket.ReadFloat;
  // TODO: check return values
end;

procedure TestTSfmlPacket.TestReadDouble;
var
  ReturnValue: Double;
begin
  ReturnValue := FSfmlPacket.ReadDouble;
  // TODO: check return values
end;

procedure TestTSfmlPacket.TestReadString;
var
  &String: AnsiString;
begin
  // TODO: Methodenaufrufparameter einrichten
  FSfmlPacket.ReadString(&String);
  // TODO: check return values
end;

procedure TestTSfmlPacket.TestReadWideString;
var
  &String: string;
begin
  // TODO: Methodenaufrufparameter einrichten
  FSfmlPacket.ReadWideString(&String);
  // TODO: check return values
end;

procedure TestTSfmlPacket.TestWriteBool;
var
  Value: Boolean;
begin
  // TODO: Methodenaufrufparameter einrichten
  FSfmlPacket.WriteBool(Value);
  // TODO: check return values
end;

procedure TestTSfmlPacket.TestWriteInt8;
var
  Value: Shortint;
begin
  // TODO: Methodenaufrufparameter einrichten
  FSfmlPacket.WriteInt8(Value);
  // TODO: check return values
end;

procedure TestTSfmlPacket.TestWriteUint8;
var
  Value: Byte;
begin
  // TODO: Methodenaufrufparameter einrichten
  FSfmlPacket.WriteUint8(Value);
  // TODO: check return values
end;

procedure TestTSfmlPacket.TestWriteInt16;
var
  Value: Smallint;
begin
  // TODO: Methodenaufrufparameter einrichten
  FSfmlPacket.WriteInt16(Value);
  // TODO: check return values
end;

procedure TestTSfmlPacket.TestWriteUint16;
var
  Value: Word;
begin
  // TODO: Methodenaufrufparameter einrichten
  FSfmlPacket.WriteUint16(Value);
  // TODO: check return values
end;

procedure TestTSfmlPacket.TestWriteInt32;
var
  Value: System.Integer;
begin
  // TODO: Methodenaufrufparameter einrichten
  FSfmlPacket.WriteInt32(Value);
  // TODO: check return values
end;

procedure TestTSfmlPacket.TestWriteUint32;
var
  Value: Cardinal;
begin
  // TODO: Methodenaufrufparameter einrichten
  FSfmlPacket.WriteUint32(Value);
  // TODO: check return values
end;

procedure TestTSfmlPacket.TestWriteFloat;
var
  Value: Single;
begin
  // TODO: Methodenaufrufparameter einrichten
  FSfmlPacket.WriteFloat(Value);
  // TODO: check return values
end;

procedure TestTSfmlPacket.TestWriteDouble;
var
  Value: Double;
begin
  // TODO: Methodenaufrufparameter einrichten
  FSfmlPacket.WriteDouble(Value);
  // TODO: check return values
end;

procedure TestTSfmlPacket.TestWriteString;
var
  &String: AnsiString;
begin
  // TODO: Methodenaufrufparameter einrichten
  FSfmlPacket.WriteString(&String);
  // TODO: check return values
end;

procedure TestTSfmlPacket.TestWriteWideString;
var
  &String: PUCS4CharArray;
begin
  // TODO: Methodenaufrufparameter einrichten
  FSfmlPacket.WriteWideString(&String);
  // TODO: check return values
end;


{ TestTSfmlSocketSelector }

procedure TestTSfmlSocketSelector.SetUp;
begin
  FSfmlSocketSelector := TSfmlSocketSelector.Create;
end;

procedure TestTSfmlSocketSelector.TearDown;
begin
  FSfmlSocketSelector.Free;
  FSfmlSocketSelector := nil;
end;

procedure TestTSfmlSocketSelector.TestCopy;
var
  ReturnValue: TSfmlSocketSelector;
begin
  ReturnValue := FSfmlSocketSelector.Copy;
  // TODO: check return values
end;

procedure TestTSfmlSocketSelector.TestAddTcpListener;
var
  Socket: PSfmlTcpListener;
begin
  // TODO: Methodenaufrufparameter einrichten
  FSfmlSocketSelector.AddTcpListener(Socket);
  // TODO: check return values
end;

procedure TestTSfmlSocketSelector.TestRemoveTcpListener;
var
  Socket: PSfmlTcpListener;
begin
  // TODO: Methodenaufrufparameter einrichten
  FSfmlSocketSelector.RemoveTcpListener(Socket);
  // TODO: check return values
end;

procedure TestTSfmlSocketSelector.TestClear;
begin
  FSfmlSocketSelector.Clear;
  // TODO: check return values
end;

procedure TestTSfmlSocketSelector.TestWait;
var
  ReturnValue: Boolean;
  Timeout: TSfmlTime;
begin
  // TODO: Methodenaufrufparameter einrichten
  ReturnValue := FSfmlSocketSelector.Wait(Timeout);
  // TODO: check return values
end;

procedure TestTSfmlSocketSelector.TestIsTcpListenerReady;
var
  ReturnValue: Boolean;
  Socket: PSfmlTcpListener;
begin
  // TODO: Methodenaufrufparameter einrichten
  ReturnValue := FSfmlSocketSelector.IsTcpListenerReady(Socket);
  // TODO: check return values
end;

procedure TestTSfmlSocketSelector.TestIsTcpSocketReady;
var
  ReturnValue: Boolean;
  Socket: PSfmlTcpSocket;
begin
  // TODO: Methodenaufrufparameter einrichten
  ReturnValue := FSfmlSocketSelector.IsTcpSocketReady(Socket);
  // TODO: check return values
end;

procedure TestTSfmlSocketSelector.TestIsUdpSocketReady;
var
  ReturnValue: Boolean;
  Socket: PSfmlUdpSocket;
begin
  // TODO: Methodenaufrufparameter einrichten
  ReturnValue := FSfmlSocketSelector.IsUdpSocketReady(Socket);
  // TODO: check return values
end;


{ TestTSfmlTcpListener }

procedure TestTSfmlTcpListener.SetUp;
begin
  FSfmlTcpListener := TSfmlTcpListener.Create;
end;

procedure TestTSfmlTcpListener.TearDown;
begin
  FSfmlTcpListener.Free;
  FSfmlTcpListener := nil;
end;

procedure TestTSfmlTcpListener.TestListen;
var
  ReturnValue: TSfmlSocketStatus;
  Port: Byte;
begin
  // TODO: Methodenaufrufparameter einrichten
  ReturnValue := FSfmlTcpListener.Listen(Port);
  // TODO: check return values
end;

procedure TestTSfmlTcpListener.TestAccept;
var
  ReturnValue: TSfmlSocketStatus;
  Connected: PSfmlTcpSocket;
begin
  // TODO: Methodenaufrufparameter einrichten
  ReturnValue := FSfmlTcpListener.Accept(Connected);
  // TODO: check return values
end;


{ TestTSfmlTcpSocket }

procedure TestTSfmlTcpSocket.SetUp;
begin
  FSfmlTcpSocket := TSfmlTcpSocket.Create;
end;

procedure TestTSfmlTcpSocket.TearDown;
begin
  FSfmlTcpSocket.Free;
  FSfmlTcpSocket := nil;
end;

procedure TestTSfmlTcpSocket.TestGetRemoteAddress;
var
  ReturnValue: TSfmlIpAddress;
begin
  ReturnValue := FSfmlTcpSocket.GetRemoteAddress;
  // TODO: check return values
end;

procedure TestTSfmlTcpSocket.TestGetRemotePort;
var
  ReturnValue: Byte;
begin
  ReturnValue := FSfmlTcpSocket.GetRemotePort;
  // TODO: check return values
end;

procedure TestTSfmlTcpSocket.TestConnect;
var
  ReturnValue: TSfmlSocketStatus;
  TimeOut: TSfmlTime;
  Port: Byte;
  Host: TSfmlIpAddress;
begin
  // TODO: Methodenaufrufparameter einrichten
  ReturnValue := FSfmlTcpSocket.Connect(Host, Port, TimeOut);
  // TODO: check return values
end;

procedure TestTSfmlTcpSocket.TestDisconnect;
begin
  FSfmlTcpSocket.Disconnect;
  // TODO: check return values
end;

procedure TestTSfmlTcpSocket.TestSend;
var
  ReturnValue: TSfmlSocketStatus;
  Size: NativeUInt;
  Data: Pointer;
begin
  // TODO: Methodenaufrufparameter einrichten
  ReturnValue := FSfmlTcpSocket.Send(Data, Size);
  // TODO: check return values
end;

procedure TestTSfmlTcpSocket.TestReceive;
var
  ReturnValue: TSfmlSocketStatus;
  SizeReceived: PNativeUInt;
  MaxSize: NativeUInt;
  Data: Pointer;
begin
  // TODO: Methodenaufrufparameter einrichten
  ReturnValue := FSfmlTcpSocket.Receive(Data, MaxSize, SizeReceived);
  // TODO: check return values
end;

procedure TestTSfmlTcpSocket.TestSendPacket;
var
  ReturnValue: TSfmlSocketStatus;
  Packet: PSfmlPacket;
begin
  // TODO: Methodenaufrufparameter einrichten
  ReturnValue := FSfmlTcpSocket.SendPacket(Packet);
  // TODO: check return values
end;

procedure TestTSfmlTcpSocket.TestReceivePacket;
var
  ReturnValue: TSfmlSocketStatus;
  Packet: PSfmlPacket;
begin
  // TODO: Methodenaufrufparameter einrichten
  ReturnValue := FSfmlTcpSocket.ReceivePacket(Packet);
  // TODO: check return values
end;


{ TestTSfmlUdpSocket }

procedure TestTSfmlUdpSocket.SetUp;
begin
  FSfmlUdpSocket := TSfmlUdpSocket.Create;
end;

procedure TestTSfmlUdpSocket.TearDown;
begin
  FSfmlUdpSocket.Free;
  FSfmlUdpSocket := nil;
end;

procedure TestTSfmlUdpSocket.TestBind;
var
  ReturnValue: TSfmlSocketStatus;
  Port: Byte;
begin
  // TODO: Methodenaufrufparameter einrichten
  ReturnValue := FSfmlUdpSocket.Bind(Port);
  // TODO: check return values
end;

procedure TestTSfmlUdpSocket.TestUnbind;
begin
  FSfmlUdpSocket.Unbind;
  // TODO: check return values
end;

procedure TestTSfmlUdpSocket.TestSend;
var
  ReturnValue: TSfmlSocketStatus;
  Port: Byte;
  Address: TSfmlIpAddress;
  Size: NativeUInt;
  Data: Pointer;
begin
  // TODO: Methodenaufrufparameter einrichten
  ReturnValue := FSfmlUdpSocket.Send(Data, Size, Address, Port);
  // TODO: check return values
end;

procedure TestTSfmlUdpSocket.TestReceive;
var
  ReturnValue: TSfmlSocketStatus;
  Port: Byte;
  Address: TSfmlIpAddress;
  SizeReceived: PNativeUInt;
  MaxSize: NativeUInt;
  Data: Pointer;
begin
  // TODO: Methodenaufrufparameter einrichten
  ReturnValue := FSfmlUdpSocket.Receive(Data, MaxSize, SizeReceived, Address,
      Port);
  // TODO: check return values
end;

procedure TestTSfmlUdpSocket.TestSendPacket;
var
  ReturnValue: TSfmlSocketStatus;
  Port: Byte;
  Address: TSfmlIpAddress;
  Packet: PSfmlPacket;
begin
  // TODO: Methodenaufrufparameter einrichten
  ReturnValue := FSfmlUdpSocket.SendPacket(Packet, Address, Port);
  // TODO: check return values
end;

procedure TestTSfmlUdpSocket.TestReceivePacket;
var
  ReturnValue: TSfmlSocketStatus;
  Port: Byte;
  Address: TSfmlIpAddress;
  Packet: PSfmlPacket;
begin
  // TODO: Methodenaufrufparameter einrichten
  ReturnValue := FSfmlUdpSocket.ReceivePacket(Packet, Address, Port);
  // TODO: check return values
end;

initialization
  RegisterTest('SfmlNetwork', TestTSfmlFtp.Suite);
  RegisterTest('SfmlNetwork', TestTSfmlHttpRequest.Suite);
  RegisterTest('SfmlNetwork', TestTSfmlHttp.Suite);
  RegisterTest('SfmlNetwork', TestTSfmlPacket.Suite);
  RegisterTest('SfmlNetwork', TestTSfmlSocketSelector.Suite);
  RegisterTest('SfmlNetwork', TestTSfmlTcpListener.Suite);
  RegisterTest('SfmlNetwork', TestTSfmlTcpSocket.Suite);
  RegisterTest('SfmlNetwork', TestTSfmlUdpSocket.Suite);
end.
