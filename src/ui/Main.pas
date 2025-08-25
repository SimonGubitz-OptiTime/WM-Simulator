unit Main;

interface

uses
  DB,
  Types,
  Verlosung,
  Utils.Routing,
  Utils.TableFormating,
  StadionEingabeFenster,
  TeamEingabeFenster,
  System.Classes, System.Generics.Collections, System.SysUtils, System.Variants,
  Vcl.ComCtrls, Vcl.Controls, Vcl.Dialogs, Vcl.Forms, Vcl.Graphics, Vcl.StdCtrls,
  Vcl.ImgList, Vcl.Grids, Vcl.ExtCtrls,
  Winapi.Windows, Winapi.Messages, System.ImageList;

type
  TMainForm = class(TForm)
    PageControl: TPageControl;
    UeberschriftStammdaten: TLabel;
    TeamHinzufuegenButton: TButton;
    StadionHinzufuegenButton: TButton;
    StammdatenSheet: TTabSheet;
    VerlosungSheet: TTabSheet;
    SpielplanSheet: TTabSheet;
    SpielSheet: TTabSheet;

    SymbolImageList: TImageList;
    TeamEingabe: TTeamEingabeFenster;
    StadionEingabe: TStadionEingabeFenster;
    StadienStringGrid: TStringGrid;
    TeamsStringGrid: TStringGrid;
    UeberschriftVerlosung: TLabel;
    UeberschriftSpielplan: TLabel;
    ZumSpielplanButton: TButton;
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

    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PageControlChanging(    Sender: TObject; var AllowChange: Boolean);
    procedure TeamHinzufuegenButtonClick(Sender: TObject);
    procedure StadionHinzufuegenButtonClick(Sender: TObject);
//    procedure VerlosungStartenButtonClick(Sender: TObject);
    procedure ZumSpielButtonClick(Sender: TObject);
    procedure ZumSpielplanButtonClick(Sender: TObject);
    procedure ZurVerlosungButtonClick(Sender: TObject);

  private
    FTeamDB: TDB<TTeam>;
    FStadionDB: TDB<TStadion>;

    FTeamAnzahl: Integer;
    FStadionAnzahl: Integer;

    FVerlosung: TVerlosungUI;
//    FSpielplan: TSpielplanUI;
//    FSpiel: TSpielUI;

    FVerlosungFertig: Boolean;
    FSpielplanFertig: Boolean;

    const FGewollteTeamAnzahl: Integer = 48;
          FGewollteStadionAnzahl: Integer = 16;

    procedure TeamDBUpdate;
    procedure TeamTabelleZeichnen(Rows: TObjectList<TList<String>>);
    procedure StadionDBUpdate;
    procedure StadionTabelleZeichnen(Rows: TObjectList<TList<String>>);
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

  // Rows NICHT .Free, da es TDB<T> gehört
  Rows := FTeamDB.GetUnstructuredTableFromCSV();
  FTeamAnzahl := Rows.Count - 1; // Header

  TeamAnzahlLabel.Caption := '0' + IntToStr(FTeamAnzahl);
  if FTeamAnzahl >= 10 then
  begin
    TeamAnzahlLabel.Caption := IntToStr(FTeamAnzahl);
  end;
  StadionAnzahlLabel.Font.Color := clRed;

  TeamVergleichsLabel.Caption := '<';
  if FTeamAnzahl = FGewollteTeamAnzahl then
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
end;

procedure TMainForm.TeamTabelleZeichnen(Rows: TObjectList<TList<String>>);
begin
  if Rows.Count <> 0 then
  begin
    Utils.TableFormating.TabelleZeichnen(TeamsStringGrid, Rows);
  end;

end;

procedure TMainForm.StadionDBUpdate;
var
  Rows: TObjectList<TList<String>>;
