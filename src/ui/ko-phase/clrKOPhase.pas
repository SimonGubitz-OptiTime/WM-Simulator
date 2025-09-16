unit clrKOPhase;

interface

uses
  System.Generics.Collections,
  System.Math,
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
    FState: IState;
    FSechzehntelfinaleLabels: TArray<TLabel>;
    FAchtelfinaleLabels: TArray<TLabel>;
    FViertelfinaleLabels: TArray<TLabel>;
    FHalbfinaleLabels: TArray<TLabel>;
    FFinaleLabel: TLabel;
    FSpielUmPlatz3Label: TLabel;

    FCurrentTeams: TList<TPair<Byte, Byte>>;
    FCurrentLabels: TArray<TLabel>;
    FNextStage: TList<Byte>;
    FNextStageSpielUmPlatz3: TList<Byte>;

    procedure KOPhaseCallback(Sender: TObject; ASpiel: TSpiel; ASpielIDs: TSpielIDs);

  public

    constructor Create(ASechzehntelfinaleLabels: TArray<TLabel>; AAchtelfinaleLabels: TArray<TLabel>; AViertelfinaleLabels: TArray<TLabel>; AHalbfinaleLabels: TArray<TLabel>; AFinaleLabel: TLabel; ASpielUmPlatz3Label: TLabel; AState: IState);
    destructor Destroy; override;

    procedure KOPhaseStarten;
  end;

const
  SLEEP_DURATION: Byte = 250;

implementation

constructor TKOPhaseUI.Create(ASechzehntelfinaleLabels: TArray<TLabel>; AAchtelfinaleLabels: TArray<TLabel>; AViertelfinaleLabels: TArray<TLabel>; AHalbfinaleLabels: TArray<TLabel>; AFinaleLabel: TLabel; ASpielUmPlatz3Label: TLabel; AState: IState);
begin
  FState := AState;
  FSechzehntelfinaleLabels := ASechzehntelfinaleLabels;
  FAchtelfinaleLabels := AAchtelfinaleLabels;
  FViertelfinaleLabels := AViertelfinaleLabels;
  FHalbfinaleLabels := AHalbfinaleLabels;
  FFinaleLabel := AFinaleLabel;
  FSpielUmPlatz3Label := ASpielUmPlatz3Label;

  FNextStage := TList<Byte>.Create;
  FNextStageSpielUmPlatz3 := TList<Byte>.Create;

  inherited Create;
end;

destructor TKOPhaseUI.Destroy;
begin
  FNextStage.Free;
  FNextStageSpielUmPlatz3.Free;

  inherited Destroy;
end;

procedure TKOPhaseUI.KOPhaseStarten;
var
  RoundOf32Teams: TList<TTeam>;
  Ndx: Integer;
  Team1, Team2: TTeam;
  TempTeam: TTeam;
  Spiel: TSpiel;
