unit Verlosung;

interface

uses
  db,
  types,
  System.Classes, System.Math, System.SysUtils,
  Vcl.Grids;

type TVerlosungUI = class
private
  FGrids: array[0..11] of TStringGrid;


public

  constructor Create(Grids: array of TStringGrid);

  procedure VerlosungStarten(var TeamDB: TDB<TTeam>);

//  destructor Free();
  
end;

implementation

constructor TVerlosungUI.Create(Grids: array of TStringGrid);
var
  i, j: Integer;
begin
  // do something...
  if High(Grids) <> 11 then
    raise Exception.Create('TVerlosungUI.Create Error: There must be exactly 12 Grids.');
  
  for i := 0 to 11 do
  begin
    for j := 0 to Grids[i].ColCount-1 do
    begin
      Grids[i].ColWidths[j] := Floor(Grids[i].Width / 4);
    end;
    
    FGrids[i] := Grids[i];
    
  end;
end;

procedure TVerlosungUI.VerlosungStarten(var TeamDB: TDB<TTeam>);
var
  j,i: Integer;
  Teams: TArray<TTeam>;
  // Stadien: TArray<TStadion>;
begin

  // alle Stadien und Teams aus der DB laden
  Teams := TeamDB.GetStructuredTableFromCSV();

  if ((Length(Teams) mod 4) <> 0) then
    raise Exception.Create('TVerlosungUI.VerlosungStarten Error: The number of teams must be divisible by 4.');
    

  // Teams shuffeln
  // Utils.ShuffleArray(Teams);

  // Für alle Grids je 4 Teams eintragen
  for i := Low(FGrids) to High(FGrids) do
  begin

    for j := i * 4 + 1 to i * 4 + 4 do
    begin
      FGrids[i].Cells[0, j] := Teams[j].Name;
      case Teams[j].TeamRanking of
        TTeamRanking.SehrStark:   FGrids[i].Cells[1, j] := 'Sehr Stark';
        TTeamRanking.Stark:       FGrids[i].Cells[1, j] := 'Stark';
        TTeamRanking.MittelStark: FGrids[i].Cells[1, j] := 'Mittel Stark';                
        TTeamRanking.Schwach:     FGrids[i].Cells[1, j] := 'Schwach Stark'
      end;

    end;



  end;


  //


end;

{destructor TVerlosungUI.Free();
begin
  //
  end;}

end.
