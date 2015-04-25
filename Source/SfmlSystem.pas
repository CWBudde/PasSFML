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

  TSfmlTime_Zero = function: TSfmlTime; cdecl;
  TSfmlTime_asSeconds = function (Time: TSfmlTime): Single; cdecl;
  TSfmlTime_asMilliseconds = function (Time: TSfmlTime): sfInt32; cdecl;
  TSfmlTime_asMicroseconds = function (Time: TSfmlTime): Int64; cdecl;
  TSfmlSeconds = function (Amount: Single): TSfmlTime; cdecl;

  TSfmlMilliseconds = function (Amount: sfInt32): TSfmlTime; cdecl;
  TSfmlMicroseconds = function (Amount: sfInt64): TSfmlTime; cdecl;

  TSfmlClock_create = function : PSfmlClock; cdecl;
  TSfmlClock_copy = function (const clock: PSfmlClock): PSfmlClock; cdecl;
  TSfmlClock_destroy = procedure (clock: PSfmlClock); cdecl;

  TSfmlClock_getElapsedTime = function (const clock: PSfmlClock): TSfmlTime; cdecl;
  TSfmlClock_restart = function (clock: PSfmlClock): TSfmlTime; cdecl;

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

  TSfmlMutex_create = function : PSfmlMutex; cdecl;
  TSfmlMutex_destroy = procedure (Mutex: PSfmlMutex); cdecl;

  TSfmlMutex_lock = procedure (Mutex: PSfmlMutex); cdecl;
  TSfmlMutex_unlock = procedure (Mutex: PSfmlMutex); cdecl;

  TSfmlSleep = procedure (duration: TSfmlTime); cdecl;

  TSfmlThread_create = function (FuncEntryPoint: Pointer; userData: Pointer): PSfmlThread; cdecl;
  TSfmlThread_destroy = procedure (Thread: PSfmlThread); cdecl;
  TSfmlThread_launch = procedure (Thread: PSfmlThread); cdecl;
  TSfmlThread_wait = procedure (Thread: PSfmlThread); cdecl;
  TSfmlThread_terminate = procedure (Thread: PSfmlThread); cdecl;

var
  SfmlTime_Zero: TSfmlTime_Zero;
  SfmlTime_asSeconds: TSfmlTime_asSeconds;
  SfmlTime_asMilliseconds: TSfmlTime_asMilliseconds;
  SfmlTime_asMicroseconds: TSfmlTime_asMicroseconds;
  SfmlSeconds: TSfmlSeconds;
  SfmlMilliseconds: TSfmlMilliseconds;
  SfmlMicroseconds: TSfmlMicroseconds;

  SfmlClock_create: TSfmlClock_create;
  SfmlClock_copy: TSfmlClock_copy;
  SfmlClock_destroy: TSfmlClock_destroy;
  SfmlClock_getElapsedTime: TSfmlClock_getElapsedTime;
  SfmlClock_restart: TSfmlClock_restart;

  SfmlMutex_create: TSfmlMutex_create;
  SfmlMutex_destroy: TSfmlMutex_destroy;
  SfmlMutex_lock: TSfmlMutex_lock;
  SfmlMutex_unlock: TSfmlMutex_unlock;

  SfmlSleep: TSfmlSleep;

  SfmlThread_create: TSfmlThread_create;
  SfmlThread_destroy: TSfmlThread_destroy;
  SfmlThread_launch: TSfmlThread_launch;
  SfmlThread_wait: TSfmlThread_wait;
  SfmlThread_terminate: TSfmlThread_terminate;

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
      SfmlTime_Zero := GetProcAddress(CSfmlSystemHandle, PAnsiChar('sfTime_Zero'));
      Assert(Assigned(SfmlTime_Zero));

      SfmlTime_asSeconds := GetProcAddress(CSfmlSystemHandle, PAnsiChar('sfTime_asSeconds'));
      Assert(Assigned(SfmlTime_asSeconds));

      SfmlTime_asMilliseconds := GetProcAddress(CSfmlSystemHandle, PAnsiChar('sfTime_asMilliseconds'));
      Assert(Assigned(SfmlTime_asMilliseconds));

      SfmlTime_asMicroseconds := GetProcAddress(CSfmlSystemHandle, PAnsiChar('sfTime_asMicroseconds'));
      Assert(Assigned(SfmlTime_asMicroseconds));

      SfmlSeconds := GetProcAddress(CSfmlSystemHandle, PAnsiChar('sfSeconds'));
      Assert(Assigned(SfmlSeconds));

      SfmlMilliseconds := GetProcAddress(CSfmlSystemHandle, PAnsiChar('sfMilliseconds'));
      Assert(Assigned(SfmlMilliseconds));

      SfmlMicroseconds := GetProcAddress(CSfmlSystemHandle, PAnsiChar('sfMicroseconds'));
      Assert(Assigned(SfmlMicroseconds));

      SfmlClock_create := GetProcAddress(CSfmlSystemHandle, PAnsiChar('sfClock_create'));
      Assert(Assigned(SfmlClock_create));

      SfmlClock_copy := GetProcAddress(CSfmlSystemHandle, PAnsiChar('sfClock_copy'));
      Assert(Assigned(SfmlClock_copy));

      SfmlClock_destroy := GetProcAddress(CSfmlSystemHandle, PAnsiChar('sfClock_destroy'));
      Assert(Assigned(SfmlClock_destroy));

      SfmlClock_getElapsedTime := GetProcAddress(CSfmlSystemHandle, PAnsiChar('sfClock_getElapsedTime'));
      Assert(Assigned(SfmlClock_getElapsedTime));

      SfmlClock_restart := GetProcAddress(CSfmlSystemHandle, PAnsiChar('sfClock_restart'));
      Assert(Assigned(SfmlClock_restart));

      SfmlMutex_create := GetProcAddress(CSfmlSystemHandle, PAnsiChar('sfMutex_create'));
      Assert(Assigned(SfmlMutex_create));

      SfmlMutex_destroy := GetProcAddress(CSfmlSystemHandle, PAnsiChar('sfMutex_destroy'));
      Assert(Assigned(SfmlMutex_destroy));

      SfmlMutex_lock := GetProcAddress(CSfmlSystemHandle, PAnsiChar('sfMutex_lock'));
      Assert(Assigned(SfmlMutex_lock));

      SfmlMutex_unlock := GetProcAddress(CSfmlSystemHandle, PAnsiChar('sfMutex_unlock'));
      Assert(Assigned(SfmlMutex_unlock));

      SfmlSleep := GetProcAddress(CSfmlSystemHandle, PAnsiChar('sfSleep'));
      Assert(Assigned(SfmlSleep));

      SfmlThread_create := GetProcAddress(CSfmlSystemHandle, PAnsiChar('sfThread_create'));
      Assert(Assigned(SfmlThread_create));

      SfmlThread_destroy := GetProcAddress(CSfmlSystemHandle, PAnsiChar('sfThread_destroy'));
      Assert(Assigned(SfmlThread_destroy));

      SfmlThread_launch := GetProcAddress(CSfmlSystemHandle, PAnsiChar('sfThread_launch'));
      Assert(Assigned(SfmlThread_launch));

      SfmlThread_wait := GetProcAddress(CSfmlSystemHandle, PAnsiChar('sfThread_wait'));
      Assert(Assigned(SfmlThread_wait));

      SfmlThread_terminate := GetProcAddress(CSfmlSystemHandle, PAnsiChar('sfThread_terminate'));
      Assert(Assigned(SfmlThread_terminate));
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
