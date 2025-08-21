unit Verlosung;

interface

uses
  db,
  types,
  Animation,
  Utils.ShuffleArray,
  System.Classes, System.Generics.Collections, System.Math, System.SysUtils,
  Vcl.Controls, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Grids, Vcl.StdCtrls;

type TVerlosungUI = class
private
  FGrids: array[0..11] of TStringGrid;

  FInitialized: Boolean;
  FTeams: TArray<TTeam>; // for the AnimationCallback

  procedure AnimationCallbackFn(Count: Integer = -1; SecondCount: Integer = -1; ThirdCount: Integer = -1);

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
  grid, forRow: Integer;
  TempLabel: TLabel;
  TeamIndex: Integer;
  AnimationList: TList<TAnimations>;
begin

  AnimationList := TList<TAnimations>.Create;

  if not FInitialized then
    raise Exception.Create('TVerlosungUI.VerlosungStarten Error: The UI is not initialized.');

  // alle Stadien und Teams aus der DB laden
  FTeams := ATeamDB.GetStructuredTableFromCSV();

  

  if ((Length(FTeams) mod 4) <> 0) then
    raise Exception.Create('TVerlosungUI.VerlosungStarten Error: The number of FTeams must be divisible by 4.');
    

  // Teams shuffeln
  Utils.ShuffleArray.TShuffleArrayUtils<TTeam>.Shuffle(FTeams);

  // Für alle Grids je 4 Teams eintragen
  TeamIndex := 0;
  for grid := Low(FGrids) to High(FGrids) do
  begin

    if (TeamIndex >= Length(FTeams)) then
      break;

  
    with FGrids[grid] do
    begin

      for forRow := 0 to 3 do
      begin

        // hier die Animation
        TempLabel := TLabel.Create(AOwner);
        with TempLabel do
        begin
          Parent  := AOwner as TWinControl;
          Caption := FTeams[TeamIndex].Name;
          Top     := Round((FGrids[grid].Height / 2) - (Height / 2)); // Middle
          Left    := Round((FGrids[grid].Width / 2) - (Width / 2));   // Middle
        end;

        AnimationList.Add(TAnimations.Create(ATimer, TempLabel, FGrids[grid].Top, FGrids[grid].Left, 3)); // 3 sek
        AnimationList.Last.MoveObject(AnimationCallbackFn, forRow, grid, TeamIndex);
      end;
    end;
  end;

  AnimationList.Free;
end;

                                          // cols               // grids                   // teams 
procedure TVerlosungUI.AnimationCallbackFn(Count: Integer = -1; SecondCount: Integer = -1; ThirdCount: Integer = -1);
begin

  if ((Count = -1) or (SecondCount = -1)) then
    raise Exception.Create('Fehlermeldung');

  try
    with FGrids[SecondCount] do
    begin
      // Hier können weitere Aktionen nach der Animation erfolgen, z.B.:
      Cells[0, Count] := FTeams[ThirdCount].Name;
      case FTeams[ThirdCount].TeamRanking of
        TTeamRanking.SehrStark:   Cells[1, Count] := 'Sehr Stark';
        TTeamRanking.Stark:       Cells[1, Count] := 'Stark';
        TTeamRanking.MittelStark: Cells[1, Count] := 'Mittel Stark';
        TTeamRanking.Schwach:     Cells[1, Count] := 'Schwach Stark';
      end;


      Cells[2, Count] := IntToStr(FTeams[ThirdCount].HistorischeWMSiege);

      case FTeams[ThirdCount].TeamVerband of
        TTeamVerband.AFC:       Cells[3, Count] := 'AFC';
        TTeamVerband.CAF:       Cells[3, Count] := 'CAF';
        TTeamVerband.CONCACAF:  Cells[3, Count] := 'CONCACAF';
        TTeamVerband.CONMEBOL:  Cells[3, Count] := 'CONMEBOL';
        TTeamVerband.OFC:       Cells[3, Count] := 'OFC';
        TTeamVerband.UEFA:      Cells[3, Count] := 'UEFA';
      end;

      Inc(ThirdCount);

    end;
  except
    on ERangeError do
    begin
      ShowMessage('ThirdCount: ' + IntToStr(ThirdCount));
    end;
  end;
end;

{destructor TVerlosungUI.Free();
begin
  //
  end;}

end.
