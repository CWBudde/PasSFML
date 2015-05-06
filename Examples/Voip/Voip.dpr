program Pong;

uses
  Server in 'Server.pas',
  Client in 'Client.pas',
  SfmlAudio in '..\..\Source\SfmlAudio.pas',
  SfmlNetwork in '..\..\Source\SfmlNetwork.pas',
  SfmlSystem in '..\..\Source\SfmlSystem.pas';

const
  Port = 2435;
var
  Who: AnsiChar;
begin
  // Client or server ?
  WriteLn('Do you want to be a server (''s'') or a client (''c'')?');
  ReadLn(Who);

  if Who = 's' then
  begin
    // Run as a server
    DoServer(Port);
  end
  else
  begin
    // Run as a client
    DoClient(Port);
  end;

  // Wait until the user presses 'enter' key
  WriteLn('Press enter to exit...');
  ReadLn;
end.
