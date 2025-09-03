unit Main;

interface

uses
  System.Classes,
  System.Generics.Collections,
  System.ImageList,
  System.SysUtils,
  System.Variants,
  Vcl.ComCtrls,
  Vcl.Controls,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.Forms,
  Vcl.Graphics,
  Vcl.ImgList,
  Vcl.Grids,
  Vcl.StdCtrls,
  Winapi.Messages,
  Winapi.Windows,
  clrDB,
  damTypes,
  clrState,
  clrVerlosung,
  clrGruppenphase,
  fraTeamEingabeFenster,
  fraStadionEingabeFenster,
  clrUtils.Routing,
  clrUtils.TableFormating, Vcl.Outline, Vcl.ToolWin;

type  TMainForm = class(TForm)
    PageControl: TPageControl;
    UeberschriftStammdaten: TLabel;
    TeamHinzufuegenButton: TButton;
    StadionHinzufuegenButton: TButton;
    Stammdaten: TTabSheet;
    VerlosungSheet: TTabSheet;
    GruppenphaseSheet: TTabSheet;
    SpielSheet: TTabSheet;

    SymbolImageList: TImageList;
    StadienStringGrid: TStringGrid;
    TeamsStringGrid: TStringGrid;
    UeberschriftVerlosung: TLabel;
    UeberschriftGruppenphase: TLabel;
    ZurGruppenphaseButton: TButton;
    ZurVerlosungButton: TButton;
    ZumSpielButton: TButton;
    StadionAnzahlLabel: TLabel;
    StadionVergleichsLabel: TLabel;
    StadionGewollteAnzahlLabel: TLabel;
    TeamAnzahlLabel: TLabel;
    TeamVergleichsLabel: TLabel;
    TeamGewollteAnzahlLabel: TLabel;
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    StringGrid3: TStringGrid;
    StringGrid4: TStringGrid;
    StringGrid5: TStringGrid;
    StringGrid6: TStringGrid;
    StringGrid7: TStringGrid;
    StringGrid8: TStringGrid;
    StringGrid9: TStringGrid;
    StringGrid10: TStringGrid;
    StringGrid11: TStringGrid;
    StringGrid12: TStringGrid;
    VerlosungStartenButton: TButton;
    Timer1: TTimer;
    GruppenphaseStartenButton: TButton;
    GruppenphaseStringGrid: TStringGrid;
    Spiel1Label: TLabel;
    Spiel2Label: TLabel;
    Spiel3Label: TLabel;
    Spiel4Label: TLabel;
    Spiel5Label: TLabel;
    Spiel6Label: TLabel;
    FinaleMatchLabel: TLabel;
    FinaleLabel: TLabel;
    Platz3Label: TLabel;
    Platz3MatchLabel: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label10: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    StatusBar1: TStatusBar;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label39: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    Label47: TLabel;
    Label50: TLabel;
    SechzehntelfinaleLabel1: TLabel;
    SechzehntelfinaleLabel2: TLabel;
    SechzehntelfinaleLabel3: TLabel;
    Label30: TLabel;
    Label38: TLabel;
    SechzehntelfinaleLabel4: TLabel;
    SechzehntelfinaleLabel5: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    SechzehntelfinaleLabel6: TLabel;
    Label56: TLabel;
    SechzehntelfinaleLabel7: TLabel;
    Label58: TLabel;
    SechzehntelfinaleLabel8: TLabel;
    Label60: TLabel;
    Label61: TLabel;
    SechzehntelfinaleLabel9: TLabel;
    Label63: TLabel;
    Label64: TLabel;
    SechzehntelfinaleLabel10: TLabel;
    SechzehntelfinaleLabel11: TLabel;
    Label67: TLabel;
    Label68: TLabel;
    SechzehntelfinaleLabel12: TLabel;
    Label70: TLabel;
    SechzehntelfinaleLabel13: TLabel;
    SechzehntelfinaleLabel14: TLabel;
    Label73: TLabel;
    Label74: TLabel;
    SechzehntelfinaleLabel15: TLabel;
    SechzehntelfinaleLabel16: TLabel;
    Label77: TLabel;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure GruppenphaseStartenButtonClick(Sender: TObject);
    procedure PageControlChanging(Sender: TObject; var AllowChange: Boolean);
    procedure TeamHinzufuegenButtonClick(Sender: TObject);
    procedure StadionHinzufuegenButtonClick(Sender: TObject);
    procedure VerlosungStartenButtonClick(Sender: TObject);
    procedure ZumSpielButtonClick(Sender: TObject);
    procedure ZurGruppenphaseButtonClick(Sender: TObject);
    procedure ZurVerlosungButtonClick(Sender: TObject);

  private

    TeamEingabe: TTeamEingabeFenster;
    StadionEingabe: TStadionEingabeFenster;

    FTeamDB: TDB<TTeam>;
    FStadionDB: TDB<TStadion>;

    FTeamAnzahl: Integer;
    FStadionAnzahl: Integer;

    FVerlosung: TVerlosungUI;
    FGruppenphase: TGruppenphaseUI;
    // FSpiel: TSpielUI;

    FVerlosungFertig: Boolean;
    FGruppenphaseFertig: Boolean;

    FState: TWMState;

  const
    FGewollteTeamAnzahl: Integer = 48;
    FGewollteStadionAnzahl: Integer = 16;

    procedure TeamDBUpdate;
    procedure TeamZeileZeichnen(ARows: TObjectList<TList<String>>);
    procedure StadionDBUpdate;
    procedure StadionTabelleZeichnen(ARows: TObjectList<TList<String>>);
  public
    { Public-Deklarationen }
