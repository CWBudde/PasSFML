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
    procedure TestAppendGetDataClear;
    procedure TestEndOfPacket;
    procedure TestCanRead;
    procedure TestReadWrite;
  end;

  TestTSfmlSocketSelector = class(TTestCase)
  strict private
    FSfmlSocketSelector: TSfmlSocketSelector;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestAddRemoveTcpListener;
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
    procedure TestBindUnbind;
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
var
  ListItem: TIdFTPListOutputItem;
begin
  // add test file
  ListItem := ADirectoryListing.Add;
  ListItem.ItemType := ditFile;
  ListItem.FileName := 'File';
  ListItem.Size := 1024;
  ListItem.ModifiedDate := Now;

  // add test directory
  ListItem := ADirectoryListing.Add;
  ListItem.ItemType := ditDirectory;
  ListItem.FileName := 'Dir';
  ListItem.Size := 1024;
  ListItem.ModifiedDate := Now;
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
begin
  FSfmlHttpRequest.SetField('Foo', 'Bar');
  // TODO: check return values
end;

procedure TestTSfmlHttpRequest.TestSetMethod;
begin
  FSfmlHttpRequest.SetMethod(sfHttpGet);
  FSfmlHttpRequest.SetMethod(sfHttpPost);
  FSfmlHttpRequest.SetMethod(sfHttpHead);
  FSfmlHttpRequest.SetMethod(sfHttpPut);
  FSfmlHttpRequest.SetMethod(sfHttpDelete);
  // TODO: check return values
end;

procedure TestTSfmlHttpRequest.TestSetUri;
begin
  FSfmlHttpRequest.SetUri('www.google.com');
end;

procedure TestTSfmlHttpRequest.TestSetHttpVersion;
begin
  FSfmlHttpRequest.SetHttpVersion(1, 1);
end;

procedure TestTSfmlHttpRequest.TestSetBody;
var
  Body: AnsiString;
begin
  FSfmlHttpRequest.SetBody(Body);
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
  Request: TSfmlHttpRequest;
  ReturnValue: TSfmlHttpResponse;
begin
  FSfmlHttp.SetHost('www.google.com', 80);

  Request := TSfmlHttpRequest.Create;
  Request.SetMethod(sfHttpGet);

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
  CheckEquals(FSfmlPacket.DataSize, ReturnValue.DataSize);
  CheckEquals(FSfmlPacket.EndOfPacket, ReturnValue.EndOfPacket);
  CheckEquals(FSfmlPacket.CanRead, ReturnValue.CanRead);
end;

procedure TestTSfmlPacket.TestAppendGetDataClear;
var
  Data: PByteArray;
  PacketData: PByteArray;
  Index: Integer;
const
  CDataSize = 10;
begin
  GetMem(Data, CDataSize);
  try
    // append some data
    FillChar(Data^, CDataSize, 42);
    FSfmlPacket.Append(Data, CDataSize);

    // ensure the size equals the data size
    CheckEquals(CDataSize, FSfmlPacket.DataSize);

    // get packet data
    PacketData := FSfmlPacket.GetData;

    // check data for validity
    for Index := 0 to CDataSize - 1 do
      CheckEquals(42, PacketData^[Index]);

    // clear contained data
    FSfmlPacket.Clear;

    // ensure the size is zero
    CheckEquals(0, FSfmlPacket.DataSize);
  finally
    Dispose(Data);
  end;
end;

procedure TestTSfmlPacket.TestEndOfPacket;
var
  ReturnValue: Boolean;
begin
  ReturnValue := FSfmlPacket.EndOfPacket;
  CheckTrue(ReturnValue);
end;

procedure TestTSfmlPacket.TestCanRead;
var
  ReturnValue: Boolean;
begin
  ReturnValue := FSfmlPacket.CanRead;
  CheckTrue(ReturnValue);
end;

procedure TestTSfmlPacket.TestReadWrite;
var
  Ansi: AnsiString;
  Wide: UnicodeString;
