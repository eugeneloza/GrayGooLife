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

unit BattleField;

{$mode objfpc}{$H+}

interface

uses
  CastleGLImages;

type
  {ownerNone is an empty cell
   ownerPlayer is a green player cell
   ownerGrayGoo is a gray GrayGoo cell
   ownerAI is enemy AI cell }
  TOwner = (ownerNone, ownerPlayer, ownerGrayGoo, ownerAI);

type
  TFieldRec = record
    Owner: TOwner;
    Age: integer;
  end;

type
  TBattleFieldArray = array of array of TFieldRec;

type
  TBattleField = class(TObject)
  strict private
    isInitialized: boolean;
    FArray: TBattleFieldArray;
    function ZeroArray(const aX, aY: integer): TBattleFieldArray;
  public
    SizeX, SizeY: integer;
    { resizes FArray to (SizeX, SizeY) and resets all cells to ownerNone }
    procedure Clear;
    procedure NextTurn;
  end;


procedure DrawBattleField;
implementation

procedure DrawBattleField;
begin

end;

function TBattleField.ZeroArray(const aX, aY: integer): TBattleFieldArray;
var
  ix, iy: integer;
begin
  SetLength(Result, aX);
  for ix := 0 to Pred(aX) do
  begin
    SetLength(Result[ix], aY);
  end;
end;

procedure TBattleField.NextTurn;
var
  tmpArray: TBattleFieldArray;
begin
  if isInitialized then
  begin
    tmpArray := ZeroArray(SizeX, SizeY);


    //FArray := nil;
    FArray := tmpArray;
  end;
end;

procedure TBattleField.Clear;
begin
  isInitialized := true;
  FArray := ZeroArray(SizeX, SizeY);
end;


end.

