unit SfmlAudio;

////////////////////////////////////////////////////////////////////////////////
//
// PasSFML - Simple and Fast Multimedia Library for Pascal
// Copyright (C) 2015-2017 Christian-W. Budde (Christian@pcjv.de)
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
////////////////////////////////////////////////////////////////////////////////

interface

{$I Sfml.inc}

uses
  SfmlSystem;

const
{$IF Defined(MSWINDOWS)}
  CSfmlAudioLibrary = 'csfml-audio-2.dll';
{$ELSEIF Defined(DARWIN) or Defined(MACOS)}
  CSfmlAudioLibrary = 'csfml-audio-2.dylib';
{$ELSEIF Defined(UNIX)}
  CSfmlAudioLibrary = 'csfml-audio.so';
{$IFEND}

type
  // opaque structures
  TSfmlMusicRecord = record end;
  TSfmlSoundRecord = record end;
  TSfmlSoundBufferRecord = record end;
  TSfmlSoundBufferRecorderRecord = record end;
  TSfmlSoundRecorderRecord = record end;
  TSfmlSoundStreamRecord = record end;

  // handles for opaque structures
  PSfmlMusic = ^TSfmlMusicRecord;
  PSfmlSound = ^TSfmlSoundRecord;
  PSfmlSoundBuffer = ^TSfmlSoundBufferRecord;
  PSfmlSoundBufferRecorder = ^TSfmlSoundBufferRecorderRecord;
  PSfmlSoundRecorder = ^TSfmlSoundRecorderRecord;
  PSfmlSoundStream = ^TSfmlSoundStreamRecord;

  TSfmlSoundStatus = (sfStopped, sfPaused, sfPlaying);

  TSfmlSoundStreamChunk = record
    Samples: PSmallInt;
    SampleCount: Cardinal;
  end;
  PSfmlSoundStreamChunk  = ^TSfmlSoundStreamChunk;

  TSfmlSoundStreamGetDataCallback = function (Chunk: PSfmlSoundStreamChunk; UserData: Pointer): LongBool; cdecl;
  TSfmlSoundStreamSeekCallback = procedure (Time: TSfmlTime; UserData: Pointer); cdecl;

  TSfmlSoundRecorderStartCallback = function (UserData: Pointer): LongBool; cdecl;
  TSfmlSoundRecorderProcessCallback = function (Data: PSmallInt; SampleFrames: NativeUInt; UserData: Pointer): LongBool; cdecl;
  TSfmlSoundRecorderStopCallback = procedure (UserData: Pointer); cdecl;

