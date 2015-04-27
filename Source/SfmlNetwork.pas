unit SfmlNetwork;

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
  SfmlSystem;

const
{$IF Defined(MSWINDOWS)}
  CSfmlNetworkLibrary = 'csfml-network-2.dll';
{$ELSEIF Defined(DARWIN)}
  CSfmlNetworkLibrary = 'csfml-network-2.dylib';
{$ELSEIF Defined(UNIX)}
  CSfmlNetworkLibrary = 'csfml-network-2.so';
{$IFEND}

type
  PSfmlFtpDirectoryResponse = Pointer;
  PSfmlFtpListingResponse = Pointer;
  PSfmlFtpResponse = Pointer;
  PSfmlFtp = Pointer;
  PSfmlHttpRequest = Pointer;
  PSfmlHttpResponse = Pointer;
  PSfmlHttp = Pointer;
  PSfmlPacket = Pointer;
  PSfmlSocketSelector = Pointer;
  PSfmlTcpListener = Pointer;
  PSfmlTcpSocket = Pointer;
  PSfmlUdpSocket = Pointer;

  TSfmlFtpTransferMode = (sfFtpBinary, sfFtpAscii, sfFtpEbcdic);

  TSfmlFtpStatus = (
    sfFtpRestartMarkerReply = 110,
    sfFtpServiceReadySoon = 120,
    sfFtpDataConnectionAlreadyOpened = 125,
    sfFtpOpeningDataConnection = 150,
    sfFtpOk = 200,
    sfFtpPointlessCommand = 202,
    sfFtpSystemStatus = 211,
    sfFtpDirectoryStatus = 212,
    sfFtpFileStatus = 213,
    sfFtpHelpMessage = 214,
    sfFtpSystemType = 215,
    sfFtpServiceReady = 220,
    sfFtpClosingConnection = 221,
    sfFtpDataConnectionOpened = 225,
    sfFtpClosingDataConnection = 226,
    sfFtpEnteringPassiveMode = 227,
    sfFtpLoggedIn = 230,
    sfFtpFileActionOk = 250,
    sfFtpDirectoryOk = 257,
    sfFtpNeedPassword = 331,
    sfFtpNeedAccountToLogIn = 332,
    sfFtpNeedInformation = 350,
    sfFtpServiceUnavailable = 421,
    sfFtpDataConnectionUnavailable = 425,
    sfFtpTransferAborted = 426,
    sfFtpFileActionAborted = 450,
    sfFtpLocalError = 451,
    sfFtpInsufficientStorageSpace = 452,
    sfFtpCommandUnknown = 500,
    sfFtpParametersUnknown = 501,
    sfFtpCommandNotImplemented = 502,
    sfFtpBadCommandSequence = 503,
    sfFtpParameterNotImplemented = 504,
    sfFtpNotLoggedIn = 530,
    sfFtpNeedAccountToStore = 532,
    sfFtpFileUnavailable = 550,
    sfFtpPageTypeUnknown = 551,
    sfFtpNotEnoughMemory = 552,
    sfFtpFilenameNotAllowed = 553,
    sfFtpInvalidResponse = 1000,
    sfFtpConnectionFailed = 1001,
    sfFtpConnectionClosed = 1002,
    sfFtpInvalidFile = 1003
  );

  TSfmlHttpMethod = (sfHttpGet, sfHttpPost, sfHttpHead, sfHttpPut, sfHttpDelete);

  TSfmlHttpStatus = (
    sfHttpOk = 200,
    sfHttpCreated = 201,
    sfHttpAccepted = 202,
    sfHttpNoContent = 204,
    sfHttpResetContent = 205,
    sfHttpPartialContent = 206,
    sfHttpMultipleChoices = 300,
    sfHttpMovedPermanently = 301,
    sfHttpMovedTemporarily = 302,
    sfHttpNotModified = 304,
    sfHttpBadRequest = 400,
    sfHttpUnauthorized = 401,
    sfHttpForbidden = 403,
    sfHttpNotFound = 404,
    sfHttpRangeNotSatisfiable = 407,
    sfHttpInternalServerError = 500,
    sfHttpNotImplemented = 501,
    sfHttpBadGateway = 502,
    sfHttpServiceNotAvailable = 503,
    sfHttpGatewayTimeout = 504,
    sfHttpVersionNotSupported = 505,
    sfHttpInvalidResponse = 1000,
    sfHttpConnectionFailed = 1001
  );

  TSfmlIpAddress = record
    Address : array [0 .. 15] of AnsiChar;
  end;

  TSfmlSocketStatus = (sfSocketDone, sfSocketNotReady, sfSocketDisconnected,
    sfSocketError);

{$IFDEF DynLink}
  TSfmlFtpListingResponseDestroy = procedure (FtpListingResponse: PSfmlFtpListingResponse); cdecl;
  TSfmlFtpListingResponseIsOk = function (const FtpListingResponse: PSfmlFtpListingResponse): sfBool; cdecl;
  TSfmlFtpListingResponseGetStatus = function (const FtpListingResponse: PSfmlFtpListingResponse): TSfmlFtpStatus; cdecl;
  TSfmlFtpListingResponseGetMessage = function (const FtpListingResponse: PSfmlFtpListingResponse): PAnsiChar; cdecl;
  TSfmlFtpListingResponseGetCount = function (const FtpListingResponse: PSfmlFtpListingResponse): NativeUInt; cdecl;
  TSfmlFtpListingResponseGetName = function (const FtpListingResponse: PSfmlFtpListingResponse; Index: NativeUInt): PAnsiChar; cdecl;
  TSfmlFtpDirectoryResponseDestroy = procedure (FtpDirectoryResponse: PSfmlFtpDirectoryResponse); cdecl;
  TSfmlFtpDirectoryResponseIsOk = function (const FtpDirectoryResponse: PSfmlFtpDirectoryResponse): sfBool; cdecl;
  TSfmlFtpDirectoryResponseGetStatus = function (const FtpDirectoryResponse: PSfmlFtpDirectoryResponse): TSfmlFtpStatus; cdecl;
  TSfmlFtpDirectoryResponseGetMessage = function (const FtpDirectoryResponse: PSfmlFtpDirectoryResponse): PAnsiChar; cdecl;
  TSfmlFtpDirectoryResponseGetDirectory = function (const FtpDirectoryResponse: PSfmlFtpDirectoryResponse): PAnsiChar; cdecl;
  TSfmlFtpResponseDestroy = procedure (FtpResponse: PSfmlFtpResponse); cdecl;
  TSfmlFtpResponseIsOk = function (const FtpResponse: PSfmlFtpResponse): sfBool; cdecl;
  TSfmlFtpResponseGetStatus = function (const FtpResponse: PSfmlFtpResponse): TSfmlFtpStatus; cdecl;
  TSfmlFtpResponseGetMessage = function (const FtpResponse: PSfmlFtpResponse): PAnsiChar; cdecl;
  TSfmlFtpCreate = function : PSfmlFtp; cdecl;
  TSfmlFtpDestroy = procedure (Ftp: PSfmlFtp); cdecl;
  TSfmlFtpConnect = function (Ftp: PSfmlFtp; Server: TSfmlIpAddress; Port: Byte; Timeout: TSfmlTime): PSfmlFtpResponse; cdecl;
  TSfmlFtpLoginAnonymous = function (Ftp: PSfmlFtp): PSfmlFtpResponse; cdecl;
  TSfmlFtpLogin = function (Ftp: PSfmlFtp; const UserName, Password: PAnsiChar): PSfmlFtpResponse; cdecl;
  TSfmlFtpDisconnect = function (Ftp: PSfmlFtp): PSfmlFtpResponse; cdecl;
  TSfmlFtpKeepAlive = function (Ftp: PSfmlFtp): PSfmlFtpResponse; cdecl;
  TSfmlFtpGetWorkingDirectory = function (Ftp: PSfmlFtp): PSfmlFtpDirectoryResponse; cdecl;
  TSfmlFtpGetDirectoryListing = function (Ftp: PSfmlFtp; const Directory: PAnsiChar): PSfmlFtpListingResponse; cdecl;
  TSfmlFtpChangeDirectory = function (Ftp: PSfmlFtp; const Directory: PAnsiChar): PSfmlFtpResponse; cdecl;
  TSfmlFtpParentDirectory = function (Ftp: PSfmlFtp): PSfmlFtpResponse; cdecl;
  TSfmlFtpCreateDirectory = function (Ftp: PSfmlFtp; const Name: PAnsiChar): PSfmlFtpResponse; cdecl;
  TSfmlFtpDeleteDirectory = function (Ftp: PSfmlFtp; const Name: PAnsiChar): PSfmlFtpResponse; cdecl;
  TSfmlFtpRenameFile = function (Ftp: PSfmlFtp; const &File: PAnsiChar; const NewName: PAnsiChar): PSfmlFtpResponse; cdecl;
  TSfmlFtpDeleteFile = function (Ftp: PSfmlFtp; const Name: PAnsiChar): PSfmlFtpResponse; cdecl;
  TSfmlFtpDownload = function (Ftp: PSfmlFtp; const DistantFile: PAnsiChar; const DestPath: PAnsiChar; Mode: TSfmlFtpTransferMode): PSfmlFtpResponse; cdecl;
  TSfmlFtpUpload = function (Ftp: PSfmlFtp; const LocalFile: PAnsiChar; const DestPath: PAnsiChar; Mode: TSfmlFtpTransferMode): PSfmlFtpResponse; cdecl;

  TSfmlHttpRequestCreate = function : PSfmlHttpRequest; cdecl;
  TSfmlHttpRequestDestroy = procedure (HttpRequest: PSfmlHttpRequest); cdecl;
  TSfmlHttpRequestSetField = procedure (HttpRequest: PSfmlHttpRequest; const Field: PAnsiChar; const Value: PAnsiChar); cdecl;
  TSfmlHttpRequestSetMethod = procedure (HttpRequest: PSfmlHttpRequest; Method: TSfmlHttpMethod); cdecl;
  TSfmlHttpRequestSetUri = procedure (HttpRequest: PSfmlHttpRequest; const uri: PAnsiChar); cdecl;
  TSfmlHttpRequestSetHttpVersion = procedure (HttpRequest: PSfmlHttpRequest; major, minor: Cardinal); cdecl;
  TSfmlHttpRequestSetBody = procedure (HttpRequest: PSfmlHttpRequest; const body: PAnsiChar); cdecl;
  TSfmlHttpResponseDestroy = procedure (httpResponse: PSfmlHttpResponse); cdecl;
  TSfmlHttpResponseGetField = function (const HttpResponse: PSfmlHttpResponse; const Field: PAnsiChar): PAnsiChar; cdecl;
  TSfmlHttpResponseGetStatus = function (const HttpResponse: PSfmlHttpResponse): TSfmlHttpStatus; cdecl;
  TSfmlHttpResponseGetMajorVersion = function (const HttpResponse: PSfmlHttpResponse): Cardinal; cdecl;
  TSfmlHttpResponseGetMinorVersion = function (const HttpResponse: PSfmlHttpResponse): Cardinal; cdecl;
  TSfmlHttpResponseGetBody = function (const HttpResponse: PSfmlHttpResponse): PAnsiChar; cdecl;
  TSfmlHttpCreate = function : PSfmlHttp; cdecl;
  TSfmlHttpDestroy = procedure (Http: PSfmlHttp); cdecl;
  TSfmlHttpSetHost = procedure (Http: PSfmlHttp; const Host: PAnsiChar; Port: Byte); cdecl;
  TSfmlHttpSendRequest = function (Http: PSfmlHttp; const Request: PSfmlHttpRequest; Timeout: TSfmlTime): PSfmlHttpResponse; cdecl;

