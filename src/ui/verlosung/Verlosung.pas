unit Verlosung;

interface

uses
  db,
  types,
  Animation,
  Utils.ShuffleArray,
  System.Classes, System.Generics.Collections, System.Math, System.SysUtils,
  Vcl.Controls, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Forms, Vcl.Grids, Vcl.StdCtrls;

type TVerlosungUI = class
private
  FGrids: TObjectList<TStringGrid>;

  FInitialized: Boolean;
  FTeams: TList<TTeam>; // for the AnimationCallback

  // array due to multiple Grids
  FColSize: array[0..11] of Integer;
  FRowSize: array[0..11] of Integer;

  procedure AnimationCallbackFn(Count: Integer = -1; SecondCount: Integer = -1; ThirdCount: Integer = -1);

public
  property Initialized: Boolean read FInitialized;
  constructor Create(Grids: array of TStringGrid);

  function VerlosungStarten(var ATeamDB: TDB<TTeam>; ATimer: TTimer; AOwner: TControl): Boolean;

  destructor Destroy; override;
end;

implementation

constructor TVerlosungUI.Create(Grids: array of TStringGrid);
var
  i, j: Integer;
begin
  if Length(Grids) <> 12 then
    raise Exception.Create('TVerlosungUI.Create Error: There must be exactly 12 Grids.');

  FGrids := TObjectList<TStringGrid>.Create;

  for i := 0 to 11 do
  begin

    FColSize[i] := Floor(Grids[i].Width / Grids[i].ColCount) - 2;
    FRowSize[i] := Floor(Grids[i].Height / Grids[i].RowCount) - 2;

    for j := 0 to Grids[i].ColCount-1 do
    begin
      Grids[i].ColWidths[j] := FColSize[i];
    end;
    for j := 0 to Grids[i].RowCount-1 do
    begin
      Grids[i].RowHeights[j] := FRowSize[i];
    end;
    FGrids.Add(Grids[i]);
  end;

  FInitialized := true;

end;

function TVerlosungUI.VerlosungStarten(var ATeamDB: TDB<TTeam>; ATimer: TTimer; AOwner: TControl): Boolean;
var
  grid, forRow: Integer;
  TempLabel: TStaticText;
  TeamIndex: Integer;
  AnimationList: TObjectList<TAnimations>;
begin

  if not FInitialized then
  begin
    raise Exception.Create('TVerlosungUI.VerlosungStarten Error: The UI is not initialized.');
  end;

  if Assigned(TempLabel) then
  begin
    TempLabel := nil;
  end;

  try
    AnimationList := TObjectList<TAnimations>.Create;
    FTeams := ATeamDB.GetStructuredTableFromCSV();


    if ((FTeams.Count mod 4) <> 0) then
    begin
      raise Exception.Create('TVerlosungUI.VerlosungStarten Error: The number of FTeams must be divisible by 4.');
    end;
    if TeamIndex >= FTeams.Count then
    begin
      TeamIndex := 0;
    end;

    try

      // Teams gleichmäßig aufteilen
      // Schritt 1 - anhand des FTeams.TTeamRankings (enum) sortieren
      // Utils.ShuffleArray.TShuffleArrayUtils<TTeam>.SortByRanking(FTeams);

      // Schritt 2 - for i := 0 to High(FTeams) / 12 <- weil es 12 Teams gibt
      {while i := 0 to High(FTeams) / 12 do
      begin
        // Schritt 3 - Temp Team erstellen
        var TempTeam: TTeam := FTeams[i];
        TempTeam[i] := FTeams[i];

        i := i + 4; // 4 Teams pro Grid
      end;}

      // Schritt 3 - Teams mischen

      Utils.ShuffleArray.TShuffleArrayUtils<TTeam>.Shuffle(FTeams);

      // Für alle Grids je 4 Teams eintragen
      TeamIndex := 0;
      for grid := 0 to FGrids.Count - 1 do
      begin

        if (TeamIndex >= FTeams.Count) then
          break;


        with FGrids[grid] do
        begin

          for forRow := 0 to 3 do
          begin

            // hier die Animation
            TempLabel := TStaticText.Create(nil);

            {try}
              TempLabel.Parent    := AOwner as TWinControl;
              TempLabel.Caption   := FTeams[TeamIndex].Name;
              TempLabel.Top       := Round((AOwner.Height / 2) - (Height / 2)); // Middle
              TempLabel.Left      := Round((AOwner.Width / 2) - (Width / 2));   // Middle

              var MoveTop := FGrids[grid].Top + Round(TempLabel.Height / 2) + (forRow * FRowSize[grid]);

              AnimationList.Add(TAnimations.Create(ATimer, TControl(TempLabel), MoveTop, FGrids[grid].Left + 15, 600)); // .6 sek
              AnimationList.Last.MoveObject(AnimationCallbackFn, forRow, grid, TeamIndex);

              Inc(TeamIndex);
            {finally
                          TempLabel.Destroy;
                                      end;}
          end;
        end;
      end;
    finally
      AnimationList.Free;
    end;

    Result := true;

  except
    on E: Exception do
    begin
      ShowMessage('TVerlosungUI.VerlosungStarten Error: ' + E.Message);
      Exit(false);
    end;
  end;
end;

                                          // cols               // grids                   // teams
procedure TVerlosungUI.AnimationCallbackFn(Count: Integer = -1; SecondCount: Integer = -1; ThirdCount: Integer = -1);
begin

  if ((Count = -1) or (SecondCount = -1)) then
    raise Exception.Create('Fehlermeldung');

  // ShowMessage('Team: ' + FTeams[ThirdCount].Name);

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

    end;
  except
    on ERangeError do
    begin
      ShowMessage('ThirdCount: ' + IntToStr(ThirdCount));
    end;
  end;
end;

destructor TVerlosungUI.Destroy;
begin
  FGrids.Free;

  inherited Destroy;
end;

end.
