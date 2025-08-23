unit Animation;

interface

uses
  System.Classes, System.SysUtils,
  Vcl.Controls, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Forms, Vcl.StdCtrls;


// Optional count for when used in a indexed loop
type TAnimationCallback = procedure(Count: Integer = -1; SecondCount: Integer = -1; ThirdCount: Integer = -1) of object;

type TAnimations = class
public

  constructor Create(var timer: TTimer; AObject: TControl; MoveToTop: Integer; MoveToLeft: Integer; ATime: Integer; ADestroyObjectOnFinish: Boolean = true);

  procedure MoveObject(callbackFn: TAnimationCallback; Count: Integer = -1; SecondCount: Integer = -1; ThirdCount: Integer = -1);

  destructor Free;

private
  FTimer: TTimer;
  FTimerAmount: Integer;
  FObject: TControl;
  FFinishedAnimation: Boolean;
  FTimerDuration: Integer;
  FWayTop: Integer;
  FWayLeft: Integer;
  FStartTop: Integer;
  FStartLeft: Integer;

  FDestroyObject: Boolean;
  FCallbackFn: TAnimationCallback;
  FCallbackCount: Integer;
  FCallbackSecondCount: Integer;
  FCallbackThirdCount: Integer;

  const FTimerInterval: Byte = 10;

  procedure MoveObjectTick(Sender: TObject);

end;


implementation

constructor TAnimations.Create(var timer: TTimer; AObject: TControl; MoveToTop: Integer; MoveToLeft: Integer; ATime: Integer; ADestroyObjectOnFinish: Boolean = true);
begin

  FDestroyObject := ADestroyObjectOnFinish;
  FFinishedAnimation := false;

  // ShowMessage('before');
  FObject := AObject;
  // ShowMessage('after');

  FTimer := timer;
  FTimer.Interval := FTimerInterval;
  FTimer.OnTimer := MoveObjectTick;
  FTimerAmount := 0;

  FStartTop := AObject.Top;
  FStartLeft := AObject.Left;
  FWayTop := MoveToTop - AObject.Top;
  FWayLeft := MoveToLeft - AObject.Left;

  FTimerDuration := ATime;

end;


procedure TAnimations.MoveObject(callbackFn: TAnimationCallback; Count: Integer = -1; SecondCount: Integer = -1; ThirdCount: Integer = -1);
begin

  FCallbackFn := callbackFn;
  FCallbackCount := Count;
  FCallbackSecondCount := SecondCount;
  FCallbackThirdCount := ThirdCount;

  FTimer.Enabled := true;

  TThread.Queue(nil,
    procedure
    begin
      while not FFinishedAnimation do
      begin
        Application.ProcessMessages;
        Sleep(10);
      end;
    end
  );

end;

procedure TAnimations.MoveObjectTick(Sender: TObject);
var
  progress: Double;
begin

  FTimerAmount := FTimerAmount + FTimerInterval;
  if FTimerAmount >= FTimerDuration then
  begin
    // Timer stoppen
    FTimer.Enabled := false;

    // Die letzte Position updaten
    FObject.Top := FStartTop + FWayTop;
    FObject.Left := FStartLeft + FWayLeft;

    // Callback Funktion aufrufen
    FFinishedAnimation := true;
    FCallbackFn(FCallbackCount, FCallbackSecondCount, FCallbackThirdCount);

    // Wenn das Objekt zerstört werden soll, dann hier aufräumen
    if FDestroyObject then
      FObject.Free;

    Exit;
  end;

  if not(FObject is TControl) then
    raise Exception.Create('TAnimations.MoveObjectTick Error: Sender is not a TControl.');

  // change the top and left vals
  // jeweils vom Startpunkt ausgehend, ein x-tel des zu gehenden Wegs beschreiten, wobei das x-tel durch die Zeit erkl�rt wird
  progress := FTimerInterval / FTimerDuration;
  FObject.Top := FObject.Top + Round(FWayTop * progress);
  FObject.Left := FObject.Left + Round(FWayleft * progress);


end;

destructor TAnimations.Free;
begin
  FTimer.Enabled := false;
  FTimer.Free;

  if FDestroyObject then
    FObject.Free;
end;


end.