begin
  // Sicherstellen, dass die Sechzehntelfinale-Teams vorhanden sind
  if FState.GetSechzehntelFinalisten.Count = 0 then
  begin
    raise ESkipStepException.Create('Bitte erst Gruppenphase starten.');
  end;


  var Simulation := TObjectList<TSimulation>.Create;
  try

    // Sechzehntelfinale
    for Ndx := 0 to FState.GetSechzehntelFinalisten.Count - 1 do
    begin
      FCurrentTeams := FState.GetSechzehntelFinalisten;
      FCurrentLabels := FSechzehntelFinaleLabels;

      FCurrentLabels[Ndx].Font.Style := [fsBold];
      FCurrentLabels[Ndx].Font.Color := clGreen;

      Spiel := TSpiel.Create;
      Spiel.Team1 := FState.GetTeams.Items[FCurrentTeams[Ndx].Key];
      Spiel.Team2 := FState.GetTeams.Items[FCurrentTeams[Ndx].Value];
      Spiel.Stadion := Default(TStadion);

      Simulation.Add(TSimulation.Create(FState, 6));
      Simulation.Last.SpielSimulieren(KOPhaseCallback, Spiel, FCurrentTeams.Items[Ndx]);

      FCurrentLabels[Ndx].Caption := clrUtils.StringFormating.FormatSpielString(Spiel);
      Spiel.Destroy;

      FCurrentLabels[Ndx].Font.Style := [];
      FCurrentLabels[Ndx].Font.Color := clWindowText;
    end;

    // Kurz warten
    Sleep(SLEEP_DURATION);


    Ndx := 0;
    while Ndx < FNextStage.Count - 1 do
    begin
      FState.AddAchtelFinalist(TPair<Byte, Byte>.Create(FNextStage[Ndx], FNextStage[Ndx + 1]));
      var debug := FState.GetAchtelFinalisten;
      Ndx := Ndx + 2;
    end;

    FNextStage.Clear;



    // Achtelfinale
    for Ndx := 0 to FState.GetAchtelFinalisten.Count - 1 do
    begin

      FCurrentTeams := FState.GetAchtelFinalisten;
      FCurrentLabels := FAchtelfinaleLabels;

      FCurrentLabels[Ndx].Font.Style := [fsBold];
      FCurrentLabels[Ndx].Font.Color := clGreen;



      Spiel := TSpiel.Create;
      Spiel.Team1 := FState.GetTeams.Items[FCurrentTeams.Items[Ndx].Key];
      Spiel.Team2 := FState.GetTeams.Items[FCurrentTeams.Items[Ndx].Value];
      Spiel.Stadion := Default(TStadion);

      Simulation.Add(TSimulation.Create(FState, 5)); // immer einen weniger, da es ja theoretisch immer schwieriger wird
      Simulation.Last.SpielSimulieren(KOPhaseCallback, Spiel, FCurrentTeams.Items[Ndx]);

      FCurrentLabels[Ndx].Caption := clrUtils.StringFormating.FormatSpielString(Spiel);
      Spiel.Destroy;

      FCurrentLabels[Ndx].Font.Style := [];
      FCurrentLabels[Ndx].Font.Color := clWindowText;
    end;

    // Kurz warten
    Sleep(SLEEP_DURATION);

    Ndx := 0;
    while Ndx < FNextStage.Count - 1 do
    begin
      FState.AddViertelFinalist(TPair<Byte, Byte>.Create(FNextStage[Ndx], FNextStage[Ndx + 1]));
      var debug := FState.GetViertelFinalisten;
      Ndx := Ndx + 2;
    end;

    FNextStage.Clear;



    // Viertelfinale
    for Ndx := 0 to FState.GetViertelFinalisten.Count - 1 do
    begin
      FCurrentTeams := FState.GetViertelFinalisten;
      FCurrentLabels := FViertelFinaleLabels;

      FCurrentLabels[Ndx].Font.Style := [fsBold];
      FCurrentLabels[Ndx].Font.Color := clGreen;



      Spiel := TSpiel.Create;
      Spiel.Team1 := FState.GetTeams.Items[FCurrentTeams.Items[Ndx].Key];
      Spiel.Team2 := FState.GetTeams.Items[FCurrentTeams.Items[Ndx].Value];
      Spiel.Stadion := Default(TStadion);

      Simulation.Add(TSimulation.Create(FState, 5));
      Simulation.Last.SpielSimulieren(KOPhaseCallback, Spiel, FCurrentTeams.Items[Ndx]);

      FCurrentLabels[Ndx].Caption := clrUtils.StringFormating.FormatSpielString(Spiel);
      Spiel.Destroy;

      FCurrentLabels[Ndx].Font.Style := [];
      FCurrentLabels[Ndx].Font.Color := clWindowText;
    end;

    // Kurz warten
    Sleep(SLEEP_DURATION);

    Ndx := 0;
    while Ndx < FNextStage.Count - 1 do
    begin
      FState.AddHalbFinalist(TPair<Byte, Byte>.Create(FNextStage[Ndx], FNextStage[Ndx + 1]));
      Ndx := Ndx + 2;
    end;

    FNextStage.Clear;
    FNextStageSpielUmPlatz3.Clear;


    // Halbfinale
    for Ndx := 0 to FState.GetHalbFinalisten.Count - 1 do
    begin
      FCurrentTeams := FState.GetHalbFinalisten;
      FCurrentLabels := FHalbFinaleLabels;

      FCurrentLabels[Ndx].Font.Style := [fsBold];
      FCurrentLabels[Ndx].Font.Color := clGreen;

      Spiel := TSpiel.Create;
      Spiel.Team1 := FState.GetTeams.Items[FCurrentTeams.Items[Ndx].Key];
      Spiel.Team2 := FState.GetTeams.Items[FCurrentTeams.Items[Ndx].Value];
      Spiel.Stadion := Default(TStadion);

      Simulation.Add(TSimulation.Create(FState, 5));
      Simulation.Last.SpielSimulieren(KOPhaseCallback, Spiel, FCurrentTeams.Items[Ndx]);

      FCurrentLabels[Ndx].Caption := clrUtils.StringFormating.FormatSpielString(Spiel);
      Spiel.Destroy;

      FCurrentLabels[Ndx].Font.Style := [];
      FCurrentLabels[Ndx].Font.Color := clWindowText;
    end;

    // Kurz warten
    Sleep(SLEEP_DURATION);

    Ndx := 0;
    while Ndx < FNextStage.Count do
    begin
      FState.SetSpielUmPlatz3(TPair<Byte, Byte>.Create(FNextStageSpielUmPlatz3[Ndx], FNextStageSpielUmPlatz3[Ndx + 1]));
      Ndx := Ndx + 2;
    end;

    // Spiel um Platz 3
    FCurrentTeams.Clear;
    FCurrentTeams.Add(FState.GetSpielUmPlatz3);
    FCurrentLabels := [FSpielUmPlatz3Label];
    FCurrentLabels[0].Font.Style := [fsBold];
    FCurrentLabels[0].Font.Color := clGreen;

    Spiel := TSpiel.Create;
    Spiel.Team1 := FState.GetTeams.Items[FCurrentTeams.Items[0].Key];
    Spiel.Team2 := FState.GetTeams.Items[FCurrentTeams.Items[0].Value];
    Spiel.Stadion := Default(TStadion);

    Simulation.Add(TSimulation.Create(FState, 5));
    Simulation.Last.SpielSimulieren(KOPhaseCallback, Spiel, FCurrentTeams.Items[0]);

    FCurrentLabels[0].Caption := clrUtils.StringFormating.FormatSpielString(Spiel);
    Spiel.Destroy;

    FCurrentLabels[0].Font.Style := [];
    FCurrentLabels[0].Font.Color := clWindowText;

    // Kurz warten
    Sleep(SLEEP_DURATION);

    Ndx := 0;
    while Ndx < FNextStage.Count - 1 do
    begin
      FState.SetFinalisten(TPair<Byte, Byte>.Create(FNextStage[Ndx], FNextStage[Ndx + 1]));
      Ndx := Ndx + 2;
    end;



    // Finale
    FCurrentTeams.Clear;
    FCurrentTeams.Add(FState.GetFinalisten);
    FCurrentLabels := [FFinaleLabel];

    FCurrentLabels[0].Font.Style := [fsBold];
    FCurrentLabels[0].Font.Color := clGreen;

    Spiel := TSpiel.Create;
    Spiel.Team1 := FState.GetTeams.Items[FCurrentTeams.Items[0].Key];
    Spiel.Team2 := FState.GetTeams.Items[FCurrentTeams.Items[0].Value];
    Spiel.Stadion := Default(TStadion);

    Simulation.Add(TSimulation.Create(FState, 3));
    Simulation.Last.SpielSimulieren(KOPhaseCallback, Spiel, FCurrentTeams.Items[0]);

    FCurrentLabels[0].Caption := clrUtils.StringFormating.FormatSpielString(Spiel);
    Spiel.Destroy;

    FCurrentLabels[0].Font.Style := [];
    FCurrentLabels[0].Font.Color := clWindowText;


    ShowMessage(FState.Teams[FNextStage[0]].Name + ' ist Gewinner der WM. 🏆');

  finally
    FNextStage.Clear;
    FCurrentTeams.Clear;
    Simulation.Free;
  end;

end;


procedure TKOphaseUI.KOPhaseCallback(Sender: TObject; ASpiel: TSpiel; ASpielIDs: TSpielIDs);
begin

  // Update state
  if ( ASpiel.Team1Tore > ASpiel.Team2Tore ) then
  begin
    FNextStage.Add(ASpiel.Team1.ID);
    FNextStageSpielUmPlatz3.Add(ASpiel.Team2.ID);
  end
  else
  begin
    FNextStage.Add(ASpiel.Team2.ID);
    FNextStageSpielUmPlatz3.Add(ASpiel.Team1.ID);
  end;

end;


end.
