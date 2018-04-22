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

(* Figure that can be placed on the battlefield *)

{$INCLUDE compilerconfig.inc}

unit Figures;

interface

uses
  Shapes;

type
  { a figure drawable, draggable and placable on the battlefield }
  TFigure = object
    FArray: array of array of boolean;
    procedure Load(aShape: array of const);
  end;

implementation
procedure TFigure.Load(aShape: array of const);
begin

end;

end.

