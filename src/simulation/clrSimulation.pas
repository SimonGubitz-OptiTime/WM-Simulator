unit clrSimulation;

interface

uses
  Vcl.ExtCtrls,
  Vcl.Forms,
  damTypes,
  clrUtils.UpdateStandings;

type TSimulationCallbackFn = reference to procedure(Sender: TObject; AMatch: TSpiel; AMatchIDs: TSpielIDs);

type TSimulation = class
  private
    FState: IState;
    FTimer: TTimer;
    FTimerCount: Integer;

    FTotalGoals: Integer;
    FSpiel: TSpiel;
    FSpielIDs: TSpielIDs;
    FCallbackFn: TSimulationCallbackFn;

    FPossibleMaxGoals: Integer;
    FSimulationFinished: Boolean;

    procedure UpdateState(Sender: TObject);
  public
    constructor Create(AState: IState; PossibleMaxGoals: Byte = 6);
    destructor Destroy; override;

    procedure SpielSimulieren(ACallbackFn: TSimulationCallbackFn; ASpiel: TSpiel; ASpielIDs: TSpielIDs);

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

constructor TSimulation.Create(AState: IState; PossibleMaxGoals: Byte = 6);
begin
  FState := AState;
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

procedure TSimulation.SpielSimulieren(ACallbackFn: TSimulationCallbackFn; ASpiel: TSpiel; ASpielIDs: TSpielIDs);
begin
  ASpiel.Team1Tore := 0;
  ASpiel.Team2Tore := 0;
  FTimerCount := 0;
  FTotalGoals := Random(FPossibleMaxGoals + 1);
  FSimulationFinished := false;

  FSpiel := ASpiel;
  FSpielIDs := ASpielIDs;
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
  TempStand1, TempStand2: TTeamStatistik;
  SiegchancenTeam1: ShortInt; // ShortInt, weil Byte durch das hinzufügen von negativen Zahlen nicht funktioniert, und ich trotzdem keinen Wert > 100 brauche
begin

  if ( FTimerCount >= FTotalGoals ) then
  begin
    FSimulationFinished := true;
    FTimer.Enabled := false;

    FCallbackFn(Self, FSpiel, FSpielIDs);
    //(Sender: TObject; AMatch: TSpiel; AMatchIDs: TSpielIDs)

    // Update State here

    clrUtils.UpdateStandings.GetUpdatedStandings(FState, FSpiel, TempStand1, TempStand2);
    FState.AddOrSetTeamStandByID(FSpiel.Team1.ID, TempStand1);
    FState.AddOrSetTeamStandByID(FSpiel.Team2.ID, TempStand2);

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
    Inc(FSpiel.Team1Tore);
  end
  else
  begin
    Inc(FSpiel.Team2Tore);
  end;

  Inc(FTimerCount);

end;


end.
