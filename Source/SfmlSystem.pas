unit SfmlSystem;

////////////////////////////////////////////////////////////
//
// SFML - Simple and Fast Multimedia Library
// Copyright (C) 2007-2015 Laurent Gomila (laurent@sfml-dev.org)
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

uses
  Windows;

{$I SFML.inc}

//{$include <SFML/Config.h>}
  
const
  CSFML_VERSION_MAJOR = 2;
  CSFML_VERSION_MINOR = 2;
  CSFML_VERSION_PATCH = 0;

  sfFalse = 0;
  sfTrue = 1;

type
  sfBool = LongInt;
  sfInt8 = ShortInt;
  sfUint8 = Byte;
  sfInt16 = SmallInt;
  sfUint16 = Word;
  sfInt32 = LongInt;
  sfUint32 = Cardinal;
  sfInt64 = Int64;
  sfUint64 = UInt64;

  PSfmlClock = Pointer;
  PSfmlMutex = Pointer;
  PSfmlThread = Pointer;

  TSfmlTime = record
    MicroSeconds: Int64;
  end;

  TSfmlVector2i = record
    X, Y: LongInt;
  end;

  TSfmlVector2u = record
    X, Y: Cardinal;
  end;

  TSfmlVector2f = record
    X, Y : Single;
  end;

  TSfmlVector3f = record
    X, Y, Z: Single;
  end;

  TSfmlTimeZero = function: TSfmlTime; cdecl;
  TSfmlTimeAsSeconds = function (Time: TSfmlTime): Single; cdecl;
  TSfmlTimeAsMilliseconds = function (Time: TSfmlTime): sfInt32; cdecl;
  TSfmlTimeAsMicroseconds = function (Time: TSfmlTime): Int64; cdecl;
  TSfmlSeconds = function (Amount: Single): TSfmlTime; cdecl;

  TSfmlMilliseconds = function (Amount: sfInt32): TSfmlTime; cdecl;
  TSfmlMicroseconds = function (Amount: sfInt64): TSfmlTime; cdecl;

  TSfmlClockCreate = function : PSfmlClock; cdecl;
  TSfmlClockCopy = function (const clock: PSfmlClock): PSfmlClock; cdecl;
  TSfmlClockDestroy = procedure (clock: PSfmlClock); cdecl;

  TSfmlClockGetElapsedTime = function (const clock: PSfmlClock): TSfmlTime; cdecl;
  TSfmlClockRestart = function (clock: PSfmlClock): TSfmlTime; cdecl;

  TSfmlInputStreamReadFunc = function (data: pointer; size: sfInt64; userData: pointer): sfInt64; cdecl;
  TSfmlInputStreamSeekFunc = function (position: sfInt64; userData: pointer): sfInt64; cdecl;
  TSfmlInputStreamTellFunc = function (userData: pointer): sfInt64; cdecl;
  TSfmlInputStreamGetSizeFunc = function (userData: pointer): sfInt64; cdecl;

  TSfmlInputStream = record
    Read: TSfmlInputStreamReadFunc;
    Seek: TSfmlInputStreamSeekFunc;
    Tell: TSfmlInputStreamTellFunc;
    GetSize: TSfmlInputStreamGetSizeFunc;
    UserData: Pointer;
  end;

  TSfmlMutexCreate = function : PSfmlMutex; cdecl;
  TSfmlMutexDestroy = procedure (Mutex: PSfmlMutex); cdecl;

  TSfmlMutexLock = procedure (Mutex: PSfmlMutex); cdecl;
  TSfmlMutexUnlock = procedure (Mutex: PSfmlMutex); cdecl;

  TSfmlSleep = procedure (duration: TSfmlTime); cdecl;

  TSfmlThreadCreate = function (FuncEntryPoint: Pointer; userData: Pointer): PSfmlThread; cdecl;
  TSfmlThreadDestroy = procedure (Thread: PSfmlThread); cdecl;
  TSfmlThreadLaunch = procedure (Thread: PSfmlThread); cdecl;
  TSfmlThreadWait = procedure (Thread: PSfmlThread); cdecl;
  TSfmlThreadTerminate = procedure (Thread: PSfmlThread); cdecl;

var
  SfmlTimeZero: TSfmlTimeZero;
  SfmlTimeAsSeconds: TSfmlTimeAsSeconds;
  SfmlTimeAsMilliseconds: TSfmlTimeAsMilliseconds;
  SfmlTimeAsMicroseconds: TSfmlTimeAsMicroseconds;
  SfmlSeconds: TSfmlSeconds;
  SfmlMilliseconds: TSfmlMilliseconds;
  SfmlMicroseconds: TSfmlMicroseconds;

  SfmlClockCreate: TSfmlClockCreate;
  SfmlClockCopy: TSfmlClockCopy;
  SfmlClockDestroy: TSfmlClockDestroy;
  SfmlClockGetElapsedTime: TSfmlClockGetElapsedTime;
  SfmlClockRestart: TSfmlClockRestart;

  SfmlMutexCreate: TSfmlMutexCreate;
  SfmlMutexDestroy: TSfmlMutexDestroy;
  SfmlMutexLock: TSfmlMutexLock;
  SfmlMutexUnlock: TSfmlMutexUnlock;

  SfmlSleep: TSfmlSleep;

  SfmlThreadCreate: TSfmlThreadCreate;
  SfmlThreadDestroy: TSfmlThreadDestroy;
  SfmlThreadLaunch: TSfmlThreadLaunch;
  SfmlThreadWait: TSfmlThreadWait;
  SfmlThreadTerminate: TSfmlThreadTerminate;

