unit clrSimulation;

interface

uses
  Vcl.ExtCtrls,
  Vcl.Forms,
  damTypes;

type TSimulationCallbackFn = procedure(Sender: TObject; ANdx: Integer; ATeam1Tore, ATeam2Tore: Integer) of object;

type TSimulation = class
  private
    FTimer: TTimer;
    FTimerCount: Integer;

    FTotalGoals: Integer;
    FNdx: Integer;
    FSpiel: TSpiel;
    FCallbackFn: TSimulationCallbackFn;
    FTeam1Tore, FTeam2Tore: Integer;

    FPossibleMaxGoals: Integer;
    FSimulationFinished: Boolean;

    procedure UpdateState(Sender: TObject);
  public
    constructor Create(PossibleMaxGoals: Byte = 6);
    destructor Destroy; override;

    procedure SpielSimulieren(ACallbackFn: TSimulationCallbackFn; ANdx: Integer; ASpiel: TSpiel);

end;

// Die pause zwischen den Toren in ms
const
  // PauseBetweenGoals = 50; // ms
  HeimspielSiegchancen = 5;
  SehrStarkSiegchancen = 20;
  StarkSiegchancen = 10;
  MittelStarkSiegchancen = 0;
  SchwachSiegchancen = -10;


implementation

constructor TSimulation.Create(PossibleMaxGoals: Byte = 6);
begin
  FTeam1Tore := 0;
  FTeam2Tore := 0;
  FTimerCount := 0;
  FTimer := TTimer.Create(nil);
  FTimer.Enabled := false;
  {$IFDEF DEBUG}
    FTimer.Interval := 5;
  {$ELSE}
    FTimer.Interval := 250;
  {$ENDIF}

  FPossibleMaxGoals := PossibleMaxGoals;

  FSimulationFinished := false;
end;

destructor TSimulation.Destroy;
begin
  FTimer.Destroy;

  inherited Destroy;
end;

procedure TSimulation.SpielSimulieren(ACallbackFn: TSimulationCallbackFn; ANdx: Integer; ASpiel: TSpiel);
begin
  FTeam1Tore := 0;
  FTeam2Tore := 0;
  FTimerCount := 0;
  FTotalGoals := Random(FPossibleMaxGoals + 1);
  FSimulationFinished := false;

  FNdx := ANdx;
  FSpiel := ASpiel;
  FCallbackFn := ACallbackFn;

  FTimer.OnTimer := UpdateState;
  FTimer.Enabled := true;

  while not FSimulationFinished do
  begin
    Application.ProcessMessages;
  end;
end;

procedure TSimulation.UpdateState(Sender: TObject);
var
  SiegchancenTeam1: ShortInt; // ShortInt, weil Byte durch das hinzufügen von negativen Zahlen nicht funktioniert, und ich trotzdem keinen Wert > 100 brauche
begin

  if ( FTimerCount >= FTotalGoals ) then
  begin
    FSimulationFinished := true;
    FTimer.Enabled := false;

    FCallbackFn(Self, FNdx, FTeam1Tore, FTeam2Tore);

    // Update State here
    {
    clrUtils.UpdateStandings.GetUpdatedStandings(FState, ATeam1Tore, ATeam2Tore, Team1.ID, Team2.ID, TempStand1, TempStand2);


    // Update the CurrentGroup
    FCurrentGroupStandings.AddOrSetValue(Team1.ID, TempStand1);
    FCurrentGroupStandings.AddOrSetValue(Team2.ID, TempStand2);

    // Also write it in the global FState.Stands to have a non scoped saved state
    // pull this into clrSimulation ???
    FState.AddOrSetTeamStandByID(Team1.ID, TempStand1);
    FState.AddOrSetTeamStandByID(Team2.ID, TempStand2);
    }

    Exit;
  end;

  SiegchancenTeam1 := 50;

  // switch statt if, da es schneller ist
  case FSpiel.Team1.TeamRanking of
    TTeamRanking.SehrStark: Inc(SiegchancenTeam1, SehrStarkSiegchancen);
    TTeamRanking.Stark: Inc(SiegchancenTeam1, StarkSiegchancen);
    TTeamRanking.MittelStark: Inc(SiegchancenTeam1, MittelStarkSiegchancen);
    TTeamRanking.Schwach: Inc(SiegchancenTeam1, SchwachSiegchancen);
  end;

  case FSpiel.Team2.TeamRanking of
    TTeamRanking.SehrStark: Dec(SiegchancenTeam1, SehrStarkSiegchancen);
    TTeamRanking.Stark: Dec(SiegchancenTeam1, StarkSiegchancen);
    TTeamRanking.MittelStark: Dec(SiegchancenTeam1, MittelStarkSiegchancen);
    TTeamRanking.Schwach: Dec(SiegchancenTeam1, SchwachSiegchancen);
  end;

  if ( FSpiel.Stadion.Name = FSpiel.Team1.HeimstadionName ) then
  begin
    Inc(SiegchancenTeam1, HeimspielSiegchancen);
  end;

  if ( FSpiel.Stadion.Name = FSpiel.Team2.HeimstadionName ) then
  begin
    Dec(SiegchancenTeam1, HeimspielSiegchancen);
  end;


  // Random Tore generieren
  if ( Random(100) < SiegchancenTeam1 ) then
  begin
    Inc(FTeam1Tore);
  end
  else
  begin
    Inc(FTeam2Tore);
  end;

  Inc(FTimerCount);

end;


end.
