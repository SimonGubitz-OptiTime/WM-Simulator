unit clrSimulation;

interface

uses
  Vcl.ExtCtrls,
  Vcl.Forms;

type TSimulationCallbackFn = procedure(Sender: TObject; ANdx: Integer) of object;

type TSimulation = class
  private
    FTimer: TTimer;
    FTimerCount: Integer;

    FTotalGoals: Integer;
    FNdx: Integer;

    procedure TimerEvent(Sender: TObject);
  public
    constructor Create;
    procedure SpielSimulieren(CallbackFn: TSimulationCallbackFn; ANdx: Integer);
    destructor Free;
end;

// Die pause zwischen den Toren in ms
const 
    PauseBetweenGoals = 500;

implementation

constructor TSimulation.Create;
begin
    FTimerCount := 0;
    FTimer := TTimer.Create(nil);
    FTimer.Interval := 100; // 100 ms
    
    FTotalGoals := Random(7); // 0 bis 6 Tore pro Spiel
end;

procedure TSimulation.SpielSimulieren(CallbackFn: TSimulationCallbackFn; ANdx: Integer);
begin

  FNdx := ANdx;

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
    FCallbackFn(Self, FNdx);
    Exit;
  end;

  Inc(FTimerCount);

end;

destructor TSimulation.Free;
begin
    FTimer.Free;
end;


end.