{$IFDEF DynLink}
  TSfmlListenerSetGlobalVolume = procedure (Volume: Single); cdecl;
  TSfmlListenerGetGlobalVolume = function : Single; cdecl;
  TSfmlListenerSetPosition = procedure (Position: TSfmlVector3f); cdecl;
  TSfmlListenerGetPosition = function : TSfmlVector3f; cdecl;
  TSfmlListenerSetDirection = procedure (Direction: TSfmlVector3f); cdecl;
  TSfmlListenerGetDirection = function : TSfmlVector3f; cdecl;
  TSfmlListenerSetUpVector = procedure (UpVector: TSfmlVector3f); cdecl;
  TSfmlListenerGetUpVector = function : TSfmlVector3f; cdecl;

  TSfmlMusicCreateFromFile = function (const FileName: PAnsiChar): PSfmlMusic; cdecl;
  TSfmlMusicCreateFromMemory = function (const Data: Pointer; SizeInBytes: NativeUInt): PSfmlMusic; cdecl;
  TSfmlMusicCreateFromStream = function (Stream: PSfmlInputStream): PSfmlMusic; cdecl;
  TSfmlMusicDestroy = procedure (Music: PSfmlMusic); cdecl;
  TSfmlMusicSetLoop = procedure (Music: PSfmlMusic; Loop: LongBool); cdecl;
  TSfmlMusicGetLoop = function (const Music: PSfmlMusic): LongBool; cdecl;
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
  TSfmlMusicSetRelativeToListener = procedure (Music: PSfmlMusic; Relative: LongBool); cdecl;
  TSfmlMusicSetMinDistance = procedure (Music: PSfmlMusic; Distance: Single); cdecl;
  TSfmlMusicSetAttenuation = procedure (Music: PSfmlMusic; Attenuation: Single); cdecl;
  TSfmlMusicSetPlayingOffset = procedure (Music: PSfmlMusic; TimeOffset: TSfmlTime); cdecl;
  TSfmlMusicGetPitch = function (const Music: PSfmlMusic): Single; cdecl;
  TSfmlMusicGetVolume = function (const Music: PSfmlMusic): Single; cdecl;
  TSfmlMusicGetPosition = function (const Music: PSfmlMusic): TSfmlVector3f; cdecl;
  TSfmlMusicIsRelativeToListener = function (const Music: PSfmlMusic): LongBool; cdecl;
  TSfmlMusicGetMinDistance = function (const Music: PSfmlMusic): Single; cdecl;
  TSfmlMusicGetAttenuation = function (const Music: PSfmlMusic): Single; cdecl;

  TSfmlSoundStreamCreate = function (OnGetData: TSfmlSoundStreamGetDataCallback; OnSeek: TSfmlSoundStreamSeekCallback; ChannelCount, SampleRate: Cardinal; UserData: Pointer): PSfmlSoundStream; cdecl;
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
  TSfmlSoundStreamSetRelativeToListener = procedure (SoundStream: PSfmlSoundStream; Relative: LongBool); cdecl;
  TSfmlSoundStreamSetMinDistance = procedure (SoundStream: PSfmlSoundStream; Distance: Single); cdecl;
  TSfmlSoundStreamSetAttenuation = procedure (SoundStream: PSfmlSoundStream; Attenuation: Single); cdecl;
  TSfmlSoundStreamSetPlayingOffset = procedure (SoundStream: PSfmlSoundStream; TimeOffset: TSfmlTime); cdecl;
  TSfmlSoundStreamSetLoop = procedure (SoundStream: PSfmlSoundStream; Loop: LongBool); cdecl;
  TSfmlSoundStreamGetPitch = function (const SoundStream: PSfmlSoundStream): Single; cdecl;
  TSfmlSoundStreamGetVolume = function (const SoundStream: PSfmlSoundStream): Single; cdecl;
  TSfmlSoundStreamGetPosition = function (const SoundStream: PSfmlSoundStream): TSfmlVector3f; cdecl;
  TSfmlSoundStreamIsRelativeToListener = function (const SoundStream: PSfmlSoundStream): LongBool; cdecl;
  TSfmlSoundStreamGetMinDistance = function (const SoundStream: PSfmlSoundStream): Single; cdecl;
  TSfmlSoundStreamGetAttenuation = function (const SoundStream: PSfmlSoundStream): Single; cdecl;
  TSfmlSoundStreamGetLoop = function (const SoundStream: PSfmlSoundStream): LongBool; cdecl;
  TSfmlSoundStreamGetPlayingOffset = function (const SoundStream: PSfmlSoundStream): TSfmlTime; cdecl;

  TSfmlSoundCreate = function : PSfmlSound; cdecl;
  TSfmlSoundCopy = function (const Sound: PSfmlSound): PSfmlSound; cdecl;
  TSfmlSoundDestroy = procedure (Sound: PSfmlSound); cdecl;
  TSfmlSoundPlay = procedure (Sound: PSfmlSound); cdecl;
  TSfmlSoundPause = procedure (Sound: PSfmlSound); cdecl;
  TSfmlSoundStop = procedure (Sound: PSfmlSound); cdecl;
  TSfmlSoundSetBuffer = procedure (Sound: PSfmlSound; const Buffer: PSfmlSoundBuffer); cdecl;
  TSfmlSoundGetBuffer = function (const Sound: PSfmlSound): PSfmlSoundBuffer; cdecl;
  TSfmlSoundSetLoop = procedure (Sound: PSfmlSound; Loop: LongBool); cdecl;
  TSfmlSoundGetLoop = function (const Sound: PSfmlSound): LongBool; cdecl;
  TSfmlSoundGetStatus = function (const Sound: PSfmlSound): TSfmlSoundStatus; cdecl;
  TSfmlSoundSetPitch = procedure (Sound: PSfmlSound; Pitch: Single); cdecl;
  TSfmlSoundSetVolume = procedure (Sound: PSfmlSound; Volume: Single); cdecl;
  TSfmlSoundSetPosition = procedure (Sound: PSfmlSound; Position: TSfmlVector3f); cdecl;
  TSfmlSoundSetRelativeToListener = procedure (Sound: PSfmlSound; Relative: LongBool); cdecl;
  TSfmlSoundSetMinDistance = procedure (Sound: PSfmlSound; Distance: Single); cdecl;
  TSfmlSoundSetAttenuation = procedure (Sound: PSfmlSound; Attenuation: Single); cdecl;
  TSfmlSoundSetPlayingOffset = procedure (Sound: PSfmlSound; TimeOffset: TSfmlTime); cdecl;
  TSfmlSoundGetPitch = function (const Sound: PSfmlSound): Single; cdecl;
  TSfmlSoundGetVolume = function (const Sound: PSfmlSound): Single; cdecl;
  TSfmlSoundGetPosition = function (const Sound: PSfmlSound): TSfmlVector3f; cdecl;
  TSfmlSoundIsRelativeToListener = function (const Sound: PSfmlSound): LongBool; cdecl;
  TSfmlSoundGetMinDistance = function (const Sound: PSfmlSound): Single; cdecl;
  TSfmlSoundGetAttenuation = function (const Sound: PSfmlSound): Single; cdecl;
  TSfmlSoundGetPlayingOffset = function (const Sound: PSfmlSound): TSfmlTime; cdecl;

  TSfmlSoundBufferCreateFromFile = function (const FileName: PAnsiChar): PSfmlSoundBuffer; cdecl;
  TSfmlSoundBufferCreateFromMemory = function (const Data: Pointer; SizeInBytes: NativeUInt): PSfmlSoundBuffer; cdecl;
  TSfmlSoundBufferCreateFromStream = function (Stream: PSfmlInputStream): PSfmlSoundBuffer; cdecl;
  TSfmlSoundBufferCreateFromSamples = function (const Samples: PSmallInt; SampleCount: UInt64; ChannelCount, SampleRate: Cardinal): PSfmlSoundBuffer; cdecl;
  TSfmlSoundBufferCopy = function (const SoundBuffer: PSfmlSoundBuffer): PSfmlSoundBuffer; cdecl;
  TSfmlSoundBufferDestroy = procedure (SoundBuffer: PSfmlSoundBuffer); cdecl;
  TSfmlSoundBufferSaveToFile = function (const SoundBuffer: PSfmlSoundBuffer; const FileName: PAnsiChar): LongBool; cdecl;
  TSfmlSoundBufferGetSamples = function (const SoundBuffer: PSfmlSoundBuffer): PSmallInt; cdecl;
  TSfmlSoundBufferGetSampleCount = function (const SoundBuffer: PSfmlSoundBuffer): NativeUInt; cdecl;
  TSfmlSoundBufferGetSampleRate = function (const SoundBuffer: PSfmlSoundBuffer): Cardinal; cdecl;
  TSfmlSoundBufferGetChannelCount = function (const SoundBuffer: PSfmlSoundBuffer): Cardinal; cdecl;
  TSfmlSoundBufferGetDuration = function (const SoundBuffer: PSfmlSoundBuffer): TSfmlTime; cdecl;

  TSfmlSoundBufferRecorderCreate = function : PSfmlSoundBufferRecorder; cdecl;
  TSfmlSoundBufferRecorderDestroy = procedure (soundBufferRecorder: PSfmlSoundBufferRecorder); cdecl;
  TSfmlSoundBufferRecorderStart = function (soundBufferRecorder: PSfmlSoundBufferRecorder; SampleRate: Cardinal): LongBool; cdecl;
  TSfmlSoundBufferRecorderStop = procedure (soundBufferRecorder: PSfmlSoundBufferRecorder); cdecl;
  TSfmlSoundBufferRecorderGetSampleRate = function (const soundBufferRecorder: PSfmlSoundBufferRecorder): Cardinal; cdecl;
  TSfmlSoundBufferRecorderGetBuffer = function (const soundBufferRecorder: PSfmlSoundBufferRecorder): PSfmlSoundBuffer; cdecl;
  TSfmlSoundBufferRecorderSetDevice = function (SoundRecorder: PSfmlSoundBufferRecorder; const Name: PAnsiChar): LongBool; cdecl;
  TSfmlSoundBufferRecorderGetDevice = function (SoundRecorder: PSfmlSoundBufferRecorder): PAnsiChar; cdecl;

  TSfmlSoundRecorderCreate = function (OnStart: TSfmlSoundRecorderStartCallback; OnProcess: TSfmlSoundRecorderProcessCallback; OnStop: TSfmlSoundRecorderStopCallback; UserData: Pointer): PSfmlSoundRecorder; cdecl;
  TSfmlSoundRecorderDestroy = procedure (SoundRecorder: PSfmlSoundRecorder); cdecl;
  TSfmlSoundRecorderStart = function (SoundRecorder: PSfmlSoundRecorder; SampleRate: Cardinal): LongBool; cdecl;
  TSfmlSoundRecorderStop = procedure (SoundRecorder: PSfmlSoundRecorder); cdecl;
  TSfmlSoundRecorderGetSampleRate = function (const SoundRecorder: PSfmlSoundRecorder): Cardinal; cdecl;
  TSfmlSoundRecorderIsAvailable = function : LongBool; cdecl;
  TSfmlSoundRecorderSetProcessingInterval = procedure (SoundRecorder: PSfmlSoundRecorder; Interval: TSfmlTime); cdecl;
  TSfmlSoundRecorderGetAvailableDevices = function (count: PNativeUInt): PPAnsiChar; cdecl;
  TSfmlSoundRecorderGetDefaultDevice = function : PAnsiChar; cdecl;
  TSfmlSoundRecorderSetDevice = function (SoundRecorder: PSfmlSoundRecorder; const Name: PAnsiChar): LongBool; cdecl;
  TSfmlSoundRecorderGetDevice = function (SoundRecorder: PSfmlSoundRecorder): PAnsiChar; cdecl;
  TSfmlSoundRecorderSetChannelCount = function (SoundRecorder: PSfmlSoundRecorder; const ChannelCount: Cardinal): LongBool; cdecl;
  TSfmlSoundRecorderGetChannelCount = function (const SoundRecorder: PSfmlSoundRecorder): Cardinal; cdecl;

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
  SfmlMusicPlay: TSfmlMusicPlay;
  SfmlMusicPause: TSfmlMusicPause;
  SfmlMusicStop: TSfmlMusicStop;
  SfmlMusicGetChannelCount: TSfmlMusicGetChannelCount;
  SfmlMusicGetSampleRate: TSfmlMusicGetSampleRate;
  SfmlMusicGetStatus: TSfmlMusicGetStatus;
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

  SfmlSoundBufferRecorderCreate: TSfmlSoundBufferRecorderCreate;
  SfmlSoundBufferRecorderDestroy: TSfmlSoundBufferRecorderDestroy;
  SfmlSoundBufferRecorderStart: TSfmlSoundBufferRecorderStart;
  SfmlSoundBufferRecorderStop: TSfmlSoundBufferRecorderStop;
  SfmlSoundBufferRecorderGetSampleRate: TSfmlSoundBufferRecorderGetSampleRate;
  SfmlSoundBufferRecorderGetBuffer: TSfmlSoundBufferRecorderGetBuffer;
  SfmlSoundBufferRecorderSetDevice: TSfmlSoundBufferRecorderSetDevice;
  SfmlSoundBufferRecorderGetDevice: TSfmlSoundBufferRecorderGetDevice;

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
  SfmlSoundRecorderSetChannelCount: TSfmlSoundRecorderSetChannelCount;
  SfmlSoundRecorderGetChannelCount: TSfmlSoundRecorderGetChannelCount;