(*
  const TSfmlIpAddress sfIpAddress_None;
  const TSfmlIpAddress sfIpAddress_LocalHost;
  const TSfmlIpAddress sfIpAddress_Broadcast;
*)
  TSfmlIpAddressFromString = function (const address: PAnsiChar): TSfmlIpAddress; cdecl;
  TSfmlIpAddressFromBytes = function (byte0, byte1, byte2, byte3: sfUint8): TSfmlIpAddress; cdecl;
  TSfmlIpAddressFromInteger = function (Address: sfUint32): TSfmlIpAddress; cdecl;
  TSfmlIpAddressToString = procedure (Address: TSfmlIpAddress; &String: PAnsiChar); cdecl;
  TSfmlIpAddressToInteger = function (Address: TSfmlIpAddress): sfUint32; cdecl;
  TSfmlIpAddressGetLocalAddress = function : TSfmlIpAddress; cdecl;
  TSfmlIpAddressGetPublicAddress = function (Timeout: TSfmlTime): TSfmlIpAddress; cdecl;

  TSfmlPacketCreate = function : PSfmlPacket; cdecl;
  TSfmlPacketCopy = function (const Packet: PSfmlPacket): PSfmlPacket; cdecl;
  TSfmlPacketDestroy = procedure (Packet: PSfmlPacket); cdecl;
  TSfmlPacketAppend = procedure (Packet: PSfmlPacket; const Data: Pointer; SizeInBytes: NativeUInt); cdecl;
  TSfmlPacketClear = procedure (Packet: PSfmlPacket); cdecl;
  TSfmlPacketGetData = function (const Packet: PSfmlPacket): Pointer; cdecl;
  TSfmlPacketGetDataSize = function (const Packet: PSfmlPacket): NativeUInt; cdecl;
  TSfmlPacketEndOfPacket = function (const Packet: PSfmlPacket): sfBool; cdecl;
  TSfmlPacketCanRead = function (const Packet: PSfmlPacket): sfBool; cdecl;
  TSfmlPacketReadBool = function (Packet: PSfmlPacket): sfBool; cdecl;
  TSfmlPacketReadInt8 = function (Packet: PSfmlPacket): sfInt8; cdecl;
  TSfmlPacketReadUint8 = function (Packet: PSfmlPacket): sfUint8; cdecl;
  TSfmlPacketReadInt16 = function (Packet: PSfmlPacket): sfInt16; cdecl;
  TSfmlPacketReadUint16 = function (Packet: PSfmlPacket): sfUint16; cdecl;
  TSfmlPacketReadInt32 = function (Packet: PSfmlPacket): sfInt32; cdecl;
  TSfmlPacketReadUint32 = function (Packet: PSfmlPacket): sfUint32; cdecl;
  TSfmlPacketReadFloat = function (Packet: PSfmlPacket): Single; cdecl;
  TSfmlPacketReadDouble = function (Packet: PSfmlPacket): Double; cdecl;
  TSfmlPacketReadString = procedure (Packet: PSfmlPacket; &String: PAnsiChar); cdecl;
  TSfmlPacketReadWideString = procedure (Packet: PSfmlPacket; &String: PWideChar); cdecl;
  TSfmlPacketWriteBool = procedure (Packet: PSfmlPacket; Value: sfBool); cdecl;
  TSfmlPacketWriteInt8 = procedure (Packet: PSfmlPacket; Value: sfInt8); cdecl;
  TSfmlPacketWriteUint8 = procedure (Packet: PSfmlPacket; Value: sfUint8); cdecl;
  TSfmlPacketWriteInt16 = procedure (Packet: PSfmlPacket; Value: sfInt16); cdecl;
  TSfmlPacketWriteUint16 = procedure (Packet: PSfmlPacket; Value: sfUint16); cdecl;
  TSfmlPacketWriteInt32 = procedure (Packet: PSfmlPacket; Value: sfInt32); cdecl;
  TSfmlPacketWriteUint32 = procedure (Packet: PSfmlPacket; Value: sfUint32); cdecl;
  TSfmlPacketWriteFloat = procedure (Packet: PSfmlPacket; Value: Single); cdecl;
  TSfmlPacketWriteDouble = procedure (Packet: PSfmlPacket; Value: Double); cdecl;
  TSfmlPacketWriteString = procedure (Packet: PSfmlPacket; const &String: PAnsiChar); cdecl;
  TSfmlPacketWriteWideString = procedure (Packet: PSfmlPacket; const &String: PWideChar); cdecl;

  TSfmlSocketSelectorCreate = function : PSfmlSocketSelector; cdecl;
  TSfmlSocketSelectorCopy = function (const Selector: PSfmlSocketSelector): PSfmlSocketSelector; cdecl;
  TSfmlSocketSelectorDestroy = procedure (Selector: PSfmlSocketSelector); cdecl;
  TSfmlSocketSelectorAddTcpListener = procedure (Selector: PSfmlSocketSelector; Socket: PSfmlTcpListener); cdecl;
  TSfmlSocketSelectorRemoveTcpListener = procedure (Selector: PSfmlSocketSelector; Socket: PSfmlTcpListener); cdecl;
  TSfmlSocketSelectorClear = procedure (Selector: PSfmlSocketSelector); cdecl;
  TSfmlSocketSelectorWait = function (Selector: PSfmlSocketSelector; Timeout: TSfmlTime): sfBool; cdecl;
  TSfmlSocketSelectorIsTcpListenerReady = function (const Selector: PSfmlSocketSelector; Socket: PSfmlTcpListener): sfBool; cdecl;
  TSfmlSocketSelectorIsTcpSocketReady = function (const Selector: PSfmlSocketSelector; Socket: PSfmlTcpSocket): sfBool; cdecl;
  TSfmlSocketSelectorIsUdpSocketReady = function (const Selector: PSfmlSocketSelector; Socket: PSfmlUdpSocket): sfBool; cdecl;

  TSfmlTcpListenerCreate = function : PSfmlTcpListener; cdecl;
  TSfmlTcpListenerDestroy = procedure (Listener: PSfmlTcpListener); cdecl;
  TSfmlTcpListenerSetBlocking = procedure (Listener: PSfmlTcpListener; Blocking: sfBool); cdecl;
  TSfmlTcpListenerIsBlocking = function (const Listener: PSfmlTcpListener): sfBool; cdecl;
  TSfmlTcpListenerGetLocalPort = function (const Listener: PSfmlTcpListener): Byte; cdecl;
  TSfmlTcpListenerListen = function (Listener: PSfmlTcpListener; Port: Byte): TSfmlSocketStatus; cdecl;
  TSfmlTcpListenerAccept = function (Listener: PSfmlTcpListener; out Connected: PSfmlTcpSocket): TSfmlSocketStatus; cdecl;

  TSfmlTcpSocketCreate = function : PSfmlTcpSocket; cdecl;
  TSfmlTcpSocketDestroy = procedure (Socket: PSfmlTcpSocket); cdecl;
  TSfmlTcpSocketSetBlocking = procedure (Socket: PSfmlTcpSocket; Blocking: sfBool); cdecl;
  TSfmlTcpSocketIsBlocking = function (const Socket: PSfmlTcpSocket): sfBool; cdecl;
  TSfmlTcpSocketGetLocalPort = function (const Socket: PSfmlTcpSocket): Byte; cdecl;
  TSfmlTcpSocketGetRemoteAddress = function (const Socket: PSfmlTcpSocket): TSfmlIpAddress; cdecl;
  TSfmlTcpSocketGetRemotePort = function (const Socket: PSfmlTcpSocket): Byte; cdecl;
  TSfmlTcpSocketConnect = function (Socket: PSfmlTcpSocket; Host: TSfmlIpAddress; Port: Byte; TimeOut: TSfmlTime): TSfmlSocketStatus; cdecl;
  TSfmlTcpSocketDisconnect = procedure (Socket: PSfmlTcpSocket); cdecl;
  TSfmlTcpSocketSend = function (Socket: PSfmlTcpSocket; const Data: Pointer; Size: NativeUInt): TSfmlSocketStatus; cdecl;
  TSfmlTcpSocketReceive = function (Socket: PSfmlTcpSocket; Data: Pointer; MaxSize: NativeUInt; SizeReceived: PNativeUInt): TSfmlSocketStatus; cdecl;
  TSfmlTcpSocketSendPacket = function (Socket: PSfmlTcpSocket; Packet: PSfmlPacket): TSfmlSocketStatus; cdecl;
  TSfmlTcpSocketReceivePacket = function (Socket: PSfmlTcpSocket; Packet: PSfmlPacket): TSfmlSocketStatus; cdecl;

  TSfmlUdpSocketCreate = function : PSfmlUdpSocket; cdecl;
  TSfmlUdpSocketDestroy = procedure (Socket: PSfmlUdpSocket); cdecl;
  TSfmlUdpSocketSetBlocking = procedure (Socket: PSfmlUdpSocket; Blocking: sfBool); cdecl;
  TSfmlUdpSocketIsBlocking = function (const Socket: PSfmlUdpSocket): sfBool; cdecl;
  TSfmlUdpSocketGetLocalPort = function (const Socket: PSfmlUdpSocket): Byte; cdecl;
  TSfmlUdpSocketBind = function (Socket: PSfmlUdpSocket; Port: Byte): TSfmlSocketStatus; cdecl;
  TSfmlUdpSocketUnbind = procedure (Socket: PSfmlUdpSocket); cdecl;
  TSfmlUdpSocketSend = function (Socket: PSfmlUdpSocket; const Data: Pointer; Size: NativeUInt; Address: TSfmlIpAddress; Port: Byte): TSfmlSocketStatus; cdecl;
  TSfmlUdpSocketReceive = function (Socket: PSfmlUdpSocket; Data: Pointer; MaxSize: NativeUInt; SizeReceived: PNativeUInt; out Address: TSfmlIpAddress; out Port: Byte): TSfmlSocketStatus; cdecl;
  TSfmlUdpSocketSendPacket = function (Socket: PSfmlUdpSocket; Packet: PSfmlPacket; Address: TSfmlIpAddress; Port: Byte): TSfmlSocketStatus; cdecl;
  TSfmlUdpSocketReceivePacket = function (Socket: PSfmlUdpSocket; Packet: PSfmlPacket; out Address: TSfmlIpAddress; out Port: Byte): TSfmlSocketStatus; cdecl;
  TSfmlUdpSocketMaxDatagramSize = function : Cardinal; cdecl;

var
  SfmlFtpListingResponseDestroy: TSfmlFtpListingResponseDestroy;
  SfmlFtpListingResponseIsOk: TSfmlFtpListingResponseIsOk;
  SfmlFtpListingResponseGetStatus: TSfmlFtpListingResponseGetStatus;
  SfmlFtpListingResponseGetMessage: TSfmlFtpListingResponseGetMessage;
  SfmlFtpListingResponseGetCount: TSfmlFtpListingResponseGetCount;
  SfmlFtpListingResponseGetName: TSfmlFtpListingResponseGetName;
  SfmlFtpDirectoryResponseDestroy: TSfmlFtpDirectoryResponseDestroy;
  SfmlFtpDirectoryResponseIsOk: TSfmlFtpDirectoryResponseIsOk;
  SfmlFtpDirectoryResponseGetStatus: TSfmlFtpDirectoryResponseGetStatus;
  SfmlFtpDirectoryResponseGetMessage: TSfmlFtpDirectoryResponseGetMessage;
  SfmlFtpDirectoryResponseGetDirectory: TSfmlFtpDirectoryResponseGetDirectory;
  SfmlFtpResponseDestroy: TSfmlFtpResponseDestroy;
  SfmlFtpResponseIsOk: TSfmlFtpResponseIsOk;
  SfmlFtpResponseGetStatus: TSfmlFtpResponseGetStatus;
  SfmlFtpResponseGetMessage: TSfmlFtpResponseGetMessage;
  SfmlFtpCreate: TSfmlFtpCreate;
  SfmlFtpDestroy: TSfmlFtpDestroy;
  SfmlFtpConnect: TSfmlFtpConnect;
  SfmlFtpLoginAnonymous: TSfmlFtpLoginAnonymous;
  SfmlFtpLogin: TSfmlFtpLogin;
  SfmlFtpDisconnect: TSfmlFtpDisconnect;
  SfmlFtpKeepAlive: TSfmlFtpKeepAlive;
  SfmlFtpGetWorkingDirectory: TSfmlFtpGetWorkingDirectory;
  SfmlFtpGetDirectoryListing: TSfmlFtpGetDirectoryListing;
  SfmlFtpChangeDirectory: TSfmlFtpChangeDirectory;
  SfmlFtpParentDirectory: TSfmlFtpParentDirectory;
  SfmlFtpCreateDirectory: TSfmlFtpCreateDirectory;
  SfmlFtpDeleteDirectory: TSfmlFtpDeleteDirectory;
  SfmlFtpRenameFile: TSfmlFtpRenameFile;
  SfmlFtpDeleteFile: TSfmlFtpDeleteFile;
  SfmlFtpDownload: TSfmlFtpDownload;
  SfmlFtpUpload: TSfmlFtpUpload;

  SfmlHttpRequestCreate: TSfmlHttpRequestCreate;
  SfmlHttpRequestDestroy: TSfmlHttpRequestDestroy;
  SfmlHttpRequestSetField: TSfmlHttpRequestSetField;
  SfmlHttpRequestSetMethod: TSfmlHttpRequestSetMethod;
  SfmlHttpRequestSetUri: TSfmlHttpRequestSetUri;
  SfmlHttpRequestSetHttpVersion: TSfmlHttpRequestSetHttpVersion;
  SfmlHttpRequestSetBody: TSfmlHttpRequestSetBody;
  SfmlHttpResponseDestroy: TSfmlHttpResponseDestroy;
  SfmlHttpResponseGetField: TSfmlHttpResponseGetField;
  SfmlHttpResponseGetStatus: TSfmlHttpResponseGetStatus;
  SfmlHttpResponseGetMajorVersion: TSfmlHttpResponseGetMajorVersion;
  SfmlHttpResponseGetMinorVersion: TSfmlHttpResponseGetMinorVersion;
  SfmlHttpResponseGetBody: TSfmlHttpResponseGetBody;
  SfmlHttpCreate: TSfmlHttpCreate;
  SfmlHttpDestroy: TSfmlHttpDestroy;
  SfmlHttpSetHost: TSfmlHttpSetHost;
  SfmlHttpSendRequest: TSfmlHttpSendRequest;

