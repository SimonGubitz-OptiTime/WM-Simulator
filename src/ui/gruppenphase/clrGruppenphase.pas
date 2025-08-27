unit clrGruppenphase;

interface

uses
  System.Generics.Collections,
  damTypes,
  clrState;


type TGruppenphaseUI = class
  private

    FGameDict: TDictionary<Byte, Byte>;

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
  FGameDict := TDictionary<Byte, Byte>.Create;
end;

destructor TGruppenphaseUI.Destroy;
begin
  // Nicht FState freigeben, wird durch MainForm verwaltet
  FGameDict.Free;

  inherited Destroy;
end;


procedure TGruppenphaseUI.CreateUniqueMatches(AGroup: TGruppe);
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
      if ( (FGameDict.ContainsKey(Team.ID))
        or (Team.ID = Team2.ID)
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