{$IFNDEF INT64RETURNWORKAROUND}
  SfmlMusicGetDuration: TSfmlMusicGetDuration;
  SfmlMusicGetPlayingOffset: TSfmlMusicGetPlayingOffset;
  SfmlSoundStreamGetPlayingOffset: TSfmlSoundStreamGetPlayingOffset;
  SfmlSoundGetPlayingOffset: TSfmlSoundGetPlayingOffset;
  SfmlSoundBufferGetDuration: TSfmlSoundBufferGetDuration;
{$ENDIF}
{$ELSE}
  // static linking
  procedure SfmlListenerSetGlobalVolume(Volume: Single); cdecl; external CSfmlAudioLibrary name 'sfListener_setGlobalVolume';
  function SfmlListenerGetGlobalVolume: Single; cdecl; external CSfmlAudioLibrary name 'sfListener_getGlobalVolume';
  procedure SfmlListenerSetPosition(Position: TSfmlVector3f); cdecl; external CSfmlAudioLibrary name 'sfListener_setPosition';
  function SfmlListenerGetPosition: TSfmlVector3f; cdecl; external CSfmlAudioLibrary name 'sfListener_getPosition';
  procedure SfmlListenerSetDirection(Direction: TSfmlVector3f); cdecl; external CSfmlAudioLibrary name 'sfListener_setDirection';
  function SfmlListenerGetDirection: TSfmlVector3f; cdecl; external CSfmlAudioLibrary name 'sfListener_getDirection';
  procedure SfmlListenerSetUpVector(UpVector: TSfmlVector3f); cdecl; external CSfmlAudioLibrary name 'sfListener_setUpVector';
  function SfmlListenerGetUpVector: TSfmlVector3f; cdecl; external CSfmlAudioLibrary name 'sfListener_getUpVector';

  function SfmlMusicCreateFromFile(const FileName: PAnsiChar): PSfmlMusic; cdecl; external CSfmlAudioLibrary name 'sfMusic_createFromFile';
  function SfmlMusicCreateFromMemory(const data: Pointer; SizeInBytes: NativeUInt): PSfmlMusic; cdecl; external CSfmlAudioLibrary name 'sfMusic_createFromMemory';
  function SfmlMusicCreateFromStream(Stream: PSfmlInputStream): PSfmlMusic; cdecl; external CSfmlAudioLibrary name 'sfMusic_createFromStream';
  procedure SfmlMusicDestroy(Music: PSfmlMusic); cdecl; external CSfmlAudioLibrary name 'sfMusic_destroy';
  procedure SfmlMusicSetLoop(Music: PSfmlMusic; Loop: LongBool); cdecl; external CSfmlAudioLibrary name 'sfMusic_setLoop';
  function SfmlMusicGetLoop(const Music: PSfmlMusic): LongBool; cdecl; external CSfmlAudioLibrary name 'sfMusic_getLoop';
  {$IFNDEF INT64RETURNWORKAROUND}
  function SfmlMusicGetDuration(const Music: PSfmlMusic): TSfmlTime; cdecl; external CSfmlAudioLibrary name 'sfMusic_getDuration';
  {$ENDIF}
  procedure SfmlMusicPlay(Music: PSfmlMusic); cdecl; external CSfmlAudioLibrary name 'sfMusic_play';
  procedure SfmlMusicPause(Music: PSfmlMusic); cdecl; external CSfmlAudioLibrary name 'sfMusic_pause';
  procedure SfmlMusicStop(Music: PSfmlMusic); cdecl; external CSfmlAudioLibrary name 'sfMusic_stop';
  function SfmlMusicGetChannelCount(const Music: PSfmlMusic): Cardinal; cdecl; external CSfmlAudioLibrary name 'sfMusic_getChannelCount';
  function SfmlMusicGetSampleRate(const Music: PSfmlMusic): Cardinal; cdecl; external CSfmlAudioLibrary name 'sfMusic_getSampleRate';
  function SfmlMusicGetStatus(const Music: PSfmlMusic): TSfmlSoundStatus; cdecl; external CSfmlAudioLibrary name 'sfMusic_getStatus';
  {$IFNDEF INT64RETURNWORKAROUND}
  function SfmlMusicGetPlayingOffset(const Music: PSfmlMusic): TSfmlTime; cdecl; external CSfmlAudioLibrary name 'sfMusic_getPlayingOffset';
  {$ENDIF}
  procedure SfmlMusicSetPitch(Music: PSfmlMusic; Pitch: Single); cdecl; external CSfmlAudioLibrary name 'sfMusic_setPitch';
  procedure SfmlMusicSetVolume(Music: PSfmlMusic; Volume: Single); cdecl; external CSfmlAudioLibrary name 'sfMusic_setVolume';
  procedure SfmlMusicSetPosition(Music: PSfmlMusic; Position: TSfmlVector3f); cdecl; external CSfmlAudioLibrary name 'sfMusic_setPosition';
  procedure SfmlMusicSetRelativeToListener(Music: PSfmlMusic; Relative: LongBool); cdecl; external CSfmlAudioLibrary name 'sfMusic_setRelativeToListener';
  procedure SfmlMusicSetMinDistance(Music: PSfmlMusic; Distance: Single); cdecl; external CSfmlAudioLibrary name 'sfMusic_setMinDistance';
  procedure SfmlMusicSetAttenuation(Music: PSfmlMusic; Attenuation: Single); cdecl; external CSfmlAudioLibrary name 'sfMusic_setAttenuation';
  procedure SfmlMusicSetPlayingOffset(Music: PSfmlMusic; TimeOffset: TSfmlTime); cdecl; external CSfmlAudioLibrary name 'sfMusic_setPlayingOffset';
  function SfmlMusicGetPitch(const Music: PSfmlMusic): Single; cdecl; external CSfmlAudioLibrary name 'sfMusic_getPitch';
  function SfmlMusicGetVolume(const Music: PSfmlMusic): Single; cdecl; external CSfmlAudioLibrary name 'sfMusic_getVolume';
  function SfmlMusicGetPosition(const Music: PSfmlMusic): TSfmlVector3f; cdecl; external CSfmlAudioLibrary name 'sfMusic_getPosition';
  function SfmlMusicIsRelativeToListener(const Music: PSfmlMusic): LongBool; cdecl; external CSfmlAudioLibrary name 'sfMusic_isRelativeToListener';
  function SfmlMusicGetMinDistance(const Music: PSfmlMusic): Single; cdecl; external CSfmlAudioLibrary name 'sfMusic_getMinDistance';
  function SfmlMusicGetAttenuation(const Music: PSfmlMusic): Single; cdecl; external CSfmlAudioLibrary name 'sfMusic_getAttenuation';

  function SfmlSoundStreamCreate(OnGetData: TSfmlSoundStreamGetDataCallback; OnSeek: TSfmlSoundStreamSeekCallback; ChannelCount, SampleRate: Cardinal; UserData: Pointer): PSfmlSoundStream; cdecl; external CSfmlAudioLibrary name 'sfSoundStream_create';
  procedure SfmlSoundStreamDestroy(SoundStream: PSfmlSoundStream); cdecl; external CSfmlAudioLibrary name 'sfSoundStream_destroy';
  procedure SfmlSoundStreamPlay(SoundStream: PSfmlSoundStream); cdecl; external CSfmlAudioLibrary name 'sfSoundStream_play';
  procedure SfmlSoundStreamPause(SoundStream: PSfmlSoundStream); cdecl; external CSfmlAudioLibrary name 'sfSoundStream_pause';
  procedure SfmlSoundStreamStop(SoundStream: PSfmlSoundStream); cdecl; external CSfmlAudioLibrary name 'sfSoundStream_stop';
  function SfmlSoundStreamGetStatus(const SoundStream: PSfmlSoundStream): TSfmlSoundStatus; cdecl; external CSfmlAudioLibrary name 'sfSoundStream_getStatus';
  function SfmlSoundStreamGetChannelCount(const SoundStream: PSfmlSoundStream): Cardinal; cdecl; external CSfmlAudioLibrary name 'sfSoundStream_getChannelCount';
  function SfmlSoundStreamGetSampleRate(const SoundStream: PSfmlSoundStream): Cardinal; cdecl; external CSfmlAudioLibrary name 'sfSoundStream_getSampleRate';
  procedure SfmlSoundStreamSetPitch(SoundStream: PSfmlSoundStream; Pitch: Single); cdecl; external CSfmlAudioLibrary name 'sfSoundStream_setPitch';
  procedure SfmlSoundStreamSetVolume(SoundStream: PSfmlSoundStream; Volume: Single); cdecl; external CSfmlAudioLibrary name 'sfSoundStream_setVolume';
  procedure SfmlSoundStreamSetPosition(SoundStream: PSfmlSoundStream; Position: TSfmlVector3f); cdecl; external CSfmlAudioLibrary name 'sfSoundStream_setPosition';
  procedure SfmlSoundStreamSetRelativeToListener(SoundStream: PSfmlSoundStream; Relative: LongBool); cdecl; external CSfmlAudioLibrary name 'sfSoundStream_setRelativeToListener';
  procedure SfmlSoundStreamSetMinDistance(SoundStream: PSfmlSoundStream; Distance: Single); cdecl; external CSfmlAudioLibrary name 'sfSoundStream_setMinDistance';
  procedure SfmlSoundStreamSetAttenuation(SoundStream: PSfmlSoundStream; Attenuation: Single); cdecl; external CSfmlAudioLibrary name 'sfSoundStream_setAttenuation';
  procedure SfmlSoundStreamSetPlayingOffset(SoundStream: PSfmlSoundStream; TimeOffset: TSfmlTime); cdecl; external CSfmlAudioLibrary name 'sfSoundStream_setPlayingOffset';
  procedure SfmlSoundStreamSetLoop(SoundStream: PSfmlSoundStream; Loop: LongBool); cdecl; external CSfmlAudioLibrary name 'sfSoundStream_setLoop';
  function SfmlSoundStreamGetPitch(const SoundStream: PSfmlSoundStream): Single; cdecl; external CSfmlAudioLibrary name 'sfSoundStream_getPitch';
  function SfmlSoundStreamGetVolume(const SoundStream: PSfmlSoundStream): Single; cdecl; external CSfmlAudioLibrary name 'sfSoundStream_getVolume';
  function SfmlSoundStreamGetPosition(const SoundStream: PSfmlSoundStream): TSfmlVector3f; cdecl; external CSfmlAudioLibrary name 'sfSoundStream_getPosition';
  function SfmlSoundStreamIsRelativeToListener(const SoundStream: PSfmlSoundStream): LongBool; cdecl; external CSfmlAudioLibrary name 'sfSoundStream_isRelativeToListener';
  function SfmlSoundStreamGetMinDistance(const SoundStream: PSfmlSoundStream): Single; cdecl; external CSfmlAudioLibrary name 'sfSoundStream_getMinDistance';
  function SfmlSoundStreamGetAttenuation(const SoundStream: PSfmlSoundStream): Single; cdecl; external CSfmlAudioLibrary name 'sfSoundStream_getAttenuation';
  function SfmlSoundStreamGetLoop(const SoundStream: PSfmlSoundStream): LongBool; cdecl; external CSfmlAudioLibrary name 'sfSoundStream_getLoop';
  {$IFNDEF INT64RETURNWORKAROUND}
  function SfmlSoundStreamGetPlayingOffset(const SoundStream: PSfmlSoundStream): TSfmlTime; cdecl; external CSfmlAudioLibrary name 'sfSoundStream_getPlayingOffset';
  {$ENDIF}

  function SfmlSoundCreate: PSfmlSound; cdecl; external CSfmlAudioLibrary name 'sfSound_create';
  function SfmlSoundCopy(const Sound: PSfmlSound): PSfmlSound; cdecl; external CSfmlAudioLibrary name 'sfSound_copy';
  procedure SfmlSoundDestroy(Sound: PSfmlSound); cdecl; external CSfmlAudioLibrary name 'sfSound_destroy';
  procedure SfmlSoundPlay(Sound: PSfmlSound); cdecl; external CSfmlAudioLibrary name 'sfSound_play';
  procedure SfmlSoundPause(Sound: PSfmlSound); cdecl; external CSfmlAudioLibrary name 'sfSound_pause';
  procedure SfmlSoundStop(Sound: PSfmlSound); cdecl; external CSfmlAudioLibrary name 'sfSound_stop';
  procedure SfmlSoundSetBuffer(Sound: PSfmlSound; const Buffer: PSfmlSoundBuffer); cdecl; external CSfmlAudioLibrary name 'sfSound_setBuffer';
  function SfmlSoundGetBuffer(const Sound: PSfmlSound): PSfmlSoundBuffer; cdecl; external CSfmlAudioLibrary name 'sfSound_getBuffer';
  procedure SfmlSoundSetLoop(Sound: PSfmlSound; Loop: LongBool); cdecl; external CSfmlAudioLibrary name 'sfSound_setLoop';
  function SfmlSoundGetLoop(const Sound: PSfmlSound): LongBool; cdecl; external CSfmlAudioLibrary name 'sfSound_getLoop';
  function SfmlSoundGetStatus(const Sound: PSfmlSound): TSfmlSoundStatus; cdecl; external CSfmlAudioLibrary name 'sfSound_getStatus';
  procedure SfmlSoundSetPitch(Sound: PSfmlSound; Pitch: Single); cdecl; external CSfmlAudioLibrary name 'sfSound_setPitch';
  procedure SfmlSoundSetVolume(Sound: PSfmlSound; Volume: Single); cdecl; external CSfmlAudioLibrary name 'sfSound_setVolume';
  procedure SfmlSoundSetPosition(Sound: PSfmlSound; Position: TSfmlVector3f); cdecl; external CSfmlAudioLibrary name 'sfSound_setPosition';
  procedure SfmlSoundSetRelativeToListener(Sound: PSfmlSound; Relative: LongBool); cdecl; external CSfmlAudioLibrary name 'sfSound_setRelativeToListener';
  procedure SfmlSoundSetMinDistance(Sound: PSfmlSound; Distance: Single); cdecl; external CSfmlAudioLibrary name 'sfSound_setMinDistance';
  procedure SfmlSoundSetAttenuation(Sound: PSfmlSound; Attenuation: Single); cdecl; external CSfmlAudioLibrary name 'sfSound_setAttenuation';
  procedure SfmlSoundSetPlayingOffset(Sound: PSfmlSound; TimeOffset: TSfmlTime); cdecl; external CSfmlAudioLibrary name 'sfSound_setPlayingOffset';
  function SfmlSoundGetPitch(const Sound: PSfmlSound): Single; cdecl; external CSfmlAudioLibrary name 'sfSound_getPitch';
  function SfmlSoundGetVolume(const Sound: PSfmlSound): Single; cdecl; external CSfmlAudioLibrary name 'sfSound_getVolume';
  function SfmlSoundGetPosition(const Sound: PSfmlSound): TSfmlVector3f; cdecl; external CSfmlAudioLibrary name 'sfSound_getPosition';
  function SfmlSoundIsRelativeToListener(const Sound: PSfmlSound): LongBool; cdecl; external CSfmlAudioLibrary name 'sfSound_isRelativeToListener';
  function SfmlSoundGetMinDistance(const Sound: PSfmlSound): Single; cdecl; external CSfmlAudioLibrary name 'sfSound_getMinDistance';
  function SfmlSoundGetAttenuation(const Sound: PSfmlSound): Single; cdecl; external CSfmlAudioLibrary name 'sfSound_getAttenuation';
{$IFNDEF INT64RETURNWORKAROUND}
  function SfmlSoundGetPlayingOffset(const Sound: PSfmlSound): TSfmlTime; cdecl; external CSfmlAudioLibrary name 'sfSound_getPlayingOffset';
{$ENDIF}

  function SfmlSoundBufferCreateFromFile(const FileName: PAnsiChar): PSfmlSoundBuffer; cdecl; external CSfmlAudioLibrary name 'sfSoundBuffer_createFromFile';
  function SfmlSoundBufferCreateFromMemory(const Data: Pointer; SizeInBytes: NativeUInt): PSfmlSoundBuffer; cdecl; external CSfmlAudioLibrary name 'sfSoundBuffer_createFromMemory';
  function SfmlSoundBufferCreateFromStream(Stream: PSfmlInputStream): PSfmlSoundBuffer; cdecl; external CSfmlAudioLibrary name 'sfSoundBuffer_createFromStream';
  function SfmlSoundBufferCreateFromSamples(const Samples: PSmallInt; SampleCount: UInt64; ChannelCount, SampleRate: Cardinal): PSfmlSoundBuffer; cdecl; external CSfmlAudioLibrary name 'sfSoundBuffer_createFromSamples';
  function SfmlSoundBufferCopy(const SoundBuffer: PSfmlSoundBuffer): PSfmlSoundBuffer; cdecl; external CSfmlAudioLibrary name 'sfSoundBuffer_copy';
  procedure SfmlSoundBufferDestroy(SoundBuffer: PSfmlSoundBuffer); cdecl; external CSfmlAudioLibrary name 'sfSoundBuffer_destroy';
  function SfmlSoundBufferSaveToFile(const SoundBuffer: PSfmlSoundBuffer; const FileName: PAnsiChar): LongBool; cdecl; external CSfmlAudioLibrary name 'sfSoundBuffer_saveToFile';
  function SfmlSoundBufferGetSamples(const SoundBuffer: PSfmlSoundBuffer): PSmallInt; cdecl; external CSfmlAudioLibrary name 'sfSoundBuffer_getSamples';
  function SfmlSoundBufferGetSampleCount(const SoundBuffer: PSfmlSoundBuffer): NativeUInt; cdecl; external CSfmlAudioLibrary name 'sfSoundBuffer_getSampleCount';
  function SfmlSoundBufferGetSampleRate(const SoundBuffer: PSfmlSoundBuffer): Cardinal; cdecl; external CSfmlAudioLibrary name 'sfSoundBuffer_getSampleRate';
  function SfmlSoundBufferGetChannelCount(const SoundBuffer: PSfmlSoundBuffer): Cardinal; cdecl; external CSfmlAudioLibrary name 'sfSoundBuffer_getChannelCount';
  {$IFNDEF INT64RETURNWORKAROUND}
  function SfmlSoundBufferGetDuration(const SoundBuffer: PSfmlSoundBuffer): TSfmlTime; cdecl; external CSfmlAudioLibrary name 'sfSoundBuffer_getDuration';
  {$ENDIF}

  function SfmlSoundBufferRecorderCreate: PSfmlSoundBufferRecorder; cdecl; external CSfmlAudioLibrary name 'sfSoundBufferRecorder_create';
  procedure SfmlSoundBufferRecorderDestroy(soundBufferRecorder: PSfmlSoundBufferRecorder); cdecl; external CSfmlAudioLibrary name 'sfSoundBufferRecorder_destroy';
  function SfmlSoundBufferRecorderStart(soundBufferRecorder: PSfmlSoundBufferRecorder; SampleRate: Cardinal): Longbool; cdecl; external CSfmlAudioLibrary name 'sfSoundBufferRecorder_start';
  procedure SfmlSoundBufferRecorderStop(soundBufferRecorder: PSfmlSoundBufferRecorder); cdecl; external CSfmlAudioLibrary name 'sfSoundBufferRecorder_stop';
  function SfmlSoundBufferRecorderGetSampleRate(const soundBufferRecorder: PSfmlSoundBufferRecorder): Cardinal; cdecl; external CSfmlAudioLibrary name 'sfSoundBufferRecorder_getSampleRate';
  function SfmlSoundBufferRecorderGetBuffer(const soundBufferRecorder: PSfmlSoundBufferRecorder): PSfmlSoundBuffer; cdecl; external CSfmlAudioLibrary name 'sfSoundBufferRecorder_getBuffer';
  function SfmlSoundBufferRecorderSetDevice(SoundRecorder: PSfmlSoundBufferRecorder; const Name: PAnsiChar): LongBool; cdecl; external CSfmlAudioLibrary name 'sfSoundBufferRecorder_setDevice';
  function SfmlSoundBufferRecorderGetDevice(SoundRecorder: PSfmlSoundBufferRecorder): PAnsiChar; cdecl; external CSfmlAudioLibrary name 'sfSoundBufferRecorder_getDevice';

  function SfmlSoundRecorderCreate(OnStart: TSfmlSoundRecorderStartCallback; OnProcess: TSfmlSoundRecorderProcessCallback; OnStop: TSfmlSoundRecorderStopCallback; UserData: Pointer): PSfmlSoundRecorder; cdecl; external CSfmlAudioLibrary name 'sfSoundRecorder_create';
  procedure SfmlSoundRecorderDestroy(SoundRecorder: PSfmlSoundRecorder); cdecl; external CSfmlAudioLibrary name 'sfSoundRecorder_destroy';
  function SfmlSoundRecorderStart(SoundRecorder: PSfmlSoundRecorder; SampleRate: Cardinal): LongBool; cdecl; external CSfmlAudioLibrary name 'sfSoundRecorder_start';
  procedure SfmlSoundRecorderStop(SoundRecorder: PSfmlSoundRecorder); cdecl; external CSfmlAudioLibrary name 'sfSoundRecorder_stop';
  function SfmlSoundRecorderGetSampleRate(const SoundRecorder: PSfmlSoundRecorder): Cardinal; cdecl; external CSfmlAudioLibrary name 'sfSoundRecorder_getSampleRate';
  function SfmlSoundRecorderIsAvailable: LongBool; cdecl; external CSfmlAudioLibrary name 'sfSoundRecorder_isAvailable';
  procedure SfmlSoundRecorderSetProcessingInterval(SoundRecorder: PSfmlSoundRecorder; Interval: TSfmlTime); cdecl; external CSfmlAudioLibrary name 'sfSoundRecorder_setProcessingInterval';
  function SfmlSoundRecorderGetAvailableDevices(count: PNativeUInt): PPAnsiChar; cdecl; external CSfmlAudioLibrary name 'sfSoundRecorder_getAvailableDevices';
  function SfmlSoundRecorderGetDefaultDevice: PAnsiChar; cdecl; external CSfmlAudioLibrary name 'sfSoundRecorder_getDefaultDevice';
  function SfmlSoundRecorderSetDevice(SoundRecorder: PSfmlSoundRecorder; const Name: PAnsiChar): LongBool; cdecl; external CSfmlAudioLibrary name 'sfSoundRecorder_setDevice';
  function SfmlSoundRecorderGetDevice(SoundRecorder: PSfmlSoundRecorder): PAnsiChar; cdecl; external CSfmlAudioLibrary name 'sfSoundRecorder_getDevice';
  function SfmlSoundRecorderSetChannelCount(SoundRecorder: PSfmlSoundRecorder; const ChannelCount: Cardinal): LongBool; cdecl; external CSfmlAudioLibrary name 'sfSoundRecorder_getChannelCount';
  function SfmlSoundRecorderGetChannelCount(const SoundRecorder: PSfmlSoundRecorder): Cardinal; cdecl; external CSfmlAudioLibrary name 'sfSoundRecorder_setChannelCount';
{$ENDIF}

