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
  GooWindow, CastleWindow,
  SysUtils, CastleApplicationProperties, CastleLog, CastleTimeUtils,
  BattleField, Sprites;


procedure doRender(Container: TUIContainer);
begin
  DeltaTime := Window.Fps.SecondsPassed;

  if Life <> nil then
    Life.Draw;

  if TotalTime < 0 then
    TotalTime := 0;
  TotalTime += DeltaTime;
  if TotalTime > TurnTime then
  begin
    TotalTime := 0;
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

