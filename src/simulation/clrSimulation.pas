unit clrSimulation;

interface

uses
  Vcl.ExtCtrls,
  Vcl.Forms;

type TSimulationCallbackFn = procedure(Sender: TObject; ANdx: Integer; ATeam1Tore, ATeam2Tore: Integer) of object;

type TSimulation = class
  private
    FTimer: TTimer;
    FTimerCount: Integer;

    FTotalGoals: Integer;
    FNdx: Integer;
    FCallbackFn: TSimulationCallbackFn;
    FTeam1Tore, FTeam2Tore: Integer;

    FPossibleMaxGoals: Integer;
    FSimulationFinished: Boolean;

    procedure TimerEvent(Sender: TObject);
  public
    constructor Create(PossibleMaxGoals: Byte = 6);
    procedure SpielSimulieren(ACallbackFn: TSimulationCallbackFn; ANdx: Integer);
    destructor Destroy; override;
end;

// Die pause zwischen den Toren in ms
const
  PauseBetweenGoals = 500;
  HeimspielSiegchancen = 5;
  

implementation

constructor TSimulation.Create(PossibleMaxGoals: Byte = 6);
begin
  FTeam1Tore := 0;
  FTeam2Tore := 0;
  FTimerCount := 0;
  FTimer := TTimer.Create(nil);
  FTimer.Enabled := false;
  {$IFDEF DEBUG}
    FTimer.Interval := 25;
  {$ENDIF}

  // FTimer.Interval := 250; // 250 ms

  FPossibleMaxGoals := PossibleMaxGoals;

  FSimulationFinished := false;
end;

destructor TSimulation.Destroy;
begin
  FTimer.Destroy;

  inherited Destroy;
end;

procedure TSimulation.SpielSimulieren(ACallbackFn: TSimulationCallbackFn; ANdx: Integer);
begin
  FTeam1Tore := 0;
  FTeam2Tore := 0;
  FTimerCount := 0;
  FTotalGoals := Random(FPossibleMaxGoals + 1);
  FSimulationFinished := false;

  FNdx := ANdx;
  FCallbackFn := ACallbackFn;
  
  FTimer.OnTimer := TimerEvent;
  FTimer.Enabled := true;

  while not FSimulationFinished do
  begin
    Application.ProcessMessages;
  end;
end;

procedure TSimulation.TimerEvent(Sender: TObject);
begin

  if ( FTimerCount >= FTotalGoals ) then
  begin
    FSimulationFinished := true;
    FTimer.Enabled := false;

    FCallbackFn(Self, FNdx, FTeam1Tore, FTeam2Tore);

    Exit;
  end;

  // Random Tore generieren
  // Hier kann noch eine Logik rein, die die Stärke der Teams berücksichtigt und auch ob es im Heimstadion gespielt wird
  if ( Random(100) < 50 ) then
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
