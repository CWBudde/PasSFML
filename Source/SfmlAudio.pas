unit SfmlAudio;

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

{$I SFML.inc}

uses
  Windows, SfmlSystem;

type
  PSfmlMusic = Pointer;
  PSfmlSound = Pointer;
  PSfmlSoundBuffer = Pointer;
  PSfmlSoundBufferRecorder = Pointer;
  PSfmlSoundRecorder = Pointer;
  PSfmlSoundStream = Pointer;

  PsfInt16 = ^sfInt16;

  TSfmlSoundStatus = (sfStopped, sfPaused, sfPlaying);

  TSfmlSoundStreamChunk = record
    Samples: PsfInt16;
    SampleCount: Cardinal;
  end;
  PSfmlSoundStreamChunk  = ^TSfmlSoundStreamChunk;

  TSfmlSoundStreamGetDataCallback = function (Para1: PSfmlSoundStreamChunk; Para2: Pointer): sfBool; cdecl;
  TSfmlSoundStreamSeekCallback = procedure (Para1: TSfmlTime; Para2: Pointer); cdecl;

  TSfmlSoundRecorderStartCallback = function (Para1: Pointer): sfBool; cdecl;
  TSfmlSoundRecorderProcessCallback = function (Para1: PsfInt16; Para2: NativeUInt; Para3: Pointer): sfBool; cdecl;
  TSfmlSoundRecorderStopCallback = procedure (Para1: Pointer); cdecl;

  TSfmlListenerSetGlobalVolume = procedure (Volume: Single); cdecl;
  TSfmlListenerGetGlobalVolume = function : Single; cdecl;
  TSfmlListenerSetPosition = procedure (Position: TSfmlVector3f); cdecl;
  TSfmlListenerGetPosition = function : TSfmlVector3f; cdecl;
  TSfmlListenerSetDirection = procedure (Direction: TSfmlVector3f); cdecl;
  TSfmlListenerGetDirection = function : TSfmlVector3f; cdecl;
  TSfmlListenerSetUpVector = procedure (UpVector: TSfmlVector3f); cdecl;
  TSfmlListenerGetUpVector = function : TSfmlVector3f; cdecl;

  TSfmlMusicCreateFromFile = function (const FileName: PAnsiChar): PSfmlMusic; cdecl;
  TSfmlMusicCreateFromMemory = function (const data: Pointer; SizeInBytes: NativeUInt): PSfmlMusic; cdecl;
  TSfmlMusicCreateFromStream = function (Stream: PSfmlInputStream): PSfmlMusic; cdecl;
  TSfmlMusicDestroy = procedure (Music: PSfmlMusic); cdecl;
  TSfmlMusicSetLoop = procedure (Music: PSfmlMusic; Loop: sfBool); cdecl;
  TSfmlMusicGetLoop = function (const Music: PSfmlMusic): sfBool; cdecl;
  TSfmlMusicGetDuration = function (const Music: PSfmlMusic): TSfmlTime; cdecl;
  TSfmlMusicPlay = procedure (Music: PSfmlMusic); cdecl;
  TSfmlMusicPause = procedure (Music: PSfmlMusic); cdecl;
  TSfmlMusicStop = procedure (Music: PSfmlMusic); cdecl;
  TSfmlMusicGetChannelCount = function (const Music: PSfmlMusic): Cardinal; cdecl;
  TSfmlMusicGetSampleRate = function (const Music: PSfmlMusic): Cardinal; cdecl;
  TSfmlMusicGetStatus = function (const Music: PSfmlMusic): TSfmlSoundStatus; cdecl;
  TSfmlMusicGetPlayingOffset = function (const Music: PSfmlMusic): TSfmlTime; cdecl;
  TSfmlMusicSetPitch = procedure (Music: PSfmlMusic; Pitch: Single); cdecl;
  TSfmlMusicSetVolume = procedure (Music: PSfmlMusic; Volume: Single); cdecl;
  TSfmlMusicSetPosition = procedure (Music: PSfmlMusic; Position: TSfmlVector3f); cdecl;
  TSfmlMusicSetRelativeToListener = procedure (Music: PSfmlMusic; Relative: sfBool); cdecl;
  TSfmlMusicSetMinDistance = procedure (Music: PSfmlMusic; Distance: Single); cdecl;
  TSfmlMusicSetAttenuation = procedure (Music: PSfmlMusic; Attenuation: Single); cdecl;
  TSfmlMusicSetPlayingOffset = procedure (Music: PSfmlMusic; TimeOffset: TSfmlTime); cdecl;
  TSfmlMusicGetPitch = function (const Music: PSfmlMusic): Single; cdecl;
  TSfmlMusicGetVolume = function (const Music: PSfmlMusic): Single; cdecl;
  TSfmlMusicGetPosition = function (const Music: PSfmlMusic): TSfmlVector3f; cdecl;
  TSfmlMusicIsRelativeToListener = function (const Music: PSfmlMusic): sfBool; cdecl;
  TSfmlMusicGetMinDistance = function (const Music: PSfmlMusic): Single; cdecl;
  TSfmlMusicGetAttenuation = function (const Music: PSfmlMusic): Single; cdecl;

  TSfmlSoundStreamCreate = function (OnGetData: TSfmlSoundStreamGetDataCallback; OnSeek: TSfmlSoundStreamSeekCallback; channelCount, sampleRate: Cardinal; userData: Pointer): PSfmlSoundStream; cdecl;
  TSfmlSoundStreamDestroy = procedure (SoundStream: PSfmlSoundStream); cdecl;
  TSfmlSoundStreamPlay = procedure (SoundStream: PSfmlSoundStream); cdecl;
  TSfmlSoundStreamPause = procedure (SoundStream: PSfmlSoundStream); cdecl;
  TSfmlSoundStreamStop = procedure (SoundStream: PSfmlSoundStream); cdecl;
  TSfmlSoundStreamGetStatus = function (const SoundStream: PSfmlSoundStream): TSfmlSoundStatus; cdecl;
  TSfmlSoundStreamGetChannelCount = function (const SoundStream: PSfmlSoundStream): Cardinal; cdecl;
  TSfmlSoundStreamGetSampleRate = function (const SoundStream: PSfmlSoundStream): Cardinal; cdecl;
  TSfmlSoundStreamSetPitch = procedure (SoundStream: PSfmlSoundStream; Pitch: Single); cdecl;
  TSfmlSoundStreamSetVolume = procedure (SoundStream: PSfmlSoundStream; Volume: Single); cdecl;
  TSfmlSoundStreamSetPosition = procedure (SoundStream: PSfmlSoundStream; Position: TSfmlVector3f); cdecl;
  TSfmlSoundStreamSetRelativeToListener = procedure (SoundStream: PSfmlSoundStream; Relative: sfBool); cdecl;
  TSfmlSoundStreamSetMinDistance = procedure (SoundStream: PSfmlSoundStream; Distance: Single); cdecl;
  TSfmlSoundStreamSetAttenuation = procedure (SoundStream: PSfmlSoundStream; Attenuation: Single); cdecl;
  TSfmlSoundStreamSetPlayingOffset = procedure (SoundStream: PSfmlSoundStream; TimeOffset: TSfmlTime); cdecl;
  TSfmlSoundStreamSetLoop = procedure (SoundStream: PSfmlSoundStream; Loop: sfBool); cdecl;
  TSfmlSoundStreamGetPitch = function (const SoundStream: PSfmlSoundStream): Single; cdecl;
  TSfmlSoundStreamGetVolume = function (const SoundStream: PSfmlSoundStream): Single; cdecl;
  TSfmlSoundStreamGetPosition = function (const SoundStream: PSfmlSoundStream): TSfmlVector3f; cdecl;
  TSfmlSoundStreamIsRelativeToListener = function (const SoundStream: PSfmlSoundStream): sfBool; cdecl;
  TSfmlSoundStreamGetMinDistance = function (const SoundStream: PSfmlSoundStream): Single; cdecl;
  TSfmlSoundStreamGetAttenuation = function (const SoundStream: PSfmlSoundStream): Single; cdecl;
  TSfmlSoundStreamGetLoop = function (const SoundStream: PSfmlSoundStream): sfBool; cdecl;
  TSfmlSoundStreamGetPlayingOffset = function (const SoundStream: PSfmlSoundStream): TSfmlTime; cdecl;

  TSfmlSoundCreate = function : PSfmlSound; cdecl;
  TSfmlSoundCopy = function (const Sound: PSfmlSound): PSfmlSound; cdecl;
  TSfmlSoundDestroy = procedure (Sound: PSfmlSound); cdecl;
  TSfmlSoundPlay = procedure (Sound: PSfmlSound); cdecl;
  TSfmlSoundPause = procedure (Sound: PSfmlSound); cdecl;
  TSfmlSoundStop = procedure (Sound: PSfmlSound); cdecl;
  TSfmlSoundSetBuffer = procedure (Sound: PSfmlSound; const Buffer: PSfmlSoundBuffer); cdecl;
  TSfmlSoundGetBuffer = function (const Sound: PSfmlSound): PSfmlSoundBuffer; cdecl;
  TSfmlSoundSetLoop = procedure (Sound: PSfmlSound; Loop: sfBool); cdecl;
  TSfmlSoundGetLoop = function (const Sound: PSfmlSound): sfBool; cdecl;
  TSfmlSoundGetStatus = function (const Sound: PSfmlSound): TSfmlSoundStatus; cdecl;
  TSfmlSoundSetPitch = procedure (Sound: PSfmlSound; Pitch: Single); cdecl;
  TSfmlSoundSetVolume = procedure (Sound: PSfmlSound; Volume: Single); cdecl;
  TSfmlSoundSetPosition = procedure (Sound: PSfmlSound; Position: TSfmlVector3f); cdecl;
  TSfmlSoundSetRelativeToListener = procedure (Sound: PSfmlSound; Relative: sfBool); cdecl;
  TSfmlSoundSetMinDistance = procedure (Sound: PSfmlSound; Distance: Single); cdecl;
  TSfmlSoundSetAttenuation = procedure (Sound: PSfmlSound; Attenuation: Single); cdecl;
  TSfmlSoundSetPlayingOffset = procedure (Sound: PSfmlSound; TimeOffset: TSfmlTime); cdecl;
  TSfmlSoundGetPitch = function (const Sound: PSfmlSound): Single; cdecl;
  TSfmlSoundGetVolume = function (const Sound: PSfmlSound): Single; cdecl;
  TSfmlSoundGetPosition = function (const Sound: PSfmlSound): TSfmlVector3f; cdecl;
  TSfmlSoundIsRelativeToListener = function (const Sound: PSfmlSound): sfBool; cdecl;
  TSfmlSoundGetMinDistance = function (const Sound: PSfmlSound): Single; cdecl;
  TSfmlSoundGetAttenuation = function (const Sound: PSfmlSound): Single; cdecl;
  TSfmlSoundGetPlayingOffset = function (const Sound: PSfmlSound): TSfmlTime; cdecl;

  TSfmlSoundBufferCreateFromFile = function (const FileName: PAnsiChar): PSfmlSoundBuffer; cdecl;
  TSfmlSoundBufferCreateFromMemory = function (const Data: Pointer; SizeInBytes: NativeUInt): PSfmlSoundBuffer; cdecl;
  TSfmlSoundBufferCreateFromStream = function (Stream: PSfmlInputStream): PSfmlSoundBuffer; cdecl;
  TSfmlSoundBufferCreateFromSamples = function (const Samples: PSfInt16; SampleCount: NativeUInt; ChannelCount, SampleRate: Cardinal): PSfmlSoundBuffer; cdecl;
  TSfmlSoundBufferCopy = function (const SoundBuffer: PSfmlSoundBuffer): PSfmlSoundBuffer; cdecl;
  TSfmlSoundBufferDestroy = procedure (SoundBuffer: PSfmlSoundBuffer); cdecl;
  TSfmlSoundBufferSaveToFile = function (const SoundBuffer: PSfmlSoundBuffer; const FileName: PAnsiChar): sfBool; cdecl;
  TSfmlSoundBufferGetSamples = function (const SoundBuffer: PSfmlSoundBuffer): PsfInt16; cdecl;
  TSfmlSoundBufferGetSampleCount = function (const SoundBuffer: PSfmlSoundBuffer): NativeUInt; cdecl;
  TSfmlSoundBufferGetSampleRate = function (const SoundBuffer: PSfmlSoundBuffer): Cardinal; cdecl;
  TSfmlSoundBufferGetChannelCount = function (const SoundBuffer: PSfmlSoundBuffer): Cardinal; cdecl;
  TSfmlSoundBufferGetDuration = function (const SoundBuffer: PSfmlSoundBuffer): TSfmlTime; cdecl;

  TSfmlSoundBufferRecorderCreate = function : PSfmlSoundBufferRecorder; cdecl;
  TSfmlSoundBufferRecorderDestroy = procedure (soundBufferRecorder: PSfmlSoundBufferRecorder); cdecl;
  TSfmlSoundBufferRecorderStart = procedure (soundBufferRecorder: PSfmlSoundBufferRecorder; SampleRate: Cardinal); cdecl;
  TSfmlSoundBufferRecorderStop = procedure (soundBufferRecorder: PSfmlSoundBufferRecorder); cdecl;
  TSfmlSoundBufferRecorderGetSampleRate = function (const soundBufferRecorder: PSfmlSoundBufferRecorder): Cardinal; cdecl;
  TSfmlSoundBufferRecorderGetBuffer = function (const soundBufferRecorder: PSfmlSoundBufferRecorder): PSfmlSoundBuffer; cdecl;

  TSfmlSoundRecorderCreate = function (OnStart: TSfmlSoundRecorderStartCallback; OnProcess: TSfmlSoundRecorderProcessCallback; OnStop: TSfmlSoundRecorderStopCallback; userData: Pointer): PSfmlSoundRecorder; cdecl;
  TSfmlSoundRecorderDestroy = procedure (SoundRecorder: PSfmlSoundRecorder); cdecl;
  TSfmlSoundRecorderStart = function (SoundRecorder: PSfmlSoundRecorder; SampleRate: Cardinal): sfBool; cdecl;
  TSfmlSoundRecorderStop = procedure (SoundRecorder: PSfmlSoundRecorder); cdecl;
  TSfmlSoundRecorderGetSampleRate = function (const SoundRecorder: PSfmlSoundRecorder): Cardinal; cdecl;
  TSfmlSoundRecorderIsAvailable = function : sfBool; cdecl;
  TSfmlSoundRecorderSetProcessingInterval = procedure (SoundRecorder: PSfmlSoundRecorder; Interval: TSfmlTime); cdecl;
  TSfmlSoundRecorderGetAvailableDevices = function (count: PNativeUInt): PPAnsiChar; cdecl;
  TSfmlSoundRecorderGetDefaultDevice = function : PAnsiChar; cdecl;
  TSfmlSoundRecorderSetDevice = function (SoundRecorder: PSfmlSoundRecorder; const Name: PAnsiChar): sfBool; cdecl;
  TSfmlSoundRecorderGetDevice = function (SoundRecorder: PSfmlSoundRecorder): PAnsiChar; cdecl;

