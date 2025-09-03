unit clrGruppenphase;

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

    FState: TWMState;
    FSimulation: TSimulation;
    FGrid: TStringGrid;
    FMatches: TList<TPair<Byte, Byte>>; // eigene TDictionary implementierung, mit mehreren gleichen Keys
    FLabels: TArray<TLabel>;

    /// <summary>
    ///   Algorithmisch Spiele verteilen
    /// </summary>
    function CreateUniqueMatches(AGroup: TGruppe): TList<TPair<Byte, Byte>>;
    procedure CallbackSimulation(Sender: TObject; AMatchNdx: Integer; ATeam1Tore, ATeam2Tore: Integer);

  public
    constructor Create(AGruppenphaseGrid: TStringGrid; var AState: TWMState);

    procedure GruppenphaseStarten(ALabels: TArray<TLabel>);

    destructor Destroy; override;

end;


implementation

constructor TGruppenphaseUI.Create(AGruppenphaseGrid: TStringGrid; var AState: TWMState);
var
  j: Integer;
begin
  FState := AState;
  FGrid := AGruppenphaseGrid;
  FSimulation := TSimulation.Create;

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
  FSimulation.Destroy;

  inherited Destroy;
end;

/// .ID nutzen, da es schneller ist in Lookups, als ein TTeam mit SizeOf() ≈ 28 Bytes vs .ID 1Byte
/// Nachteil -> man muss das Objekt in Gruppenphase wieder per Array Lookup finden, da ID fest zu dem globalen Array steht
function TGruppenphaseUI.CreateUniqueMatches(AGroup: TGruppe): TList<TPair<Byte, Byte>>;
var
  Team: TTeam;
  Team2: TTeam;
  IDList: TList<Byte>;
  FGameDict: TDictionary<Byte, TList<Byte>>;

  AsArray: TArray<TPair<Byte, TList<Byte>>>;
  ArrVal: TPair<Byte, Byte>;
  Ndx: Integer;
begin

  // ShowMessage('Sizeof TTeam is: ' + IntToStr(SizeOf(TTeam))); // 28 - 32bit 56 - 64bit

  FGameDict := TDictionary<Byte, TList<Byte>>.Create;

  for Team in AGroup do
  begin
    for Team2 in AGroup do
    begin
      // wenn es den Wert bereits als Schlüssels gibt
      if ( (FGameDict.ContainsKey(Team.ID)
          and (FGameDict[Team.ID].Contains(Team2.ID)))  // ← TList.Contains
        or (FGameDict.ContainsKey(Team2.ID))            // if the enemy has its own key already
        or (Team.ID = Team2.ID)                         // if it is the same team
      ) then
      begin
        continue;
      end
      else
      begin
        if ( FGameDict.ContainsKey(Team.ID) ) then
        begin
          IDList := FGameDict[Team.ID];
        end
        else
        begin
          IDList := TList<Byte>.Create;
        end;

        IDList.Add(Team2.ID);

        FGameDict.AddOrSetValue(Team.ID, IDList);
      end;
    end;
  end;

  AsArray := FGameDict.ToArray;
  Result := TList<TPair<Byte, Byte>>.Create;

  for Ndx := 0 to Length(AsArray) - 1 do
  begin
    for var Value in AsArray[Ndx].Value do
    begin
      // ShowMessage(Format('Team %d spielt gegen Team %d', [AsArray[Ndx].Key, Value]));
      ArrVal := TPair<Byte, Byte>.Create(AsArray[Ndx].Key, Value);
      Result.Add(ArrVal); // ungültiger Zugriff
    end;
  end;

  FGameDict.Free;

end;

procedure TGruppenphaseUI.GruppenphaseStarten(ALabels: TArray<TLabel>);
var
  CurrentGroup: TGruppe;
  Ndx: Integer;
  FSimulationList: TObjectList<TSimulation>;
begin

  FLabels := ALabels;

  if ( FState.Gruppen.Count = 0 ) then
  begin
    ShowMessage('Bitte zuerst Verlosung starten.');
  end;


  for CurrentGroup in FState.Gruppen do
  begin

    FMatches := CreateUniqueMatches(CurrentGroup);

    for Ndx := 0 to FMatches.Count - 1 do
    begin

      clrUtils.TableFormating.TeamTabelleZeichnen(FGrid, CurrentGroup);

      ALabels[Ndx].Caption := clrUtils.StringFormating.FormatMatchString(
        FState.Teams[FMatches[Ndx].Key].Name,
        FState.Teams[FMatches[Ndx].Value].Name,
        0,
        0
      );

      // Das aktuelle Spiel immer grün markieren
      ALabels[Ndx].Font.Style := [fsBold];
      ALabels[Ndx].Font.Color := clGreen;


      FSimulationList := TObjectList<TSimulation>.Create;
      try
        FSimulationList.Add(TSimulation.Create);
        FSimulationList.Last.SpielSimulieren(CallbackSimulation, Ndx);

      finally
        FSimulationList.Free;
      end;



      ALabels[Ndx].Font.Style := [];
      ALabels[Ndx].Font.Color := clWindowText;
    end;

    // Das man die Chance hat etwas zu sehen
    // Sleep(2000);

  end;


  // Vielleicht noch pro gruppe TGruppenphase private Fields als temp storage dafür oder als funktions vars und dann die generische version und die besetzung von FAchtelFinale
  var TopTeams := clrUtils.SortHashMap.THashMapUtils.Sort(FState.GetTeamStand);

  clrUtils.SortHashMap.THashMapUtils.Sort<Byte, TTeamStatistik>(FState.TeamStands,
    function(Left: TTeamStatistik; Right: TTeamStatistik): Boolean
    begin
      Result := (Left.Punkte - Right.Punkte) > 0;
    end
  );


  // Schritt 2. Die jeweiligen top einträge als Spiele für das Achtelfinale eintragen



  ShowMessage('Die Gruppenphase ist abgeschlossen.');

end;

procedure TGruppenphaseUI.CallbackSimulation(Sender: TObject; AMatchNdx: Integer; ATeam1Tore, ATeam2Tore: Integer);
var
  Team1, Team2: TTeam;
  TempStand1, TempStand2: TTeamStatistik;
begin

  Team1 := FState.Teams[FMatches[AMatchNdx].Key];
  Team2 := FState.Teams[FMatches[AMatchNdx].Value];
  FLabels[AMatchNdx].Caption := clrUtils.StringFormating.FormatMatchString(Team1.Name, Team2.Name, ATeam1Tore, ATeam2Tore);

  clrUtils.UpdateStandings.GetUpdatedStandings(FState, ATeam1Tore, ATeam2Tore, Team1.ID, Team2.ID, TempStand1, TempStand2);

  FState.AddOrSetTeamStandByID(Team1.ID, TempStand1);
  FState.AddOrSetTeamStandByID(Team2.ID, TempStand2);

end;

end.
