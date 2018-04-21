{Copyright (C) 2018 Yevhen Loza

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program. If not, see <http://www.gnu.org/licenses/>.}

{---------------------------------------------------------------------------}

(* Core file, managing input/output *)

{$INCLUDE compilerconfig.inc}

unit Game;

interface



implementation

uses
  GooWindow, CastleWindow, CastleVectors, CastleFilesUtils,
  SysUtils, CastleApplicationProperties, CastleLog, CastleTimeUtils,
  CastleSoundEngine,
  BattleField, Sprites, Global;

const
  SoundBeat = 60/100/2; {100bpm}

var
  Buffer: TSoundBuffer;
  NextBeat: TFloatTime;

procedure doRender(Container: TUIContainer);
begin
  DeltaTime := Window.Fps.SecondsPassed;

  if Life <> nil then
    Life.Draw;

  if TotalTime < 0 then
  begin
    NextBeat := SoundBeat;
    //SoundEngine.PlaySound(Buffer, false, true, 0, 1, 1, 1, Vector3(0,0,0));
    TotalTime := 0;
  end;
  TotalTime += DeltaTime;
  if TotalTime > NextBeat then
  begin
    NextBeat += SoundBeat;
    Life.NextTurn;
  end;

end;

{---------------------------------------------------------------------------}

function GetApplicationName: string;
begin
  Result := 'Gray Goo Life';
end;

procedure ApplicationInitialize;
begin
  Window.OnRender := @doRender;
  Window.DoubleBuffer := true;
  Window.ResizeAllowed := raOnlyAtOpen;
  GetMapScale;
  LoadSprites;

  SoundEngine.MinAllocatedSources := 1;
  Buffer := SoundEngine.LoadBuffer(ApplicationData('Evasion_[LOOP]_CC-BY_by_Matthew_Pablo.ogg'));

  Life := TBattleField.Create;
  Life.SizeX := 40;
  Life.SizeY := 40;
  Life.Clear;
  TotalTime := -1;
end;

procedure InitAll;
begin
  InitializeLog(nil, ltTime);
  ApplicationProperties(true).ApplicationName := GetApplicationName;
  OnGetApplicationName := @GetApplicationName;
  Window := TCastleWindowCustom.Create(Application);
  Application.MainWindow := Window;
  Application.OnInitialize := @ApplicationInitialize;
  Window.Caption := GetApplicationName;
end;

procedure FreeAll;
begin
  FreeSprites;
  FreeAndNil(Life);
end;

initialization
  InitAll;

finalization
  FreeAll;

end.