begin
  // Boolean
  FSfmlPacket.WriteBool(True);
  CheckEquals(True, FSfmlPacket.ReadBool);

  // ShortInt
  FSfmlPacket.Writeint8(123);
  CheckEquals(123, FSfmlPacket.ReadInt8);

  // Byte
  FSfmlPacket.WriteUint8(234);
  CheckEquals(234, FSfmlPacket.ReadUInt8);

  // SmallInt
  FSfmlPacket.WriteInt16(345);
  CheckEquals(345, FSfmlPacket.ReadInt16);

  // Word
  FSfmlPacket.WriteUint16(456);
  CheckEquals(456, FSfmlPacket.ReadUInt16);

  FSfmlPacket.WriteUint16(567);
  CheckEquals(567, FSfmlPacket.ReadUint16);

  FSfmlPacket.WriteInt32(678);
  CheckEquals(678, FSfmlPacket.ReadInt32);

  FSfmlPacket.WriteUint32(789);
  CheckEquals(789, FSfmlPacket.ReadUint32);

  FSfmlPacket.WriteFloat(0.25);
  CheckEquals(0.25, FSfmlPacket.ReadFloat);

  FSfmlPacket.WriteDouble(0.125);
  CheckEquals(0.125, FSfmlPacket.ReadDouble);

  FSfmlPacket.WriteString(AnsiString('Foo'));
  FSfmlPacket.ReadString(Ansi);
  CheckEquals(AnsiString('Foo'), Ansi);

  FSfmlPacket.WriteWideString('Bar');
  FSfmlPacket.ReadWideString(Wide);
  CheckEquals('Bar', Wide);
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

procedure TestTSfmlSocketSelector.TestAddRemoveTcpListener;
var
  Socket: TSfmlTcpListener;
begin
  Socket := TSfmlTcpListener.Create;
  try
    FSfmlSocketSelector.AddTcpListener(Socket.Handle);
    // TODO: check return values

    FSfmlSocketSelector.RemoveTcpListener(Socket.Handle);
    // TODO: check return values
  finally
    Socket.Free;
  end;
end;

procedure TestTSfmlSocketSelector.TestClear;
var
  Socket: TSfmlTcpListener;
begin
  Socket := TSfmlTcpListener.Create;
  try
    FSfmlSocketSelector.AddTcpListener(Socket.Handle);
    FSfmlSocketSelector.Clear;
    // TODO: check return values
  finally
    Socket.Free;
  end;
end;

procedure TestTSfmlSocketSelector.TestWait;
var
  ReturnValue: Boolean;
begin
  ReturnValue := FSfmlSocketSelector.Wait(SfmlSeconds(1));
  CheckTrue(ReturnValue);
end;

procedure TestTSfmlSocketSelector.TestIsTcpListenerReady;
var
  ReturnValue: Boolean;
  Socket: TSfmlTcpListener;
begin
  Socket := TSfmlTcpListener.Create;
  try
    ReturnValue := FSfmlSocketSelector.IsTcpListenerReady(Socket.Handle);
    CheckTrue(ReturnValue);
  finally
    Socket.Free;
  end;
end;

procedure TestTSfmlSocketSelector.TestIsTcpSocketReady;
var
  ReturnValue: Boolean;
  Socket: TSfmlTcpSocket;
begin
  Socket := TSfmlTcpSocket.Create;
  try
    ReturnValue := FSfmlSocketSelector.IsTcpSocketReady(Socket.Handle);
    CheckTrue(ReturnValue);
  finally
    Socket.Free;
  end;
end;

procedure TestTSfmlSocketSelector.TestIsUdpSocketReady;
var
  ReturnValue: Boolean;
  Socket: TSfmlUdpSocket;
begin
  Socket := TSfmlUdpSocket.Create;
  try
    ReturnValue := FSfmlSocketSelector.IsUdpSocketReady(Socket.Handle);
    CheckTrue(ReturnValue);
  finally
    Socket.Free;
  end;
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
begin
  ReturnValue := FSfmlTcpListener.Listen(80);
  CheckTrue(ReturnValue <> sfSocketError);
  // TODO: check return values
end;

procedure TestTSfmlTcpListener.TestAccept;
var
  ReturnValue: TSfmlSocketStatus;
  Connected: PSfmlTcpSocket;
begin
  ReturnValue := FSfmlTcpListener.Accept(Connected);
  CheckTrue(ReturnValue <> sfSocketError);
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
  CheckEquals(123, ReturnValue);
  // TODO: check return values
end;

procedure TestTSfmlTcpSocket.TestConnect;
var
  ReturnValue: TSfmlSocketStatus;