end;


var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.FormCreate(Sender: TObject);
begin

  // Globaler State, wodrin alle Teams, Gruppen und Auskommen nach und nach gespeichert werden
  FState := TWMState.Create;

  FVerlosung := TVerlosungUI.Create([StringGrid1, StringGrid2, StringGrid3, StringGrid4, StringGrid5, StringGrid6, StringGrid7, StringGrid8, StringGrid9, StringGrid10, StringGrid11, StringGrid12], FState);
  FGruppenphase := TGruppenphaseUI.Create(GruppenphaseStringGrid, FState);
  // FSpiel := nil;

  TeamGewollteAnzahlLabel.Caption := IntToStr(FGewollteTeamAnzahl);
  StadionGewollteAnzahlLabel.Caption := IntToStr(FGewollteStadionAnzahl);

  FTeamDB := TDB<TTeam>.Create(TTeamEingabeFenster.GetTableName);
  FStadionDB := TDB<TStadion>.Create(TStadionEingabeFenster.GetTableName);

  TeamEingabe := TTeamEingabeFenster.Create(FTeamDB);
  StadionEingabe := TStadionEingabeFenster.Create(FStadionDB);

  // Teams laden
  if ( FTeamDB.Initialized ) then
  begin
    TeamDBUpdate;
  end;
  FTeamDB.AddDBUpdateEventListener(TeamDBUpdate);

  // Stadien laden
  if ( FStadionDB.Initialized ) then
  begin
    StadionDBUpdate;
  end;
  FStadionDB.AddDBUpdateEventListener(StadionDBUpdate);

end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin

  FState.Destroy;

  FStadionDB.Destroy;
  FTeamDB.Destroy;

  FVerlosung.Free;
  FGruppenphase.Free;

  StadionEingabe.Free;
  TeamEingabe.Free;
end;

procedure TMainForm.TeamDBUpdate;
var
  Rows: TObjectList<TList<String>>;
begin

  Rows := FTeamDB.UnstrukturierteTabelleErhaltenCSV();
  FTeamAnzahl := Rows.Count - 1; // Header

  TeamAnzahlLabel.Caption := '0' + IntToStr(FTeamAnzahl);
  if ( FTeamAnzahl >= 10 ) then
  begin
    TeamAnzahlLabel.Caption := IntToStr(FTeamAnzahl);
  end;
  StadionAnzahlLabel.Font.Color := clRed;

  TeamVergleichsLabel.Caption := '<';
  if ( FTeamAnzahl = FGewollteTeamAnzahl ) then
  begin
    TeamVergleichsLabel.Caption := '=';
    TeamVergleichsLabel.Font.Color := clGreen;
    TeamVergleichsLabel.Font.Style := [fsBold];
    TeamAnzahlLabel.Font.Color := clGreen;
    TeamAnzahlLabel.Font.Style := [fsBold];

    TeamHinzufuegenButton.Enabled := false;
  end;

  // Hierdrin wird UnstrukturierteTabelleErhaltenCSV aufgerufen also vorher StrukturierteTabelleErhaltenCSV aufrufen, um damit nicht nur die Daten zu laden, sonder auch die Daten zu cachen
  TeamZeileZeichnen(Rows);

  Rows.Free;
end;

procedure TMainForm.TeamZeileZeichnen(ARows: TObjectList<TList<String>>);
begin
  if ( ARows.Count <> 0 ) then
  begin
    clrUtils.TableFormating.VolleTabelleZeichnen(TeamsStringGrid, ARows);
  end;

end;

procedure TMainForm.StadionDBUpdate;
var
  Rows: TObjectList<TList<String>>;
