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
    FLabels: TArray<TLabel>;
    FCurrentGroup: TGruppe;
    FCurrentGroupStandings: TDictionary<Byte, TTeamStatistik>;


    procedure CallbackSimulation(Sender: TObject; AMatchNdx: Integer; ATeam1Tore, ATeam2Tore: Integer);

  public
    constructor Create(AGruppenphaseGrid: TStringGrid; const AState: IState);

    procedure GruppenphaseStarten(AGruppenphaseLabels: TArray<TLabel>; ASechzehntelfinaleLabels: TArray<TLabel>);

    destructor Destroy; override;

end;


implementation

constructor TGruppenphaseUI.Create(AGruppenphaseGrid: TStringGrid; const AState: IState);
var
  j: Integer;
begin
  FState := AState;
  FGrid := AGruppenphaseGrid;
  FSimulation := TSimulation.Create;
  FCurrentGroupStandings := TDictionary<Byte, TTeamStatistik>.Create;

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
  FMatches.Free;
  FSimulation.Destroy;
  FCurrentGroupStandings.Destroy;

  inherited Destroy;
end;

procedure TGruppenphaseUI.GruppenphaseStarten(AGruppenphaseLabels: TArray<TLabel>; ASechzehntelfinaleLabels: TArray<TLabel>);
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

        clrUtils.TableFormating.TeamTabelleZeichnen(FGrid, FCurrentGroup);

        AGruppenphaseLabels[Ndx].Caption := clrUtils.StringFormating.FormatMatchString(
          FState.Teams[FMatches[Ndx].Key].Name,
          FState.Teams[FMatches[Ndx].Value].Name,
          0,
          0
        );

        // Das aktuelle Spiel immer grün markieren
        AGruppenphaseLabels[Ndx].Font.Style := [fsBold];
        AGruppenphaseLabels[Ndx].Font.Color := clGreen;


        var Spiel := Default(TSpiel);
        Spiel.Team1 := FState.Teams[FMatches[Ndx].Key];
        Spiel.Team1 := FState.Teams[FMatches[Ndx].Value];
        Spiel.Stadion := Default(TStadion);

        FSimulationList := TObjectList<TSimulation>.Create;
        try
          FSimulationList.Add(TSimulation.Create);
          FSimulationList.Last.SpielSimulieren(CallbackSimulation, Ndx, Spiel);

        finally
          FSimulationList.Free;
        end;

        AGruppenphaseLabels[Ndx].Font.Style := [];
        AGruppenphaseLabels[Ndx].Font.Color := clWindowText;
      end;


      {

       ALLES HIERDRUNTER MUSS REFACTORED WERDEN

       - Callback in Main.pas, wo Logic and UI may meet?

      }

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
          Caption := clrUtils.StringFormating.FormatMatchString(
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

procedure TGruppenphaseUI.CallbackSimulation(Sender: TObject; AMatchNdx: Integer; ATeam1Tore, ATeam2Tore: Integer);
var
  Team1, Team2: TTeam;
  TempStand1, TempStand2: TTeamStatistik;
begin

  Team1 := FState.Teams[FMatches[AMatchNdx].Key];
  Team2 := FState.Teams[FMatches[AMatchNdx].Value];
  FLabels[AMatchNdx].Caption := clrUtils.StringFormating.FormatMatchString(Team1.Name, Team2.Name, ATeam1Tore, ATeam2Tore);

  // Schreibt die Werte in TempStand1 & TempStand2
  clrUtils.UpdateStandings.GetUpdatedStandings(FState, ATeam1Tore, ATeam2Tore, Team1.ID, Team2.ID, TempStand1, TempStand2);


  // ↓ pull this into clrSimulation ???

  // Update the CurrentGroup
  FCurrentGroupStandings.AddOrSetValue(Team1.ID, TempStand1);
  FCurrentGroupStandings.AddOrSetValue(Team2.ID, TempStand2);

  // Also write it in the global FState.Stands to have a non scoped saved state
  FState.AddOrSetTeamStandByID(Team1.ID, TempStand1);
  FState.AddOrSetTeamStandByID(Team2.ID, TempStand2);

end;


end.