(*
  const TSfmlIpAddress sfIpAddress_None;
  const TSfmlIpAddress sfIpAddress_LocalHost;
  const TSfmlIpAddress sfIpAddress_Broadcast;
*)
  SfmlIpAddressFromString: TSfmlIpAddressFromString;
  SfmlIpAddressFromBytes: TSfmlIpAddressFromBytes;
  SfmlIpAddressFromInteger: TSfmlIpAddressFromInteger;
  SfmlIpAddressToString: TSfmlIpAddressToString;
  SfmlIpAddressToInteger: TSfmlIpAddressToInteger;
  SfmlIpAddressGetLocalAddress: TSfmlIpAddressGetLocalAddress;
  SfmlIpAddressGetPublicAddress: TSfmlIpAddressGetPublicAddress;

  SfmlPacketCreate: TSfmlPacketCreate;
  SfmlPacketCopy: TSfmlPacketCopy;
  SfmlPacketDestroy: TSfmlPacketDestroy;
  SfmlPacketAppend: TSfmlPacketAppend;
  SfmlPacketClear: TSfmlPacketClear;
  SfmlPacketGetData: TSfmlPacketGetData;
  SfmlPacketGetDataSize: TSfmlPacketGetDataSize;
  SfmlPacketEndOfPacket: TSfmlPacketEndOfPacket;
  SfmlPacketCanRead: TSfmlPacketCanRead;
  SfmlPacketReadBool: TSfmlPacketReadBool;
  SfmlPacketReadInt8: TSfmlPacketReadInt8;
  SfmlPacketReadUint8: TSfmlPacketReadUint8;
  SfmlPacketReadInt16: TSfmlPacketReadInt16;
  SfmlPacketReadUint16: TSfmlPacketReadUint16;
  SfmlPacketReadInt32: TSfmlPacketReadInt32;
  SfmlPacketReadUint32: TSfmlPacketReadUint32;
  SfmlPacketReadFloat: TSfmlPacketReadFloat;
  SfmlPacketReadDouble: TSfmlPacketReadDouble;
  SfmlPacketReadString: TSfmlPacketReadString;
  SfmlPacketReadWideString: TSfmlPacketReadWideString;
  SfmlPacketWriteBool: TSfmlPacketWriteBool;
  SfmlPacketWriteInt8: TSfmlPacketWriteInt8;
  SfmlPacketWriteUint8: TSfmlPacketWriteUint8;
  SfmlPacketWriteInt16: TSfmlPacketWriteInt16;
  SfmlPacketWriteUint16: TSfmlPacketWriteUint16;
  SfmlPacketWriteInt32: TSfmlPacketWriteInt32;
  SfmlPacketWriteUint32: TSfmlPacketWriteUint32;
  SfmlPacketWriteFloat: TSfmlPacketWriteFloat;
  SfmlPacketWriteDouble: TSfmlPacketWriteDouble;
  SfmlPacketWriteString: TSfmlPacketWriteString;
  SfmlPacketWriteWideString: TSfmlPacketWriteWideString;

  SfmlSocketSelectorCreate: TSfmlSocketSelectorCreate;
  SfmlSocketSelectorCopy: TSfmlSocketSelectorCopy;
  SfmlSocketSelectorDestroy: TSfmlSocketSelectorDestroy;
  SfmlSocketSelectorAddTcpListener: TSfmlSocketSelectorAddTcpListener;
  SfmlSocketSelectorRemoveTcpListener: TSfmlSocketSelectorRemoveTcpListener;
  SfmlSocketSelectorClear: TSfmlSocketSelectorClear;
  SfmlSocketSelectorWait: TSfmlSocketSelectorWait;
  SfmlSocketSelectorIsTcpListenerReady: TSfmlSocketSelectorIsTcpListenerReady;
  SfmlSocketSelectorIsTcpSocketReady: TSfmlSocketSelectorIsTcpSocketReady;
  SfmlSocketSelectorIsUdpSocketReady: TSfmlSocketSelectorIsUdpSocketReady;

  SfmlTcpListenerCreate: TSfmlTcpListenerCreate;
  SfmlTcpListenerDestroy: TSfmlTcpListenerDestroy;
  SfmlTcpListenerSetBlocking: TSfmlTcpListenerSetBlocking;
  SfmlTcpListenerIsBlocking: TSfmlTcpListenerIsBlocking;
  SfmlTcpListenerGetLocalPort: TSfmlTcpListenerGetLocalPort;
  SfmlTcpListenerListen: TSfmlTcpListenerListen;
  SfmlTcpListenerAccept: TSfmlTcpListenerAccept;

  SfmlTcpSocketCreate: TSfmlTcpSocketCreate;
  SfmlTcpSocketDestroy: TSfmlTcpSocketDestroy;
  SfmlTcpSocketSetBlocking: TSfmlTcpSocketSetBlocking;
  SfmlTcpSocketIsBlocking: TSfmlTcpSocketIsBlocking;
  SfmlTcpSocketGetLocalPort: TSfmlTcpSocketGetLocalPort;
  SfmlTcpSocketGetRemoteAddress: TSfmlTcpSocketGetRemoteAddress;
  SfmlTcpSocketGetRemotePort: TSfmlTcpSocketGetRemotePort;
  SfmlTcpSocketConnect: TSfmlTcpSocketConnect;
  SfmlTcpSocketDisconnect: TSfmlTcpSocketDisconnect;
  SfmlTcpSocketSend: TSfmlTcpSocketSend;
  SfmlTcpSocketReceive: TSfmlTcpSocketReceive;
  SfmlTcpSocketSendPacket: TSfmlTcpSocketSendPacket;
  SfmlTcpSocketReceivePacket: TSfmlTcpSocketReceivePacket;

  SfmlUdpSocketCreate: TSfmlUdpSocketCreate;
  SfmlUdpSocketDestroy: TSfmlUdpSocketDestroy;
  SfmlUdpSocketSetBlocking: TSfmlUdpSocketSetBlocking;
  SfmlUdpSocketIsBlocking: TSfmlUdpSocketIsBlocking;
  SfmlUdpSocketGetLocalPort: TSfmlUdpSocketGetLocalPort;
  SfmlUdpSocketBind: TSfmlUdpSocketBind;
  SfmlUdpSocketUnbind: TSfmlUdpSocketUnbind;
  SfmlUdpSocketSend: TSfmlUdpSocketSend;
  SfmlUdpSocketReceive: TSfmlUdpSocketReceive;
  SfmlUdpSocketSendPacket: TSfmlUdpSocketSendPacket;
  SfmlUdpSocketReceivePacket: TSfmlUdpSocketReceivePacket;
  SfmlUdpSocketMaxDatagramSize: TSfmlUdpSocketMaxDatagramSize;
{$ELSE}
  // static linking
  procedure SfmlFtpListingResponseDestroy(FtpListingResponse: PSfmlFtpListingResponse); cdecl; external CSfmlNetworkLibrary name 'sfFtpListingResponse_destroy';
  function SfmlFtpListingResponseIsOk(const FtpListingResponse: PSfmlFtpListingResponse): Boolean; cdecl; external CSfmlNetworkLibrary name 'sfFtpListingResponse_isOk';
  function SfmlFtpListingResponseGetStatus(const FtpListingResponse: PSfmlFtpListingResponse): TSfmlFtpStatus; cdecl; external CSfmlNetworkLibrary name 'sfFtpListingResponse_getStatus';
  function SfmlFtpListingResponseGetMessage(const FtpListingResponse: PSfmlFtpListingResponse): PAnsiChar; cdecl; external CSfmlNetworkLibrary name 'sfFtpListingResponse_getMessage';
  function SfmlFtpListingResponseGetCount(const FtpListingResponse: PSfmlFtpListingResponse): NativeUInt; cdecl; external CSfmlNetworkLibrary name 'sfFtpListingResponse_getCount';
  function SfmlFtpListingResponseGetName(const FtpListingResponse: PSfmlFtpListingResponse; Index: NativeUInt): PAnsiChar; cdecl; external CSfmlNetworkLibrary name 'sfFtpListingResponse_getName';
  procedure SfmlFtpDirectoryResponseDestroy(FtpDirectoryResponse: PSfmlFtpDirectoryResponse); cdecl; external CSfmlNetworkLibrary name 'sfFtpDirectoryResponse_destroy';
  function SfmlFtpDirectoryResponseIsOk(const FtpDirectoryResponse: PSfmlFtpDirectoryResponse): Boolean; cdecl; external CSfmlNetworkLibrary name 'sfFtpDirectoryResponse_isOk';
  function SfmlFtpDirectoryResponseGetStatus(const FtpDirectoryResponse: PSfmlFtpDirectoryResponse): TSfmlFtpStatus; cdecl; external CSfmlNetworkLibrary name 'sfFtpDirectoryResponse_getStatus';
  function SfmlFtpDirectoryResponseGetMessage(const FtpDirectoryResponse: PSfmlFtpDirectoryResponse): PAnsiChar; cdecl; external CSfmlNetworkLibrary name 'sfFtpDirectoryResponse_getMessage';
  function SfmlFtpDirectoryResponseGetDirectory(const FtpDirectoryResponse: PSfmlFtpDirectoryResponse): PAnsiChar; cdecl; external CSfmlNetworkLibrary name 'sfFtpDirectoryResponse_getDirectory';
  procedure SfmlFtpResponseDestroy(FtpResponse: PSfmlFtpResponse); cdecl; external CSfmlNetworkLibrary name 'sfFtpResponse_destroy';
  function SfmlFtpResponseIsOk(const FtpResponse: PSfmlFtpResponse): Boolean; cdecl; external CSfmlNetworkLibrary name 'sfFtpResponse_isOk';
  function SfmlFtpResponseGetStatus(const FtpResponse: PSfmlFtpResponse): TSfmlFtpStatus; cdecl; external CSfmlNetworkLibrary name 'sfFtpResponse_getStatus';
  function SfmlFtpResponseGetMessage(const FtpResponse: PSfmlFtpResponse): PAnsiChar; cdecl; external CSfmlNetworkLibrary name 'sfFtpResponse_getMessage';
  function SfmlFtpCreate: PSfmlFtp; cdecl; external CSfmlNetworkLibrary name 'sfFtp_create';
  procedure SfmlFtpDestroy(Ftp: PSfmlFtp); cdecl; external CSfmlNetworkLibrary name 'sfFtp_destroy';
  function SfmlFtpConnect(Ftp: PSfmlFtp; Server: TSfmlIpAddress; Port: Byte; Timeout: TSfmlTime): PSfmlFtpResponse; cdecl; external CSfmlNetworkLibrary name 'sfFtp_connect';
  function SfmlFtpLoginAnonymous(Ftp: PSfmlFtp): PSfmlFtpResponse; cdecl; external CSfmlNetworkLibrary name 'sfFtp_loginAnonymous';
  function SfmlFtpLogin(Ftp: PSfmlFtp; const UserName, Password: PAnsiChar): PSfmlFtpResponse; cdecl; external CSfmlNetworkLibrary name 'sfFtp_login';
  function SfmlFtpDisconnect(Ftp: PSfmlFtp): PSfmlFtpResponse; cdecl; external CSfmlNetworkLibrary name 'sfFtp_disconnect';
  function SfmlFtpKeepAlive(Ftp: PSfmlFtp): PSfmlFtpResponse; cdecl; external CSfmlNetworkLibrary name 'sfFtp_keepAlive';
  function SfmlFtpGetWorkingDirectory(Ftp: PSfmlFtp): PSfmlFtpDirectoryResponse; cdecl; external CSfmlNetworkLibrary name 'sfFtp_getWorkingDirectory';
  function SfmlFtpGetDirectoryListing(Ftp: PSfmlFtp; const Directory: PAnsiChar): PSfmlFtpListingResponse; cdecl; external CSfmlNetworkLibrary name 'sfFtp_getDirectoryListing';
  function SfmlFtpChangeDirectory(Ftp: PSfmlFtp; const Directory: PAnsiChar): PSfmlFtpResponse; cdecl; external CSfmlNetworkLibrary name 'sfFtp_changeDirectory';
  function SfmlFtpParentDirectory(Ftp: PSfmlFtp): PSfmlFtpResponse; cdecl; external CSfmlNetworkLibrary name 'sfFtp_parentDirectory';
  function SfmlFtpCreateDirectory(Ftp: PSfmlFtp; const Name: PAnsiChar): PSfmlFtpResponse; cdecl; external CSfmlNetworkLibrary name 'sfFtp_createDirectory';
  function SfmlFtpDeleteDirectory(Ftp: PSfmlFtp; const Name: PAnsiChar): PSfmlFtpResponse; cdecl; external CSfmlNetworkLibrary name 'sfFtp_deleteDirectory';
  function SfmlFtpRenameFile(Ftp: PSfmlFtp; const &File: PAnsiChar; const NewName: PAnsiChar): PSfmlFtpResponse; cdecl; external CSfmlNetworkLibrary name 'sfFtp_renameFile';
  function SfmlFtpDeleteFile(Ftp: PSfmlFtp; const Name: PAnsiChar): PSfmlFtpResponse; cdecl; external CSfmlNetworkLibrary name 'sfFtp_deleteFile';
  function SfmlFtpDownload(Ftp: PSfmlFtp; const DistantFile: PAnsiChar; const DestPath: PAnsiChar; Mode: TSfmlFtpTransferMode): PSfmlFtpResponse; cdecl; external CSfmlNetworkLibrary name 'sfFtp_download';
  function SfmlFtpUpload(Ftp: PSfmlFtp; const LocalFile: PAnsiChar; const DestPath: PAnsiChar; Mode: TSfmlFtpTransferMode): PSfmlFtpResponse; cdecl; external CSfmlNetworkLibrary name 'sfFtp_upload';

  function SfmlHttpRequestCreate: PSfmlHttpRequest; cdecl; external CSfmlNetworkLibrary name 'sfHttpRequest_create';
  procedure SfmlHttpRequestDestroy(HttpRequest: PSfmlHttpRequest); cdecl; external CSfmlNetworkLibrary name 'sfHttpRequest_destroy';
  procedure SfmlHttpRequestSetField(HttpRequest: PSfmlHttpRequest; const Field: PAnsiChar; const Value: PAnsiChar); cdecl; external CSfmlNetworkLibrary name 'sfHttpRequest_setField';
  procedure SfmlHttpRequestSetMethod(HttpRequest: PSfmlHttpRequest; Method: TSfmlHttpMethod); cdecl; external CSfmlNetworkLibrary name 'sfHttpRequest_setMethod';
  procedure SfmlHttpRequestSetUri(HttpRequest: PSfmlHttpRequest; const uri: PAnsiChar); cdecl; external CSfmlNetworkLibrary name 'sfHttpRequest_setUri';
  procedure SfmlHttpRequestSetHttpVersion(HttpRequest: PSfmlHttpRequest; major, minor: Cardinal); cdecl; external CSfmlNetworkLibrary name 'sfHttpRequest_setHttpVersion';
  procedure SfmlHttpRequestSetBody(HttpRequest: PSfmlHttpRequest; const body: PAnsiChar); cdecl; external CSfmlNetworkLibrary name 'sfHttpRequest_setBody';
  procedure SfmlHttpResponseDestroy(httpResponse: PSfmlHttpResponse); cdecl; external CSfmlNetworkLibrary name 'sfHttpResponse_destroy';
  function SfmlHttpResponseGetField(const HttpResponse: PSfmlHttpResponse; const Field: PAnsiChar): PAnsiChar; cdecl; external CSfmlNetworkLibrary name 'sfHttpResponse_getField';
  function SfmlHttpResponseGetStatus(const HttpResponse: PSfmlHttpResponse): TSfmlHttpStatus; cdecl; external CSfmlNetworkLibrary name 'sfHttpResponse_getStatus';
  function SfmlHttpResponseGetMajorVersion(const HttpResponse: PSfmlHttpResponse): Cardinal; cdecl; external CSfmlNetworkLibrary name 'sfHttpResponse_getMajorVersion';
  function SfmlHttpResponseGetMinorVersion(const HttpResponse: PSfmlHttpResponse): Cardinal; cdecl; external CSfmlNetworkLibrary name 'sfHttpResponse_getMinorVersion';
  function SfmlHttpResponseGetBody(const HttpResponse: PSfmlHttpResponse): PAnsiChar; cdecl; external CSfmlNetworkLibrary name 'sfHttpResponse_getBody';
  function SfmlHttpCreate: PSfmlHttp; cdecl; external CSfmlNetworkLibrary name 'sfHttp_create';
  procedure SfmlHttpDestroy(Http: PSfmlHttp); cdecl; external CSfmlNetworkLibrary name 'sfHttp_destroy';
  procedure SfmlHttpSetHost(Http: PSfmlHttp; const Host: PAnsiChar; Port: Byte); cdecl; external CSfmlNetworkLibrary name 'sfHttp_setHost';
  function SfmlHttpSendRequest(Http: PSfmlHttp; const Request: PSfmlHttpRequest; Timeout: TSfmlTime): PSfmlHttpResponse; cdecl; external CSfmlNetworkLibrary name 'sfHttp_sendRequest';