type
  TSfmlSoundSource = class
  protected
    function GetAttenuation: Single; virtual; abstract;
    function GetMinDistance: Single; virtual; abstract;
    function GetPitch: Single; virtual; abstract;
    function GetPosition: TSfmlVector3f; virtual; abstract;
    function GetRelativeToListener: Boolean; virtual; abstract;
    function GetStatus: TSfmlSoundStatus; virtual; abstract;
    function GetVolume: Single; virtual; abstract;
    procedure SetAttenuation(Attenuation: Single); virtual; abstract;
    procedure SetMinDistance(Distance: Single); virtual; abstract;
    procedure SetPitch(Pitch: Single); virtual; abstract;
    procedure SetPosition(Position: TSfmlVector3f); virtual; abstract;
    procedure SetRelativeToListener(Relative: Boolean); virtual; abstract;
    procedure SetVolume(Volume: Single); virtual; abstract;
  public
    property Attenuation: Single read GetAttenuation write SetAttenuation;
    property MinDistance: Single read GetMinDistance write SetMinDistance;
    property Pitch: Single read GetPitch write SetPitch;
    property Position: TSfmlVector3f read GetPosition write SetPosition;
    property RelativeToListener: Boolean read GetRelativeToListener write SetRelativeToListener;
    property Status: TSfmlSoundStatus read GetStatus;
    property Volume: Single read GetVolume write SetVolume;
  end;

  TSfmlSoundStream = class(TSfmlSoundSource)
  private
    FHandle: PSfmlSoundStream;
  protected
    function GetAttenuation: Single; override;
    function GetChannelCount: Cardinal; virtual;
    function GetLoop: Boolean; virtual;
    function GetMinDistance: Single; override;
    function GetPitch: Single; override;
    function GetPlayingOffset: TSfmlTime; virtual;
    function GetPosition: TSfmlVector3f; override;
    function GetRelativeToListener: Boolean; override;
    function GetSampleRate: Cardinal; virtual;
    function GetStatus: TSfmlSoundStatus; override;
    function GetVolume: Single; override;
    procedure SetAttenuation(Attenuation: Single); override;
    procedure SetLoop(Loop: Boolean); virtual;
    procedure SetMinDistance(Distance: Single); override;
    procedure SetPitch(Pitch: Single); override;
    procedure SetPlayingOffset(TimeOffset: TSfmlTime); virtual;
    procedure SetPosition(Position: TSfmlVector3f); override;
    procedure SetRelativeToListener(Relative: Boolean); override;
    procedure SetVolume(Volume: Single); override;
  public
    constructor Create(OnGetData: TSfmlSoundStreamGetDataCallback;
      OnSeek: TSfmlSoundStreamSeekCallback;
      ChannelCount, SampleRate: Cardinal; UserData: Pointer);
    destructor Destroy; override;

    procedure Play;
    procedure Pause;
    procedure Stop;

    property ChannelCount: Cardinal read GetChannelCount;
    property Handle: PSfmlSoundStream read FHandle;
    property Loop: Boolean read GetLoop write SetLoop;
    property PlayingOffset: TSfmlTime read GetPlayingOffset write SetPlayingOffset;
    property SampleRate: Cardinal read GetSampleRate;
  end;

  TSfmlMusic = class(TSfmlSoundStream)
  private
    FHandle: PSfmlMusic;
    function GetDuration: TSfmlTime;
  protected
    function GetAttenuation: Single; override;
    function GetChannelCount: Cardinal; override;
    function GetLoop: Boolean; override;
    function GetMinDistance: Single; override;
    function GetPitch: Single; override;
    function GetPlayingOffset: TSfmlTime; override;
    function GetPosition: TSfmlVector3f; override;
    function GetRelativeToListener: Boolean; override;
    function GetSampleRate: Cardinal; override;
    function GetStatus: TSfmlSoundStatus; override;
    function GetVolume: Single; override;
    procedure SetAttenuation(Attenuation: Single); override;
    procedure SetLoop(Loop: Boolean); override;
    procedure SetMinDistance(Distance: Single); override;
    procedure SetPitch(Pitch: Single); override;
    procedure SetPlayingOffset(TimeOffset: TSfmlTime); override;
    procedure SetPosition(Position: TSfmlVector3f); override;
    procedure SetRelativeToListener(Relative: Boolean); override;
    procedure SetVolume(Volume: Single); override;
  public
    constructor Create(const FileName: AnsiString); overload;
    constructor Create(const Data: Pointer; SizeInBytes: NativeUInt); overload;
    constructor Create(Stream: PSfmlInputStream); overload;
    destructor Destroy; override;

    procedure Play;
    procedure Pause;
    procedure Stop;

    property Attenuation: Single read GetAttenuation write SetAttenuation;
    property ChannelCount: Cardinal read GetChannelCount;
    property Duration: TSfmlTime read GetDuration;
    property Handle: PSfmlMusic read FHandle;
    property Loop: Boolean read GetLoop write SetLoop;
    property MinDistance: Single read GetMinDistance write SetMinDistance;
    property Pitch: Single read GetPitch write SetPitch;
    property PlayingOffset: TSfmlTime read GetPlayingOffset write SetPlayingOffset;
    property Position: TSfmlVector3f read GetPosition write SetPosition;
    property RelativeToListener: Boolean read GetRelativeToListener write SetRelativeToListener;
    property SampleRate: Cardinal read GetSampleRate;
    property Status: TSfmlSoundStatus read GetStatus;
    property Volume: Single read GetVolume write SetVolume;
  end;

  TSfmlSoundBuffer = class
  private
    FHandle: PSfmlSoundBuffer;
    constructor Create(Handle: PSfmlSoundBuffer); overload;
    function GetSampleCount: NativeUInt;
    function GetSampleRate: Cardinal;
    function GetChannelCount: Cardinal;
    function GetDuration: TSfmlTime;
  public
    constructor Create(const FileName: AnsiString); overload;
    constructor Create(const Data: Pointer; SizeInBytes: NativeUInt); overload;
    constructor Create(Stream: PSfmlInputStream); overload;
    constructor Create(const Samples: PSmallInt; SampleCount: NativeUInt;
      ChannelCount, SampleRate: Cardinal); overload;
    destructor Destroy; override;

    function Copy: TSfmlSoundBuffer;
    function SaveToFile(const FileName: AnsiString): Boolean;
    function GetSamples: PSmallInt;

    property ChannelCount: Cardinal read GetChannelCount;
    property Duration: TSfmlTime read GetDuration;
    property Handle: PSfmlSoundBuffer read FHandle;
    property SampleCount: NativeUInt read GetSampleCount;
    property SampleRate: Cardinal read GetSampleRate;
  end;

  TSfmlSound = class(TSfmlSoundSource)
  private
    FHandle: PSfmlSound;
    constructor Create(Handle: PSfmlSound); overload;
    function GetLoop: Boolean;
    function GetPlayingOffset: TSfmlTime;
    procedure SetLoop(Loop: Boolean);
    procedure SetPlayingOffset(TimeOffset: TSfmlTime);
  protected
    function GetAttenuation: Single; override;
    function GetPitch: Single; override;
    function GetMinDistance: Single; override;
    function GetPosition: TSfmlVector3f; override;
    function GetRelativeToListener: Boolean; override;
    function GetStatus: TSfmlSoundStatus; override;
    function GetVolume: Single; override;
    procedure SetAttenuation(Attenuation: Single); override;
    procedure SetMinDistance(Distance: Single); override;
    procedure SetPitch(Pitch: Single); override;
    procedure SetPosition(Position: TSfmlVector3f); override;
    procedure SetRelativeToListener(Relative: Boolean); override;
    procedure SetVolume(Volume: Single); override;
  public
    constructor Create; overload;
    constructor Create(Buffer: TSfmlSoundBuffer); overload;
    destructor Destroy; override;

    function Copy: TSfmlSound;

    function GetBuffer: PSfmlSoundBuffer;
    procedure SetBuffer(const Buffer: PSfmlSoundBuffer); overload;
    procedure SetBuffer(const Buffer: TSfmlSoundBuffer); overload;

    procedure Pause;
    procedure Play;
    procedure Stop;

    property Handle: PSfmlSound read FHandle;
    property Loop: Boolean read GetLoop write SetLoop;
    property PlayingOffset: TSfmlTime read GetPlayingOffset write SetPlayingOffset;
  end;

  TSfmlSoundBufferRecorder = class
  private
    FHandle: PSfmlSoundBufferRecorder;
    function GetSampleRate: Cardinal;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Start(SampleRate: Cardinal);
    procedure Stop;

    function GetBuffer: PSfmlSoundBuffer;

    property Handle: PSfmlSoundBufferRecorder read FHandle;
    property SampleRate: Cardinal read GetSampleRate;
  end;

  TSfmlSoundRecorder = class
  private
    FHandle: PSfmlSoundRecorder;
    function GetDevice: AnsiString;
    function GetSampleRate: Cardinal;
    procedure SetDevice(const Name: AnsiString);
  public
    constructor Create(OnStart: TSfmlSoundRecorderStartCallback;
      OnProcess: TSfmlSoundRecorderProcessCallback;
      OnStop: TSfmlSoundRecorderStopCallback; UserData: Pointer);
    destructor Destroy; override;

    function Start(SampleRate: Cardinal): Boolean;
    procedure Stop;
    procedure SetProcessingInterval(Interval: TSfmlTime);

    property Handle: PSfmlSoundRecorder read FHandle;
    property Device: AnsiString read GetDevice write SetDevice;
    property SampleRate: Cardinal read GetSampleRate;
  end;

