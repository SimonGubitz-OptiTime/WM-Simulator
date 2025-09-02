unit clrAnimation;

interface

uses
  System.Classes, System.SysUtils,
  Vcl.Controls, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Forms, Vcl.StdCtrls;

// Optional count for when used in a indexed loop
type
  TAnimationCallback = procedure(ACount: Integer = -1; ASecondCount: Integer = -1;
    AThirdCount: Integer = -1) of object;

type
  TAnimations = class
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
  public

    constructor Create(var ATimer: TTimer; AObject: TControl; ATime: Integer; ADestroyObjectOnFinish: Boolean = true);

    procedure ObjektBewegen(ACallbackFn: TAnimationCallback; AMoveToTop: Integer; AMoveToLeft: Integer; ACount: Integer = -1; ASecondCount: Integer = -1; AThirdCount: Integer = -1);
    procedure TypewriterEffect(AText: String);

    destructor Destroy; override;

  const
    FTimerInterval: Byte = 10;

    procedure ObjektBewegenTick(ASender: TObject);

  end;

implementation

constructor TAnimations.Create(var ATimer: TTimer; AObject: TControl; ATime: Integer; ADestroyObjectOnFinish: Boolean = true);
begin

  FDestroyObject := ADestroyObjectOnFinish;
  FFinishedAnimation := false;

  // ShowMessage('before');
  FObject := AObject;
  // ShowMessage('after');

  FTimer := ATimer;
  FTimer.Interval := FTimerInterval;
  FTimer.OnTimer := ObjektBewegenTick;
  FTimerAmount := 0;

  FTimerDuration := ATime;

end;

destructor TAnimations.Destroy;
begin
  FTimer.Enabled := false;
  FTimer.Free;

  if ( FDestroyObject ) then
  begin
    FObject.Free;
  end;

  inherited Destroy;
end;

procedure TAnimations.ObjektBewegen(ACallbackFn: TAnimationCallback;
  AMoveToTop: Integer; AMoveToLeft: Integer;
  ACount: Integer = -1; ASecondCount: Integer = -1; AThirdCount: Integer = -1);
begin

  FStartTop := FObject.Top;
  FStartLeft := FObject.Left;
  FWayTop := AMoveToTop - FObject.Top;
  FWayLeft := AMoveToLeft - FObject.Left;

  FCallbackFn := AcallbackFn;
  FCallbackCount := ACount;
  FCallbackSecondCount := ASecondCount;
  FCallbackThirdCount := AThirdCount;

  FTimer.Enabled := true;

  { TThread.Queue(nil,
    procedure
    begin }
  while not FFinishedAnimation do
  begin
    Application.ProcessMessages;
    Sleep(10);
  end;
  { end
    ); }

end;

procedure TAnimations.ObjektBewegenTick(ASender: TObject);
var
  progress: Double;
begin

  FTimerAmount := FTimerAmount + FTimerInterval;
  if ( FTimerAmount >= FTimerDuration ) then
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
    if ( FDestroyObject ) then
    begin
      FObject.Free;
    end;

    Exit;
  end;

  if ( not(FObject is TControl) ) then
  begin
    raise Exception.Create('TAnimations.ObjektBewegenTick Error: Sender is not a TControl.');
  end;

  // change the top and left vals
  // jeweils vom Startpunkt ausgehend, ein x-tel des zu gehenden Wegs beschreiten, wobei das x-tel durch die Zeit erkl�rt wird
  progress := FTimerInterval / FTimerDuration;
  FObject.Top := FObject.Top + Round(FWayTop * progress);
  FObject.Left := FObject.Left + Round(FWayLeft * progress);

end;

procedure TAnimations.TypewriterEffect(AText: String);
begin
  if ( not(FObject is TControl) ) then
  begin
    raise Exception.Create('TAnimations.ObjektBewegenTick Error: Sender is not a TControl.');
  end;
  
end;


end.