(*
  const TSfmlIpAddress sfIpAddress_None;
  const TSfmlIpAddress sfIpAddress_LocalHost;
  const TSfmlIpAddress sfIpAddress_Broadcast;
*)
  function SfmlIpAddressFromString(const address: PAnsiChar): TSfmlIpAddress; cdecl; external CSfmlNetworkLibrary name 'sfIpAddress_fromString';
  function SfmlIpAddressFromBytes(byte0, byte1, byte2, byte3: Byte): TSfmlIpAddress; cdecl; external CSfmlNetworkLibrary name 'sfIpAddress_fromBytes';
  function SfmlIpAddressFromInteger(Address: Cardinal): TSfmlIpAddress; cdecl; external CSfmlNetworkLibrary name 'sfIpAddress_fromInteger';
  procedure SfmlIpAddressToString(Address: TSfmlIpAddress; &String: PAnsiChar); cdecl; external CSfmlNetworkLibrary name 'sfIpAddress_toString';
  function SfmlIpAddressToInteger(Address: TSfmlIpAddress): Cardinal; cdecl; external CSfmlNetworkLibrary name 'sfIpAddress_toInteger';
  function SfmlIpAddressGetLocalAddress: TSfmlIpAddress; cdecl; external CSfmlNetworkLibrary name 'sfIpAddress_getLocalAddress';
  function SfmlIpAddressGetPublicAddress(Timeout: TSfmlTime): TSfmlIpAddress; cdecl; external CSfmlNetworkLibrary name 'sfIpAddress_getPublicAddress';

  function SfmlPacketCreate: PSfmlPacket; cdecl; external CSfmlNetworkLibrary name 'sfPacket_create';
  function SfmlPacketCopy(const Packet: PSfmlPacket): PSfmlPacket; cdecl; external CSfmlNetworkLibrary name 'sfPacket_copy';
  procedure SfmlPacketDestroy(Packet: PSfmlPacket); cdecl; external CSfmlNetworkLibrary name 'sfPacket_destroy';
  procedure SfmlPacketAppend(Packet: PSfmlPacket; const Data: Pointer; SizeInBytes: NativeUInt); cdecl; external CSfmlNetworkLibrary name 'sfPacket_append';
  procedure SfmlPacketClear(Packet: PSfmlPacket); cdecl; external CSfmlNetworkLibrary name 'sfPacket_clear';
  function SfmlPacketGetData(const Packet: PSfmlPacket): Pointer; cdecl; external CSfmlNetworkLibrary name 'sfPacket_getData';
  function SfmlPacketGetDataSize(const Packet: PSfmlPacket): NativeUInt; cdecl; external CSfmlNetworkLibrary name 'sfPacket_getDataSize';
  function SfmlPacketEndOfPacket(const Packet: PSfmlPacket): Boolean; cdecl; external CSfmlNetworkLibrary name 'sfPacket_endOfPacket';
  function SfmlPacketCanRead(const Packet: PSfmlPacket): Boolean; cdecl; external CSfmlNetworkLibrary name 'sfPacket_canRead';
  function SfmlPacketReadBool(Packet: PSfmlPacket): Boolean; cdecl; external CSfmlNetworkLibrary name 'sfPacket_readBool';
  function SfmlPacketReadInt8(Packet: PSfmlPacket): ShortInt; cdecl; external CSfmlNetworkLibrary name 'sfPacket_readInt8';
  function SfmlPacketReadUint8(Packet: PSfmlPacket): Byte; cdecl; external CSfmlNetworkLibrary name 'sfPacket_readUint8';
  function SfmlPacketReadInt16(Packet: PSfmlPacket): SmallInt; cdecl; external CSfmlNetworkLibrary name 'sfPacket_readInt16';
  function SfmlPacketReadUint16(Packet: PSfmlPacket): Word; cdecl; external CSfmlNetworkLibrary name 'sfPacket_readUint16';
  function SfmlPacketReadInt32(Packet: PSfmlPacket): LongInt; cdecl; external CSfmlNetworkLibrary name 'sfPacket_readInt32';
  function SfmlPacketReadUint32(Packet: PSfmlPacket): Cardinal; cdecl; external CSfmlNetworkLibrary name 'sfPacket_readUint32';
  function SfmlPacketReadFloat(Packet: PSfmlPacket): Single; cdecl; external CSfmlNetworkLibrary name 'sfPacket_readFloat';
  function SfmlPacketReadDouble(Packet: PSfmlPacket): Double; cdecl; external CSfmlNetworkLibrary name 'sfPacket_readDouble';
  procedure SfmlPacketReadString(Packet: PSfmlPacket; &String: PAnsiChar); cdecl; external CSfmlNetworkLibrary name 'sfPacket_readString';
  procedure SfmlPacketReadWideString(Packet: PSfmlPacket; &String: PWideChar); cdecl; external CSfmlNetworkLibrary name 'sfPacket_readWideString';
  procedure SfmlPacketWriteBool(Packet: PSfmlPacket; Value: Boolean); cdecl; external CSfmlNetworkLibrary name 'sfPacket_writeBool';
  procedure SfmlPacketWriteInt8(Packet: PSfmlPacket; Value: ShortInt); cdecl; external CSfmlNetworkLibrary name 'sfPacket_writeInt8';
  procedure SfmlPacketWriteUint8(Packet: PSfmlPacket; Value: Byte); cdecl; external CSfmlNetworkLibrary name 'sfPacket_writeUint8';
  procedure SfmlPacketWriteInt16(Packet: PSfmlPacket; Value: SmallInt); cdecl; external CSfmlNetworkLibrary name 'sfPacket_writeInt16';
  procedure SfmlPacketWriteUint16(Packet: PSfmlPacket; Value: Word); cdecl; external CSfmlNetworkLibrary name 'sfPacket_writeUint16';
  procedure SfmlPacketWriteInt32(Packet: PSfmlPacket; Value: LongInt); cdecl; external CSfmlNetworkLibrary name 'sfPacket_writeInt32';
  procedure SfmlPacketWriteUint32(Packet: PSfmlPacket; Value: Cardinal); cdecl; external CSfmlNetworkLibrary name 'sfPacket_writeUint32';
  procedure SfmlPacketWriteFloat(Packet: PSfmlPacket; Value: Single); cdecl; external CSfmlNetworkLibrary name 'sfPacket_writeFloat';
  procedure SfmlPacketWriteDouble(Packet: PSfmlPacket; Value: Double); cdecl; external CSfmlNetworkLibrary name 'sfPacket_writeDouble';
  procedure SfmlPacketWriteString(Packet: PSfmlPacket; const &String: PAnsiChar); cdecl; external CSfmlNetworkLibrary name 'sfPacket_writeString';
  procedure SfmlPacketWriteWideString(Packet: PSfmlPacket; const &String: PWideChar); cdecl; external CSfmlNetworkLibrary name 'sfPacket_writeWideString';

  function SfmlSocketSelectorCreate: PSfmlSocketSelector; cdecl; external CSfmlNetworkLibrary name 'sfSocketSelector_create';
  function SfmlSocketSelectorCopy(const Selector: PSfmlSocketSelector): PSfmlSocketSelector; cdecl; external CSfmlNetworkLibrary name 'sfSocketSelector_copy';
  procedure SfmlSocketSelectorDestroy(Selector: PSfmlSocketSelector); cdecl; external CSfmlNetworkLibrary name 'sfSocketSelector_destroy';
  procedure SfmlSocketSelectorAddTcpListener(Selector: PSfmlSocketSelector; Socket: PSfmlTcpListener); cdecl; external CSfmlNetworkLibrary name 'sfSocketSelector_addTcpListener';
  procedure SfmlSocketSelectorRemoveTcpListener(Selector: PSfmlSocketSelector; Socket: PSfmlTcpListener); cdecl; external CSfmlNetworkLibrary name 'sfSocketSelector_removeTcpListener';
  procedure SfmlSocketSelectorClear(Selector: PSfmlSocketSelector); cdecl; external CSfmlNetworkLibrary name 'sfSocketSelector_clear';
  function SfmlSocketSelectorWait(Selector: PSfmlSocketSelector; Timeout: TSfmlTime): Boolean; cdecl; external CSfmlNetworkLibrary name 'sfSocketSelector_wait';
  function SfmlSocketSelectorIsTcpListenerReady(const Selector: PSfmlSocketSelector; Socket: PSfmlTcpListener): Boolean; cdecl; external CSfmlNetworkLibrary name 'sfSocketSelector_isTcpListenerReady';
  function SfmlSocketSelectorIsTcpSocketReady(const Selector: PSfmlSocketSelector; Socket: PSfmlTcpSocket): Boolean; cdecl; external CSfmlNetworkLibrary name 'sfSocketSelector_isTcpSocketReady';
  function SfmlSocketSelectorIsUdpSocketReady(const Selector: PSfmlSocketSelector; Socket: PSfmlUdpSocket): Boolean; cdecl; external CSfmlNetworkLibrary name 'sfSocketSelector_isUdpSocketReady';

  function SfmlTcpListenerCreate: PSfmlTcpListener; cdecl; external CSfmlNetworkLibrary name 'sfTcpListener_create';
  procedure SfmlTcpListenerDestroy(Listener: PSfmlTcpListener); cdecl; external CSfmlNetworkLibrary name 'sfTcpListener_destroy';
  procedure SfmlTcpListenerSetBlocking(Listener: PSfmlTcpListener; Blocking: Boolean); cdecl; external CSfmlNetworkLibrary name 'sfTcpListener_setBlocking';
  function SfmlTcpListenerIsBlocking(const Listener: PSfmlTcpListener): Boolean; cdecl; external CSfmlNetworkLibrary name 'sfTcpListener_isBlocking';
  function SfmlTcpListenerGetLocalPort(const Listener: PSfmlTcpListener): Byte; cdecl; external CSfmlNetworkLibrary name 'sfTcpListener_getLocalPort';
  function SfmlTcpListenerListen(Listener: PSfmlTcpListener; Port: Byte): TSfmlSocketStatus; cdecl; external CSfmlNetworkLibrary name 'sfTcpListener_listen';
  function SfmlTcpListenerAccept(Listener: PSfmlTcpListener; out Connected: PSfmlTcpSocket): TSfmlSocketStatus; cdecl; external CSfmlNetworkLibrary name 'sfTcpListener_accept';

  function SfmlTcpSocketCreate: PSfmlTcpSocket; cdecl; external CSfmlNetworkLibrary name 'sfTcpSocket_create';
  procedure SfmlTcpSocketDestroy(Socket: PSfmlTcpSocket); cdecl; external CSfmlNetworkLibrary name 'sfTcpSocket_destroy';
  procedure SfmlTcpSocketSetBlocking(Socket: PSfmlTcpSocket; Blocking: Boolean); cdecl; external CSfmlNetworkLibrary name 'sfTcpSocket_setBlocking';
  function SfmlTcpSocketIsBlocking(const Socket: PSfmlTcpSocket): Boolean; cdecl; external CSfmlNetworkLibrary name 'sfTcpSocket_isBlocking';
  function SfmlTcpSocketGetLocalPort(const Socket: PSfmlTcpSocket): Byte; cdecl; external CSfmlNetworkLibrary name 'sfTcpSocket_getLocalPort';
  function SfmlTcpSocketGetRemoteAddress(const Socket: PSfmlTcpSocket): TSfmlIpAddress; cdecl; external CSfmlNetworkLibrary name 'sfTcpSocket_getRemoteAddress';
  function SfmlTcpSocketGetRemotePort(const Socket: PSfmlTcpSocket): Byte; cdecl; external CSfmlNetworkLibrary name 'sfTcpSocket_getRemotePort';
  function SfmlTcpSocketConnect(Socket: PSfmlTcpSocket; Host: TSfmlIpAddress; Port: Byte; TimeOut: TSfmlTime): TSfmlSocketStatus; cdecl; external CSfmlNetworkLibrary name 'sfTcpSocket_connect';
  procedure SfmlTcpSocketDisconnect(Socket: PSfmlTcpSocket); cdecl; external CSfmlNetworkLibrary name 'sfTcpSocket_disconnect';
  function SfmlTcpSocketSend(Socket: PSfmlTcpSocket; const Data: Pointer; Size: NativeUInt): TSfmlSocketStatus; cdecl; external CSfmlNetworkLibrary name 'sfTcpSocket_send';
  function SfmlTcpSocketReceive(Socket: PSfmlTcpSocket; Data: Pointer; MaxSize: NativeUInt; SizeReceived: PNativeUInt): TSfmlSocketStatus; cdecl; external CSfmlNetworkLibrary name 'sfTcpSocket_receive';
  function SfmlTcpSocketSendPacket(Socket: PSfmlTcpSocket; Packet: PSfmlPacket): TSfmlSocketStatus; cdecl; external CSfmlNetworkLibrary name 'sfTcpSocket_sendPacket';
  function SfmlTcpSocketReceivePacket(Socket: PSfmlTcpSocket; Packet: PSfmlPacket): TSfmlSocketStatus; cdecl; external CSfmlNetworkLibrary name 'sfTcpSocket_receivePacket';

  function SfmlUdpSocketCreate: PSfmlUdpSocket; cdecl; external CSfmlNetworkLibrary name 'sfUdpSocket_create';
  procedure SfmlUdpSocketDestroy(Socket: PSfmlUdpSocket); cdecl; external CSfmlNetworkLibrary name 'sfUdpSocket_destroy';
  procedure SfmlUdpSocketSetBlocking(Socket: PSfmlUdpSocket; Blocking: Boolean); cdecl; external CSfmlNetworkLibrary name 'sfUdpSocket_setBlocking';
  function SfmlUdpSocketIsBlocking(const Socket: PSfmlUdpSocket): Boolean; cdecl; external CSfmlNetworkLibrary name 'sfUdpSocket_isBlocking';
  function SfmlUdpSocketGetLocalPort(const Socket: PSfmlUdpSocket): Byte; cdecl; external CSfmlNetworkLibrary name 'sfUdpSocket_getLocalPort';
  function SfmlUdpSocketBind(Socket: PSfmlUdpSocket; Port: Byte): TSfmlSocketStatus; cdecl; external CSfmlNetworkLibrary name 'sfUdpSocket_bind';
  procedure SfmlUdpSocketUnbind(Socket: PSfmlUdpSocket); cdecl; external CSfmlNetworkLibrary name 'sfUdpSocket_unbind';
  function SfmlUdpSocketSend(Socket: PSfmlUdpSocket; const Data: Pointer; Size: NativeUInt; Address: TSfmlIpAddress; Port: Byte): TSfmlSocketStatus; cdecl; external CSfmlNetworkLibrary name 'sfUdpSocket_send';
  function SfmlUdpSocketReceive(Socket: PSfmlUdpSocket; Data: Pointer; MaxSize: NativeUInt; SizeReceived: PNativeUInt; out Address: TSfmlIpAddress; out Port: Byte): TSfmlSocketStatus; cdecl; external CSfmlNetworkLibrary name 'sfUdpSocket_receive';
  function SfmlUdpSocketSendPacket(Socket: PSfmlUdpSocket; Packet: PSfmlPacket; Address: TSfmlIpAddress; Port: Byte): TSfmlSocketStatus; cdecl; external CSfmlNetworkLibrary name 'sfUdpSocket_sendPacket';
  function SfmlUdpSocketReceivePacket(Socket: PSfmlUdpSocket; Packet: PSfmlPacket; out Address: TSfmlIpAddress; out Port: Byte): TSfmlSocketStatus; cdecl; external CSfmlNetworkLibrary name 'sfUdpSocket_receivePacket';
  function SfmlUdpSocketMaxDatagramSize: Cardinal; cdecl; external CSfmlNetworkLibrary name 'sfUdpSocket_maxDatagramSize';
{$ENDIF}

