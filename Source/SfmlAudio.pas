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

{$I Sfml.inc}

uses
  {$IFDEF MSWindows}Windows, {$ENDIF} SfmlSystem;

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

  function BindFunction(Name: AnsiString): Pointer;
  begin
    Result := GetProcAddress(CSfmlAudioHandle, PAnsiChar(Name));
    Assert(Assigned(Result));
  end;

begin
  CSfmlAudioHandle := LoadLibraryA(CSfmlAudioLibrary);
  if CSfmlAudioHandle <> 0 then
    try
      SfmlListenerSetGlobalVolume := BindFunction('sfListener_setGlobalVolume');
      SfmlListenerGetGlobalVolume := BindFunction('sfListener_getGlobalVolume');
      SfmlListenerSetPosition := BindFunction('sfListener_setPosition');
      SfmlListenerGetPosition := BindFunction('sfListener_getPosition');
      SfmlListenerSetDirection := BindFunction('sfListener_setDirection');
      SfmlListenerGetDirection := BindFunction('sfListener_getDirection');
      SfmlListenerSetUpVector := BindFunction('sfListener_setUpVector');
      SfmlListenerGetUpVector := BindFunction('sfListener_getUpVector');
      SfmlMusicCreateFromFile := BindFunction('sfMusic_createFromFile');
      SfmlMusicCreateFromMemory := BindFunction('sfMusic_createFromMemory');
      SfmlMusicCreateFromStream := BindFunction('sfMusic_createFromStream');
      SfmlMusicDestroy := BindFunction('sfMusic_destroy');
      SfmlMusicSetLoop := BindFunction('sfMusic_setLoop');
      SfmlMusicGetLoop := BindFunction('sfMusic_getLoop');
      SfmlMusicGetDuration := BindFunction('sfMusic_getDuration');
      SfmlMusicPlay := BindFunction('sfMusic_play');
      SfmlMusicPause := BindFunction('sfMusic_pause');
      SfmlMusicStop := BindFunction('sfMusic_stop');
      SfmlMusicGetChannelCount := BindFunction('sfMusic_getChannelCount');
      SfmlMusicGetSampleRate := BindFunction('sfMusic_getSampleRate');
      SfmlMusicGetStatus := BindFunction('sfMusic_getStatus');
      SfmlMusicGetPlayingOffset := BindFunction('sfMusic_getPlayingOffset');
      SfmlMusicSetPitch := BindFunction('sfMusic_setPitch');
      SfmlMusicSetVolume := BindFunction('sfMusic_setVolume');
      SfmlMusicSetPosition := BindFunction('sfMusic_setPosition');
      SfmlMusicSetRelativeToListener := BindFunction('sfMusic_setRelativeToListener');
      SfmlMusicSetMinDistance := BindFunction('sfMusic_setMinDistance');
      SfmlMusicSetAttenuation := BindFunction('sfMusic_setAttenuation');
      SfmlMusicSetPlayingOffset := BindFunction('sfMusic_setPlayingOffset');
      SfmlMusicGetPitch := BindFunction('sfMusic_getPitch');
      SfmlMusicGetVolume := BindFunction('sfMusic_getVolume');
      SfmlMusicGetPosition := BindFunction('sfMusic_getPosition');
      SfmlMusicIsRelativeToListener := BindFunction('sfMusic_isRelativeToListener');
      SfmlMusicGetMinDistance := BindFunction('sfMusic_getMinDistance');
      SfmlMusicGetAttenuation := BindFunction('sfMusic_getAttenuation');
      SfmlSoundStreamCreate := BindFunction('sfSoundStream_create');
      SfmlSoundStreamDestroy := BindFunction('sfSoundStream_destroy');
      SfmlSoundStreamPlay := BindFunction('sfSoundStream_play');
      SfmlSoundStreamPause := BindFunction('sfSoundStream_pause');
      SfmlSoundStreamStop := BindFunction('sfSoundStream_stop');
      SfmlSoundStreamGetStatus := BindFunction('sfSoundStream_getStatus');
      SfmlSoundStreamGetChannelCount := BindFunction('sfSoundStream_getChannelCount');
      SfmlSoundStreamGetSampleRate := BindFunction('sfSoundStream_getSampleRate');
      SfmlSoundStreamSetPitch := BindFunction('sfSoundStream_setPitch');
      SfmlSoundStreamSetVolume := BindFunction('sfSoundStream_setVolume');
      SfmlSoundStreamSetPosition := BindFunction('sfSoundStream_setPosition');
      SfmlSoundStreamSetRelativeToListener := BindFunction('sfSoundStream_setRelativeToListener');
      SfmlSoundStreamSetMinDistance := BindFunction('sfSoundStream_setMinDistance');
      SfmlSoundStreamSetAttenuation := BindFunction('sfSoundStream_setAttenuation');
      SfmlSoundStreamSetPlayingOffset := BindFunction('sfSoundStream_setPlayingOffset');
      SfmlSoundStreamSetLoop := BindFunction('sfSoundStream_setLoop');
      SfmlSoundStreamGetPitch := BindFunction('sfSoundStream_getPitch');
      SfmlSoundStreamGetVolume := BindFunction('sfSoundStream_getVolume');
      SfmlSoundStreamGetPosition := BindFunction('sfSoundStream_getPosition');
      SfmlSoundStreamIsRelativeToListener := BindFunction('sfSoundStream_isRelativeToListener');
      SfmlSoundStreamGetMinDistance := BindFunction('sfSoundStream_getMinDistance');
      SfmlSoundStreamGetAttenuation := BindFunction('sfSoundStream_getAttenuation');
      SfmlSoundStreamGetLoop := BindFunction('sfSoundStream_getLoop');
      SfmlSoundStreamGetPlayingOffset := BindFunction('sfSoundStream_getPlayingOffset');
      SfmlSoundCreate := BindFunction('sfSound_create');
      SfmlSoundCopy := BindFunction('sfSound_copy');
      SfmlSoundDestroy := BindFunction('sfSound_destroy');
      SfmlSoundPlay := BindFunction('sfSound_play');
      SfmlSoundPause := BindFunction('sfSound_pause');
      SfmlSoundStop := BindFunction('sfSound_stop');
      SfmlSoundSetBuffer := BindFunction('sfSound_setBuffer');
      SfmlSoundGetBuffer := BindFunction('sfSound_getBuffer');
      SfmlSoundSetLoop := BindFunction('sfSound_setLoop');
      SfmlSoundGetLoop := BindFunction('sfSound_getLoop');
      SfmlSoundGetStatus := BindFunction('sfSound_getStatus');
      SfmlSoundSetPitch := BindFunction('sfSound_setPitch');
      SfmlSoundSetVolume := BindFunction('sfSound_setVolume');
      SfmlSoundSetPosition := BindFunction('sfSound_setPosition');
      SfmlSoundSetRelativeToListener := BindFunction('sfSound_setRelativeToListener');
      SfmlSoundSetMinDistance := BindFunction('sfSound_setMinDistance');
      SfmlSoundSetAttenuation := BindFunction('sfSound_setAttenuation');
      SfmlSoundSetPlayingOffset := BindFunction('sfSound_setPlayingOffset');
      SfmlSoundGetPitch := BindFunction('sfSound_getPitch');
      SfmlSoundGetVolume := BindFunction('sfSound_getVolume');
      SfmlSoundGetPosition := BindFunction('sfSound_getPosition');
      SfmlSoundIsRelativeToListener := BindFunction('sfSound_isRelativeToListener');
      SfmlSoundGetMinDistance := BindFunction('sfSound_isRelativeToListener');
      SfmlSoundGetAttenuation := BindFunction('sfSound_getAttenuation');
      SfmlSoundGetPlayingOffset := BindFunction('sfSound_getPlayingOffset');
      SfmlSoundBufferCreateFromFile := BindFunction('sfSoundBuffer_createFromFile');
      SfmlSoundBufferCreateFromMemory := BindFunction('sfSoundBuffer_createFromMemory');
      SfmlSoundBufferCreateFromStream := BindFunction('sfSoundBuffer_createFromStream');
      SfmlSoundBufferCreateFromSamples := BindFunction('sfSoundBuffer_createFromSamples');
      SfmlSoundBufferCopy := BindFunction('sfSoundBuffer_copy');
      SfmlSoundBufferDestroy := BindFunction('sfSoundBuffer_destroy');
      SfmlSoundBufferSaveToFile := BindFunction('sfSoundBuffer_saveToFile');
      SfmlSoundBufferGetSamples := BindFunction('sfSoundBuffer_getSamples');
      SfmlSoundBufferGetSampleCount := BindFunction('sfSoundBuffer_getSampleCount');
      SfmlSoundBufferGetSampleRate := BindFunction('sfSoundBuffer_getSampleRate');
      SfmlSoundBufferGetChannelCount := BindFunction('sfSoundBuffer_getChannelCount');
      SfmlSoundBufferGetDuration := BindFunction('sfSoundBuffer_getDuration');
      SfmlSoundBufferRecorderCreate := BindFunction('sfSoundBufferRecorder_create');
      SfmlSoundBufferRecorderDestroy := BindFunction('sfSoundBufferRecorder_destroy');
      SfmlSoundBufferRecorderStart := BindFunction('sfSoundBufferRecorder_start');
      SfmlSoundBufferRecorderStop := BindFunction('sfSoundBufferRecorder_stop');
      SfmlSoundBufferRecorderGetSampleRate := BindFunction('sfSoundBufferRecorder_getSampleRate');
      SfmlSoundBufferRecorderGetBuffer := BindFunction('sfSoundBufferRecorder_getBuffer');
      SfmlSoundRecorderCreate := BindFunction('sfSoundRecorder_create');
      SfmlSoundRecorderDestroy := BindFunction('sfSoundRecorder_destroy');
      SfmlSoundRecorderStart := BindFunction('sfSoundRecorder_start');
      SfmlSoundRecorderStop := BindFunction('sfSoundRecorder_stop');
      SfmlSoundRecorderGetSampleRate := BindFunction('sfSoundRecorder_getSampleRate');
      SfmlSoundRecorderIsAvailable := BindFunction('sfSoundRecorder_isAvailable');
      SfmlSoundRecorderSetProcessingInterval := BindFunction('sfSoundRecorder_setProcessingInterval');
      SfmlSoundRecorderGetAvailableDevices := BindFunction('sfSoundRecorder_getAvailableDevices');
      SfmlSoundRecorderGetDefaultDevice := BindFunction('sfSoundRecorder_getDefaultDevice');
      SfmlSoundRecorderSetDevice := BindFunction('sfSoundRecorder_setDevice');
      SfmlSoundRecorderGetDevice := BindFunction('sfSoundRecorder_getDevice');
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