{$IFDEF INT64RETURNWORKAROUND}
  // Workarounds for the Delphi compiler
  function SfmlMusicGetDuration(const Music: PSfmlMusic): TSfmlTime; cdecl;
  function SfmlMusicGetPlayingOffset(const Music: PSfmlMusic): TSfmlTime; cdecl;
  function SfmlSoundStreamGetPlayingOffset(const SoundStream: PSfmlSoundStream): TSfmlTime; cdecl;
  function SfmlSoundGetPlayingOffset(const Sound: PSfmlSound): TSfmlTime; cdecl;
  function SfmlSoundBufferGetDuration(const SoundBuffer: PSfmlSoundBuffer): TSfmlTime; cdecl;
{$ENDIF}

implementation

{$IFDEF DynLink}
uses
{$IFDEF FPC}
  DynLibs;
{$ELSE}
{$IFDEF MSWindows}
  Windows;
{$ENDIF}
{$ENDIF}
{$ENDIF}

{ TSfmlMusic }

constructor TSfmlMusic.Create(const Data: Pointer; SizeInBytes: NativeUInt);
begin
  FHandle := SfmlMusicCreateFromMemory(Data, SizeInBytes);
end;

constructor TSfmlMusic.Create(const FileName: AnsiString);
begin
  FHandle := SfmlMusicCreateFromFile(PAnsiChar(FileName));
