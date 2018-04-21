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

unit Sprites;

interface

uses
  CastleGLImages;

type
  {ownerNone is an empty cell
   ownerGray is a gray GrayGoo cell
   ownerGreen is a green player cell
   other owners are enemy AI cell }
  TOwner = (ownerNone, ownerGray, ownerGreen, ownerRed, ownerBlue, ownerViolet, ownerCyan, ownerYellow);

var
  Cell: Array[TOwner] of TSprite;
  EmptyCell: TGLImage;

procedure LoadSprites;
procedure FreeSprites;
implementation
uses
  SysUtils, CastleFilesUtils;

procedure LoadSprites;
var
  o: TOwner;
begin
  EmptyCell := TGlImage.Create(ApplicationData('Empty.png'));
  Cell[ownerGray] := TSprite.Create(ApplicationData('Goo.png'), 10, 10, 1, true, true, true);
  Cell[ownerGreen] := TSprite.Create(ApplicationData('Green.png'), 10, 10, 1, true, true, true);
  Cell[ownerRed] := TSprite.Create(ApplicationData('Red.png'), 10, 10, 1, true, true, true);
  Cell[ownerBlue] := TSprite.Create(ApplicationData('Blue.png'), 10, 10, 1, true, true, true);
  Cell[ownerViolet] := TSprite.Create(ApplicationData('Violet.png'), 10, 10, 1, true, true, true);
  Cell[ownerCyan] := TSprite.Create(ApplicationData('Cyan.png'), 10, 10, 1, true, true, true);
  Cell[ownerYellow] := TSprite.Create(ApplicationData('Yellow.png'), 10, 10, 1, true, true, true);
  for o in TOwner do
    if Cell[o] <> nil then
      Cell[o].FramesPerSecond := 10;
end;

procedure FreeSprites;
var
  o: TOwner;
begin
  FreeAndNil(EmptyCell);
  for o in TOwner do
    FreeAndNil(Cell[o]);
end;

end.

