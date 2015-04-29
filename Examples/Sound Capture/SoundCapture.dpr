program SoundCapture;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  SfmlAudio in '..\..\Source\SfmlAudio.pas',
  SfmlGraphics in '..\..\Source\SfmlGraphics.pas',
  SfmlNetwork in '..\..\Source\SfmlNetwork.pas',
  SfmlSystem in '..\..\Source\SfmlSystem.pas',
  SfmlWindow in '..\..\Source\SfmlWindow.pas';

var
  SampleRate: Cardinal;
  Recorder: TSfmlSoundBufferRecorder;
  Buffer: PSfmlSoundBuffer;
  Choice: AnsiChar;
  FileName: AnsiString;
  Sound: TSfmlSound;
begin
  // Check that the device can capture audio
  if not SfmlSoundRecorderisAvailable then
  begin
    Writeln('Sorry, audio capture is not supported by your system');
    Halt;
  end;

  // Choose the sample rate
  Writeln('Please choose the sample rate for sound capture (44100 is CD quality): ');
  ReadLn(SampleRate);

  // Wait for user input...
  Writeln('Press enter to start recording audio');
  ReadLn;

  // Here we'll use an integrated custom recorder, which saves the captured data into a SoundBuffer
  Recorder := TSfmlSoundBufferRecorder.Create;

  // Audio capture is done in a separate thread, so we can block the main thread while it is capturing
  Recorder.Start(SampleRate);
  Writeln('Recording... press enter to stop');
  ReadLn;
  Recorder.Stop;

  // Get the buffer containing the captured data
  Buffer := Recorder.GetBuffer;

  // Display captured sound informations
  Writeln('Sound information:');
  Writeln(' ', SfmlTimeAsSeconds(SfmlSoundBufferGetDuration(Buffer)), ' seconds');
  Writeln(' ', SfmlSoundBufferGetSampleRate(Buffer), ' samples / seconds');
  Writeln(' ', SfmlSoundBufferGetChannelCount(Buffer), ' channels');

  // Choose what to do with the recorded sound data
  Writeln('What do you want to do with captured sound (p = play, s = save) ? ');
  Readln(Choice);

  if Choice = 's' then
  begin
    // Choose the filename
    Writeln('Choose the file to create: ');
    Readln(FileName);

    // Save the buffer
    SfmlSoundBufferSaveToFile(Buffer, PAnsiChar(Filename));
  end
  else
  begin
    // Create a sound instance and play it
    Sound := TSfmlSound.Create;
    Sound.SetBuffer(Buffer);
    Sound.Play;

    // Wait until finished
    while Sound.Status = sfPlaying do
    begin
      // Display the playing position
      Writeln('Playing... ', Sound.PlayingOffset.asSeconds, ' sec');

      // Leave some CPU time for other threads
      SfmlSleep(SfmlMilliseconds(100));
    end;
  end;

  // Finished!
  Writeln('Done!');

  // Wait until the user presses 'enter' key
  Writeln('Press enter to exit...');
  ReadLn;
end.