var
  SfmlListenerSetGlobalVolume: TSfmlListenerSetGlobalVolume;
  SfmlListenerGetGlobalVolume: TSfmlListenerGetGlobalVolume;
  SfmlListenerSetPosition: TSfmlListenerSetPosition;
  SfmlListenerGetPosition: TSfmlListenerGetPosition;
  SfmlListenerSetDirection: TSfmlListenerSetDirection;
  SfmlListenerGetDirection: TSfmlListenerGetDirection;
  SfmlListenerSetUpVector: TSfmlListenerSetUpVector;
  SfmlListenerGetUpVector: TSfmlListenerGetUpVector;

  SfmlMusicCreateFromFile: TSfmlMusicCreateFromFile;
  SfmlMusicCreateFromMemory: TSfmlMusicCreateFromMemory;
  SfmlMusicCreateFromStream: TSfmlMusicCreateFromStream;
  SfmlMusicDestroy: TSfmlMusicDestroy;
  SfmlMusicSetLoop: TSfmlMusicSetLoop;
  SfmlMusicGetLoop: TSfmlMusicGetLoop;
  SfmlMusicGetDuration: TSfmlMusicGetDuration;
  SfmlMusicPlay: TSfmlMusicPlay;
  SfmlMusicPause: TSfmlMusicPause;
  SfmlMusicStop: TSfmlMusicStop;
  SfmlMusicGetChannelCount: TSfmlMusicGetChannelCount;
  SfmlMusicGetSampleRate: TSfmlMusicGetSampleRate;
  SfmlMusicGetStatus: TSfmlMusicGetStatus;
  SfmlMusicGetPlayingOffset: TSfmlMusicGetPlayingOffset;
  SfmlMusicSetPitch: TSfmlMusicSetPitch;
  SfmlMusicSetVolume: TSfmlMusicSetVolume;
  SfmlMusicSetPosition: TSfmlMusicSetPosition;
  SfmlMusicSetRelativeToListener: TSfmlMusicSetRelativeToListener;
  SfmlMusicSetMinDistance: TSfmlMusicSetMinDistance;
  SfmlMusicSetAttenuation: TSfmlMusicSetAttenuation;
  SfmlMusicSetPlayingOffset: TSfmlMusicSetPlayingOffset;
  SfmlMusicGetPitch: TSfmlMusicGetPitch;
  SfmlMusicGetVolume: TSfmlMusicGetVolume;
  SfmlMusicGetPosition: TSfmlMusicGetPosition;
  SfmlMusicIsRelativeToListener: TSfmlMusicIsRelativeToListener;
  SfmlMusicGetMinDistance: TSfmlMusicGetMinDistance;
  SfmlMusicGetAttenuation: TSfmlMusicGetAttenuation;

  SfmlSoundStreamCreate: TSfmlSoundStreamCreate;
  SfmlSoundStreamDestroy: TSfmlSoundStreamDestroy;
  SfmlSoundStreamPlay: TSfmlSoundStreamPlay;
  SfmlSoundStreamPause: TSfmlSoundStreamPause;
  SfmlSoundStreamStop: TSfmlSoundStreamStop;
  SfmlSoundStreamGetStatus: TSfmlSoundStreamGetStatus;
  SfmlSoundStreamGetChannelCount: TSfmlSoundStreamGetChannelCount;
  SfmlSoundStreamGetSampleRate: TSfmlSoundStreamGetSampleRate;
  SfmlSoundStreamSetPitch: TSfmlSoundStreamSetPitch;
  SfmlSoundStreamSetVolume: TSfmlSoundStreamSetVolume;
  SfmlSoundStreamSetPosition: TSfmlSoundStreamSetPosition;
  SfmlSoundStreamSetRelativeToListener: TSfmlSoundStreamSetRelativeToListener;
  SfmlSoundStreamSetMinDistance: TSfmlSoundStreamSetMinDistance;
  SfmlSoundStreamSetAttenuation: TSfmlSoundStreamSetAttenuation;
  SfmlSoundStreamSetPlayingOffset: TSfmlSoundStreamSetPlayingOffset;
  SfmlSoundStreamSetLoop: TSfmlSoundStreamSetLoop;
  SfmlSoundStreamGetPitch: TSfmlSoundStreamGetPitch;
  SfmlSoundStreamGetVolume: TSfmlSoundStreamGetVolume;
  SfmlSoundStreamGetPosition: TSfmlSoundStreamGetPosition;
  SfmlSoundStreamIsRelativeToListener: TSfmlSoundStreamIsRelativeToListener;
  SfmlSoundStreamGetMinDistance: TSfmlSoundStreamGetMinDistance;
  SfmlSoundStreamGetAttenuation: TSfmlSoundStreamGetAttenuation;
  SfmlSoundStreamGetLoop: TSfmlSoundStreamGetLoop;
  SfmlSoundStreamGetPlayingOffset: TSfmlSoundStreamGetPlayingOffset;

  SfmlSoundCreate: TSfmlSoundCreate;
  SfmlSoundCopy: TSfmlSoundCopy;
  SfmlSoundDestroy: TSfmlSoundDestroy;
  SfmlSoundPlay: TSfmlSoundPlay;
  SfmlSoundPause: TSfmlSoundPause;
  SfmlSoundStop: TSfmlSoundStop;
  SfmlSoundSetBuffer: TSfmlSoundSetBuffer;
  SfmlSoundGetBuffer: TSfmlSoundGetBuffer;
  SfmlSoundSetLoop: TSfmlSoundSetLoop;
  SfmlSoundGetLoop: TSfmlSoundGetLoop;
  SfmlSoundGetStatus: TSfmlSoundGetStatus;
  SfmlSoundSetPitch: TSfmlSoundSetPitch;
  SfmlSoundSetVolume: TSfmlSoundSetVolume;
  SfmlSoundSetPosition: TSfmlSoundSetPosition;
  SfmlSoundSetRelativeToListener: TSfmlSoundSetRelativeToListener;
  SfmlSoundSetMinDistance: TSfmlSoundSetMinDistance;
  SfmlSoundSetAttenuation: TSfmlSoundSetAttenuation;
  SfmlSoundSetPlayingOffset: TSfmlSoundSetPlayingOffset;
  SfmlSoundGetPitch: TSfmlSoundGetPitch;
  SfmlSoundGetVolume: TSfmlSoundGetVolume;
  SfmlSoundGetPosition: TSfmlSoundGetPosition;
  SfmlSoundIsRelativeToListener: TSfmlSoundIsRelativeToListener;
  SfmlSoundGetMinDistance: TSfmlSoundGetMinDistance;
  SfmlSoundGetAttenuation: TSfmlSoundGetAttenuation;
  SfmlSoundGetPlayingOffset: TSfmlSoundGetPlayingOffset;

  SfmlSoundBufferCreateFromFile: TSfmlSoundBufferCreateFromFile;
  SfmlSoundBufferCreateFromMemory: TSfmlSoundBufferCreateFromMemory;
  SfmlSoundBufferCreateFromStream: TSfmlSoundBufferCreateFromStream;
  SfmlSoundBufferCreateFromSamples: TSfmlSoundBufferCreateFromSamples;
  SfmlSoundBufferCopy: TSfmlSoundBufferCopy;
  SfmlSoundBufferDestroy: TSfmlSoundBufferDestroy;
  SfmlSoundBufferSaveToFile: TSfmlSoundBufferSaveToFile;
  SfmlSoundBufferGetSamples: TSfmlSoundBufferGetSamples;
  SfmlSoundBufferGetSampleCount: TSfmlSoundBufferGetSampleCount;
  SfmlSoundBufferGetSampleRate: TSfmlSoundBufferGetSampleRate;
  SfmlSoundBufferGetChannelCount: TSfmlSoundBufferGetChannelCount;
  SfmlSoundBufferGetDuration: TSfmlSoundBufferGetDuration;

  SfmlSoundBufferRecorderCreate: TSfmlSoundBufferRecorderCreate;
  SfmlSoundBufferRecorderDestroy: TSfmlSoundBufferRecorderDestroy;
  SfmlSoundBufferRecorderStart: TSfmlSoundBufferRecorderStart;
  SfmlSoundBufferRecorderStop: TSfmlSoundBufferRecorderStop;
  SfmlSoundBufferRecorderGetSampleRate: TSfmlSoundBufferRecorderGetSampleRate;
  SfmlSoundBufferRecorderGetBuffer: TSfmlSoundBufferRecorderGetBuffer;

  SfmlSoundRecorderCreate: TSfmlSoundRecorderCreate;
  SfmlSoundRecorderDestroy: TSfmlSoundRecorderDestroy;
  SfmlSoundRecorderStart: TSfmlSoundRecorderStart;
  SfmlSoundRecorderStop: TSfmlSoundRecorderStop;
  SfmlSoundRecorderGetSampleRate: TSfmlSoundRecorderGetSampleRate;
  SfmlSoundRecorderIsAvailable: TSfmlSoundRecorderIsAvailable;
  SfmlSoundRecorderSetProcessingInterval: TSfmlSoundRecorderSetProcessingInterval;
  SfmlSoundRecorderGetAvailableDevices: TSfmlSoundRecorderGetAvailableDevices;
  SfmlSoundRecorderGetDefaultDevice: TSfmlSoundRecorderGetDefaultDevice;
  SfmlSoundRecorderSetDevice: TSfmlSoundRecorderSetDevice;
  SfmlSoundRecorderGetDevice: TSfmlSoundRecorderGetDevice;