begin

  Rows := FStadionDB.UnstrukturierteTabelleErhaltenCSV();
  FStadionAnzahl := Rows.Count - 1; // Header

  StadionAnzahlLabel.Caption := '0' + IntToStr(FStadionAnzahl);
  if ( FStadionAnzahl >= 10 ) then
  begin
    StadionAnzahlLabel.Caption := IntToStr(FStadionAnzahl);
  end;
  StadionAnzahlLabel.Font.Color := clRed;

  StadionVergleichsLabel.Caption := '<';
  if ( FStadionAnzahl = FGewollteStadionAnzahl ) then
  begin
    StadionVergleichsLabel.Caption := '=';
    StadionVergleichsLabel.Font.Color := clGreen;
    StadionVergleichsLabel.Font.Style := [fsBold];
    StadionAnzahlLabel.Font.Color := clGreen;
    StadionAnzahlLabel.Font.Style := [fsBold];

    StadionHinzufuegenButton.Enabled := false;
  end;

  // Hierdrin wird UnstrukturierteTabelleErhaltenCSV aufgerufen also vorher StrukturierteTabelleErhaltenCSV aufrufen, um damit nicht nur die Daten zu laden, sonder auch die Daten zu cachen
  StadionTabelleZeichnen(Rows);

  Rows.Free;
end;

procedure TMainForm.StadionTabelleZeichnen(ARows: TObjectList<TList<String>>);
begin
  if ARows.Count <> 0 then
  begin
    clrUtils.TableFormating.VolleTabelleZeichnen(StadienStringGrid, ARows);
  end;

end;

procedure TMainForm.TeamHinzufuegenButtonClick(Sender: TObject);
begin
  TeamEingabe.Show; // ShowModal;
end;

procedure TMainForm.StadionHinzufuegenButtonClick(Sender: TObject);
begin
  StadionEingabe.Show; // ShowModal;
end;

procedure TMainForm.VerlosungStartenButtonClick(Sender: TObject);
begin
  FVerlosungFertig := FVerlosung.VerlosungStarten(FTeamDB, VerlosungSheet);

  // Wenn es genügend Gruppen gibt
  if ( FState.GetGruppen.Count = 12 ) then
  begin
    ZurGruppenphaseButton.Enabled := true;
  end;
end;

procedure TMainForm.GruppenphaseStartenButtonClick(Sender: TObject);
begin

  // Gruppenphase Labels und Sechzehntelfinale Labels
  FGruppenphase.GruppenphaseStarten([ Spiel1Label, Spiel2Label, Spiel3Label, Spiel4Label, Spiel5Label, Spiel6Label ], [ SechzehntelfinaleLabel1, SechzehntelfinaleLabel2, SechzehntelfinaleLabel3, SechzehntelfinaleLabel4, SechzehntelfinaleLabel5, SechzehntelfinaleLabel6, SechzehntelfinaleLabel7, SechzehntelfinaleLabel8, SechzehntelfinaleLabel9, SechzehntelfinaleLabel10, SechzehntelfinaleLabel11, SechzehntelfinaleLabel12, SechzehntelfinaleLabel13, SechzehntelfinaleLabel14, SechzehntelfinaleLabel15, SechzehntelfinaleLabel16 ]);

end;

procedure TMainForm.ZurVerlosungButtonClick(Sender: TObject);
begin
  // Gültigkeitsprüfung
  if not ( clrUtils.Routing.OnVerlosungChanging((FTeamAnzahl = FGewollteTeamAnzahl)
    and ( FStadionAnzahl = FGewollteStadionAnzahl)) ) then
  begin
    Exit;
  end;

  // Verlosung starten
  FVerlosungFertig := FVerlosung.VerlosungStarten(FTeamDB, VerlosungSheet);
end;

procedure TMainForm.ZurGruppenphaseButtonClick(Sender: TObject);
begin
  // Gültigkeitsprüfung
  if not ( clrUtils.Routing.OnGruppenphaseChanging((FTeamAnzahl = FGewollteTeamAnzahl)
    and ( FStadionAnzahl = FGewollteStadionAnzahl)) ) then
  begin
    Exit;
  end;
end;

procedure TMainForm.ZumSpielButtonClick(Sender: TObject);
begin
  // Gültigkeitsprüfung
end;

procedure TMainForm.PageControlChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  case TPageControl(Sender).ActivePageIndex of
    0:
      AllowChange := clrUtils.Routing.OnStammdatenChanging(True);
      // man kann immer zurück zu den Stammdaten
    1:
      begin
        AllowChange := clrUtils.Routing.OnVerlosungChanging
          ((FTeamAnzahl = FGewollteTeamAnzahl) and
          (FStadionAnzahl = FGewollteStadionAnzahl));
      end;
    2:
      begin
        AllowChange := clrUtils.Routing.OnGruppenphaseChanging((FVerlosungFertig));

        // Spielplan Klasse erstellen?
        // if not ( Assigned(FSpielplan) ) then
        // begin
        // FSpielplan := TSpielplanUI.Create();
        // end;
      end;
    3:
      begin
        AllowChange := clrUtils.Routing.OnSpielChanging((FGruppenphaseFertig));
      end;
  end;

  AllowChange := True;
end;

end.
