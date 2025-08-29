unit clrUtils.TableFormating;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  Vcl.Grids,
  damTypes;

procedure SetColumnFullWidth(AGrid: TStringGrid; ACol: Integer);
procedure VolleTabelleZeichnen(AGrid: TStringGrid; ARows: TObjectList<TList<String>> );
procedure TeamZeileZeichnen(AGrid: TStringGrid; const ATeam: TTeam; const ARow: Integer);
procedure TeamTabelleZeichnen(AGrid: TStringGrid; const AGroup: TGruppe);
procedure TabelleLeeren(AGrid: TStringGrid);

implementation

procedure SetColumnFullWidth(AGrid: TStringGrid; ACol: Integer);
var
  Ndx, StrWidth, ColWidth: Integer;
begin
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

procedure VolleTabelleZeichnen(AGrid: TStringGrid; ARows: TObjectList<TList<String>>);
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

    Cells[2, ARow] := IntToStr(ATeam.HistorischeWMSiege);

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

procedure TeamTabelleZeichnen(AGrid: TStringGrid; const AGroup: TGruppe);
var
  Ndx: Integer;
begin
  for Ndx := 0 to AGroup.Count - 1 do
  begin
    TeamZeileZeichnen(AGrid, AGroup[Ndx], Ndx);
  end;
end;

// O(n) n = Anzahl der Zellen
procedure TabelleLeeren(AGrid: TStringGrid);
var
  NdxRows, NdxCols: Integer;
begin
  for NdxRows := 0 to AGrid.RowCount - 1 do
  begin
    for NdxCols := 0 to AGrid.ColCount - 1 do
    begin
      AGrid.Cells[NdxCols, NdxRows] := '';
    end;
  end;
end;

end.
