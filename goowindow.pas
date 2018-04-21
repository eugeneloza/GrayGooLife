unit GooWindow;

interface

uses
  CastleWindow;

var
  { window that shows it all }
  Window: TCastleWindowCustom;

  { array for the game map }
  MapWidth: integer;
  MapHeight: integer;

{ init scale of the window }
procedure GetMapScale;
implementation

procedure GetMapScale;
begin
  MapWidth := Window.Height;
  MapHeight := Window.Height;
end;

end.

