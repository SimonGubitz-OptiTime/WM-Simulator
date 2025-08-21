unit Verlosung;

interface

uses
  db,
  types,
  Animation,
  System.Classes, System.Math, System.SysUtils,
  Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Grids, Vcl.StdCtrls;

type TVerlosungUI = class
private
  FGrids: array[0..11] of TStringGrid;

  FInitialized: Boolean;
  FAnimation: TAnimations;

public
  property Initialized: Boolean read FInitialized;
  constructor Create(Grids: array of TStringGrid);

  procedure VerlosungStarten(var ATeamDB: TDB<TTeam>; ATimer: TTimer; AOwner: TComponent);

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

procedure TVerlosungUI.VerlosungStarten(var ATeamDB: TDB<TTeam>; ATimer: TTimer; AOwner: TComponent);
var
  grid, forCol: Integer;
  Teams: TArray<TTeam>;
  TeamArrayIndex: Integer;
  tempLabel: TLabel;
  // Stadien: TArray<TStadion>;
begin

  if not FInitialized then
    raise Exception.Create('TVerlosungUI.VerlosungStarten Error: The UI is not initialized.');

  // alle Stadien und Teams aus der DB laden
  Teams := ATeamDB.GetStructuredTableFromCSV();

  

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
        tempLabel := TLabel.Create(AOwner);
        with tempLabel do
        begin
          Caption := Teams[TeamArrayIndex].Name;
          Top := Round((FGrids[grid].Height / 2) - (Height / 2)); // Middle
          Left := Round((FGrids[grid].Width / 2) / (Width / 2));  // Middle
        end;

        FAnimation := TAnimations.Create(ATimer, tempLabel, FGrids[grid].Top, FGrids[grid].Left, 3000); // 3 sek
        FAnimation.MoveObject;

        tempLabel.Free;

        
        
      
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
