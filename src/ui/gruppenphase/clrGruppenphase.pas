unit clrGruppenphase;

interface

uses
  System.Generics.Collections,
  damTypes,
  clrState;


type TGruppenphaseUI = class
  private

    FGameDict: TDictionary<Byte, TList<Byte>>;

    FState: TWMState;

    /// <summary>
    /// Algorithmisch Spiele verteilen
    /// </summary>
    procedure CreateUniqueMatches(AGroup: TGruppe);

  public
    constructor Create(AState: TWMState);

    procedure GruppenphaseStarten();

    destructor Destroy;

end;


implementation

constructor TGruppenphaseUI.Create(AState: TWMState);
begin
  FState := AState;
  FGameDict := TDictionary<Byte, TList<Byte>>.Create;
end;

destructor TGruppenphaseUI.Destroy;
begin
  // Nicht FState freigeben, wird durch MainForm verwaltet
  FGameDict.Free;

  inherited Destroy;
end;

/// .ID nutzen, da es minimal schneller ist in Lookups, als ein TTeam mit SizeOf() ≈ (x)Bytes vs .ID 1Byte
/// Nachteil -> man muss das Objekt in Gruppenphase wieder per Array Lookup finden, da ID fest zu dem globalen Array steht
procedure TGruppenphaseUI.CreateUniqueMatches(AGroup: TGruppe);
var
  Team: TTeam;
  Team2: TTeam;
  IDList: TList<Byte>;
  Ndx: Byte;
begin

  for Team in AGroup do
  begin
    for Team2 in AGroup do
    begin
      // wenn es den Wert bereits als Schlüssels gibt
      if ( (FGameDict.ContainsKey(Team.ID)
          and (FGameDict[Team.ID].Contains(Team2.ID)))  // if the enemy is already in the dict, thus having all their games filled in already
        or (FGameDict.ContainsKey(Team2.ID))            // if the enemy has its own key already
        or (Team.ID = Team2.ID)                         // if it is the same team
      ) then
      begin
        continue;
      end
      else
      begin
        IDList := FGameDict[Team.ID];
        FGameDict.AddOrSetValue(Team.ID, IDList);
      end;
    end;
  end;

  // FGameDict.ToArray

end;

procedure TGruppenphaseUI.GruppenphaseStarten();
var
  CurrentGroup: TGruppe;
begin

  for CurrentGroup in FState.Groups do
  begin
    CreateUniqueMatches(CurrentGroup);
  end;



end;

end.
