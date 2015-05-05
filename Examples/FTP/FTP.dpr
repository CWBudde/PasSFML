program FTP;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  SfmlSystem in '..\..\Source\SfmlSystem.pas',
  SfmlNetwork in '..\..\Source\SfmlNetwork.pas';

var
  Address: TSfmlIpAddress;
  Server: TSfmlFtp;
  Response: TSfmlFtpResponse;
  DirectoryResponse: TSfmlFtpDirectoryResponse;
  ListingResponse: TSfmlFtpListingResponse;
  User, Password, FileName, Directory, Source, Destination: AnsiString;
  Index, Choice: Integer;
begin
  // Choose the server address
  repeat
    WriteLn('Enter the FTP server address: ');
    ReadLn(Address.Address);
  until (Address.Address <> SfmlIpAddressNone.Address);

  Server := TSfmlFtp.Create;

  // Connect to the server
  Response := Server.Connect(Address);
  if not Response.isOk then
    Exit;
  WriteLn(Response.&Message);
  WriteLn('');

  // Ask for user name and password
  WriteLn('User name: ');
  ReadLn(User);
  WriteLn('Password: ');
  ReadLn(Password);

  // Login to the server
  Response := Server.Login(User, Password);
  if not Response.isOk then
    Exit;
  WriteLn(Response.&Message);
  WriteLn('');

  // Main menu
  repeat
    // Main FTP menu
    WriteLn('Choose an action:');
    WriteLn('1. Print working directory');
    WriteLn('2. Print contents of working directory');
    WriteLn('3. Change directory');
    WriteLn('4. Create directory');
    WriteLn('5. Delete directory');
    WriteLn('6. Rename file');
    WriteLn('7. Remove file');
    WriteLn('8. Download file');
    WriteLn('9. Upload file');
    WriteLn('0. Disconnect');
    WriteLn('');
    WriteLn('Your choice: ');
    ReadLn(Choice);
    WriteLn('');

    case Choice of
      0:;
      1:
        begin
          // Print the current server directory
          DirectoryResponse := Server.GetWorkingDirectory;
          WriteLn(DirectoryResponse.&Message);
          WriteLn('Current directory is ', DirectoryResponse.getDirectory);
        end;

      2:
        begin
          // Print the contents of the current server directory
          ListingResponse := Server.GetDirectoryListing('');
          for Index := 0 to ListingResponse.GetCount - 1 do
          begin
            WriteLn(ListingResponse.GetName(Index));
          end;
(*
          const std::vector<std::string>& names = response.getListing();
          for (std::vector<std::string>::const_iterator it = names.begin(); it != names.end(); ++it)
              std::cout << *it << std::endl;
*)
        end;

      3:
        begin
          // Change the current directory
          WriteLn('Choose a directory: ');
          ReadLn(Directory);
          Response := Server.ChangeDirectory(Directory);
          WriteLn(Response.&Message);
        end;

      4:
        begin
          // Create a new directory
          WriteLn('Name of the directory to create: ');
          ReadLn(Directory);
          Response := Server.CreateDirectory(directory);
          WriteLn(Response.&Message);
        end;

      5:
        begin
          // Remove an existing directory
          WriteLn('Name of the directory to remove: ');
          ReadLn(Directory);
          Response := Server.DeleteDirectory(Directory);
          WriteLn(Response.&Message);
        end;

      6:
        begin
          // Rename a file
          WriteLn('Name of the file to rename: ');
          ReadLn(Source);
          WriteLn('New name: ');
          ReadLn(Destination);
          Response := server.renameFile(source, destination);
          WriteLn(Response.&Message);
        end;

      7:
        begin
          // Remove an existing directory
          WriteLn('Name of the file to remove: ');
          ReadLn(Filename);
          Response := Server.DeleteFile(Filename);
          WriteLn(Response.&Message);
        end;

      8:
        begin
          // Download a file from server
          WriteLn('Filename of the file to download (relative to current directory): ');
          ReadLn(Filename);
          WriteLn('Directory to download the file to: ');
          ReadLn(Directory);
          Response := Server.Download(Filename, Directory, sfFtpBinary);
          WriteLn(Response.&Message);
        end;

      9:
        begin
          // Upload a file to server
          WriteLn('Path of the file to upload (absolute or relative to working directory): ');
          ReadLn(Filename);
          WriteLn('Directory to upload the file to (relative to current directory): ');
          ReadLn(Directory);
          Response := Server.Upload(Filename, Directory);
          WriteLn(Response.&Message);
        end;
      else
        begin
          // Wrong choice
          WriteLn('Invalid choice!');
        end;
    end;
  until Choice = 0;

  // Disconnect from the server
  WriteLn('Disconnecting from server...');
  Response := Server.Disconnect;
  WriteLn(Response.&Message);

  // Wait until the user presses 'enter' key
  WriteLn('Press enter to exit...');
  ReadLn;
end.