type
  TSfmlFtpListingResponse = class
  private
    FHandle: PSfmlFtpListingResponse;
  public
    destructor Destroy; override;
    function IsOk: Boolean;
    function GetStatus: TSfmlFtpStatus;
    function GetMessage: AnsiString;
    function GetCount: NativeUInt;
    function GetName(Index: NativeUInt): AnsiString;
  end;

  TSfmlFtpDirectoryResponse = class
  private
    FHandle: PSfmlFtpDirectoryResponse;
  public
    destructor Destroy; override;
    function IsOk: Boolean;
    function GetStatus: TSfmlFtpStatus;
    function GetMessage: AnsiString;
    function GetDirectory: AnsiString;
  end;

  TSfmlFtpResponse = class
  private
    FHandle: PSfmlFtpResponse;
  public
    destructor Destroy; override;
    function IsOk: Boolean;
    function GetStatus: TSfmlFtpStatus;
    function GetMessage: AnsiString;
  end;

  TSfmlFtp = class
  private
    FHandle: PSfmlFtp;
  public
    constructor Create;
    destructor Destroy; override;
    function Connect(Server: TSfmlIpAddress; Port: Byte; Timeout: TSfmlTime): PSfmlFtpResponse;
    function LoginAnonymous: PSfmlFtpResponse;
    function Login(const UserName, Password: AnsiString): PSfmlFtpResponse;
    function Disconnect: PSfmlFtpResponse;
    function KeepAlive: PSfmlFtpResponse;
    function GetWorkingDirectory: PSfmlFtpDirectoryResponse;
    function GetDirectoryListing(Directory: AnsiString): PSfmlFtpListingResponse;
    function ChangeDirectory(Directory: AnsiString): PSfmlFtpResponse;
    function ParentDirectory: PSfmlFtpResponse;
    function CreateDirectory(Name: AnsiString): PSfmlFtpResponse;
    function DeleteDirectory(Name: AnsiString): PSfmlFtpResponse;
    function RenameFile(&File: AnsiString; const NewName: AnsiString): PSfmlFtpResponse;
    function DeleteFile(Name: AnsiString): PSfmlFtpResponse;
    function Download(DistantFile: AnsiString; const DestPath: AnsiString; Mode: TSfmlFtpTransferMode): PSfmlFtpResponse;
    function Upload(LocalFile: AnsiString; const DestPath: AnsiString; Mode: TSfmlFtpTransferMode): PSfmlFtpResponse;
  end;

  TSfmlHttpRequest = class
  private
    FHandle: PSfmlHttpRequest;
  public
    constructor Create;
    destructor Destroy; override;
    procedure SetField(Field: AnsiString; const Value: AnsiString);
    procedure SetMethod(Method: TSfmlHttpMethod);
    procedure SetUri(Uri: AnsiString);
    procedure SetHttpVersion(Major, Minor: Cardinal);
    procedure SetBody(Body: AnsiString);
  end;

  TSfmlHttpResponse = class
  private
    FHandle: PSfmlHttpResponse;
  public
    destructor Destroy; override;
    function GetField(const Field: AnsiString): AnsiString;
    function GetStatus: TSfmlHttpStatus;
    function GetMajorVersion: Cardinal;
    function GetMinorVersion: Cardinal;
    function GetBody: AnsiString;
  end;

  TSfmlHttp = class
  private
    FHandle: PSfmlHttp;
  public
    constructor Create;
    destructor Destroy; override;
    procedure SetHost(const Host: AnsiString; Port: Byte);
    function SendRequest(const Request: PSfmlHttpRequest; Timeout: TSfmlTime): PSfmlHttpResponse;
  end;

  TSfmlPacket = class
  private
    FHandle: PSfmlPacket;
  public
    constructor Create;
    destructor Destroy; override;
    function Copy: TSfmlPacket;
    procedure Append(Data: Pointer; SizeInBytes: NativeUInt);
    procedure Clear;
    function GetData: Pointer;
    function GetDataSize: NativeUInt;
    function EndOfPacket: Boolean;
    function CanRead: Boolean;
    function ReadBool: Boolean;
    function ReadInt8: ShortInt;
    function ReadUint8: Byte;
    function ReadInt16: SmallInt;
    function ReadUint16: Word;
    function ReadInt32: LongInt;
    function ReadUint32: Cardinal;
    function ReadFloat: Single;
    function ReadDouble: Double;
    procedure ReadString(&String: AnsiString);
    procedure ReadWideString(&String: string);
    procedure WriteBool(Value: Boolean);
    procedure WriteInt8(Value: ShortInt);
    procedure WriteUint8(Value: Byte);
    procedure WriteInt16(Value: SmallInt);
    procedure WriteUint16(Value: Word);
    procedure WriteInt32(Value: LongInt);
    procedure WriteUint32(Value: Cardinal);
    procedure WriteFloat(Value: Single);
    procedure WriteDouble(Value: Double);
    procedure WriteString(&String: AnsiString);
    procedure WriteWideString(&String: PWideChar);
  end;

  TSfmlSocketSelector = class
  private
    FHandle: PSfmlSocketSelector;
  public
    constructor Create;
    destructor Destroy; override;

    function Copy: TSfmlSocketSelector;
    procedure AddTcpListener(Socket: PSfmlTcpListener);
    procedure RemoveTcpListener(Socket: PSfmlTcpListener);
    procedure Clear;
    function Wait(Timeout: TSfmlTime): Boolean;
    function IsTcpListenerReady(Socket: PSfmlTcpListener): Boolean;
    function IsTcpSocketReady(Socket: PSfmlTcpSocket): Boolean;
    function IsUdpSocketReady(Socket: PSfmlUdpSocket): Boolean;
  end;

  TSfmlTcpListener = class
  private
    FHandle: PSfmlTcpListener;
  public
    constructor Create;
    destructor Destroy; override;

    procedure SetBlocking(Blocking: Boolean);
    function IsBlocking: Boolean;
    function GetLocalPort: Byte;
    function Listen(Port: Byte): TSfmlSocketStatus;
    function Accept(out Connected: PSfmlTcpSocket): TSfmlSocketStatus;
  end;

  TSfmlTcpSocket = class
  private
    FHandle: PSfmlTcpSocket;
  public
    constructor Create;
    destructor Destroy; override;

    procedure SetBlocking(Blocking: Boolean);
    function IsBlocking: Boolean;
    function GetLocalPort: Byte;
    function GetRemoteAddress: TSfmlIpAddress;
    function GetRemotePort: Byte;
    function Connect(Host: TSfmlIpAddress; Port: Byte; TimeOut: TSfmlTime): TSfmlSocketStatus;
    procedure Disconnect;
    function Send(Data: Pointer; Size: NativeUInt): TSfmlSocketStatus;
    function Receive(Data: Pointer; MaxSize: NativeUInt; SizeReceived: PNativeUInt): TSfmlSocketStatus;
    function SendPacket(Packet: PSfmlPacket): TSfmlSocketStatus;
    function ReceivePacket(Packet: PSfmlPacket): TSfmlSocketStatus;
  end;

  TSfmlUdpSocket = class
  private
    FHandle: PSfmlUdpSocket;
  public
    constructor Create;
    destructor Destroy; override;

    procedure SetBlocking(Blocking: Boolean);
    function IsBlocking: Boolean;
    function GetLocalPort: Byte;
    function Bind(Port: Byte): TSfmlSocketStatus;
    procedure Unbind;
    function Send(Data: Pointer; Size: NativeUInt; Address: TSfmlIpAddress; Port: Byte): TSfmlSocketStatus;
    function Receive(Data: Pointer; MaxSize: NativeUInt; SizeReceived: PNativeUInt; out Address: TSfmlIpAddress; out Port: Byte): TSfmlSocketStatus;
    function SendPacket(Packet: PSfmlPacket; Address: TSfmlIpAddress; Port: Byte): TSfmlSocketStatus;
    function ReceivePacket(Packet: PSfmlPacket; out Address: TSfmlIpAddress; out Port: Byte): TSfmlSocketStatus;
    function MaxDatagramSize: Cardinal;
  end;

