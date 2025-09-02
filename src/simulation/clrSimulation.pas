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

    procedure TimerEvent(Sender: TObject);
  public
    constructor Create(PossibleMaxGoals: Byte = 6);
    procedure SpielSimulieren(ACallbackFn: TSimulationCallbackFn; ANdx: Integer);
    destructor Destroy; override;
end;

// Die pause zwischen den Toren in ms
const
  PauseBetweenGoals = 500;

implementation

constructor TSimulation.Create(PossibleMaxGoals: Byte = 6);
begin
  FTeam1Tore := 0;
  FTeam2Tore := 0;
  FTimerCount := 0;
  FTimer := TTimer.Create(nil);
  FTimer.Enabled := false;
  FTimer.Interval := 100; // 100 ms

  FTotalGoals := Random(PossibleMaxGoals + 1);
end;

destructor TSimulation.Destroy;
begin
  FTimer.Destroy;

  inherited Destroy;
end;

procedure TSimulation.SpielSimulieren(ACallbackFn: TSimulationCallbackFn; ANdx: Integer);
begin

  FNdx := ANdx;
  FCallbackFn := ACallbackFn;

  FTimer.Enabled := true;
  FTimer.OnTimer := TimerEvent;
end;

procedure TSimulation.TimerEvent(Sender: TObject);
begin

  if ( FTimerCount >= FTotalGoals ) then
  begin
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
