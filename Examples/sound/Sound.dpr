program Sound;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  SfmlAudio in '..\..\Source\SfmlAudio.pas',
  SfmlGraphics in '..\..\Source\SfmlGraphics.pas',
  SfmlNetwork in '..\..\Source\SfmlNetwork.pas',
  SfmlSystem in '..\..\Source\SfmlSystem.pas',
  SfmlWindow in '..\..\Source\SfmlWindow.pas';

procedure PlaySound;
var
  Buffer: TSfmlSoundBuffer;
  Sound: TSfmlSound;
begin
  // Load a sound buffer from a wav file
  Buffer := TSfmlSoundBuffer.Create('../Resources/Canary.wav');

  // Display sound informations
  Writeln('Canary.wav:');
  Writeln(' ', Buffer.Duration.AsSeconds, ' seconds');
  Writeln(' ', Buffer.SampleRate, ' samples / sec');
  Writeln(' ', Buffer.ChannelCount, ' channels');

  // Create a sound instance and play it
  Sound := TSfmlSound(buffer);
  Sound.Play;

  // Loop while the sound is playing
  while Sound.Status = sfPlaying do
  begin
    // Leave some CPU time for other processes
    SfmlSleep(SfmlMilliseconds(100));

    // Display the playing position
    WriteLn('Playing... ', Sound.PlayingOffset.AsSeconds, ' sec');
  end;
  WriteLn;
end;

procedure PlayMusic;
var
  Music: TSfmlMusic;
begin
  // Load an ogg music file
  Music := TSfmlMusic.Create('../Resources/Orchestral.ogg');

  // Display music informations
  Writeln('Orchestral.ogg:');
  Writeln(' ', Music.Duration.asSeconds, ' seconds');
  Writeln(' ', Music.SampleRate, ' samples / sec');
  Writeln(' ', Music.ChannelCount, ' channels');

  // Play it
  Music.Play;

  // Loop while the music is playing
  while Music.Status = sfPlaying do
  begin
    // Leave some CPU time for other processes
    SfmlSleep(SfmlMilliseconds(100));

    // Display the playing position
    WriteLn('Playing... ', Music.PlayingOffset.AsSeconds, ' sec');
  end;
  Writeln;
end;

begin
  // Play a sound
  PlaySound;

  // Play a music
  PlayMusic;

  // Wait until the user presses 'enter' key
  WriteLn('Press enter to exit...');
  Readln;;
end.
