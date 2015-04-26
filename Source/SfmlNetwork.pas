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
  {$IFDEF MSWindows}Windows, {$ENDIF} SfmlSystem;

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
  TSfmlTcpSocketReceive = function (Socket: PSfmlTcpSocket; Data: Pointer; maxSize: NativeUInt; SizeReceived: PNativeUInt): TSfmlSocketStatus; cdecl;
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
  TSfmlUdpSocketReceive = function (Socket: PSfmlUdpSocket; Data: Pointer; maxSize: NativeUInt; SizeReceived: PNativeUInt; out Address: TSfmlIpAddress; out port: Byte): TSfmlSocketStatus; cdecl;
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


implementation

var
  CSfmlNetworkHandle: HINST;
{$IF Defined(MSWINDOWS)}
  CSfmlNetworkLibrary: PAnsiChar = 'csfml-network-2.dll';
{$ELSEIF Defined(DARWIN)}
  error, not yet defined
{$ELSEIF Defined(UNIX)}
  error, not yet defined
{$IFEND}

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

end.
