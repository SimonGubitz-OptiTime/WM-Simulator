unit Utils.TableFormating;

interface

uses
  System.Generics.Collections, System.SysUtils,
  Vcl.Grids;

procedure SetColumnFullWidth(var Grid: TStringGrid; ACol: Integer);
function TabelleZeichnen(var Grid: TStringGrid;
  Rows: TObjectList < TList < String >> ): String;

implementation

procedure SetColumnFullWidth(var Grid: TStringGrid; ACol: Integer);
var
  I, StrWidth, ColWidth: Integer;
begin
  { set the width of the defined column in a string grid to the width of the widest string }
  StrWidth := 0;
  ColWidth := 0;
  for I := 0 To Grid.RowCount - 1 do
  begin
    // get the pixel width of the complete string
    ColWidth := Grid.Canvas.TextWidth(Grid.Cells[ACol, I]);

    // if its greater, then put it in str_width
    if ColWidth > StrWidth then
      StrWidth := ColWidth;
  end;
  Grid.ColWidths[ACol] := StrWidth + 35; // add some margins

end;

function TabelleZeichnen(var Grid: TStringGrid;
  Rows: TObjectList < TList < String >> ): String;
var
  I, j: Integer;
begin
  Grid.RowCount := Rows.Count;
  Grid.ColCount := Rows[0].Count;

  for I := 0 to Rows.Count - 1 do
  begin
    Grid.Cells[0, I + 1] := IntToStr(I + 1);
    for j := 0 to Rows[I].Count - 1 do
    begin
      // SetColumnFullWidth(Grid, j);
      Grid.Cells[j + 1, I] := Rows[I][j];
    end;
  end;
end;

end.
