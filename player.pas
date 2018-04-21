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

(* Management and drawing of the battlefield *)

{$INCLUDE compilerconfig.inc}

unit Player;

interface

uses
  Global;

type
  TPlayer = record
    Resource: single;
  end;

var
  { stores information on the players }
  Players: array [TOwner] of TPlayer;

//set all players to zero resources
procedure ResetPlayers;
implementation

procedure ResetPlayers;
var
  o: TOwner;
begin
  for o in TOwner do
  begin
    Players[o].Resource := 0;
  end;
end;

end.

