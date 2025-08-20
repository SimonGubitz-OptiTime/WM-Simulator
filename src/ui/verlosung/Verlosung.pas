unit Verlosung;

interface

uses
  db,
  types,
  System.Classes, System.Math, System.SysUtils,
  Vcl.Grids, Vcl.Dialogs;

type TVerlosungUI = class
private
  FGrids: array[0..11] of TStringGrid;

  FInitialized: Boolean;

public
  property Initialized: Boolean read FInitialized;
  constructor Create(Grids: array of TStringGrid);

  procedure VerlosungStarten(var TeamDB: TDB<TTeam>);

//  destructor Free();
  
end;

implementation

constructor TVerlosungUI.Create(Grids: array of TStringGrid);
var
  i, j: Integer;
begin
  if Length(Grids) <> 12 then
    raise Exception.Create('TVerlosungUI.Create Error: There must be exactly 12 Grids.');
  
  for i := 0 to 11 do
  begin
    for j := 0 to Grids[i].ColCount-1 do
    begin
      Grids[i].ColWidths[j] := Floor(Grids[i].Width / 4) - 2;
    end;
    for j := 0 to Grids[i].RowCount-1 do
    begin
      Grids[i].RowHeights[j] := Floor(Grids[i].Height / 4) - 2;
    end;
    
    FGrids[i] := Grids[i];
  end;

  FInitialized := true;
  
end;

procedure TVerlosungUI.VerlosungStarten(var TeamDB: TDB<TTeam>);
var
  grid, forCol: Integer;
  Teams: TArray<TTeam>;
  TeamArrayIndex: Integer;
  // Stadien: TArray<TStadion>;
begin

  if not FInitialized then
    raise Exception.Create('TVerlosungUI.VerlosungStarten Error: The UI is not initialized.');

  // alle Stadien und Teams aus der DB laden
  Teams := TeamDB.GetStructuredTableFromCSV();

  

  if ((Length(Teams) mod 4) <> 0) then
    raise Exception.Create('TVerlosungUI.VerlosungStarten Error: The number of teams must be divisible by 4.');
    

  // Teams shuffeln
  // Utils.ShuffleArray(Teams);

  // Für alle Grids je 4 Teams eintragen
  TeamArrayIndex := 0;
  for grid := Low(FGrids) to High(FGrids) do
  begin

    if (TeamArrayIndex >= Length(Teams)) then
      break;

  
    with FGrids[grid] do
    begin

      for forCol := 0 to 3 do
      begin

        // hier die Animation
        // TLabel NUR mit Teams[TeamArrayIndex].Name
        // tempLabel := TLabel.Create();
        // tempLabel.Caption := Teams[TeamArrayIndex].Name;
        
        // procedure Animation.MoveObject(TObject);
        Animation.MoveObject(tempLabel, 3000); // 3sek


        // tempLabel.Free;

        
        
      
        Cells[0, forCol] := Teams[TeamArrayIndex].Name;
        case Teams[TeamArrayIndex].TeamRanking of
          TTeamRanking.SehrStark:   Cells[1, forCol] := 'Sehr Stark';
          TTeamRanking.Stark:       Cells[1, forCol] := 'Stark';
          TTeamRanking.MittelStark: Cells[1, forCol] := 'Mittel Stark';                
          TTeamRanking.Schwach:     Cells[1, forCol] := 'Schwach Stark';
        end;


        Cells[2, forCol] := IntToStr(Teams[TeamArrayIndex].HistorischeWMSiege);

        case Teams[TeamArrayIndex].TeamVerband of
          TTeamVerband.AFC:       Cells[3, forCol] := 'AFC';
          TTeamVerband.CAF:       Cells[3, forCol] := 'CAF';
          TTeamVerband.CONCACAF:  Cells[3, forCol] := 'CONCACAF';
          TTeamVerband.CONMEBOL:  Cells[3, forCol] := 'CONMEBOL';
          TTeamVerband.OFC:       Cells[3, forCol] := 'OFC';
          TTeamVerband.UEFA:      Cells[3, forCol] := 'UEFA';
        end;

        // hinzufügen zweiter counter
        Inc(TeamArrayIndex);
        
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