implementation

var
  CSfmlSystemHandle: HINST;
{$IF Defined(MSWINDOWS)}
  CSfmlSystemLibrary: PAnsiChar = 'csfml-system-2.dll';
{$ELSEIF Defined(DARWIN)}
  error, not yet defined
{$ELSEIF Defined(UNIX)}
  error, not yet defined
{$IFEND}

procedure InitDLL;
begin
  CSfmlSystemHandle := LoadLibraryA(CSfmlSystemLibrary);
  if CSfmlSystemHandle <> 0 then
    try
      SfmlTimeZero := GetProcAddress(CSfmlSystemHandle, PAnsiChar('sfTime_Zero'));
      Assert(Assigned(SfmlTimeZero));

      SfmlTimeAsSeconds := GetProcAddress(CSfmlSystemHandle, PAnsiChar('sfTime_asSeconds'));
      Assert(Assigned(SfmlTimeAsSeconds));

      SfmlTimeAsMilliseconds := GetProcAddress(CSfmlSystemHandle, PAnsiChar('sfTime_asMilliseconds'));
      Assert(Assigned(SfmlTimeAsMilliseconds));

      SfmlTimeAsMicroseconds := GetProcAddress(CSfmlSystemHandle, PAnsiChar('sfTime_asMicroseconds'));
      Assert(Assigned(SfmlTimeAsMicroseconds));

      SfmlSeconds := GetProcAddress(CSfmlSystemHandle, PAnsiChar('sfSeconds'));
      Assert(Assigned(SfmlSeconds));

      SfmlMilliseconds := GetProcAddress(CSfmlSystemHandle, PAnsiChar('sfMilliseconds'));
      Assert(Assigned(SfmlMilliseconds));

      SfmlMicroseconds := GetProcAddress(CSfmlSystemHandle, PAnsiChar('sfMicroseconds'));
      Assert(Assigned(SfmlMicroseconds));

      SfmlClockCreate := GetProcAddress(CSfmlSystemHandle, PAnsiChar('sfClock_create'));
      Assert(Assigned(SfmlClockCreate));

      SfmlClockCopy := GetProcAddress(CSfmlSystemHandle, PAnsiChar('sfClock_copy'));
      Assert(Assigned(SfmlClockCopy));

      SfmlClockDestroy := GetProcAddress(CSfmlSystemHandle, PAnsiChar('sfClock_destroy'));
      Assert(Assigned(SfmlClockDestroy));

      SfmlClockGetElapsedTime := GetProcAddress(CSfmlSystemHandle, PAnsiChar('sfClock_getElapsedTime'));
      Assert(Assigned(SfmlClockGetElapsedTime));

      SfmlClockRestart := GetProcAddress(CSfmlSystemHandle, PAnsiChar('sfClock_restart'));
      Assert(Assigned(SfmlClockRestart));

      SfmlMutexCreate := GetProcAddress(CSfmlSystemHandle, PAnsiChar('sfMutex_create'));
      Assert(Assigned(SfmlMutexCreate));

      SfmlMutexDestroy := GetProcAddress(CSfmlSystemHandle, PAnsiChar('sfMutex_destroy'));
      Assert(Assigned(SfmlMutexDestroy));

      SfmlMutexLock := GetProcAddress(CSfmlSystemHandle, PAnsiChar('sfMutex_lock'));
      Assert(Assigned(SfmlMutexLock));

      SfmlMutexUnlock := GetProcAddress(CSfmlSystemHandle, PAnsiChar('sfMutex_unlock'));
      Assert(Assigned(SfmlMutexUnlock));

      SfmlSleep := GetProcAddress(CSfmlSystemHandle, PAnsiChar('sfSleep'));
      Assert(Assigned(SfmlSleep));

      SfmlThreadCreate := GetProcAddress(CSfmlSystemHandle, PAnsiChar('sfThread_create'));
      Assert(Assigned(SfmlThreadCreate));

      SfmlThreadDestroy := GetProcAddress(CSfmlSystemHandle, PAnsiChar('sfThread_destroy'));
      Assert(Assigned(SfmlThreadDestroy));

      SfmlThreadLaunch := GetProcAddress(CSfmlSystemHandle, PAnsiChar('sfThread_launch'));
      Assert(Assigned(SfmlThreadLaunch));

      SfmlThreadWait := GetProcAddress(CSfmlSystemHandle, PAnsiChar('sfThread_wait'));
      Assert(Assigned(SfmlThreadWait));

      SfmlThreadTerminate := GetProcAddress(CSfmlSystemHandle, PAnsiChar('sfThread_terminate'));
      Assert(Assigned(SfmlThreadTerminate));
    except
      FreeLibrary(CSfmlSystemHandle);
      CSfmlSystemHandle := 0;
    end;
end;

procedure FreeDLL;
begin
  if CSfmlSystemHandle <> 0 then
    FreeLibrary(CSfmlSystemHandle);
end;

initialization

InitDLL;

finalization

FreeDLL;

end.