begin

  // Rows NICHT .Free, da es TDB<T> gehört
  Rows := FStadionDB.GetUnstructuredTableFromCSV();
  FStadionAnzahl := Rows.Count - 1; // Header

  StadionAnzahlLabel.Caption := '0' + IntToStr(FStadionAnzahl);
  if FStadionAnzahl >= 10 then
  begin
    StadionAnzahlLabel.Caption := IntToStr(FStadionAnzahl);
  end;
  StadionAnzahlLabel.Font.Color := clRed;

  StadionVergleichsLabel.Caption := '<';
  if FStadionAnzahl = FGewollteStadionAnzahl then
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
end;

procedure TMainForm.StadionTabelleZeichnen(Rows: TObjectList<TList<String>>);
begin
  if Rows.Count <> 0 then
  begin
    Utils.TableFormating.TabelleZeichnen(StadienStringGrid, Rows);
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

  FVerlosung := nil;
//  FSpielplan := nil;
//  FSpiel := nil;

  TeamGewollteAnzahlLabel.Caption := IntToStr(FGewollteTeamAnzahl);
  StadionGewollteAnzahlLabel.Caption := IntToStr(FGewollteStadionAnzahl);

  FTeamDB    := TDB<TTeam>.Create(TTeamEingabeFenster.GetTableName);
  FStadionDB := TDB<TStadion>.Create(TStadionEingabeFenster.GetTableName);

  // Teams laden
  if FTeamDB.Initialized then
  begin
    TeamDBUpdate;
  end;
  FTeamDB.AddDBUpdateEventListener(TeamDBUpdate);

  // Stadien laden
  if FStadionDB.Initialized then
  begin
    StadionDBUpdate;
  end;
  FStadionDB.AddDBUpdateEventListener(StadionDBUpdate);

end;

procedure TMainForm.ZurVerlosungButtonClick(Sender: TObject);
begin
  // Gültigkeitsprüfung
  if not(Utils.Routing.OnVerlosungChanging((FTeamAnzahl = FGewollteTeamAnzahl) and (FStadionAnzahl = FGewollteStadionAnzahl))) then
    Exit;

  // Verlosung starten
  if not Assigned(FVerlosung) then
    FVerlosung := TVerlosungUI.Create([ StringGrid1, StringGrid2, StringGrid3, StringGrid4, StringGrid5, StringGrid6, StringGrid7, StringGrid8, StringGrid9, StringGrid10, StringGrid11, StringGrid12 ]);

  FVerlosungFertig := FVerlosung.VerlosungStarten(FTeamDB, Timer1, VerlosungSheet);
end;

procedure TMainForm.ZumSpielplanButtonClick(Sender: TObject);
begin
  // Gültigkeitsprüfung
end;

procedure TMainForm.ZumSpielButtonClick(Sender: TObject);
begin
  // Gültigkeitsprüfung
end;

procedure TMainForm.PageControlChanging(Sender: TObject; var AllowChange: Boolean);
begin
  case TPageControl(Sender).ActivePageIndex of
    0: AllowChange := Utils.Routing.OnStammdatenChanging(True); // man kann immer zurück zu den Stammdaten
    1: begin
      AllowChange := Utils.Routing.OnVerlosungChanging((FTeamAnzahl = FGewollteTeamAnzahl) and (FStadionAnzahl = FGewollteStadionAnzahl));

      if not(Assigned(FVerlosung)) then
      begin
        FVerlosung := TVerlosungUI.Create([ StringGrid1, StringGrid2, StringGrid3, StringGrid4, StringGrid5, StringGrid6, StringGrid7, StringGrid8, StringGrid9, StringGrid10, StringGrid11, StringGrid12 ]);
      end;
    end;
    2: begin
      AllowChange := Utils.Routing.OnSpielplanChanging((FVerlosungFertig));

      // Spielplan Klasse erstellen?
      // if not(Assigned(FSpielplan)) then
      // begin
      //   FSpielplan := TSpielplanUI.Create();
      // end;
    end;
    3: begin
      AllowChange := Utils.Routing.OnSpielChanging((FSpielplanFertig));
    end;
  end;

  AllowChange := True;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  // Aufräumen
  StadionEingabe.Free;

  FVerlosung.Free;
  FStadionDB.Free;
  FTeamDB.Free;
end;


end.
