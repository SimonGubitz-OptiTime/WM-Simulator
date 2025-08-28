unit clrGruppenphase;

interface

uses
  System.Generics.Collections,
  System.SysUtils,
  System.Math,
  Vcl.Dialogs,
  Vcl.Grids,
  damTypes,
  clrState;


type TGruppenphaseUI = class
  private

    FState: TWMState;
    FGrid: TStringGrid;

    /// <summary>
    /// Algorithmisch Spiele verteilen
    /// </summary>
    function CreateUniqueMatches(AGroup: TGruppe): TArray<TPair<Byte, TList<Byte>>>;

  public
    constructor Create(AGruppenphaseGrid: TStringGrid; AState: TWMState);

    procedure GruppenphaseStarten();

    destructor Free;

end;


implementation

constructor TGruppenphaseUI.Create(AGruppenphaseGrid: TStringGrid; AState: TWMState);
var
  j: Integer;
begin
  FState := AState;
  FGrid := AGruppenphaseGrid;

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

destructor TGruppenphaseUI.Free;
begin
  // Nicht FState freigeben, wird durch MainForm verwaltet

  inherited Free;
end;

/// .ID nutzen, da es schneller ist in Lookups, als ein TTeam mit SizeOf() ≈ (x)Bytes vs .ID 1Byte
/// Nachteil -> man muss das Objekt in Gruppenphase wieder per Array Lookup finden, da ID fest zu dem globalen Array steht
function TGruppenphaseUI.CreateUniqueMatches(AGroup: TGruppe): TList<TPair<Byte, Byte>>;
var
  Team: TTeam;
  Team2: TTeam;
  IDList: TList<Byte>;
  FGameDict: TDictionary<Byte, TList<Byte>>;

  AsArray: TArray<TPair<Byte, TList<Byte>>>;
  Ndx: Integer;
begin

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

  for Ndx := 0 to Length(AsArray) - 1 do
  begin
    for var Value in AsArray[Ndx].Value do
    begin
      // ShowMessage(Format('Team %d spielt gegen Team %d', [AsArray[Ndx].Key, Value]));
      Result.Add(TPair<Byte, Byte>.Create(AsArray[Ndx].Key, Value));
    end;  
  end;

  FGameDict.Free;

end;

procedure TGruppenphaseUI.GruppenphaseStarten();
var
  CurrentGroup: TGruppe;
  Matches: TArray<TPair<Byte, TList<Byte>>>;

begin

  if ( FState.Groups.count = 0 ) then
  begin
    ShowMessage('Bitte zuerst Verlosung starten.');
  end;


  for CurrentGroup in FState.Groups do
  begin

    Matches := CreateUniqueMatches(CurrentGroup);

    // -

  end;



end;

end.
