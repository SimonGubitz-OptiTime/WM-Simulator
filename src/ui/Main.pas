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
  clrUtils.TableFormating;

type
  TMainForm = class(TForm)
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
    StringGrid13: TStringGrid;
    Spiel1Label: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;

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
    procedure TeamTabelleZeichnen(ARows: TObjectList<TList<String>>);
    procedure StadionDBUpdate;
    procedure StadionTabelleZeichnen(ARows: TObjectList<TList<String>>);
  public
    { Public-Deklarationen }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.TeamDBUpdate;
var
  Rows: TObjectList<TList<String>>;
begin

  Rows := FTeamDB.GetUnstructuredTableFromCSV();
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

  // Hierdrin wird GetUnstructuredTableFromCSV aufgerufen also vorher GetStructuredTableFromCSV aufrufen, um damit nicht nur die Daten zu laden, sonder auch die Daten zu cachen
  TeamTabelleZeichnen(Rows);

  Rows.Free;
end;

procedure TMainForm.TeamTabelleZeichnen(ARows: TObjectList<TList<String>>);
begin
  if ( ARows.Count <> 0 ) then
  begin
    clrUtils.TableFormating.TabelleZeichnen(TeamsStringGrid, ARows);
  end;

end;

procedure TMainForm.StadionDBUpdate;
var
  Rows: TObjectList<TList<String>>;
begin

  Rows := FStadionDB.GetUnstructuredTableFromCSV();
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

  // Hierdrin wird GetUnstructuredTableFromCSV aufgerufen also vorher GetStructuredTableFromCSV aufrufen, um damit nicht nur die Daten zu laden, sonder auch die Daten zu cachen
  StadionTabelleZeichnen(Rows);

  Rows.Free;
end;

procedure TMainForm.StadionTabelleZeichnen(ARows: TObjectList<TList<String>>);
begin
  if ARows.Count <> 0 then
  begin
    clrUtils.TableFormating.TabelleZeichnen(StadienStringGrid, ARows);
  end;

end;

procedure TMainForm.TeamHinzufuegenButtonClick(Sender: TObject);
begin
  TeamEingabe := TTeamEingabeFenster.Create(FTeamDB);
  TeamEingabe.Show; // ShowModal;
end;

procedure TMainForm.StadionHinzufuegenButtonClick(Sender: TObject);
begin
  StadionEingabe := TStadionEingabeFenster.Create(FStadionDB);
  StadionEingabe.Show; // ShowModal;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin

  FState := TWMState.Create;

  FVerlosung := nil;
  FGruppenphase := nil;
  // FSpiel := nil;

  TeamGewollteAnzahlLabel.Caption := IntToStr(FGewollteTeamAnzahl);
  StadionGewollteAnzahlLabel.Caption := IntToStr(FGewollteStadionAnzahl);

  FTeamDB := TDB<TTeam>.Create(TTeamEingabeFenster.GetTableName);
  FStadionDB := TDB<TStadion>.Create(TStadionEingabeFenster.GetTableName);

  // Teams laden
  if ( FTeamDB.Initialized ) then
  begin
    TeamDBUpdate;
  end;
//  FTeamDB.AddDBUpdateEventListener(TeamDBUpdate);

  // Stadien laden
  if ( FStadionDB.Initialized ) then
  begin
    StadionDBUpdate;
  end;
  FStadionDB.AddDBUpdateEventListener(StadionDBUpdate); // fehler hier?

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
  if not ( Assigned(FVerlosung) ) then
  begin
    FVerlosung := TVerlosungUI.Create([StringGrid1, StringGrid2, StringGrid3, StringGrid4, StringGrid5, StringGrid6, StringGrid7, StringGrid8, StringGrid9, StringGrid10, StringGrid11, StringGrid12], FState);
  end;

  FVerlosungFertig := FVerlosung.VerlosungStarten(FTeamDB, Timer1, VerlosungSheet);
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

        if not ( Assigned(FVerlosung) ) then
        begin
          FVerlosung := TVerlosungUI.Create([StringGrid1, StringGrid2, StringGrid3, StringGrid4, StringGrid5, StringGrid6, StringGrid7, StringGrid8, StringGrid9, StringGrid10, StringGrid11, StringGrid12], FState);
        end;
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

procedure TMainForm.VerlosungStartenButtonClick(Sender: TObject);
begin
  if ( not(Assigned(FVerlosung)) or not(FVerlosung.Initialized) ) then
  begin
    FVerlosung := TVerlosungUI.Create([StringGrid1, StringGrid2, StringGrid3, StringGrid4, StringGrid5, StringGrid6, StringGrid7, StringGrid8, StringGrid9, StringGrid10, StringGrid11, StringGrid12], FState);
  end;
  
  FVerlosungFertig := FVerlosung.VerlosungStarten(FTeamDB, Timer1, VerlosungSheet);

  // Wenn es genügend Gruppen gibt
  if ( FState.GetGroups.Count = 12 ) then
  begin
    ZurGruppenphaseButton.Enabled := true;
  end;
end;

procedure TMainForm.GruppenphaseStartenButtonClick(Sender: TObject);
begin
  if ( not(Assigned(FGruppenphase)) ) then
  begin
    FGruppenphase := TGruppenphaseUI.Create(FState);
  end;

  FGruppenphase.GruppenphaseStarten;

end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  // Aufräumen
  StadionEingabe.Free;
  TeamEingabe.Free;


  FState.Destroy;

  FVerlosung.Destroy;
  FStadionDB.Destroy;
  FTeamDB.Destroy;
end;

end.