implementation

{$IFDEF DynLink}
{$IFDEF MSWindows}
uses
  Windows;
{$ENDIF}
{$ENDIF}

{ TSfmlFtpListingResponse }

destructor TSfmlFtpListingResponse.Destroy;
begin
  SfmlFtpListingResponseDestroy(FHandle);
  inherited;
end;

function TSfmlFtpListingResponse.GetCount: NativeUInt;
begin
  Result := SfmlFtpListingResponseGetCount(FHandle);
end;

function TSfmlFtpListingResponse.GetMessage: AnsiString;
begin
  Result := SfmlFtpListingResponseGetMessage(FHandle);
end;

function TSfmlFtpListingResponse.GetName(Index: NativeUInt): AnsiString;
begin
  Result := SfmlFtpListingResponseGetName(FHandle, Index);
end;

function TSfmlFtpListingResponse.GetStatus: TSfmlFtpStatus;
begin
  Result := SfmlFtpListingResponseGetStatus(FHandle);
end;

function TSfmlFtpListingResponse.IsOk: Boolean;
begin
  Result := SfmlFtpListingResponseIsOk(FHandle);
end;


{ TSfmlFtpDirectoryResponse }

destructor TSfmlFtpDirectoryResponse.Destroy;
begin
  SfmlFtpDirectoryResponseDestroy(FHandle);
  inherited;
end;

function TSfmlFtpDirectoryResponse.GetDirectory: AnsiString;
begin
  Result := SfmlFtpDirectoryResponseGetDirectory(FHandle);
end;

function TSfmlFtpDirectoryResponse.GetMessage: AnsiString;
begin
  Result := SfmlFtpDirectoryResponseGetMessage(FHandle);
end;

function TSfmlFtpDirectoryResponse.GetStatus: TSfmlFtpStatus;
begin
  Result := SfmlFtpDirectoryResponseGetStatus(FHandle);
end;

function TSfmlFtpDirectoryResponse.IsOk: Boolean;
begin
  Result := SfmlFtpDirectoryResponseIsOk(FHandle);
end;


{ TSfmlFtpResponse }

destructor TSfmlFtpResponse.Destroy;
begin
  SfmlFtpResponseDestroy(FHandle);
  inherited;
end;

function TSfmlFtpResponse.GetMessage: AnsiString;
begin
  Result := SfmlFtpResponseGetMessage(FHandle);
end;

function TSfmlFtpResponse.GetStatus: TSfmlFtpStatus;
begin
  Result := SfmlFtpResponseGetStatus(FHandle);
end;

function TSfmlFtpResponse.IsOk: Boolean;
begin
  Result := SfmlFtpResponseIsOk(FHandle);
end;


{ TSfmlFtp }

constructor TSfmlFtp.Create;
begin
  FHandle := SfmlFtpCreate;
end;

destructor TSfmlFtp.Destroy;
begin
  SfmlFtpDestroy(FHandle);
  inherited;
end;

function TSfmlFtp.ChangeDirectory(Directory: AnsiString): PSfmlFtpResponse;
begin
  Result := SfmlFtpChangeDirectory(FHandle, PAnsiChar(Directory));
end;

function TSfmlFtp.Connect(Server: TSfmlIpAddress; Port: Byte;
  Timeout: TSfmlTime): PSfmlFtpResponse;
begin
  Result := SfmlFtpConnect(FHandle, Server, Port, Timeout);
end;

function TSfmlFtp.CreateDirectory(Name: AnsiString): PSfmlFtpResponse;
begin
  Result := SfmlFtpCreateDirectory(FHandle, PAnsiChar(Name));
end;

function TSfmlFtp.DeleteDirectory(Name: AnsiString): PSfmlFtpResponse;
begin
  Result := SfmlFtpDeleteDirectory(FHandle, PAnsiChar(Name));
end;

function TSfmlFtp.DeleteFile(Name: AnsiString): PSfmlFtpResponse;
begin
  Result := SfmlFtpDeleteFile(FHandle, PAnsiChar(Name));
end;

function TSfmlFtp.Disconnect: PSfmlFtpResponse;
begin
  Result := SfmlFtpDisconnect(FHandle);
end;

function TSfmlFtp.Download(DistantFile: AnsiString; const DestPath: AnsiString;
  Mode: TSfmlFtpTransferMode): PSfmlFtpResponse;
begin
  Result := SfmlFtpDownload(FHandle, PAnsiChar(DistantFile),
    PAnsiChar(DestPath), Mode);
end;

function TSfmlFtp.GetDirectoryListing(
  Directory: AnsiString): PSfmlFtpListingResponse;
begin
  Result := SfmlFtpGetDirectoryListing(FHandle, PAnsiChar(Directory));
end;

function TSfmlFtp.GetWorkingDirectory: PSfmlFtpDirectoryResponse;
begin
  Result := SfmlFtpGetWorkingDirectory(FHandle);
end;

function TSfmlFtp.KeepAlive: PSfmlFtpResponse;
begin
  Result := SfmlFtpKeepAlive(FHandle);
end;

function TSfmlFtp.Login(const UserName, Password: AnsiString): PSfmlFtpResponse;
begin
  Result := SfmlFtpLogin(FHandle, PAnsiChar(UserName), PAnsiChar(Password));
end;

function TSfmlFtp.LoginAnonymous: PSfmlFtpResponse;
begin
  Result := SfmlFtpLoginAnonymous(FHandle);
end;

function TSfmlFtp.ParentDirectory: PSfmlFtpResponse;
begin
  Result := SfmlFtpParentDirectory(FHandle);
end;

function TSfmlFtp.RenameFile(&File: AnsiString;
  const NewName: AnsiString): PSfmlFtpResponse;
begin
  Result := SfmlFtpRenameFile(FHandle, PAnsiChar(&File), PAnsiChar(NewName));
end;

function TSfmlFtp.Upload(LocalFile: AnsiString; const DestPath: AnsiString;
  Mode: TSfmlFtpTransferMode): PSfmlFtpResponse;
begin
  Result := SfmlFtpUpload(FHandle, PAnsiChar(LocalFile), PAnsiChar(DestPath), Mode);
end;


{ TSfmlHttpRequest }

constructor TSfmlHttpRequest.Create;
begin
  FHandle := SfmlHttpRequestCreate;
end;

destructor TSfmlHttpRequest.Destroy;
begin
  SfmlHttpRequestDestroy(FHandle);
  inherited;
end;

procedure TSfmlHttpRequest.SetBody(Body: AnsiString);
begin
  SfmlHttpRequestSetBody(FHandle, PAnsiChar(Body));
end;

procedure TSfmlHttpRequest.SetField(Field: AnsiString; const Value: AnsiString);
begin
  SfmlHttpRequestSetField(FHandle, PAnsiChar(Field), PAnsiChar(Value));
end;

procedure TSfmlHttpRequest.SetHttpVersion(Major, Minor: Cardinal);
begin
  SfmlHttpRequestSetHttpVersion(FHandle, Major, Minor);
end;

procedure TSfmlHttpRequest.SetMethod(Method: TSfmlHttpMethod);
begin
  SfmlHttpRequestSetMethod(FHandle, Method);
end;

procedure TSfmlHttpRequest.SetUri(Uri: AnsiString);
begin
  SfmlHttpRequestSetUri(FHandle, PAnsiChar(Uri));
end;


{ TSfmlHttpResponse }

destructor TSfmlHttpResponse.Destroy;
begin
  SfmlHttpResponseDestroy(FHandle);
  inherited;
end;

function TSfmlHttpResponse.GetBody: AnsiString;
begin
  SfmlHttpResponseGetBody(FHandle);
end;

function TSfmlHttpResponse.GetField(const Field: AnsiString): AnsiString;
begin
  SfmlHttpResponseGetField(FHandle, PAnsiChar(Field));
end;

