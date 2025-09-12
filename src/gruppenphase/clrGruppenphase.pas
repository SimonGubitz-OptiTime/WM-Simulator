unit clrGruppenphase;

interface

uses
  System.Generics.Collections,
  damTypes,
  clrState;

type TGruppenphaseLogik = class
    private

      FField: String;
      FMatches: TList<TPair<Byte, Byte>>;

      /// <summary>
      ///   Algorithmisch Spiele verteilen
      /// </summary>
      function CreateUniqueMatches(AGroup: TGruppe): TList<TPair<Byte, Byte>>;

    public

      constructor Create(AState: IState);
      destructor Destroy;

      procedure Starten;

      // ↓ ???
      // procedure AddMatchFinishCallback();

  end;

implementation

constructor TGruppenphaseLogik.Create(AState: IState);
begin
  //
  FState := AState;
end;

destructor TGruppenphaseLogik.Destroy;
begin
  //
end;

/// .ID nutzen, da es schneller ist in Lookups, als ein TTeam mit SizeOf() ≈ 28 Bytes vs .ID 1Byte
/// Nachteil -> man muss das Objekt in Gruppenphase wieder per Array Lookup finden, da ID fest zu dem globalen Array steht
function TGruppenphaseLogik.CreateUniqueMatches(AGroup: TGruppe): TList<TPair<Byte, Byte>>;
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

  GameDict.Free;

end;

procedure TGruppenphaseLogik.Starten();
begin

  FMatches := CreateUniqueMatches();

end;

// think of a way to get the Callback here
// or have the global state update really in the simulation


end.
