unit clrGruppenphaseUI;

interface

uses
  System.Generics.Collections,
  System.SysUtils,
  System.Math,
  Vcl.Dialogs,
  Vcl.Graphics,
  Vcl.Grids,
  Vcl.StdCtrls,
  damTypes,
  clrState,
  clrSimulation,
  clrUtils.SortHashMap,
  clrUtils.TableFormating,
  clrUtils.StringFormating,
  clrUtils.UpdateStandings;


type TGruppenphaseUI = class
  private

    FState: IState;
    FSimulation: TSimulation;
    FGrid: TStringGrid;
    FMatches: TList<TPair<Byte, Byte>>; // sortierbare TDictionary implementierung, mit mehreren gleichen Keys
    FCurrentGroup: TGruppe;
    FGruppenphaseLabels: TArray<TLabel>;
    FSechzehntelfinaleLabels: TArray<TLabel>;


    procedure CallbackSimulation(Sender: TObject; ASpielIDs: TSpiel; ASpielIDsIDs: TSpielIDs);

  public
    constructor Create(AGruppenphaseGrid: TStringGrid; AGruppenphaseLabels: TArray<TLabel>; ASechzehntelfinaleLabels: TArray<TLabel>; const AState: IState);
    destructor Destroy; override;

    procedure Starten(ASpielIDs: TSpielIDs; AGruppe: TGruppe; ANdx: Integer);

  end;

implementation

constructor TGruppenphaseUI.Create(AGruppenphaseGrid: TStringGrid; AGruppenphaseLabels: TArray<TLabel>; ASechzehntelfinaleLabels: TArray<TLabel>; const AState: IState);
var
  j: Integer;
begin
  FState := AState;
  FGrid := AGruppenphaseGrid;
  FSimulation := TSimulation.Create;
  FGruppenphaseLabels := AGruppenphaseLabels;
  FSechzehntelfinaleLabels := ASechzehntelfinaleLabels;

  var ColSize := Floor(FGrid.Width / FGrid.ColCount) - 2;
  var RowSize := Floor(FGrid.Height / FGrid.RowCount) - 2;

  for j := 0 to FGrid.ColCount - 1 do
  begin
    FGrid.ColWidths[j] := ColSize;
  end;
  for j := 0 to FGrid.RowCount - 1 do
  begin
    FGrid.RowHeights[j] := RowSize;
  end;
end;

destructor TGruppenphaseUI.Destroy;
begin
  inherited Destroy;
end;

//{
procedure TGruppenphaseUI.Starten(ASpielIDs: TSpielIDs; AGruppe: TGruppe; ANdx: Integer);
var
  SimulationList: TObjectList<TSimulation>;
begin
  clrUtils.TableFormating.TeamTabelleZeichnen(FGrid, AGruppe);

  FGruppenphaseLabels[ANdx].Caption := clrUtils.StringFormating.FormaTSpielIDsString(
    FState.Teams[ASpielIDs.Key].Name,
    FState.Teams[ASpielIDs.Value].Name,
    0,
    0
  );

  // Das aktuelle Spiel immer grün markieren
  FGruppenphaseLabels[ANdx].Font.Style := [fsBold];
  FGruppenphaseLabels[ANdx].Font.Color := clGreen;


  var Spiel := Default(TSpiel);
  Spiel.Team1 := FState.Teams[ASpielIDs.Key];
  Spiel.Team1 := FState.Teams[ASpielIDs.Value];
  Spiel.Stadion := Default(TStadion);

  SimulationList := TObjectList<TSimulation>.Create;
  try
    SimulationList.Add(TSimulation.Create);
    SimulationList.Last.SpielSimulieren(CallbackSimulation, ANdx, Spiel, ASpielIDs);

  finally
    SimulationList.Free;
  end;

  FGruppenphaseLabels[ANdx].Font.Style := [];
  FGruppenphaseLabels[ANdx].Font.Color := clWindowText;
end;
// }

