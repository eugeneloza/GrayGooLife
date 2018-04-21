unit GooWindow;

interface

uses
  CastleWindow;

var
  Window: TCastleWindowCustom;

  MapWidth: integer;
  MapHeight: integer;

procedure GetMapScale;
implementation

procedure GetMapScale;
begin
  MapWidth := Window.Height;
  MapHeight := Window.Height;
end;

end.

