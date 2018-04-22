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

unit Global;

interface

uses
  CastleTimeUtils;

const
  SoundBeat = 60/100; {100bpm}

type
  {ownerNone is an empty cell
   ownerGray is a gray GrayGoo cell
   ownerGreen is a green player cell
   other owners are enemy AI cell }
  TOwner = (ownerNone, ownerGray, ownerGreen, ownerRed, ownerBlue, ownerViolet, ownerCyan, ownerYellow);

var
  { time variables for global use }
  DeltaTime: TFloatTime;
  TotalTime: TFloatTime;


implementation

end.