{

procedure TGruppenphaseUI.Starten(AGruppenphaseLabels: TArray<TLabel>; ASechzehntelfinaleLabels: TArray<TLabel>);
var
  CurrentGroup: TGruppe;
  Ndx: Integer;
  FSimulationList: TObjectList<TSimulation>;

  Gruppen: TList<TGruppe>;

  SechzehntelfinaleLabel: TLabel;

  TopTeams: TList<Byte>;
  ThirdPlaceTeams: TList<Byte>;
  RoundOf32Teams: TList<Byte>;
begin

  FLabels := AGruppenphaseLabels;

  TopTeams := TList<Byte>.Create;
  ThirdPlaceTeams := TList<Byte>.Create;
  RoundOf32Teams := TList<Byte>.Create;

  try
    if ( FState.Gruppen.Count = 0 ) then
    begin
      ShowMessage('Bitte zuerst Verlosung starten.');
      Exit;
    end;


    for CurrentGroup in FState.Gruppen do
    begin

      FCurrentGroup := CurrentGroup;
      FCurrentGroupStandings.Clear;

      for Ndx := 0 to FMatches.Count - 1 do
      begin


      end;



      // Extract the top 2 teams
      var x := clrUtils.SortHashMap.THashMapUtils.Sort<Byte, TTeamStatistik>(
        FCurrentGroupStandings,
        function(Left: TTeamStatistik; Right: TTeamStatistik): Boolean
        begin
          Result := (Left.Punkte - Right.Punkte) > 0;
        end,
        true // as array, as to avoid object copying and ambiguous cleanup behavior
      );

      TopTeams.Add(x[0].Key);
      TopTeams.Add(x[1].Key);
      ThirdPlaceTeams.Add(x[2].Key);

      // Das man die Chance hat etwas zu sehen
      Sleep(500);


      // Das Team sortieren
      var sorted_teams := clrUtils.SortHashMap.THashMapUtils.Sort<Byte, TTeamStatistik>(
        FCurrentGroupStandings,
        function(Left: TTeamStatistik; Right: TTeamStatistik): Boolean
        begin
          Result := (Left.Punkte - Right.Punkte) > 0;
        end
      );

      // und in den dafür vorgesehenen Grid reinschreiben

    end;

    // [x] Spaltenüberschriften
    // [x] Stillstand für die sortierten gruppen nach der Gruppenphase
    // [ ] mit sortierten nach Punkten


    // Compose round-of-32 teams
    RoundOf32Teams.AddRange(TopTeams);
    RoundOf32Teams.AddRange([ThirdPlaceTeams[0], ThirdPlaceTeams[1], ThirdPlaceTeams[2], ThirdPlaceTeams[3], ThirdPlaceTeams[4], ThirdPlaceTeams[5], ThirdPlaceTeams[6], ThirdPlaceTeams[7]]);


    // Die jeweiligen top Einträge als Spiele für das Sechzehntelfinale eintragen
    for var i := 0 to Floor(RoundOf32Teams.Count / 2) - 1 do
    begin
      var Team1Index := i;
      var Team2Index := 31 - i;

      if (Team1Index < RoundOf32Teams.Count) and
         (Team2Index < RoundOf32Teams.Count) and
         (RoundOf32Teams[Team1Index] <> RoundOf32Teams[Team2Index]) then
      begin
        with ASechzehntelfinaleLabels[i] do
        begin
          Caption := clrUtils.StringFormating.FormaTSpielIDsString(
            FState.Teams[RoundOf32Teams[Team1Index]].Name,
            FState.Teams[RoundOf32Teams[Team2Index]].Name,
            0, 0
          );

          // TODO: Add teams to FState.SechzehntelFinale structure
          // in a TArray<TPair<Byte, Byte>> datastructure
          FState.AddSechzehntelFinalist(TPair<Byte, Byte>.Create(RoundOf32Teams[Team1Index], RoundOf32Teams[Team2Index]));
        end;
      end
      else
      begin
        ShowMessage(Format('Error: Invalid pairing for match %d', [i]));
      end;
    end;


    ShowMessage('Die Gruppenphase ist abgeschlossen.');
  finally
    TopTeams.Destroy;
    ThirdPlaceTeams.Destroy;
    RoundOf32Teams.Destroy;
  end;

end;
//}

procedure TGruppenphaseUI.CallbackSimulation(Sender: TObject; ASpielIDs: TSpiel; ASpielIDsIDs: TSpielIDs);
var
  Team1, Team2: TTeam;
  TempStand1, TempStand2: TTeamStatistik;
begin

  Team1 := FState.Teams[ASpielIDsIDs.Key];
  Team2 := FState.Teams[ASpielIDsIDs.Value];
  //FLabels[ASpielIDsNdx].Caption := clrUtils.StringFormating.FormaTSpielIDsString(Team1.Name, Team2.Name, ATeam1Tore, ATeam2Tore);

  // Schreibt die Werte in TempStand1 & TempStand2
  clrUtils.UpdateStandings.GetUpdatedStandings(FState, ASpielIDs.Team1Tore, ASpielIDs.Team2Tore, Team1.ID, Team2.ID, TempStand1, TempStand2);

  // Update the CurrentGroup
  //FCurrentGroupStandings.AddOrSetValue(Team1.ID, TempStand1);
  //FCurrentGroupStandings.AddOrSetValue(Team2.ID, TempStand2);

end;
//}

end.