begin
  ReturnValue := FSfmlTcpSocket.Connect(SfmlIpAddressLocalHost, 123,
    SfmlSeconds(1));
  CheckTrue(ReturnValue <> sfSocketError);
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
  Size := 1024;
  GetMem(Data, Size);
  try
    FillChar(Data^, Size, 0);
    ReturnValue := FSfmlTcpSocket.Send(Data, Size);
    CheckTrue(ReturnValue <> sfSocketError);
  finally
    Dispose(Data);
  end;
end;

procedure TestTSfmlTcpSocket.TestReceive;
var
  ReturnValue: TSfmlSocketStatus;
  SizeReceived: NativeUInt;
  Data: Pointer;
begin
  GetMem(Data, 1024);
  try
    ReturnValue := FSfmlTcpSocket.Receive(Data, 1024, SizeReceived);
    CheckEquals(0, SizeReceived);
    CheckTrue(ReturnValue <> sfSocketError);
  finally
    Dispose(Data);
  end;
end;

procedure TestTSfmlTcpSocket.TestSendPacket;
var
  ReturnValue: TSfmlSocketStatus;
  Packet: TSfmlPacket;
begin
  Packet := TSfmlPacket.Create;
  try
    ReturnValue := FSfmlTcpSocket.SendPacket(Packet.Handle);
    CheckTrue(ReturnValue <> sfSocketError);
  finally
    Packet.Free;
  end;
end;

procedure TestTSfmlTcpSocket.TestReceivePacket;
var
  ReturnValue: TSfmlSocketStatus;
  Packet: TSfmlPacket;
begin
  Packet := TSfmlPacket.Create;
  try
    ReturnValue := FSfmlTcpSocket.ReceivePacket(Packet.Handle);
    CheckTrue(ReturnValue <> sfSocketError);
  finally
    Packet.Free;
  end;
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

procedure TestTSfmlUdpSocket.TestBindUnbind;
var
  ReturnValue: TSfmlSocketStatus;
begin
  ReturnValue := FSfmlUdpSocket.Bind(123);
  CheckTrue(ReturnValue <> sfSocketError);
  FSfmlUdpSocket.Unbind;
end;

procedure TestTSfmlUdpSocket.TestSend;
var
  ReturnValue: TSfmlSocketStatus;
  Address: TSfmlIpAddress;
  Size: NativeUInt;
  Data: Pointer;
begin
  Size := 1024;
  GetMem(Data, Size);
  try
    FillChar(Data^, Size, 0);
    ReturnValue := FSfmlUdpSocket.Send(Data, Size, Address, 123);
    CheckTrue(ReturnValue <> sfSocketError);
  finally
    Dispose(Data);
  end;
end;

procedure TestTSfmlUdpSocket.TestReceive;
var
  ReturnValue: TSfmlSocketStatus;
  Port: Byte;
  Address: TSfmlIpAddress;
  SizeReceived: NativeUInt;
  MaxSize: NativeUInt;
  Data: Pointer;
begin
  MaxSize := 1024;
  GetMem(Data, MaxSize);
  try
    ReturnValue := FSfmlUdpSocket.Receive(Data, MaxSize, SizeReceived,
      Address, Port);

    CheckTrue(ReturnValue <> sfSocketError);
    CheckEquals(SizeReceived, 0);
  finally
    Dispose(Data);
  end;
end;

procedure TestTSfmlUdpSocket.TestSendPacket;
var
  ReturnValue: TSfmlSocketStatus;
  Address: TSfmlIpAddress;
  Packet: TSfmlPacket;
begin
  Packet := TSfmlPacket.Create;
  try
    ReturnValue := FSfmlUdpSocket.SendPacket(Packet.Handle, Address, 123);
    CheckTrue(ReturnValue <> sfSocketError);
  finally
    Packet.Free;
  end;
end;

procedure TestTSfmlUdpSocket.TestReceivePacket;
var
  ReturnValue: TSfmlSocketStatus;
  Port: Byte;
  Address: TSfmlIpAddress;
  Packet: TSfmlPacket;
begin
  Packet := TSfmlPacket.Create;
  try
    ReturnValue := FSfmlUdpSocket.ReceivePacket(Packet.Handle, Address, Port);
    CheckTrue(ReturnValue <> sfSocketError);
  finally
    Packet.Free;
  end;
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
