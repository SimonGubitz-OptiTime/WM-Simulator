unit clrUtils.TableFormating;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  Vcl.Grids,
  damTypes;

procedure SetColumnFullWidth(AGrid: TStringGrid; ACol: Integer);
procedure TabelleZeichnen(AGrid: TStringGrid; ARows: TObjectList<TList<String>> );
procedure TeamZeileZeichnen(AGrid: TStringGrid; const ATeam: TTeam; const ARow: Integer);

implementation

procedure SetColumnFullWidth(AGrid: TStringGrid; ACol: Integer);
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

procedure TabelleZeichnen(AGrid: TStringGrid; ARows: TObjectList<TList<String>>);
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

procedure TeamZeileZeichnen(AGrid: TStringGrid; const ATeam: TTeam; const ARow: Integer);
begin

  with AGrid do
  begin
    Cells[0, ARow] := ATeam.Name;
    case ATeam.TeamRanking of
      TTeamRanking.SehrStark:
        Cells[1, ARow] := 'Sehr Stark';
      TTeamRanking.Stark:
        Cells[1, ARow] := 'Stark';
      TTeamRanking.MittelStark:
        Cells[1, ARow] := 'Mittel Stark';
      TTeamRanking.Schwach:
        Cells[1, ARow] := 'Schwach Stark';
    end;

    Cells[2, ARow] := IntToStr(ATeam.ID);

    case ATeam.TeamVerband of
      TTeamVerband.AFC:
        Cells[3, ARow] := 'AFC';
      TTeamVerband.CAF:
        Cells[3, ARow] := 'CAF';
      TTeamVerband.CONCACAF:
        Cells[3, ARow] := 'CONCACAF';
      TTeamVerband.CONMEBOL:
        Cells[3, ARow] := 'CONMEBOL';
      TTeamVerband.OFC:
        Cells[3, ARow] := 'OFC';
      TTeamVerband.UEFA:
        Cells[3, ARow] := 'UEFA';
    end;
  end;
end;


end.
