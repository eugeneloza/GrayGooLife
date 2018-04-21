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

(* Init file of the game. Here everything starts. *)


{$INCLUDE compilerconfig.inc}

unit Game;

interface

uses
  CastleWindow;

var
  Window: TCastleWindowCustom;

implementation

uses
  SysUtils, CastleApplicationProperties, CastleLog;


procedure doRender(Container: TUIContainer);
begin

end;

{---------------------------------------------------------------------------}

function GetApplicationName: string;
begin
  Result := 'Gray Goo Life';
end;

procedure ApplicationInitialize;
begin
  Window.OnRender := doRender;

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

end;

initialization
  InitAll;

finalization
  FreeAll;

end.

