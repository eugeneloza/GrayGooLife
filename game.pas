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
  CastleKeysMouse,
  CastleSoundEngine,
  CastleControls, CastleColors,//for UIFont
  CastleGLUtils,//for RenderContext
  BattleField, Sprites, Global, Player;

const MaxBeatZoom = 9;

var
  Buffer: TSoundBuffer;
  Sound: TSound;
  CurrentBeatZoom: integer = 4;
  NextBeat: array [0..MaxBeatZoom] of TFloatTime;
  NextTurn: boolean;

{ advance time at all beat levels }
procedure doTime;
var
  i: integer;
  function BeatMult(const aBeatNum: integer): single;
  begin
    if aBeatNum = 0 then
      Result := 2
    else
      Result := 1 / aBeatNum;
  end;
begin
  //init time and start playing music
  if TotalTime < 0 then
  begin
    for i := 0 to MaxBeatZoom do
      NextBeat[i] := SoundBeat * BeatMult(i);
    {if stop playing music we'll go off-sync, but that's a rare case so I don't care :)}
    Sound := SoundEngine.PlaySound(Buffer, false, true, 0, 1, 1, 1, Vector3(0,0,0));
    TotalTime := 0;
  end;

  //advance time by frame duration
  DeltaTime := Window.Fps.SecondsPassed;
  TotalTime += DeltaTime;

  {despite changing time flow speed, action would always be in sync with music
   all beats go sync to SoundBeat }
  NextTurn := false;
  for i := 0 to MaxBeatZoom do
    if TotalTime > NextBeat[i] then
    begin
      NextBeat[i] += SoundBeat * BeatMult(i);
      if i = CurrentBeatZoom then
        NextTurn := true;
    end;

end;

procedure doRender(Container: TUIContainer);
begin
  RenderContext.Clear([cbColor], Black);

  DoTime;

  if Life <> nil then
  begin
    Life.Draw;
    if NextTurn then
      Life.NextTurn;
  end;

  //ui
  UIFont.Print(MapWidth+10, 0, White, 'Resource: ' + IntToSTr(Round(Players[ownerGreen].Resource)));
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