implementation

var
  CSfmlAudioHandle: HINST;
{$IF Defined(MSWINDOWS)}
  CSfmlAudioLibrary: PAnsiChar = 'csfml-audio-2.dll';
{$ELSEIF Defined(DARWIN)}
  error, not yet defined
{$ELSEIF Defined(UNIX)}
  error, not yet defined
{$IFEND}

procedure InitDLL;
begin
  CSfmlAudioHandle := LoadLibraryA(CSfmlAudioLibrary);
  if CSfmlAudioHandle <> 0 then
    try
      SfmlListenerSetGlobalVolume := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfListener_setGlobalVolume'));
      Assert(Assigned(SfmlListenerSetGlobalVolume));

      SfmlListenerGetGlobalVolume := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfListener_getGlobalVolume'));
      Assert(Assigned(SfmlListenerGetGlobalVolume));

      SfmlListenerSetPosition := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfListener_setPosition'));
      Assert(Assigned(SfmlListenerSetPosition));

      SfmlListenerGetPosition := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfListener_getPosition'));
      Assert(Assigned(SfmlListenerGetPosition));

      SfmlListenerSetDirection := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfListener_setDirection'));
      Assert(Assigned(SfmlListenerSetDirection));

      SfmlListenerGetDirection := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfListener_getDirection'));
      Assert(Assigned(SfmlListenerGetDirection));

      SfmlListenerSetUpVector := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfListener_setUpVector'));
      Assert(Assigned(SfmlListenerSetUpVector));

      SfmlListenerGetUpVector := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfListener_getUpVector'));
      Assert(Assigned(SfmlListenerGetUpVector));

      SfmlMusicCreateFromFile := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfMusic_createFromFile'));
      Assert(Assigned(SfmlMusicCreateFromFile));

      SfmlMusicCreateFromMemory := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfMusic_createFromMemory'));
      Assert(Assigned(SfmlMusicCreateFromMemory));

      SfmlMusicCreateFromStream := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfMusic_createFromStream'));
      Assert(Assigned(SfmlMusicCreateFromStream));

      SfmlMusicDestroy := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfMusic_destroy'));
      Assert(Assigned(SfmlMusicDestroy));

      SfmlMusicSetLoop := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfMusic_setLoop'));
      Assert(Assigned(SfmlMusicSetLoop));

      SfmlMusicGetLoop := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfMusic_getLoop'));
      Assert(Assigned(SfmlMusicGetLoop));

      SfmlMusicGetDuration := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfMusic_getDuration'));
      Assert(Assigned(SfmlMusicGetDuration));

      SfmlMusicPlay := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfMusic_play'));
      Assert(Assigned(SfmlMusicPlay));

      SfmlMusicPause := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfMusic_pause'));
      Assert(Assigned(SfmlMusicPause));

      SfmlMusicStop := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfMusic_stop'));
      Assert(Assigned(SfmlMusicStop));

      SfmlMusicGetChannelCount := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfMusic_getChannelCount'));
      Assert(Assigned(SfmlMusicGetChannelCount));

      SfmlMusicGetSampleRate := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfMusic_getSampleRate'));
      Assert(Assigned(SfmlMusicGetSampleRate));

      SfmlMusicGetStatus := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfMusic_getStatus'));
      Assert(Assigned(SfmlMusicGetStatus));

      SfmlMusicGetPlayingOffset := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfMusic_getPlayingOffset'));
      Assert(Assigned(SfmlMusicGetPlayingOffset));

      SfmlMusicSetPitch := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfMusic_setPitch'));
      Assert(Assigned(SfmlMusicSetPitch));

      SfmlMusicSetVolume := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfMusic_setVolume'));
      Assert(Assigned(SfmlMusicSetVolume));

      SfmlMusicSetPosition := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfMusic_setPosition'));
      Assert(Assigned(SfmlMusicSetPosition));

      SfmlMusicSetRelativeToListener := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfMusic_setRelativeToListener'));
      Assert(Assigned(SfmlMusicSetRelativeToListener));

      SfmlMusicSetMinDistance := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfMusic_setMinDistance'));
      Assert(Assigned(SfmlMusicSetMinDistance));

      SfmlMusicSetAttenuation := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfMusic_setAttenuation'));
      Assert(Assigned(SfmlMusicSetAttenuation));

      SfmlMusicSetPlayingOffset := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfMusic_setPlayingOffset'));
      Assert(Assigned(SfmlMusicSetPlayingOffset));

      SfmlMusicGetPitch := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfMusic_getPitch'));
      Assert(Assigned(SfmlMusicGetPitch));

      SfmlMusicGetVolume := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfMusic_getVolume'));
      Assert(Assigned(SfmlMusicGetVolume));

      SfmlMusicGetPosition := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfMusic_getPosition'));
      Assert(Assigned(SfmlMusicGetPosition));

      SfmlMusicIsRelativeToListener := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfMusic_isRelativeToListener'));
      Assert(Assigned(SfmlMusicIsRelativeToListener));

      SfmlMusicGetMinDistance := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfMusic_getMinDistance'));
      Assert(Assigned(SfmlMusicGetMinDistance));

      SfmlMusicGetAttenuation := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfMusic_getAttenuation'));
      Assert(Assigned(SfmlMusicGetAttenuation));

      SfmlSoundStreamCreate := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSoundStream_create'));
      Assert(Assigned(SfmlSoundStreamCreate));

      SfmlSoundStreamDestroy := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSoundStream_destroy'));
      Assert(Assigned(SfmlSoundStreamDestroy));

      SfmlSoundStreamPlay := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSoundStream_play'));
      Assert(Assigned(SfmlSoundStreamPlay));

      SfmlSoundStreamPause := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSoundStream_pause'));
      Assert(Assigned(SfmlSoundStreamPause));

      SfmlSoundStreamStop := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSoundStream_stop'));
      Assert(Assigned(SfmlSoundStreamStop));

      SfmlSoundStreamGetStatus := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSoundStream_getStatus'));
      Assert(Assigned(SfmlSoundStreamGetStatus));

      SfmlSoundStreamGetChannelCount := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSoundStream_getChannelCount'));
      Assert(Assigned(SfmlSoundStreamGetChannelCount));

      SfmlSoundStreamGetSampleRate := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSoundStream_getSampleRate'));
      Assert(Assigned(SfmlSoundStreamGetSampleRate));

      SfmlSoundStreamSetPitch := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSoundStream_setPitch'));
      Assert(Assigned(SfmlSoundStreamSetPitch));

      SfmlSoundStreamSetVolume := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSoundStream_setVolume'));
      Assert(Assigned(SfmlSoundStreamSetVolume));

      SfmlSoundStreamSetPosition := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSoundStream_setPosition'));
      Assert(Assigned(SfmlSoundStreamSetPosition));

      SfmlSoundStreamSetRelativeToListener := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSoundStream_setRelativeToListener'));
      Assert(Assigned(SfmlSoundStreamSetRelativeToListener));

      SfmlSoundStreamSetMinDistance := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSoundStream_setMinDistance'));
      Assert(Assigned(SfmlSoundStreamSetMinDistance));

      SfmlSoundStreamSetAttenuation := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSoundStream_setAttenuation'));
      Assert(Assigned(SfmlSoundStreamSetAttenuation));

      SfmlSoundStreamSetPlayingOffset := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSoundStream_setPlayingOffset'));
      Assert(Assigned(SfmlSoundStreamSetPlayingOffset));

      SfmlSoundStreamSetLoop := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSoundStream_setLoop'));
      Assert(Assigned(SfmlSoundStreamSetLoop));

      SfmlSoundStreamGetPitch := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSoundStream_getPitch'));
      Assert(Assigned(SfmlSoundStreamGetPitch));

      SfmlSoundStreamGetVolume := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSoundStream_getVolume'));
      Assert(Assigned(SfmlSoundStreamGetVolume));

      SfmlSoundStreamGetPosition := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSoundStream_getPosition'));
      Assert(Assigned(SfmlSoundStreamGetPosition));

      SfmlSoundStreamIsRelativeToListener := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSoundStream_isRelativeToListener'));
      Assert(Assigned(SfmlSoundStreamIsRelativeToListener));

      SfmlSoundStreamGetMinDistance := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSoundStream_getMinDistance'));
      Assert(Assigned(SfmlSoundStreamGetMinDistance));

      SfmlSoundStreamGetAttenuation := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSoundStream_getAttenuation'));
      Assert(Assigned(SfmlSoundStreamGetAttenuation));

      SfmlSoundStreamGetLoop := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSoundStream_getLoop'));
      Assert(Assigned(SfmlSoundStreamGetLoop));

      SfmlSoundStreamGetPlayingOffset := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSoundStream_getPlayingOffset'));
      Assert(Assigned(SfmlSoundStreamGetPlayingOffset));

      SfmlSoundCreate := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSound_create'));
      Assert(Assigned(SfmlSoundCreate));

      SfmlSoundCopy := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSound_copy'));
      Assert(Assigned(SfmlSoundCopy));

      SfmlSoundDestroy := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSound_destroy'));
      Assert(Assigned(SfmlSoundDestroy));

      SfmlSoundPlay := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSound_play'));
      Assert(Assigned(SfmlSoundPlay));

      SfmlSoundPause := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSound_pause'));
      Assert(Assigned(SfmlSoundPause));

      SfmlSoundStop := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSound_stop'));
      Assert(Assigned(SfmlSoundStop));

      SfmlSoundSetBuffer := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSound_setBuffer'));
      Assert(Assigned(SfmlSoundSetBuffer));

      SfmlSoundGetBuffer := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSound_getBuffer'));
      Assert(Assigned(SfmlSoundGetBuffer));

      SfmlSoundSetLoop := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSound_setLoop'));
      Assert(Assigned(SfmlSoundSetLoop));

      SfmlSoundGetLoop := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSound_getLoop'));
      Assert(Assigned(SfmlSoundGetLoop));

      SfmlSoundGetStatus := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSound_getStatus'));
      Assert(Assigned(SfmlSoundGetStatus));

      SfmlSoundSetPitch := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSound_setPitch'));
      Assert(Assigned(SfmlSoundSetPitch));

      SfmlSoundSetVolume := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSound_setVolume'));
      Assert(Assigned(SfmlSoundSetVolume));

      SfmlSoundSetPosition := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSound_setPosition'));
      Assert(Assigned(SfmlSoundSetPosition));

      SfmlSoundSetRelativeToListener := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSound_setRelativeToListener'));
      Assert(Assigned(SfmlSoundSetRelativeToListener));

      SfmlSoundSetMinDistance := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSound_setMinDistance'));
      Assert(Assigned(SfmlSoundSetMinDistance));

      SfmlSoundSetAttenuation := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSound_setAttenuation'));
      Assert(Assigned(SfmlSoundSetAttenuation));

      SfmlSoundSetPlayingOffset := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSound_setPlayingOffset'));
      Assert(Assigned(SfmlSoundSetPlayingOffset));

      SfmlSoundGetPitch := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSound_getPitch'));
      Assert(Assigned(SfmlSoundGetPitch));

      SfmlSoundGetVolume := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSound_getVolume'));
      Assert(Assigned(SfmlSoundGetVolume));

      SfmlSoundGetPosition := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSound_getPosition'));
      Assert(Assigned(SfmlSoundGetPosition));

      SfmlSoundIsRelativeToListener := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSound_isRelativeToListener'));
      Assert(Assigned(SfmlSoundIsRelativeToListener));

      SfmlSoundGetMinDistance := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSound_isRelativeToListener'));
      Assert(Assigned(SfmlSoundGetMinDistance));

      SfmlSoundGetAttenuation := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSound_getAttenuation'));
      Assert(Assigned(SfmlSoundGetAttenuation));

      SfmlSoundGetPlayingOffset := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSound_getPlayingOffset'));
      Assert(Assigned(SfmlSoundGetPlayingOffset));

      SfmlSoundBufferCreateFromFile := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSoundBuffer_createFromFile'));
      Assert(Assigned(SfmlSoundBufferCreateFromFile));

      SfmlSoundBufferCreateFromMemory := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSoundBuffer_createFromMemory'));
      Assert(Assigned(SfmlSoundBufferCreateFromMemory));

      SfmlSoundBufferCreateFromStream := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSoundBuffer_createFromStream'));
      Assert(Assigned(SfmlSoundBufferCreateFromStream));

      SfmlSoundBufferCreateFromSamples := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSoundBuffer_createFromSamples'));
      Assert(Assigned(SfmlSoundBufferCreateFromSamples));

      SfmlSoundBufferCopy := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSoundBuffer_copy'));
      Assert(Assigned(SfmlSoundBufferCopy));

      SfmlSoundBufferDestroy := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSoundBuffer_destroy'));
      Assert(Assigned(SfmlSoundBufferDestroy));

      SfmlSoundBufferSaveToFile := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSoundBuffer_saveToFile'));
      Assert(Assigned(SfmlSoundBufferSaveToFile));

      SfmlSoundBufferGetSamples := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSoundBuffer_getSamples'));
      Assert(Assigned(SfmlSoundBufferGetSamples));

      SfmlSoundBufferGetSampleCount := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSoundBuffer_getSampleCount'));
      Assert(Assigned(SfmlSoundBufferGetSampleCount));

      SfmlSoundBufferGetSampleRate := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSoundBuffer_getSampleRate'));
      Assert(Assigned(SfmlSoundBufferGetSampleRate));

      SfmlSoundBufferGetChannelCount := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSoundBuffer_getChannelCount'));
      Assert(Assigned(SfmlSoundBufferGetChannelCount));

      SfmlSoundBufferGetDuration := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSoundBuffer_getDuration'));
      Assert(Assigned(SfmlSoundBufferGetDuration));

      SfmlSoundBufferRecorderCreate := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSoundBufferRecorder_create'));
      Assert(Assigned(SfmlSoundBufferRecorderCreate));

      SfmlSoundBufferRecorderDestroy := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSoundBufferRecorder_destroy'));
      Assert(Assigned(SfmlSoundBufferRecorderDestroy));

      SfmlSoundBufferRecorderStart := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSoundBufferRecorder_start'));
      Assert(Assigned(SfmlSoundBufferRecorderStart));

      SfmlSoundBufferRecorderStop := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSoundBufferRecorder_stop'));
      Assert(Assigned(SfmlSoundBufferRecorderStop));

      SfmlSoundBufferRecorderGetSampleRate := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSoundBufferRecorder_getSampleRate'));
      Assert(Assigned(SfmlSoundBufferRecorderGetSampleRate));

      SfmlSoundBufferRecorderGetBuffer := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSoundBufferRecorder_getBuffer'));
      Assert(Assigned(SfmlSoundBufferRecorderGetBuffer));

      SfmlSoundRecorderCreate := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSoundRecorder_create'));
      Assert(Assigned(SfmlSoundRecorderCreate));

      SfmlSoundRecorderDestroy := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSoundRecorder_destroy'));
      Assert(Assigned(SfmlSoundRecorderDestroy));

      SfmlSoundRecorderStart := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSoundRecorder_start'));
      Assert(Assigned(SfmlSoundRecorderStart));

      SfmlSoundRecorderStop := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSoundRecorder_stop'));
      Assert(Assigned(SfmlSoundRecorderStop));

      SfmlSoundRecorderGetSampleRate := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSoundRecorder_getSampleRate'));
      Assert(Assigned(SfmlSoundRecorderGetSampleRate));

      SfmlSoundRecorderIsAvailable := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSoundRecorder_isAvailable'));
      Assert(Assigned(SfmlSoundRecorderIsAvailable));

      SfmlSoundRecorderSetProcessingInterval := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSoundRecorder_setProcessingInterval'));
      Assert(Assigned(SfmlSoundRecorderSetProcessingInterval));

      SfmlSoundRecorderGetAvailableDevices := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSoundRecorder_getAvailableDevices'));
      Assert(Assigned(SfmlSoundRecorderGetAvailableDevices));

      SfmlSoundRecorderGetDefaultDevice := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSoundRecorder_getDefaultDevice'));
      Assert(Assigned(SfmlSoundRecorderGetDefaultDevice));

      SfmlSoundRecorderSetDevice := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSoundRecorder_setDevice'));
      Assert(Assigned(SfmlSoundRecorderSetDevice));

      SfmlSoundRecorderGetDevice := GetProcAddress(CSfmlAudioHandle, PAnsiChar('sfSoundRecorder_getDevice'));
      Assert(Assigned(SfmlSoundRecorderGetDevice));
    except
      FreeLibrary(CSfmlAudioHandle);
      CSfmlAudioHandle := 0;
    end;
end;

procedure FreeDLL;
begin
  if CSfmlAudioHandle <> 0 then
    FreeLibrary(CSfmlAudioHandle);
end;

initialization

InitDLL;

finalization

FreeDLL;

end.
