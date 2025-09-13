unit clrGruppenphase;

interface

uses
  System.Generics.Collections,
  damTypes,
  clrState,
  clrSimulation,
  clrUtils.SortHashMap,
  clrUtils.UpdateStandings;

type

  TSpielFertigCallbackFn = reference to procedure(AMatch: TSpiel; AGruppe: TGruppe; ANdx: Integer);

  TGruppenphaseLogik = class
    private

      FState: IState;

      /// <summary>
      ///   Algorithmisch Spiele verteilen
      /// </summary>
      function CreateUniqueMatches(AGroup: TGruppe): TList<TSpielIDs>;

    public

      constructor Create(AState: IState);
      destructor Destroy;

      procedure Starten(ACallbackOnSpielFertig: TSpielFertigCallbackFn);

      // ↓ ???
      // procedure AddMatchFinishCallback();

  end;

implementation

constructor TGruppenphaseLogik.Create(AState: IState);
begin
  inherited Create;

  FState := AState;
end;

destructor TGruppenphaseLogik.Destroy;
begin
  inherited Destroy;
end;

/// .ID nutzen, da es schneller ist in Lookups, als ein TTeam mit SizeOf() ≈ 28 Bytes vs .ID 1Byte
/// Nachteil -> man muss das Objekt in Gruppenphase wieder per Array Lookup finden, da ID fest zu dem globalen Array steht
function TGruppenphaseLogik.CreateUniqueMatches(AGroup: TGruppe): TList<TSpielIDs>;
var
  Team: TTeam;
  Team2: TTeam;
  IDList: TList<Byte>;
  GameDict: TDictionary<Byte, TList<Byte>>;

  AsArray: TArray<TPair<Byte, TList<Byte>>>;
  ArrVal: TPair<Byte, Byte>;
  Ndx: Integer;
begin

  GameDict := TDictionary<Byte, TList<Byte>>.Create;

  for Team in AGroup do
  begin
    for Team2 in AGroup do
    begin
      // wenn es den Wert bereits als Schlüssels gibt
      if ( (GameDict.ContainsKey(Team.ID)
          and (GameDict[Team.ID].Contains(Team2.ID)))  // ← TList.Contains
        or (GameDict.ContainsKey(Team2.ID))            // if the enemy has its own key already
        or (Team.ID = Team2.ID)                         // if it is the same team
      ) then
      begin
        continue;
      end
      else
      begin
        if ( GameDict.ContainsKey(Team.ID) ) then
        begin
          IDList := GameDict[Team.ID];
        end
        else
        begin
          IDList := TList<Byte>.Create;
        end;

        IDList.Add(Team2.ID);

        GameDict.AddOrSetValue(Team.ID, IDList);
      end;
    end;
  end;

  AsArray := GameDict.ToArray;
  Result := TList<TSpielIDs>.Create;

  for Ndx := 0 to Length(AsArray) - 1 do
  begin
    for var Value in AsArray[Ndx].Value do
    begin
      // ShowMessage(Format('Team %d spielt gegen Team %d', [AsArray[Ndx].Key, Value]));
      ArrVal := TSpielIDs.Create(AsArray[Ndx].Key, Value);
      Result.Add(ArrVal); // ungültiger Zugriff
    end;
  end;

  GameDict.Free;

end;

procedure TGruppenphaseLogik.Starten(ACallbackOnSpielFertig: TSpielFertigCallbackFn);
var
  Ndx: Integer;
  Matches: TList<TSpielIDs>;
  CurrentGroup: TGruppe;

  TopTeams: TList<Byte>;
  ThirdPlaceTeams: TList<Byte>;
  RoundOf32Teams: TList<Byte>;
  Spiel: TSpiel;
  Simulation: TSimulation;
  GroupStandings: TDictionary<Byte, TTeamStatistik>;
  OutTempState1, OutTempState2: TTeamSTatistik;
begin

  TopTeams := TList<Byte>.Create;
  ThirdPlaceTeams := TList<Byte>.Create;
  RoundOf32Teams := TList<Byte>.Create;
  GroupStandings := TDictionary<Byte, TTeamStatistik>.Create;
  Spiel := TSpiel.Create;
  Simulation := TSimulation.Create(FState);
  try
    for CurrentGroup in FState.Gruppen do
    begin

      Matches := CreateUniqueMatches(CurrentGroup);
      for Ndx := 0 to Matches.Count - 1 do
      begin

        // hier muss simuliert werden
        Spiel.Team1 := FState.Teams[Matches[Ndx].Key];
        Spiel.Team2 := FState.Teams[Matches[Ndx].Value];
        Spiel.Stadion := Default(TStadion);

        Simulation.SpielSimulieren(procedure(Sender: TObject; AMatch: TSpiel; AMatchIDs: TSpielIDs)
          begin
            // Update GroupStandings
            clrUtils.UpdateStandings.GetUpdatedStandings(FState, Spiel, OutTempState1, OutTempState2);
            GroupStandings.AddOrSetValue(Spiel.Team1.ID, OutTempState1);
            GroupStandings.AddOrSetValue(Spiel.Team2.ID, OutTempState2);

            ACallbackOnSpielFertig(Spiel, CurrentGroup, Ndx);
          end,
          Spiel, Matches[Ndx]
        );
      end;


      // Extract the top 2 teams
      var x := clrUtils.SortHashMap.THashMapUtils.Sort<Byte, TTeamStatistik>(
        GroupStandings,
        function(Left: TTeamStatistik; Right: TTeamStatistik): Boolean
        begin
          Result := (Left.Punkte - Right.Punkte) > 0;
        end,
        true // as array, as to avoid object copying and ambiguous cleanup behavior
      );

      TopTeams.Add(x[0].Key);
      TopTeams.Add(x[1].Key);
      ThirdPlaceTeams.Add(x[2].Key);

    end;

    // Compose round-of-32 teams
    RoundOf32Teams.AddRange(TopTeams);
    RoundOf32Teams.AddRange([ThirdPlaceTeams[0], ThirdPlaceTeams[1], ThirdPlaceTeams[2], ThirdPlaceTeams[3], ThirdPlaceTeams[4], ThirdPlaceTeams[5], ThirdPlaceTeams[6], ThirdPlaceTeams[7]]);


    // Die jeweiligen top Einträge als Spiele für das Sechzehntelfinale eintragen
    for var i := 0 to Floor(RoundOf32Teams.Count / 2) - 1 do
    begin
      var Team1Index := i;
      var Team2Index := RoundOf32Teams.Count - i;

      if (Team1Index < RoundOf32Teams.Count) and
         (Team2Index < RoundOf32Teams.Count) and
         (RoundOf32Teams[Team1Index] <> RoundOf32Teams[Team2Index]) then
      begin
        with ASechzehntelfinaleLabels[i] do
        begin


          // TODO: Refactor to new TSpiel type format
          {Caption := clrUtils.StringFormating.FormatMatchString(
            FState.Teams[RoundOf32Teams[Team1Index]].Name,
            FState.Teams[RoundOf32Teams[Team2Index]].Name,
            0, 0
          );}

          FState.AddSechzehntelFinalist(TSpielIDs.Create(RoundOf32Teams[Team1Index], RoundOf32Teams[Team2Index]));
        end;
      end
      else
      begin
        ShowMessage(Format('Error: Invalid pairing for match %d', [i]));
      end;
    end;


    ShowMessage('Die Gruppenphase ist abgeschlossen.');

  finally
    Simulation.Destroy;
    TopTeams.Free;
    ThirdPlaceTeams.Free;
    RoundOf32Teams.Free;
    GroupStandings.Free;
  end;

end;


end.

