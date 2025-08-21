unit Animation;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Controls, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;


// Optional count for when used in a indexed loop
type TAnimationCallback = procedure(Count: Integer = -1) of object;

type TAnimations = class
public

  constructor Create(var timer: TTimer; AObject: TControl; MoveToTop: Integer; MoveToLeft: Integer; ATime: Integer; ADestroyObjectOnFinish: Boolean = false);

  procedure MoveObject(callbackFn: TAnimationCallback; Count: Integer = -1);

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

  const FTimerInterval: Byte = 50;

  procedure MoveObjectTick(Sender: TObject);

end;


implementation

constructor TAnimations.Create(var timer: TTimer; AObject: TControl; MoveToTop: Integer; MoveToLeft: Integer; ATime: Integer; ADestroyObjectOnFinish: Boolean = false);
begin

  FDestroyObject := ADestroyObjectOnFinish;
  FFinishedAnimation := false;

  FObject := AObject;

  FTimer := timer;
  FTimer.Interval := FTimerInterval;
  FTimer.OnTimer := MoveObjectTick;
  FTimerAmount := 0;

  FStartTop := AObject.Top;
  FStartLeft := AObject.Left;
  FWayTop := AObject.Top - MoveToTop;
  FWayLeft := AObject.Left - MoveToLeft;

  FTimerDuration := ATime;

end;


procedure TAnimations.MoveObject(callbackFn: TAnimationCallback; Count: Integer = -1);
begin

  FCallbackFn := callbackFn;
  FCallbackCount := Count;

  FTimer.Enabled := true;

end;

procedure TAnimations.MoveObjectTick(Sender: TObject);
begin

  FTimerAmount := FTimerAmount + FTimerInterval;
  if FTimerAmount > FTimerDuration then
  begin
    FFinishedAnimation := true;
    FCallbackFn(FCallbackCount);
    Exit;
  end;

  if not(FObject is TControl) then
    raise Exception.Create('TAnimations.MoveObjectTick Error: Sender is not a TControl.');


  with TControl(FObject) do
  begin
    // change the top and left vals
    // jeweils vom Startpunkt ausgehend, ein x-tel des zu gehenden Wegs beschreiten, wobei das x-tel durch die Zeit erkl�rt wird
    Top := FStartTop + (FWayTop * Round(FTimerInterval / FTimerDuration));
    Left := FStartLeft + (FWayleft * Round(FTimerInterval / FTimerDuration));
  end;
end;

destructor TAnimations.Free;
begin
  FTimer.Enabled := false;
  FTimer.Free;

  if FDestroyObject then
    FObject.Free;
end;


end.
