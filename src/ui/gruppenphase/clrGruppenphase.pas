unit clrGruppenphase;

interface

uses
  damTypes;


type TGruppenphase = class
  private

    FGameDict: TDictionary<Byte, Byte>;

    FState: TWMState;

    /// <summary>
    /// Algorithmisch Spiele verteilen
    /// </summary>
    procedure CreateUniqueMatches(AGroup: TGruppe);

  public
    constructor Create(AState: TWMState);

    procedure GruppenPhaseStarten();

end;


implementation

constructor TGruppenphase.Create(AState: TWMState);
begin
  FState := AState;
  FGameDict := TDictionary<Byte, Byte>.Create;
end;

destructor TGruppenphase.Destroy;
begin
  // Nicht FState freigeben, wird durch MainForm verwaltet
  FGameDict.Free;
end;


procedure CreateUniqueMatches(AGroup: TGruppe);
var
  Team: TTeam;
  Team2: TTeam;
  GetVal: Byte;
  Ndx: Byte;
begin

  for Team in AGroup do
  begin

    for Team2 in AGroup do
    begin

      // wenn es den Wert bereits als Schlüssels gibt
      if ( FGameDict.ContainsKey(Team.ID)
        or Team.Equals(Team2)
      ) then
      begin
        continue;
      end
      else
      begin
        FGameDict.AddOrSetValue(Team.ID, Team2.ID);
      end;
    end;
  end;
end;


end.
