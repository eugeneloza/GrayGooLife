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

(* Predefined shapes than can be assigned to Figures *)

{$INCLUDE compilerconfig.inc}

unit Shapes;

interface

{ basic game shapes placable on the battlefield
  reference of array indexes is inverse: Y-X }
const
  { a main attack force, cheap and small
    Flight speed: 1 tile per 4 turns diagonal}
  Glider: array [0..2,0..2] of byte = ((0,1,0),(0,0,1),(1,1,1));
  { a main power generator
    Period : 2}
  SolarPanel: array [0..0,0..2] of byte = ((1,1,1));
  { main productive force with 4 solar panels
    Unwraps in 9 turns}
  SolarArray: array [0..1,0..2] of byte = ((0,1,0),(1,1,1));
  { a powerful core with 4 (1/3 effective) solar panels
    Unwraps in 26 turns
    Period: 3 }
  BaseUnpacker: array [0..4,0..4] of byte =
    ((1, 0, 1, 0, 1),
     (1, 0, 0, 0, 1),
     (1, 0, 0, 0, 1),
     (1, 0, 0, 0, 1),
     (1, 0, 1, 0, 1));
  { a powerful attack unit
    Flight speed: 2 tiles per 4 turns rectagonal }
  LWSS: array [0..3,0..4] of byte =
    ((0, 1, 1, 1, 1),
     (1, 0, 0, 0, 1),
     (0, 0, 0, 0, 1),
     (1, 0, 0, 1, 0));

  { Large oscillator (with a few solar panels) }
  Line10: array [0..0,0..9] of byte = ((1,1,1,1,1,1,1,1,1,1));

  { extreme attack force for the enemy
    Fires sequential gliders (first one at turn 73) each 32 turns }
  GosperGun: array [0..14,0..37] of byte =
    ((0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,1,1,0,0),
     (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,1,1,0,0),
     (1,1,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
     (1,1,0,0,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
     (0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
     (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
     (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
     (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0),
     (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1),
     (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0),
     (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
     (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
     (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0),
     (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0),
     (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0));

implementation

end.