end;

constructor TSfmlMusic.Create(Stream: PSfmlInputStream);
begin
  FHandle := SfmlMusicCreateFromStream(Stream);
end;

destructor TSfmlMusic.Destroy;
begin
  SfmlMusicDestroy(FHandle);

  inherited;
end;

function TSfmlMusic.GetAttenuation: Single;
begin
  Result := SfmlMusicGetAttenuation(FHandle);
end;

function TSfmlMusic.GetChannelCount: Cardinal;
begin
  Result := SfmlMusicGetChannelCount(FHandle);
end;

function TSfmlMusic.GetDuration: TSfmlTime;
begin
  Result := SfmlMusicGetDuration(FHandle);
end;

function TSfmlMusic.GetLoop: Boolean;
begin
  Result := SfmlMusicGetLoop(FHandle);
end;

function TSfmlMusic.GetMinDistance: Single;
begin
  Result := SfmlMusicGetMinDistance(FHandle);
end;

function TSfmlMusic.GetPitch: Single;
begin
  Result := SfmlMusicGetPitch(FHandle);
end;

function TSfmlMusic.GetPlayingOffset: TSfmlTime;
begin
  Result := SfmlMusicGetPlayingOffset(FHandle);
end;

function TSfmlMusic.GetPosition: TSfmlVector3f;
begin
  Result := SfmlMusicGetPosition(FHandle);
end;

function TSfmlMusic.GetSampleRate: Cardinal;
begin
  Result := SfmlMusicGetSampleRate(FHandle);
end;

function TSfmlMusic.GetStatus: TSfmlSoundStatus;
begin
  Result := SfmlMusicGetStatus(FHandle);
end;

function TSfmlMusic.GetVolume: Single;
begin
  Result := SfmlMusicGetVolume(FHandle);
end;

function TSfmlMusic.GetRelativeToListener: Boolean;
begin
  Result := SfmlMusicIsRelativeToListener(FHandle);
end;

procedure TSfmlMusic.Pause;
begin
  SfmlMusicPause(FHandle);
end;

procedure TSfmlMusic.Play;
begin
  SfmlMusicPlay(FHandle);
end;

procedure TSfmlMusic.SetAttenuation(Attenuation: Single);
begin
  SfmlMusicSetAttenuation(FHandle, Attenuation);
end;

procedure TSfmlMusic.SetLoop(Loop: Boolean);
begin
  SfmlMusicSetLoop(FHandle, Loop);
end;

procedure TSfmlMusic.SetMinDistance(Distance: Single);
begin
  SfmlMusicSetMinDistance(FHandle, Distance);
end;

procedure TSfmlMusic.SetPitch(Pitch: Single);
begin
  SfmlMusicSetPitch(FHandle, Pitch);
end;

procedure TSfmlMusic.SetPlayingOffset(TimeOffset: TSfmlTime);
begin
  SfmlMusicSetPlayingOffset(FHandle, TimeOffset);
end;

procedure TSfmlMusic.SetPosition(Position: TSfmlVector3f);
begin
  SfmlMusicSetPosition(FHandle, Position);
end;

procedure TSfmlMusic.SetRelativeToListener(Relative: Boolean);
begin
  SfmlMusicSetRelativeToListener(FHandle, Relative);
end;

procedure TSfmlMusic.SetVolume(Volume: Single);
begin
  SfmlMusicSetVolume(FHandle, Volume);
end;

procedure TSfmlMusic.Stop;
begin
  SfmlMusicStop(FHandle);
end;


{ TSfmlSoundStream }

constructor TSfmlSoundStream.Create(OnGetData: TSfmlSoundStreamGetDataCallback;
  OnSeek: TSfmlSoundStreamSeekCallback; ChannelCount, SampleRate: Cardinal;
  UserData: Pointer);
begin
  FHandle := SfmlSoundStreamCreate(OnGetData, OnSeek, ChannelCount, SampleRate,
    UserData);
end;

