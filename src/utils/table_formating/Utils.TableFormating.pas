unit Utils.TableFormating;

interface
uses
  SysUtils,
  Vcl.Grids;

procedure SetColumnFullWidth(var Grid: TStringGrid; ACol: Integer);
function TabelleZeichnen(var Grid: TStringGrid; Rows: TArray<TArray<String>>): String;

implementation

procedure SetColumnFullWidth(var Grid: TStringGrid; ACol: Integer);
var
  I, StrWidth, ColWidth: Integer;
begin
  { set the width of the defined column in a string grid to the width of the widest string }
   StrWidth := 0;
   ColWidth := 0;
   for i := 0 To Grid.RowCount - 1 do
   begin
     // get the pixel width of the complete string
     ColWidth := Grid.Canvas.TextWidth(Grid.Cells[Acol, i]);

     // if its greater, then put it in str_width
     if ColWidth > StrWidth then
      StrWidth := ColWidth;
   end;
   Grid.ColWidths[Acol] := StrWidth + 35; // add some margins

end;

function TabelleZeichnen(var Grid: TStringGrid; Rows: TArray<TArray<String>>): String;
var
  i, j: Integer;
begin
      Grid.RowCount := Length(Rows);
      Grid.ColCount := Length(Rows[0])+1;


      for i := Low(Rows) to High(Rows) do
      begin
        Grid.Cells[0, i+1] := IntToStr(i+1);
        for j := Low(Rows[i]) to High(Rows[i]) do
        begin
//          SetColumnFullWidth(Grid, j);
          Grid.Cells[j+1, i] := Rows[i][j];
        end;
      end;
end;


end.
