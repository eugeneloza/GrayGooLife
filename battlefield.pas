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

unit BattleField;

interface

uses
  CastleTimeUtils,
  Sprites;

type
  TFieldRec = record
    Owner: TOwner;
    Age: integer;
    Shade: byte;
    ShadeSign: shortint;
  end;

type
  TBattleFieldArray = array of array of TFieldRec;

type
  TBattleField = class(TObject)
  strict private
    isInitialized: boolean;
    FArray: TBattleFieldArray;
    { return an epmty TBattleFieldArray }
    function ZeroArray(const aX, aY: integer): TBattleFieldArray;
    { cycle cell color }
    //procedure CycleCell(const aX, aY: integer);
    procedure DrawCell(const aX, aY: integer);
  public
    SizeX, SizeY: integer;
    { resizes FArray to (SizeX, SizeY) and resets all cells to ownerNone }
    procedure Clear;
    { process a game step }
    procedure NextTurn;
    { draw the game screen }
    procedure Draw;
  end;


var
  Life: TBattleField;
  DeltaTime: TFloatTime;

implementation
uses
  GooWindow;

procedure TBattleField.DrawCell(const aX, aY: integer);
var
  sx, sy, wx, wy: single;
begin
  sx := ax * Window.Width / SizeX;
  sy := ay * Window.Height / SizeY;
  wx := (ax+1) * Window.Width / SizeX - sx;
  wy := (ay+1) * Window.Height / SizeY - sy;
  EmptyCell.Draw(sx, sy, wx, wy);
  if FArray[aX, aY].Owner <> ownerNone then
  begin
    Cell[FArray[aX, aY].Owner].Update(DeltaTime);
    Cell[FArray[aX, aY].Owner].Draw(sx, sy, wx, wy);
  end;
end;

procedure TBattleField.Draw;
var
  ix, iy: integer;
begin
  for ix := 0 to Pred(SizeX) do
    for iy := 0 to Pred(SizeY) do
      DrawCell(ix, iy);
end;

function TBattleField.ZeroArray(const aX, aY: integer): TBattleFieldArray;
var
  ix: integer;
  iy: integer;
begin
  SetLength(Result, aX);
  for ix := 0 to Pred(aX) do
  begin
    SetLength(Result[ix], aY);
    for iy := 0 to Pred(aY) do
      Result[ix, iy].Owner := ownerNone;
  end;
end;

procedure TBattleField.NextTurn;
var
  tmpArray: TBattleFieldArray;
begin
  if isInitialized then
  begin
    tmpArray := ZeroArray(SizeX, SizeY);

    ///CycleCell(x,y);

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

