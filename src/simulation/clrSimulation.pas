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
    constructor Create;
    procedure SpielSimulieren(ACallbackFn: TSimulationCallbackFn; ANdx: Integer);
    destructor Destroy;
end;

// Die pause zwischen den Toren in ms
const
  PauseBetweenGoals = 500;

implementation

constructor TSimulation.Create;
begin
  FTeam1Tore := 0;
  FTeam2Tore := 0;
  FTimerCount := 0;
  FTimer := TTimer.Create(nil);
  FTimer.Interval := 100; // 100 ms

  FTotalGoals := Random(7); // 0 bis 6 Tore pro Spiel
end;

destructor TSimulation.Destroy;
begin
  FTimer.Free;
end;

procedure TSimulation.SpielSimulieren(ACallbackFn: TSimulationCallbackFn; ANdx: Integer);
begin

  FNdx := ANdx;
  FCallbackFn := ACallbackFn;

  FTimer.Enabled := True;
  FTimer.OnTimer := TimerEvent;


  while FTimerCount < FTotalGoals do
  begin
    Application.ProcessMessages;
  end;
end;

procedure TSimulation.TimerEvent(Sender: TObject);
begin

  if (FTimerCount >= FTotalGoals) then
  begin
    FTimer.Enabled := False;

    FCallbackFn(Self, FNdx, FTeam1Tore, FTeam2Tore);

    Exit;
  end;

  // Random Tore generieren
  // Hier kann noch eine Logik rein, die die Stärke der Teams berücksichtigt und auch ob es im Heimstadion gespielt wird
  if ( Random(2) = 0 ) then
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