destructor TSfmlSoundStream.Destroy;
begin
  SfmlSoundStreamDestroy(FHandle);
  inherited;
end;

function TSfmlSoundStream.GetAttenuation: Single;
begin
  Result := SfmlSoundStreamGetAttenuation(FHandle);
end;

function TSfmlSoundStream.GetChannelCount: Cardinal;
begin
  Result := SfmlSoundStreamGetChannelCount(FHandle);
end;

function TSfmlSoundStream.GetLoop: Boolean;
begin
  Result := SfmlSoundStreamGetLoop(FHandle);
end;

function TSfmlSoundStream.GetMinDistance: Single;
begin
  Result := SfmlSoundStreamGetMinDistance(FHandle);
end;

function TSfmlSoundStream.GetPitch: Single;
begin
  Result := SfmlSoundStreamGetPitch(FHandle);
end;

function TSfmlSoundStream.GetPlayingOffset: TSfmlTime;
begin
  Result := SfmlSoundStreamGetPlayingOffset(FHandle);
end;

function TSfmlSoundStream.GetPosition: TSfmlVector3f;
begin
  Result := SfmlSoundStreamGetPosition(FHandle);
end;

function TSfmlSoundStream.GetSampleRate: Cardinal;
begin
  Result := SfmlSoundStreamGetSampleRate(FHandle);
end;

function TSfmlSoundStream.GetStatus: TSfmlSoundStatus;
begin
  Result := SfmlSoundStreamGetStatus(FHandle);
end;

function TSfmlSoundStream.GetVolume: Single;
begin
  Result := SfmlSoundStreamGetVolume(FHandle);
end;

function TSfmlSoundStream.GetRelativeToListener: Boolean;
begin
  Result := SfmlSoundStreamIsRelativeToListener(FHandle);
end;

procedure TSfmlSoundStream.Pause;
begin
  SfmlSoundStreamPause(FHandle);
end;

procedure TSfmlSoundStream.Play;
begin
  SfmlSoundStreamPlay(FHandle);
end;

procedure TSfmlSoundStream.SetAttenuation(Attenuation: Single);
begin
  SfmlSoundStreamSetAttenuation(FHandle, Attenuation);
end;

procedure TSfmlSoundStream.SetLoop(Loop: Boolean);
begin
  SfmlSoundStreamSetLoop(FHandle, Loop);
end;

procedure TSfmlSoundStream.SetMinDistance(Distance: Single);
begin
  SfmlSoundStreamSetMinDistance(FHandle, Distance);
end;

procedure TSfmlSoundStream.SetPitch(Pitch: Single);
begin
  SfmlSoundStreamSetPitch(FHandle, Pitch);
end;

procedure TSfmlSoundStream.SetPlayingOffset(TimeOffset: TSfmlTime);
begin
  SfmlSoundStreamSetPlayingOffset(FHandle, TimeOffset);
end;

procedure TSfmlSoundStream.SetPosition(Position: TSfmlVector3f);
begin
  SfmlSoundStreamSetPosition(FHandle, Position);
end;

procedure TSfmlSoundStream.SetRelativeToListener(Relative: Boolean);
begin
  SfmlSoundStreamSetRelativeToListener(FHandle, Relative);
end;

procedure TSfmlSoundStream.SetVolume(Volume: Single);
begin
  SfmlSoundStreamSetVolume(FHandle, Volume);
end;

procedure TSfmlSoundStream.Stop;
begin
  SfmlSoundStreamStop(FHandle);
end;


{ TSfmlSoundBuffer }

constructor TSfmlSoundBuffer.Create(Handle: PSfmlSoundBuffer);
begin
  FHandle := Handle;
end;

constructor TSfmlSoundBuffer.Create(const FileName: AnsiString);
begin
  FHandle := SfmlSoundBufferCreateFromFile(PAnsiChar(FileName));
end;

constructor TSfmlSoundBuffer.Create(const Data: Pointer;
  SizeInBytes: NativeUInt);
begin
  FHandle := SfmlSoundBufferCreateFromMemory(Data, SizeInBytes);
end;

constructor TSfmlSoundBuffer.Create(const Samples: PSmallInt;
  SampleCount: NativeUInt; ChannelCount, SampleRate: Cardinal);
begin
  FHandle := SfmlSoundBufferCreateFromSamples(Samples, SampleCount,
    ChannelCount, SampleRate);
end;

constructor TSfmlSoundBuffer.Create(Stream: PSfmlInputStream);
begin
  FHandle := SfmlSoundBufferCreateFromStream(Stream);
end;

destructor TSfmlSoundBuffer.Destroy;
begin
  SfmlSoundBufferDestroy(FHandle);
  inherited;
end;

function TSfmlSoundBuffer.Copy: TSfmlSoundBuffer;
begin
  Result := TSfmlSoundBuffer.Create(SfmlSoundBufferCopy(FHandle));
end;

function TSfmlSoundBuffer.GetChannelCount: Cardinal;
begin
  Result := SfmlSoundBufferGetChannelCount(FHandle);
end;

function TSfmlSoundBuffer.GetDuration: TSfmlTime;
begin
  Result := SfmlSoundBufferGetDuration(FHandle);
end;

function TSfmlSoundBuffer.GetSampleCount: NativeUInt;
begin
  Result := SfmlSoundBufferGetSampleCount(FHandle);
end;

function TSfmlSoundBuffer.GetSampleRate: Cardinal;
begin
  Result := SfmlSoundBufferGetSampleRate(FHandle);
end;

function TSfmlSoundBuffer.GetSamples: PSmallInt;
begin
  Result := SfmlSoundBufferGetSamples(FHandle);
end;

function TSfmlSoundBuffer.SaveToFile(const FileName: AnsiString): Boolean;
begin
  Result := SfmlSoundBufferSaveToFile(FHandle, PAnsiChar(FileName));
end;


{ TSfmlSound }

constructor TSfmlSound.Create;
begin
  FHandle := SfmlSoundCreate;
end;

constructor TSfmlSound.Create(Buffer: TSfmlSoundBuffer);
begin
  Create;
  SetBuffer(Buffer);
end;

constructor TSfmlSound.Create(Handle: PSfmlSound);
begin
  FHandle := Handle;
end;

destructor TSfmlSound.Destroy;
begin
  SfmlSoundDestroy(FHandle);
  inherited;
end;

function TSfmlSound.Copy: TSfmlSound;
begin
  Result := TSfmlSound.Create(SfmlSoundCopy(FHandle))
end;

function TSfmlSound.GetAttenuation: Single;
begin
  Result := SfmlSoundGetAttenuation(FHandle);
end;

function TSfmlSound.GetBuffer: PSfmlSoundBuffer;
begin
  Result := SfmlSoundGetBuffer(FHandle);
end;

function TSfmlSound.GetLoop: Boolean;
begin
  Result := SfmlSoundGetLoop(FHandle);
end;

function TSfmlSound.GetMinDistance: Single;
begin
  Result := SfmlSoundGetMinDistance(FHandle);
end;

function TSfmlSound.GetPitch: Single;
begin
  Result := SfmlSoundGetPitch(FHandle);
end;

function TSfmlSound.GetPlayingOffset: TSfmlTime;
begin
  Result := SfmlSoundGetPlayingOffset(FHandle);
end;

function TSfmlSound.GetPosition: TSfmlVector3f;
begin
  Result := SfmlSoundGetPosition(FHandle);
end;

function TSfmlSound.GetStatus: TSfmlSoundStatus;
begin
  Result := SfmlSoundGetStatus(FHandle);
end;

function TSfmlSound.GetVolume: Single;
begin
  Result := SfmlSoundGetVolume(FHandle);
end;

function TSfmlSound.GetRelativeToListener: Boolean;
begin
  Result := SfmlSoundIsRelativeToListener(FHandle);
end;

procedure TSfmlSound.Pause;
begin
  SfmlSoundPause(FHandle);
end;

procedure TSfmlSound.Play;
begin
  SfmlSoundPlay(FHandle);
end;

procedure TSfmlSound.SetAttenuation(Attenuation: Single);
begin
  SfmlSoundSetAttenuation(FHandle, Attenuation);
end;

procedure TSfmlSound.SetBuffer(const Buffer: PSfmlSoundBuffer);
begin
  SfmlSoundSetBuffer(FHandle, Buffer);
end;

procedure TSfmlSound.SetBuffer(const Buffer: TSfmlSoundBuffer);
begin
  SfmlSoundSetBuffer(FHandle, Buffer.Handle);
end;

procedure TSfmlSound.SetLoop(Loop: Boolean);
begin
  SfmlSoundSetLoop(FHandle, Loop);
end;

procedure TSfmlSound.SetMinDistance(Distance: Single);
begin
  SfmlSoundSetMinDistance(FHandle, Distance);
end;

procedure TSfmlSound.SetPitch(Pitch: Single);
begin
  SfmlSoundSetPitch(FHandle, Pitch);
end;

procedure TSfmlSound.SetPlayingOffset(TimeOffset: TSfmlTime);
begin
  SfmlSoundSetPlayingOffset(FHandle, TimeOffset);
end;

