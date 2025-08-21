unit Animation;

interface

uses
  System.Classes,
  Vcl.Controls, Vcl.ExtCtrls, Vcl.StdCtrls;



type TAnimations = class
public

  constructor Create(var timer: TTimer; AObject: TControl; MoveToTop: Integer; MoveToLeft: Integer; ATime: Integer);

  procedure MoveObject;

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

  const FTimerInterval: Byte = 50;

  procedure _MoveObject(Sender: TObject);

end;


implementation

constructor TAnimations.Create(var timer: TTimer; AObject: TControl; MoveToTop: Integer; MoveToLeft: Integer; ATime: Integer);
begin

  FFinishedAnimation := false;

  FObject := AObject;

  FTimer := timer;
  FTimer.Interval := FTimerInterval;
  FTimer.OnTimer := _MoveObject;

  FStartTop := AObject.Top;
  FStartLeft := AObject.Left;
  FWayTop := AObject.Top - MoveToTop;
  FWayLeft := AObject.Left - MoveToLeft;

  FTimerDuration := ATime;

end;


procedure TAnimations.MoveObject();
begin
  FTimer.Enabled := true;

  // Warten
  while not(FFinishedAnimation) do begin end;

end;

procedure TAnimations._MoveObject(Sender: TObject);
begin

  FTimerAmount := FTimerAmount + FTimerInterval;
  if FTimerAmount > FTimerDuration then
  begin
    FFinishedAnimation := true;
    Exit;
  end;


  with TControl(FObject) do
  begin
    // change the top and left vals
    // jeweils vom Startpunkt ausgehend, ein x-tel des zu gehenden Wegs beschreiten, wobei das x-tel durch die Zeit erkl�rt wird
    Top := FStartTop + (FWayTop * Round(FTimerInterval / FTimerDuration));
    Left := FStartLeft + (FWayleft * Round(FTimerInterval / FTimerDuration));
  end;
end;

end.
