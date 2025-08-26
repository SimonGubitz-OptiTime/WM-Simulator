unit clrUtils.TableFormating;

interface

uses
  System.Generics.Collections, System.SysUtils,
  Vcl.Grids;

procedure SetColumnFullWidth(var AGrid: TStringGrid; ACol: Integer);
function TabelleZeichnen(var AGrid: TStringGrid;
  ARows: TObjectList < TList < String >> ): String;

implementation

procedure SetColumnFullWidth(var AGrid: TStringGrid; ACol: Integer);
var
  Ndx, StrWidth, ColWidth: Integer;
begin
  { set the width of the defined column in a string grid to the width of the widest string }
  StrWidth := 0;
  ColWidth := 0;
  for Ndx := 0 To AGrid.RowCount - 1 do
  begin
    // get the pixel width of the complete string
    ColWidth := AGrid.Canvas.TextWidth(AGrid.Cells[ACol, Ndx]);

    // if its greater, then put it in str_width
    if ( ColWidth > StrWidth ) then
    begin
      StrWidth := ColWidth;
    end;
  end;
  AGrid.ColWidths[ACol] := StrWidth + 35; // add some margins

end;

function TabelleZeichnen(var AGrid: TStringGrid;
  ARows: TObjectList < TList < String >> ): String;
var
  NdxRows, NdxCols: Integer;
begin
  AGrid.RowCount := ARows.Count;
  AGrid.ColCount := ARows[0].Count;

  for NdxRows := 0 to ARows.Count - 1 do
  begin
    AGrid.Cells[0, NdxRows + 1] := IntToStr(NdxRows + 1);
    for NdxCols := 0 to ARows[NdxRows].Count - 1 do
    begin
      SetColumnFullWidth(AGrid, NdxCols);
      AGrid.Cells[NdxCols + 1, NdxRows] := ARows[NdxRows][NdxCols];
    end;
  end;
end;

end.
