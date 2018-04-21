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
  Global;

const
  CriticalAge = 3; //how many turns will pass before the cell will turn into goo

  TurnTime = 60/100/2; //in seconds

type
  TCellRec = record
    Owner: TOwner;
    Age: integer;
  end;

type
  TBattleFieldArray = array of array of TCellRec;

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
    { main procedure. Calculates the number of neighbours and
      result is what sort of cell it will be next turn (none or playerID)}
    function GetNeighbours(const aX, aY: integer): TOwner;
    { cell gets older }
    function GetOlder(const aCell: TCellRec): TCellRec;
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

implementation
uses
  CastleRandom, CastleVectors,
  GooWindow, Sprites, Player;

procedure TBattleField.DrawCell(const aX, aY: integer);
var
  sx, sy, wx, wy: single;
  AgeShade: single;
begin
  sx := ax * MapWidth / SizeX;
  sy := ay * MapHeight / SizeY;
  wx := (ax+1) * MapWidth / SizeX - sx;
  wy := (ay+1) * MapHeight / SizeY - sy;
  EmptyCell.Draw(sx, sy, wx, wy);
  if FArray[aX, aY].Owner <> ownerNone then
  begin
    AgeShade := CriticalAge / (sqrt(FArray[aX, aY].Age) + CriticalAge);
    if AgeShade < 0.5 then
      AgeShade := 0.5;

    Cell[FArray[aX, aY].Owner].Color := Vector4(AgeShade, AgeShade, AgeShade, 1.0);
    Cell[FArray[aX, aY].Owner].Draw(sx, sy, wx, wy);
  end;
end;

procedure TBattleField.Draw;
var
  ix, iy: integer;
  o: TOwner;
begin
  for o in TOwner do
    if Cell[o] <> nil then
      Cell[o].Update(DeltaTime);

  for ix := 0 to Pred(SizeX) do
    for iy := 0 to Pred(SizeY) do
      DrawCell(ix, iy);
end;

function TBattleField.ZeroArray(const aX, aY: integer): TBattleFieldArray;
var
  ix: integer;
  iy: integer;
  o: TOwner;
begin
  SetLength(Result, aX);
  for ix := 0 to Pred(aX) do
  begin
    SetLength(Result[ix], aY);
    for iy := 0 to Pred(aY) do
      Result[ix, iy].Owner := ownerNone
  end;

  o := ownerGreen;
  Result[20, 20].Owner := o;
  Result[21, 20].Owner := o;
  Result[22, 20].Owner := o;
  Result[21, 21].Owner := o;

  o := ownerRed;
  Result[25, 25].Owner := o;
  Result[26, 25].Owner := o;
  Result[27, 25].Owner := o;
  Result[26, 26].Owner := o;

  o := ownerBlue;
  Result[30, 22].Owner := o;
  Result[31, 22].Owner := o;
  Result[32, 22].Owner := o;
  Result[31, 23].Owner := o;

  o := ownerYellow;
  Result[14, 22].Owner := o;
  Result[15, 22].Owner := o;
  Result[16, 22].Owner := o;
  Result[15, 23].Owner := o;

  o := ownerCyan;
  Result[14, 17].Owner := o;
  Result[15, 17].Owner := o;
  Result[16, 17].Owner := o;
  Result[15, 18].Owner := o;
end;

{----------------------------------------------------------------------------}

function TBattleField.GetNeighbours(const aX, aY: integer): TOwner;
var
  dx, dy: integer;
  count: array[TOwner] of integer;
  o: TOwner;
  TotalNeighbours: integer;
  MaxCount: integer;
  Nearby: integer;
  BestOwner: TOwner;
  function GetCellSafe: TOwner;
  begin
    if (ax + dx >= 0) and (ax + dx < SizeX) and
       (ay + dy >= 0) and (ay + dy < SizeY) then
         Result := FArray[ax + dx, ay + dy].Owner
    else
      Result := ownerNone;
  end;
begin
  for o in TOwner do
    count[o] := 0;

  for dx := -1 to 1 do
    for dy := -1 to 1 do
      if (dx<>0) or (dy<>0) then
        inc(count[GetCellSafe]);

  TotalNeighbours := 0;
  for o in TOwner do
    if o <> ownerNone then
      inc(TotalNeighbours, count[o]);

  if (TotalNeighbours < 2) or (TotalNeighbours > 3) then
  begin
    Result := ownerNone; {cell dies}
    Exit;
  end;

  BestOwner := FArray[aX, aY].Owner;
  if BestOwner = ownerNone then
    BestOwner := ownerGray;

  if BestOwner = ownerGray then
    MaxCount := 0
  else
    MaxCount := 1; // owned cells are less likely to change ownership

  for o in TOwner do
    if (o <> ownerNone) and (o <> ownerGray) then
      if count[o] > MaxCount then
      begin
        MaxCount := count[o];
        BestOwner := o;
      end;

  Nearby := 0;
  for o in TOwner do
    if (o <> ownerNone) and (o <> ownerGray) and (count[o] > 0) then
      inc(Nearby);

  //birth
  if FArray[aX, aY].Owner = ownerNone then
  begin
    Result := ownerNone;
    if (TotalNeighbours = 3) then
    begin
      //determine new cell owner
      if (Nearby = 1) then
        Result := BestOwner  //if a single owner around, it will be his cell
      else
        Result := ownerGray; //otherwise it's a gray goo
    end;
    Exit;
  end;

  ///change of ownership
  if FArray[aX, aY].Owner = ownerGray then
  begin
    if Nearby = 1 then
      Result := BestOwner //if gray goo's neighbours are only one-colored it'll change ownership
    else
      Result := ownerGray; //otherwise it remains as is
  end
  else
  begin
    //it's a normal cell, most complex ownership mechanism.
    if MaxCount > 1 then
      Result := BestOwner //a cell can't resist two or three neighbours;
    else
      Result := FArray[aX, aY].Owner; //otherwise it persists
  end;
end;

function TBattleField.GetOlder(const aCell: TCellRec): TCellRec;
begin
  Result := aCell;
  inc(Result.Age);
  if (Result.Owner = ownerGray) or (Result.Owner = ownerNone) then
    Result.Age := 0;
end;

procedure TBattleField.NextTurn;
var
  tmpArray: TBattleFieldArray;
  ix, iy: integer;
begin
  if isInitialized then
  begin
    tmpArray := ZeroArray(SizeX, SizeY);

    //let the cells get older
    for ix := 0 to Pred(SizeX) do
      for iy := 0 to Pred(SizeY) do
      begin
        FArray[ix, iy] := GetOlder(FArray[ix, iy]);
        //if the cell is too old it'll turn into Goo
        //but will be revived if there are friends nearby
        if FArray[ix, iy].Age > CriticalAge then
          FArray[ix, iy].Owner := ownerGray;
      end;

    //now the main Life algorithm
    for ix := 0 to Pred(SizeX) do
      for iy := 0 to Pred(SizeY) do
      begin
        tmpArray[ix, iy] := FArray[ix, iy];
        tmpArray[ix, iy].Owner := GetNeighbours(ix, iy); //sets new ownership
      end;

    //FArray := nil;
    FArray := tmpArray;

    for ix := 0 to Pred(SizeX) do
      for iy := 0 to Pred(SizeY) do
        Players[FArray[ix, iy].Owner].Resource += 1;

  end;
end;

procedure TBattleField.Clear;
begin
  isInitialized := true;
  FArray := ZeroArray(SizeX, SizeY);
end;


end.

