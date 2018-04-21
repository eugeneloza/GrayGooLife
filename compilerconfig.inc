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

(* Compiler directives/options to include in every unit *)

{====================== PASCAL-SPECIFIC DIRECTIVES =========================}

//yes, I use this horrible stuff
{$WARN 2005 off : Comment level $1 found}

{$SMARTLINK ON} // Enable smart-linking

{$MODE objfpc}
{$H+} // AnsiStrings
{$J-} // non-writeable constants
{$COPERATORS ON} // allow += style operators, I like them
{$GOTO OFF} // Disallow goto and label

{ Use simple corba interfaces }
{$INTERFACES corba}

{ Can use definition of `procedure is nested` }
{$MODESWITCH nestedprocvars}