function TSfmlHttpResponse.GetMajorVersion: Cardinal;
begin
  Result := SfmlHttpResponseGetMajorVersion(FHandle);
end;

function TSfmlHttpResponse.GetMinorVersion: Cardinal;
begin
  Result := SfmlHttpResponseGetMinorVersion(FHandle);
end;

function TSfmlHttpResponse.GetStatus: TSfmlHttpStatus;
begin
  Result := SfmlHttpResponseGetStatus(FHandle);
end;


{ TSfmlHttp }

constructor TSfmlHttp.Create;
begin
  FHandle := SfmlHttpCreate;
end;

destructor TSfmlHttp.Destroy;
begin
  SfmlHttpDestroy(FHandle);
  inherited;
end;

function TSfmlHttp.SendRequest(const Request: PSfmlHttpRequest;
  Timeout: TSfmlTime): PSfmlHttpResponse;
begin
  Result := SfmlHttpSendRequest(FHandle, Request, TimeOut);
end;

procedure TSfmlHttp.SetHost(const Host: AnsiString; Port: Byte);
begin
  SfmlHttpSetHost(FHandle, PAnsiChar(Host), Port);
end;


{ TSfmlPacket }

constructor TSfmlPacket.Create;
begin
  FHandle := SfmlPacketCreate;
end;

destructor TSfmlPacket.Destroy;
begin
  SfmlPacketDestroy(FHandle);
  inherited;
end;

procedure TSfmlPacket.Append(Data: Pointer; SizeInBytes: NativeUInt);
begin
  SfmlPacketAppend(FHandle, Data, SizeInBytes);
end;

function TSfmlPacket.CanRead: Boolean;
begin
  Result := SfmlPacketCanRead(FHandle);
end;

procedure TSfmlPacket.Clear;
begin
  SfmlPacketClear(FHandle);
end;

function TSfmlPacket.Copy: TSfmlPacket;
begin
  Result := SfmlPacketCopy(FHandle);
end;

function TSfmlPacket.EndOfPacket: Boolean;
begin
  Result := SfmlPacketEndOfPacket(FHandle);
end;

function TSfmlPacket.GetData: Pointer;
begin
  Result := SfmlPacketGetData(FHandle);
end;

function TSfmlPacket.GetDataSize: NativeUInt;
begin
  Result := SfmlPacketGetDataSize(FHandle);
end;

function TSfmlPacket.ReadBool: Boolean;
begin
  Result := SfmlPacketReadBool(FHandle);
end;

function TSfmlPacket.ReadDouble: Double;
begin
  Result := SfmlPacketReadDouble(FHandle);
end;

function TSfmlPacket.ReadFloat: Single;
begin
  Result := SfmlPacketReadFloat(FHandle);
end;

function TSfmlPacket.ReadInt16: SmallInt;
begin
  Result := SfmlPacketReadInt16(FHandle);
end;

function TSfmlPacket.ReadInt32: LongInt;
begin
  Result := SfmlPacketReadInt32(FHandle);
end;

function TSfmlPacket.ReadInt8: ShortInt;
begin
  Result := SfmlPacketReadInt8(FHandle);
end;

procedure TSfmlPacket.ReadString(&String: AnsiString);
begin
  SfmlPacketReadString(FHandle, PAnsiChar(&String));
end;

function TSfmlPacket.ReadUint16: Word;
begin
  Result := SfmlPacketReadUint16(FHandle);
end;

function TSfmlPacket.ReadUint32: Cardinal;
begin
  Result := SfmlPacketReadUint32(FHandle);
end;

function TSfmlPacket.ReadUint8: Byte;
begin
  Result := SfmlPacketReadUint8(FHandle);
end;

procedure TSfmlPacket.ReadWideString(&String: string);
begin
  SfmlPacketReadWideString(FHandle, PWideChar(&String));
end;

procedure TSfmlPacket.WriteBool(Value: Boolean);
begin
  SfmlPacketWriteBool(FHandle, Value);
end;

procedure TSfmlPacket.WriteDouble(Value: Double);
begin
  SfmlPacketWriteDouble(FHandle, Value);
end;

procedure TSfmlPacket.WriteFloat(Value: Single);
begin
  SfmlPacketWriteFloat(FHandle, Value);
end;

procedure TSfmlPacket.WriteInt16(Value: SmallInt);
begin
  SfmlPacketWriteInt16(FHandle, Value);
end;

procedure TSfmlPacket.WriteInt32(Value: Integer);
begin
  SfmlPacketWriteInt32(FHandle, Value);
end;

procedure TSfmlPacket.WriteInt8(Value: ShortInt);
begin
  SfmlPacketWriteInt8(FHandle, Value);
end;

procedure TSfmlPacket.WriteString(&String: AnsiString);
begin
  SfmlPacketWriteString(FHandle, PAnsiChar(&String));
end;

procedure TSfmlPacket.WriteUint16(Value: Word);
begin
  SfmlPacketWriteUint16(FHandle, Value);
end;

procedure TSfmlPacket.WriteUint32(Value: Cardinal);
begin
  SfmlPacketWriteUint32(FHandle, Value);
end;

procedure TSfmlPacket.WriteUint8(Value: Byte);
begin
  SfmlPacketWriteUint8(FHandle, Value);
end;

procedure TSfmlPacket.WriteWideString(&String: PWideChar);
begin
  SfmlPacketWriteWideString(FHandle, PWideChar(&String));
end;


{ TSfmlSocketSelector }

constructor TSfmlSocketSelector.Create;
begin
  FHandle := SfmlSocketSelectorCreate;
end;

destructor TSfmlSocketSelector.Destroy;
begin
  SfmlSocketSelectorDestroy(FHandle);
  inherited;
end;

procedure TSfmlSocketSelector.AddTcpListener(Socket: PSfmlTcpListener);
begin
  SfmlSocketSelectorAddTcpListener(FHandle, Socket);
end;

procedure TSfmlSocketSelector.Clear;
begin
  SfmlSocketSelectorClear(FHandle);
end;

function TSfmlSocketSelector.Copy: TSfmlSocketSelector;
begin
  Result := SfmlSocketSelectorCopy(FHandle);
end;

function TSfmlSocketSelector.IsTcpListenerReady(
  Socket: PSfmlTcpListener): Boolean;
begin
  Result := SfmlSocketSelectorIsTcpListenerReady(FHandle, Socket);
end;

function TSfmlSocketSelector.IsTcpSocketReady(Socket: PSfmlTcpSocket): Boolean;
begin
  Result := SfmlSocketSelectorIsTcpSocketReady(FHandle, Socket);
end;

function TSfmlSocketSelector.IsUdpSocketReady(Socket: PSfmlUdpSocket): Boolean;
begin
  Result := SfmlSocketSelectorIsUdpSocketReady(FHandle, Socket);
end;

procedure TSfmlSocketSelector.RemoveTcpListener(Socket: PSfmlTcpListener);
begin
  SfmlSocketSelectorRemoveTcpListener(FHandle, Socket);
end;

function TSfmlSocketSelector.Wait(Timeout: TSfmlTime): Boolean;
begin
  Result := SfmlSocketSelectorWait(FHandle, Timeout);
end;


{ TSfmlTcpListener }

constructor TSfmlTcpListener.Create;
begin
  FHandle := SfmlTcpListenerCreate;
end;

destructor TSfmlTcpListener.Destroy;
begin
  SfmlTcpListenerDestroy(FHandle);
  inherited;
end;

function TSfmlTcpListener.Accept(
  out Connected: PSfmlTcpSocket): TSfmlSocketStatus;
begin
  Result := SfmlTcpListenerAccept(FHandle, Connected);
end;

function TSfmlTcpListener.GetLocalPort: Byte;
begin
  Result := SfmlTcpListenerGetLocalPort(FHandle);
end;

function TSfmlTcpListener.IsBlocking: Boolean;
begin
  Result := SfmlTcpListenerIsBlocking(FHandle);
end;

function TSfmlTcpListener.Listen(Port: Byte): TSfmlSocketStatus;
begin
  Result := SfmlTcpListenerListen(FHandle, Port);
end;

procedure TSfmlTcpListener.SetBlocking(Blocking: Boolean);
begin
  SfmlTcpListenerSetBlocking(FHandle, Blocking);
end;


{ TSfmlTcpSocket }

constructor TSfmlTcpSocket.Create;
begin
  FHandle := SfmlTcpSocketCreate;
end;

destructor TSfmlTcpSocket.Destroy;
begin
  SfmlTcpSocketDestroy(FHandle);
  inherited;
end;

function TSfmlTcpSocket.Connect(Host: TSfmlIpAddress; Port: Byte;
  TimeOut: TSfmlTime): TSfmlSocketStatus;
begin
  Result := SfmlTcpSocketConnect(FHandle, Host, Port, TimeOut);
end;

procedure TSfmlTcpSocket.Disconnect;
begin
  SfmlTcpSocketDisconnect(FHandle);
end;

function TSfmlTcpSocket.GetLocalPort: Byte;
begin
  Result := SfmlTcpSocketGetLocalPort(FHandle);
end;

function TSfmlTcpSocket.GetRemoteAddress: TSfmlIpAddress;
begin
  SfmlTcpSocketGetRemoteAddress(FHandle);
end;

function TSfmlTcpSocket.GetRemotePort: Byte;
begin
  Result := SfmlTcpSocketGetRemotePort(FHandle);
end;

function TSfmlTcpSocket.IsBlocking: Boolean;
begin
  Result := SfmlTcpSocketIsBlocking(FHandle);
end;

function TSfmlTcpSocket.Receive(Data: Pointer; MaxSize: NativeUInt;
  SizeReceived: PNativeUInt): TSfmlSocketStatus;
begin
  Result := SfmlTcpSocketReceive(FHandle, Data, MaxSize, SizeReceived);
end;

function TSfmlTcpSocket.ReceivePacket(Packet: PSfmlPacket): TSfmlSocketStatus;
begin
  Result := SfmlTcpSocketReceivePacket(FHandle, Packet);
end;

function TSfmlTcpSocket.Send(Data: Pointer;
  Size: NativeUInt): TSfmlSocketStatus;
begin
  Result := SfmlTcpSocketSend(FHandle, Data, Size);
end;

function TSfmlTcpSocket.SendPacket(Packet: PSfmlPacket): TSfmlSocketStatus;
begin
  Result := SfmlTcpSocketSendPacket(FHandle, Packet);
end;

procedure TSfmlTcpSocket.SetBlocking(Blocking: Boolean);
begin
  SfmlTcpSocketSetBlocking(FHandle, Blocking);
end;


{ TSfmlUdpSocket }

constructor TSfmlUdpSocket.Create;
begin
  FHandle := SfmlUdpSocketCreate;
end;

destructor TSfmlUdpSocket.Destroy;
begin
  SfmlUdpSocketDestroy(FHandle);
  inherited;
end;

function TSfmlUdpSocket.Bind(Port: Byte): TSfmlSocketStatus;
begin
  Result := SfmlUdpSocketBind(FHandle, Port);
end;

function TSfmlUdpSocket.GetLocalPort: Byte;
begin
  Result := SfmlUdpSocketGetLocalPort(FHandle);
end;

function TSfmlUdpSocket.IsBlocking: Boolean;
begin
  Result := SfmlUdpSocketIsBlocking(FHandle);
end;

function TSfmlUdpSocket.Receive(Data: Pointer; MaxSize: NativeUInt;
  SizeReceived: PNativeUInt; out Address: TSfmlIpAddress;
  out Port: Byte): TSfmlSocketStatus;
begin
  Result := SfmlUdpSocketReceive(FHandle, Data, MaxSize, SizeReceived, Address, Port);
end;

function TSfmlUdpSocket.ReceivePacket(Packet: PSfmlPacket;
  out Address: TSfmlIpAddress; out Port: Byte): TSfmlSocketStatus;
begin
  Result := SfmlUdpSocketReceivePacket(FHandle, Packet, Address, Port);
end;

function TSfmlUdpSocket.Send(Data: Pointer; Size: NativeUInt;
  Address: TSfmlIpAddress; Port: Byte): TSfmlSocketStatus;
begin
  Result := SfmlUdpSocketSend(FHandle, Data, Size, Address, Port);
end;

function TSfmlUdpSocket.SendPacket(Packet: PSfmlPacket; Address: TSfmlIpAddress;
  Port: Byte): TSfmlSocketStatus;
begin
  Result := SfmlUdpSocketSendPacket(FHandle, Packet, Address, Port);
end;

procedure TSfmlUdpSocket.SetBlocking(Blocking: Boolean);
begin
  SfmlUdpSocketSetBlocking(FHandle, Blocking);
