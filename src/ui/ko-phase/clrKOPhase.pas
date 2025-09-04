unit clrKOPhase;

interface

uses
  System.Generics.Collections,
  System.SysUtils,
  Vcl.StdCtrls,
  Vcl.Graphics,
  Vcl.Dialogs,
  damTypes,
  clrState,
  clrSimulation,
  clrUtils.SortHashMap,
  clrUtils.StringFormating;

type
  TKOPhaseUI = class
  private
    FState: TWMState;
    FSechzehntelfinaleLabels: TArray<TLabel>;
    FAchtelfinaleLabels: TArray<TLabel>;
    FViertelfinaleLabels: TArray<TLabel>;
    FHalbfinaleLabels: TArray<TLabel>;
    FFinaleLabel: TLabel;
    FSpielUmPlatz3Label: TLabel;

    FCurrentTeams: TList<TPair<Byte, Byte>>;
    FCurrentLabels: TArray<TLabel>;


    procedure KOPhaseCallback(Sender: TObject; ANdx: Integer; ATeam1Tore, ATeam2Tore: Integer);
  public

    constructor Create(ASechzehntelfinaleLabels: TArray<TLabel>; AAchtelfinaleLabels: TArray<TLabel>; AViertelfinaleLabels: TArray<TLabel>; AHalbfinaleLabels: TArray<TLabel>; AFinaleLabel: TLabel; ASpielUmPlatz3Label: TLabel; const AState: TWMState);
    destructor Destroy; override;

    procedure KOPhaseStarten;
  end;

implementation

constructor TKOPhaseUI.Create(ASechzehntelfinaleLabels: TArray<TLabel>; AAchtelfinaleLabels: TArray<TLabel>; AViertelfinaleLabels: TArray<TLabel>; AHalbfinaleLabels: TArray<TLabel>; AFinaleLabel: TLabel; ASpielUmPlatz3Label: TLabel; const AState: TWMState);
begin
  FState := AState;
  FSechzehntelfinaleLabels := ASechzehntelfinaleLabels;
  FAchtelfinaleLabels := AAchtelfinaleLabels;
  FViertelfinaleLabels := AViertelfinaleLabels;
  FHalbfinaleLabels := AHalbfinaleLabels;
  FFinaleLabel := AFinaleLabel;
  FSpielUmPlatz3Label := ASpielUmPlatz3Label;
  inherited Create;
end;

destructor TKOPhaseUI.Destroy;
begin
  inherited Destroy;
end;

procedure TKOPhaseUI.KOPhaseStarten;
var
  RoundOf32Teams: TList<TTeam>;
  Ndx: Integer;
  Team1, Team2: TTeam;
  TempTeam: TTeam;