procedure TSfmlSound.SetPosition(Position: TSfmlVector3f);
begin
  SfmlSoundSetPosition(FHandle, Position);
end;

procedure TSfmlSound.SetRelativeToListener(Relative: Boolean);
begin
  SfmlSoundSetRelativeToListener(FHandle, Relative);
end;

procedure TSfmlSound.SetVolume(Volume: Single);
begin
  SfmlSoundSetVolume(FHandle, Volume);
end;

procedure TSfmlSound.Stop;
begin
  SfmlSoundStop(FHandle);
end;


{ TSfmlSoundBufferRecorder }

constructor TSfmlSoundBufferRecorder.Create;
begin
  FHandle := SfmlSoundBufferRecorderCreate;
end;

destructor TSfmlSoundBufferRecorder.Destroy;
begin
  SfmlSoundBufferRecorderDestroy(FHandle);
  inherited;
end;

function TSfmlSoundBufferRecorder.GetBuffer: PSfmlSoundBuffer;
begin
  Result := SfmlSoundBufferRecorderGetBuffer(FHandle);
end;

function TSfmlSoundBufferRecorder.GetSampleRate: Cardinal;
begin
  Result := SfmlSoundBufferRecorderGetSampleRate(FHandle);
end;

procedure TSfmlSoundBufferRecorder.Start(SampleRate: Cardinal);
begin
  SfmlSoundBufferRecorderStart(FHandle, SampleRate);
end;

procedure TSfmlSoundBufferRecorder.Stop;
begin
  SfmlSoundBufferRecorderStop(FHandle);
end;


{ TSfmlSoundRecorder }

constructor TSfmlSoundRecorder.Create(OnStart: TSfmlSoundRecorderStartCallback;
  OnProcess: TSfmlSoundRecorderProcessCallback;
  OnStop: TSfmlSoundRecorderStopCallback; UserData: Pointer);
begin
  FHandle := SfmlSoundRecorderCreate(OnStart, OnProcess, OnStop, UserData);
end;

destructor TSfmlSoundRecorder.Destroy;
begin
  SfmlSoundRecorderDestroy(FHandle);
  inherited;
end;

function TSfmlSoundRecorder.GetDevice: AnsiString;
begin
  Result := SfmlSoundRecorderGetDevice(FHandle);
end;

function TSfmlSoundRecorder.GetSampleRate: Cardinal;
begin
  Result := SfmlSoundRecorderGetSampleRate(FHandle);
end;

procedure TSfmlSoundRecorder.SetDevice(const Name: AnsiString);
begin
  Assert(SfmlSoundRecorderSetDevice(FHandle, PAnsiChar(Name)));
end;

procedure TSfmlSoundRecorder.SetProcessingInterval(Interval: TSfmlTime);
begin
  SfmlSoundRecorderSetProcessingInterval(FHandle, Interval);
end;

function TSfmlSoundRecorder.Start(SampleRate: Cardinal): Boolean;
begin
  Result := SfmlSoundRecorderStart(FHandle, SampleRate);
end;

procedure TSfmlSoundRecorder.Stop;
begin
  SfmlSoundRecorderStop(FHandle);
end;

{$IFDEF DynLink}
var
  CSfmlAudioHandle: {$IFDEF FPC}TLibHandle{$ELSE}HINST{$ENDIF};
{$IFDEF INT64RETURNWORKAROUND}
  sfMusic_getDuration: function (const Music: PSfmlMusic): Int64; cdecl;
  sfMusic_getPlayingOffset: function (const Music: PSfmlMusic): Int64; cdecl;
  sfSoundStream_getPlayingOffset: function (const SoundStream: PSfmlSoundStream): Int64; cdecl;
  sfSound_getPlayingOffset: function (const Sound: PSfmlSound): Int64; cdecl;
  sfSoundBuffer_getDuration: function (const SoundBuffer: PSfmlSoundBuffer): Int64; cdecl;
{$ENDIF}

procedure InitDLL;

  function BindFunction(Name: AnsiString): Pointer;
  begin
    Result := GetProcAddress(CSfmlAudioHandle, PAnsiChar(Name));
    Assert(Assigned(Result));
  end;

begin
  // dynamically load external library
  {$IFDEF FPC}
  CSfmlAudioHandle := LoadLibrary(CSfmlAudioLibrary);
  {$ELSE}
  CSfmlAudioHandle := LoadLibraryA(CSfmlAudioLibrary);
  {$ENDIF}

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
      SfmlMusicPlay := BindFunction('sfMusic_play');
      SfmlMusicPause := BindFunction('sfMusic_pause');
      SfmlMusicStop := BindFunction('sfMusic_stop');
      SfmlMusicGetChannelCount := BindFunction('sfMusic_getChannelCount');
      SfmlMusicGetSampleRate := BindFunction('sfMusic_getSampleRate');
      SfmlMusicGetStatus := BindFunction('sfMusic_getStatus');
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
      SfmlSoundBufferRecorderCreate := BindFunction('sfSoundBufferRecorder_create');
      SfmlSoundBufferRecorderDestroy := BindFunction('sfSoundBufferRecorder_destroy');
      SfmlSoundBufferRecorderStart := BindFunction('sfSoundBufferRecorder_start');
      SfmlSoundBufferRecorderStop := BindFunction('sfSoundBufferRecorder_stop');
      SfmlSoundBufferRecorderGetSampleRate := BindFunction('sfSoundBufferRecorder_getSampleRate');
      SfmlSoundBufferRecorderGetBuffer := BindFunction('sfSoundBufferRecorder_getBuffer');
      SfmlSoundBufferRecorderSetDevice := BindFunction('sfSoundBufferRecorder_setDevice');
      SfmlSoundBufferRecorderGetDevice := BindFunction('sfSoundBufferRecorder_getDevice');
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
      SfmlSoundRecorderSetChannelCount := BindFunction('sfSoundRecorder_setChannelCount');
      SfmlSoundRecorderGetChannelCount := BindFunction('sfSoundRecorder_getChannelCount');

{$IFDEF INT64RETURNWORKAROUND}
      sfMusic_getDuration := BindFunction('sfMusic_getDuration');
      sfMusic_getPlayingOffset := BindFunction('sfMusic_getPlayingOffset');
      sfSoundStream_getPlayingOffset := BindFunction('sfSoundStream_getPlayingOffset');
      sfSound_getPlayingOffset := BindFunction('sfSound_getPlayingOffset');
      sfSoundBuffer_getDuration := BindFunction('sfSoundBuffer_getDuration');
{$ELSE}
      SfmlMusicGetDuration := BindFunction('sfMusic_getDuration');
      SfmlMusicGetPlayingOffset := BindFunction('sfMusic_getPlayingOffset');
      SfmlSoundStreamGetPlayingOffset := BindFunction('sfSoundStream_getPlayingOffset');
      SfmlSoundGetPlayingOffset := BindFunction('sfSound_getPlayingOffset');
      SfmlSoundBufferGetDuration := BindFunction('sfSoundBuffer_getDuration');
{$ENDIF}
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
{$ELSE}
{$IFDEF INT64RETURNWORKAROUND}
function sfMusic_getDuration(const Music: PSfmlMusic): Int64; cdecl; external CSfmlAudioLibrary;
function sfMusic_getPlayingOffset(const Music: PSfmlMusic): Int64; cdecl; external CSfmlAudioLibrary;
function sfSoundStream_getPlayingOffset(const SoundStream: PSfmlSoundStream): Int64; cdecl; external CSfmlAudioLibrary;
function sfSound_getPlayingOffset(const Sound: PSfmlSound): Int64; cdecl; external CSfmlAudioLibrary;
function sfSoundBuffer_getDuration(const SoundBuffer: PSfmlSoundBuffer): Int64; cdecl; external CSfmlAudioLibrary;
{$ENDIF}
{$ENDIF}

{$IFDEF INT64RETURNWORKAROUND}
function SfmlMusicGetDuration(const Music: PSfmlMusic): TSfmlTime; cdecl;
begin
  Result.MicroSeconds := sfMusic_getDuration(Music);
end;

function SfmlMusicGetPlayingOffset(const Music: PSfmlMusic): TSfmlTime; cdecl;
begin
  Result.MicroSeconds := sfMusic_getPlayingOffset(Music);
end;

function SfmlSoundStreamGetPlayingOffset(const SoundStream: PSfmlSoundStream): TSfmlTime; cdecl;
begin
  Result.MicroSeconds := sfSoundStream_getPlayingOffset(SoundStream);
end;

function SfmlSoundGetPlayingOffset(const Sound: PSfmlSound): TSfmlTime; cdecl;
begin
  Result.MicroSeconds := sfSound_getPlayingOffset(Sound);
end;

function SfmlSoundBufferGetDuration(const SoundBuffer: PSfmlSoundBuffer): TSfmlTime; cdecl;
begin
  Result.MicroSeconds := sfSoundBuffer_getDuration(SoundBuffer);
end;
{$ENDIF}

{$IFDEF DynLink}
initialization

InitDLL;

finalization

FreeDLL;

{$ENDIF}
end.
