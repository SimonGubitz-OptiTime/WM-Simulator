unit clrGruppenphase;

interface

uses
  System.Generics.Collections,
  System.Math,
  System.SysUtils,
  Vcl.Dialogs,
  damTypes,
  clrState,
  clrSimulation,
  clrUtils.SortArray,
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
      function CreateUniqueMatches(AGruppe: TGruppe): TList<TSpielIDs>;
      procedure ResetTeamStandings(AGruppe: TGruppe);

    public

      constructor Create(AState: IState);
      destructor Destroy; override;

      procedure Starten(ACallbackOnSpielFertig: TSpielFertigCallbackFn);

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
function TGruppenphaseLogik.CreateUniqueMatches(AGruppe: TGruppe): TList<TSpielIDs>;
var
  Team: TTeam;
  Team2: TTeam;
  IDList: TList<Byte>;
  GameDict: TObjectDictionary<Byte, TList<Byte>>;
  AsArray: TArray<TPair<Byte, TList<Byte>>>;
  ArrVal: TPair<Byte, Byte>;
  Ndx: Integer;
begin

  GameDict := TObjectDictionary<Byte, TList<Byte>>.Create([ doOwnsValues ]);
  try
    for Team in AGruppe do
    begin
      for Team2 in AGruppe do
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
            IDList.Add(Team2.ID);
          end
          else
          begin
            IDList := TList<Byte>.Create;
            IDList.Add(Team2.ID);
            GameDict.AddOrSetValue(Team.ID, IDList);
          end;
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
        Result.Add(ArrVal);
      end;
    end;
  finally
    GameDict.Free;
  end;
end;

procedure TGruppenphaseLogik.ResetTeamStandings(AGruppe: TGruppe);
var
  Team: TTeam;
begin
  for Team in AGruppe do
  begin
    FState.AddOrSetTeamStandByID(Team.ID, Default(TTeamStatistik));
  end;
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
  OutTempState1, OutTempState2: TTeamStatistik;
begin

  if ( FState.Gruppen.Count = 0 ) then
  begin
    raise ESkipStepException.Create('Gruppen sind leer. Bitte zuerst Verlosung starten.');
  end;


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

      try
        // set the teams in the group to baseline 0
        ResetTeamStandings(CurrentGroup);

        // for each group reset the CurrentStanding
        GroupStandings.Clear;


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

              clrUtils.SortArray.TSortArrayUtils<TTeam>.Sort(
                CurrentGroup,
                function(Left: TTeam; Right: TTeam): Boolean
                begin
                  Result := FState.TeamStands[Left.ID].Punkte < FState.TeamStands[Right.ID].Punkte;
                end
              );

              ACallbackOnSpielFertig(Spiel, CurrentGroup, Ndx);
            end,
            Spiel, Matches[Ndx]
          );
        end;
      finally
        Matches.Free;
      end;


      // Extract the top 2 teams
      var x := clrUtils.SortHashMap.THashMapUtils.Sort<Byte, TTeamStatistik>(
        GroupStandings,
        function(Left: TTeamStatistik; Right: TTeamStatistik): Boolean
        begin
          Result := Left.Punkte > Right.Punkte;
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

    var teams__ := FState.Teams;

    if RoundOf32Teams.Count <> 32 then
      raise Exception.CreateFmt('Expected 32 teams, got %d', [RoundOf32Teams.Count]);


    // Die jeweiligen top Einträge als Spiele für das Sechzehntelfinale eintragen
    for var i := 0 to Floor(RoundOf32Teams.Count / 2) - 1 do
    begin
      var Team1Index := i;
      var Team2Index := RoundOf32Teams.Count - 1 - i;

      if (Team1Index < RoundOf32Teams.Count) and
         (Team2Index < RoundOf32Teams.Count) and
         (RoundOf32Teams[Team1Index] <> RoundOf32Teams[Team2Index]) then
      begin
        FState.AddSechzehntelFinalist(TSpielIDs.Create(RoundOf32Teams[Team1Index], RoundOf32Teams[Team2Index]));
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
    Spiel.Destroy;
  end;

end;


end.