begin
  // Sicherstellen, dass die Sechzehntelfinale-Teams vorhanden sind
  if FState.GetSechzehntelFinalisten.Count = 0 then
  begin
    raise Exception.Create('Sechzehntelfinale teams are not set in the state.');
  end;


  var Myself := TObjectList<TSimulation>.Create;
  try

    // Sechzehntelfinale
    for Ndx := 0 to FState.GetSechzehntelFinalisten.Count - 1 do
    begin
      FCurrentTeams := FState.GetSechzehntelFinalisten;
      FCurrentLabels := FSechzehntelFinaleLabels;

      FCurrentLabels[Ndx].Font.Style := [fsBold];
      FCurrentLabels[Ndx].Font.Color := clGreen;


      Myself.Add(TSimulation.Create(6));
      Myself.Last.SpielSimulieren(KOPhaseCallback, Ndx);

      FCurrentLabels[Ndx].Font.Style := [];
      FCurrentLabels[Ndx].Font.Color := clWindowText;
    end;

    // Kurz warten
    Sleep(250);


    // Achtelfinale
    for Ndx := 0 to FState.GetAchtelFinalisten.Count - 1 do
    begin

      ShowMessage('ich bin müde alter');

      FCurrentTeams := FState.GetAchtelFinalisten;
      FCurrentLabels := FAchtelfinaleLabels;

      FCurrentLabels[Ndx].Font.Style := [fsBold];
      FCurrentLabels[Ndx].Font.Color := clGreen;

      Myself.Add(TSimulation.Create(5)); // immer einen weniger, da es ja theoritisch immer schwieriger wird
      Myself.Last.SpielSimulieren(KOPhaseCallback, Ndx);

      FCurrentLabels[Ndx].Font.Style := [];
      FCurrentLabels[Ndx].Font.Color := clWindowText;
    end;

    // Kurz warten
    Sleep(250);


    // Viertelfinale
    for Ndx := 0 to FState.GetViertelFinalisten.Count - 1 do
    begin
      FCurrentTeams := FState.GetViertelFinalisten;
      FCurrentLabels := FViertelFinaleLabels;

      FCurrentLabels[Ndx].Font.Style := [fsBold];
      FCurrentLabels[Ndx].Font.Color := clGreen;

      Myself.Add(TSimulation.Create(5));
      Myself.Last.SpielSimulieren(KOPhaseCallback, Ndx);

      FCurrentLabels[Ndx].Font.Style := [];
      FCurrentLabels[Ndx].Font.Color := clWindowText;
    end;

    // Kurz warten
    Sleep(250);


    // Halbfinale
    for Ndx := 0 to FState.GetHalbFinalisten.Count - 1 do
    begin
      FCurrentTeams := FState.GetHalbFinalisten;
      FCurrentLabels := FHalbFinaleLabels;

      FCurrentLabels[Ndx].Font.Style := [fsBold];
      FCurrentLabels[Ndx].Font.Color := clGreen;

      Myself.Add(TSimulation.Create(5));
      Myself.Last.SpielSimulieren(KOPhaseCallback, Ndx);

      FCurrentLabels[Ndx].Font.Style := [];
      FCurrentLabels[Ndx].Font.Color := clWindowText;
    end;

    // Kurz warten
    Sleep(250);


    // Spiel um Platz 3
    FCurrentTeams.Clear;
    FCurrentTeams.Add(FState.GetSpielUmPlatz3);
    FCurrentLabels := [FSpielUmPlatz3Label];
    FCurrentLabels[0].Font.Style := [fsBold];
    FCurrentLabels[0].Font.Color := clGreen;

    Myself.Add(TSimulation.Create(5));
    Myself.Last.SpielSimulieren(KOPhaseCallback, 0);

    FCurrentLabels[0].Font.Style := [];
    FCurrentLabels[0].Font.Color := clWindowText;

    // Kurz warten
    Sleep(250);


    // Finale
    FCurrentTeams.Clear;
    FCurrentTeams.Add(FState.GetFinalisten);
    FCurrentLabels := [FFinaleLabel];

    FCurrentLabels[0].Font.Style := [fsBold];
    FCurrentLabels[0].Font.Color := clGreen;

    Myself.Add(TSimulation.Create(5));
    Myself.Last.SpielSimulieren(KOPhaseCallback, 0);

    FCurrentLabels[0].Font.Style := [];
    FCurrentLabels[0].Font.Color := clWindowText;

  finally
    Myself.Free;
  end;

end;

procedure TKOphaseUI.KOPhaseCallback(Sender: TObject; ANdx: Integer; ATeam1Tore, ATeam2Tore: Integer);
var
  Team1, Team2: TTeam;
begin
  Team1 := FState.GetTeams.Items[FCurrentTeams.Items[ANdx].Key];
  Team2 := FState.GetTeams.Items[FCurrentTeams.Items[ANdx].Value];

  FCurrentLabels[ANdx].Caption := clrUtils.StringFormating.FormatMatchString(Team1.Name, Team2.Name, ATeam1Tore, ATeam2Tore);

  // Update state

end;


end.