end;

procedure TSfmlUdpSocket.Unbind;
begin
  SfmlUdpSocketUnbind(FHandle);
end;

{$IFDEF DynLink}

var
  CSfmlNetworkHandle: HINST;

procedure InitDLL;

  function BindFunction(Name: AnsiString): Pointer;
  begin
    Result := GetProcAddress(CSfmlNetworkHandle, PAnsiChar(Name));
    Assert(Assigned(Result));
  end;

begin
  CSfmlNetworkHandle := LoadLibraryA(CSfmlNetworkLibrary);
  if CSfmlNetworkHandle <> 0 then
    try
      SfmlFtpListingResponseDestroy := BindFunction('sfFtpListingResponse_destroy');
      SfmlFtpListingResponseIsOk := BindFunction('sfFtpListingResponse_isOk');
      SfmlFtpListingResponseGetStatus := BindFunction('sfFtpListingResponse_getStatus');
      SfmlFtpListingResponseGetMessage := BindFunction('sfFtpListingResponse_getMessage');
      SfmlFtpListingResponseGetCount := BindFunction('sfFtpListingResponse_getCount');
      SfmlFtpListingResponseGetName := BindFunction('sfFtpListingResponse_getName');
      SfmlFtpDirectoryResponseDestroy := BindFunction('sfFtpDirectoryResponse_destroy');
      SfmlFtpDirectoryResponseIsOk := BindFunction('sfFtpDirectoryResponse_isOk');
      SfmlFtpDirectoryResponseGetStatus := BindFunction('sfFtpDirectoryResponse_getStatus');
      SfmlFtpDirectoryResponseGetMessage := BindFunction('sfFtpDirectoryResponse_getMessage');
      SfmlFtpDirectoryResponseGetDirectory := BindFunction('sfFtpDirectoryResponse_getDirectory');
      SfmlFtpResponseDestroy := BindFunction('sfFtpResponse_destroy');
      SfmlFtpResponseIsOk := BindFunction('sfFtpResponse_isOk');
      SfmlFtpResponseGetStatus := BindFunction('sfFtpResponse_getStatus');
      SfmlFtpResponseGetMessage := BindFunction('sfFtpResponse_getMessage');
      SfmlFtpCreate := BindFunction('sfFtp_create');
      SfmlFtpDestroy := BindFunction('sfFtp_destroy');
      SfmlFtpConnect := BindFunction('sfFtp_connect');
      SfmlFtpLoginAnonymous := BindFunction('sfFtp_loginAnonymous');
      SfmlFtpLogin := BindFunction('sfFtp_login');
      SfmlFtpDisconnect := BindFunction('sfFtp_disconnect');
      SfmlFtpKeepAlive := BindFunction('sfFtp_keepAlive');
      SfmlFtpGetWorkingDirectory := BindFunction('sfFtp_getWorkingDirectory');
      SfmlFtpGetDirectoryListing := BindFunction('sfFtp_getDirectoryListing');
      SfmlFtpChangeDirectory := BindFunction('sfFtp_changeDirectory');
      SfmlFtpParentDirectory := BindFunction('sfFtp_parentDirectory');
      SfmlFtpCreateDirectory := BindFunction('sfFtp_createDirectory');
      SfmlFtpDeleteDirectory := BindFunction('sfFtp_deleteDirectory');
      SfmlFtpRenameFile := BindFunction('sfFtp_renameFile');
      SfmlFtpDeleteFile := BindFunction('sfFtp_deleteFile');
      SfmlFtpDownload := BindFunction('sfFtp_download');
      SfmlFtpUpload := BindFunction('sfFtp_upload');
      SfmlHttpRequestCreate := BindFunction('sfHttpRequest_create');
      SfmlHttpRequestDestroy := BindFunction('sfHttpRequest_destroy');
      SfmlHttpRequestSetField := BindFunction('sfHttpRequest_setField');
      SfmlHttpRequestSetMethod := BindFunction('sfHttpRequest_setMethod');
      SfmlHttpRequestSetUri := BindFunction('sfHttpRequest_setUri');
      SfmlHttpRequestSetHttpVersion := BindFunction('sfHttpRequest_setHttpVersion');
      SfmlHttpRequestSetBody := BindFunction('sfHttpRequest_setBody');
      SfmlHttpResponseDestroy := BindFunction('sfHttpResponse_destroy');
      SfmlHttpResponseGetField := BindFunction('sfHttpResponse_getField');
      SfmlHttpResponseGetStatus := BindFunction('sfHttpResponse_getStatus');
      SfmlHttpResponseGetMajorVersion := BindFunction('sfHttpResponse_getMajorVersion');
      SfmlHttpResponseGetMinorVersion := BindFunction('sfHttpResponse_getMinorVersion');
      SfmlHttpResponseGetBody := BindFunction('sfHttpResponse_getBody');
      SfmlHttpCreate := BindFunction('sfHttp_create');
      SfmlHttpDestroy := BindFunction('sfHttp_destroy');
      SfmlHttpSetHost := BindFunction('sfHttp_setHost');
      SfmlHttpSendRequest := BindFunction('sfHttp_sendRequest');
      SfmlIpAddressFromString := BindFunction('sfIpAddress_fromString');
      SfmlIpAddressFromBytes := BindFunction('sfIpAddress_fromBytes');
      SfmlIpAddressFromInteger := BindFunction('sfIpAddress_fromInteger');
      SfmlIpAddressToString := BindFunction('sfIpAddress_toString');
      SfmlIpAddressToInteger := BindFunction('sfIpAddress_toInteger');
      SfmlIpAddressGetLocalAddress := BindFunction('sfIpAddress_getLocalAddress');
      SfmlIpAddressGetPublicAddress := BindFunction('sfIpAddress_getPublicAddress');
      SfmlPacketCreate := BindFunction('sfPacket_create');
      SfmlPacketCopy := BindFunction('sfPacket_copy');
      SfmlPacketDestroy := BindFunction('sfPacket_destroy');
      SfmlPacketAppend := BindFunction('sfPacket_append');
      SfmlPacketClear := BindFunction('sfPacket_clear');
      SfmlPacketGetData := BindFunction('sfPacket_getData');
      SfmlPacketGetDataSize := BindFunction('sfPacket_getDataSize');
      SfmlPacketEndOfPacket := BindFunction('sfPacket_endOfPacket');
      SfmlPacketCanRead := BindFunction('sfPacket_canRead');
      SfmlPacketReadBool := BindFunction('sfPacket_readBool');
      SfmlPacketReadInt8 := BindFunction('sfPacket_readInt8');
      SfmlPacketReadUint8 := BindFunction('sfPacket_readUint8');
      SfmlPacketReadInt16 := BindFunction('sfPacket_readInt16');
      SfmlPacketReadUint16 := BindFunction('sfPacket_readUint16');
      SfmlPacketReadInt32 := BindFunction('sfPacket_readInt32');
      SfmlPacketReadUint32 := BindFunction('sfPacket_readUint32');
      SfmlPacketReadFloat := BindFunction('sfPacket_readFloat');
      SfmlPacketReadDouble := BindFunction('sfPacket_readDouble');
      SfmlPacketReadString := BindFunction('sfPacket_readString');
      SfmlPacketReadWideString := BindFunction('sfPacket_readWideString');
      SfmlPacketWriteBool := BindFunction('sfPacket_writeBool');
      SfmlPacketWriteInt8 := BindFunction('sfPacket_writeInt8');
      SfmlPacketWriteUint8 := BindFunction('sfPacket_writeUint8');
      SfmlPacketWriteInt16 := BindFunction('sfPacket_writeInt16');
      SfmlPacketWriteUint16 := BindFunction('sfPacket_writeUint16');
      SfmlPacketWriteInt32 := BindFunction('sfPacket_writeInt32');
      SfmlPacketWriteUint32 := BindFunction('sfPacket_writeUint32');
      SfmlPacketWriteFloat := BindFunction('sfPacket_writeFloat');
      SfmlPacketWriteDouble := BindFunction('sfPacket_writeDouble');
      SfmlPacketWriteString := BindFunction('sfPacket_writeString');
      SfmlPacketWriteWideString := BindFunction('sfPacket_writeWideString');
      SfmlSocketSelectorCreate := BindFunction('sfSocketSelector_create');
      SfmlSocketSelectorCopy := BindFunction('sfSocketSelector_copy');
      SfmlSocketSelectorDestroy := BindFunction('sfSocketSelector_destroy');
      SfmlSocketSelectorAddTcpListener := BindFunction('sfSocketSelector_addTcpListener');
      SfmlSocketSelectorRemoveTcpListener := BindFunction('sfSocketSelector_removeTcpListener');
      SfmlSocketSelectorClear := BindFunction('sfSocketSelector_clear');
      SfmlSocketSelectorWait := BindFunction('sfSocketSelector_wait');
      SfmlSocketSelectorIsTcpListenerReady := BindFunction('sfSocketSelector_isTcpListenerReady');
      SfmlSocketSelectorIsTcpSocketReady := BindFunction('sfSocketSelector_isTcpSocketReady');
      SfmlSocketSelectorIsUdpSocketReady := BindFunction('sfSocketSelector_isUdpSocketReady');
      SfmlTcpListenerCreate := BindFunction('sfTcpListener_create');
      SfmlTcpListenerDestroy := BindFunction('sfTcpListener_destroy');
      SfmlTcpListenerSetBlocking := BindFunction('sfTcpListener_setBlocking');
      SfmlTcpListenerIsBlocking := BindFunction('sfTcpListener_isBlocking');
      SfmlTcpListenerGetLocalPort := BindFunction('sfTcpListener_getLocalPort');
      SfmlTcpListenerListen := BindFunction('sfTcpListener_listen');
      SfmlTcpListenerAccept := BindFunction('sfTcpListener_accept');
      SfmlTcpSocketCreate := BindFunction('sfTcpSocket_create');
      SfmlTcpSocketDestroy := BindFunction('sfTcpSocket_destroy');
      SfmlTcpSocketSetBlocking := BindFunction('sfTcpSocket_setBlocking');
      SfmlTcpSocketIsBlocking := BindFunction('sfTcpSocket_isBlocking');
      SfmlTcpSocketGetLocalPort := BindFunction('sfTcpSocket_getLocalPort');
      SfmlTcpSocketGetRemoteAddress := BindFunction('sfTcpSocket_getRemoteAddress');
      SfmlTcpSocketGetRemotePort := BindFunction('sfTcpSocket_getRemotePort');
      SfmlTcpSocketConnect := BindFunction('sfTcpSocket_connect');
      SfmlTcpSocketDisconnect := BindFunction('sfTcpSocket_disconnect');
      SfmlTcpSocketSend := BindFunction('sfTcpSocket_send');
      SfmlTcpSocketReceive := BindFunction('sfTcpSocket_receive');
      SfmlTcpSocketSendPacket := BindFunction('sfTcpSocket_sendPacket');
      SfmlTcpSocketReceivePacket := BindFunction('sfTcpSocket_receivePacket');
      SfmlUdpSocketCreate := BindFunction('sfUdpSocket_create');
      SfmlUdpSocketDestroy := BindFunction('sfUdpSocket_destroy');
      SfmlUdpSocketSetBlocking := BindFunction('sfUdpSocket_setBlocking');
      SfmlUdpSocketIsBlocking := BindFunction('sfUdpSocket_isBlocking');
      SfmlUdpSocketGetLocalPort := BindFunction('sfUdpSocket_getLocalPort');
      SfmlUdpSocketBind := BindFunction('sfUdpSocket_bind');
      SfmlUdpSocketUnbind := BindFunction('sfUdpSocket_unbind');
      SfmlUdpSocketSend := BindFunction('sfUdpSocket_send');
      SfmlUdpSocketReceive := BindFunction('sfUdpSocket_receive');
      SfmlUdpSocketSendPacket := BindFunction('sfUdpSocket_sendPacket');
      SfmlUdpSocketReceivePacket := BindFunction('sfUdpSocket_receivePacket');
      SfmlUdpSocketMaxDatagramSize := BindFunction('sfUdpSocket_maxDatagramSize');
    except
      FreeLibrary(CSfmlNetworkHandle);
      CSfmlNetworkHandle := 0;
    end;
end;

procedure FreeDLL;
begin
  if CSfmlNetworkHandle <> 0 then
    FreeLibrary(CSfmlNetworkHandle);
end;

initialization

InitDLL;

finalization

FreeDLL;

{$ENDIF}
end.
