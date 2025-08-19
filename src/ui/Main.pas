unit Main;

interface

uses
  DB,
  Types,
  Utils.TableFormating,
  StadionEingabeFenster,
  TeamEingabeFenster,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls,
  System.ImageList, Vcl.ImgList, Vcl.Grids;

type
  TMainForm = class(TForm)
    PageControl: TPageControl;
    Stammdaten: TTabSheet;
    UeberschriftStammdaten: TLabel;
    TeamHinzufuegenButton: TButton;
    StadionHinzufuegenButton: TButton;
    Verlosung: TTabSheet;
    Spielplan: TTabSheet;
    Spiel: TTabSheet;
    SymbolImageList: TImageList;
    TeamEingabe: TTeamEingabeFenster;
    StadionEingabe: TStadionEingabeFenster;
    StadienStringGrid: TStringGrid;
    TeamsStringGrid: TStringGrid;
    UeberschriftVerlosung: TLabel;
    UeberschriftSpielplan: TLabel;

    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TeamHinzufuegenButtonClick(Sender: TObject);
    procedure StadionHinzufuegenButtonClick(Sender: TObject);

  private
    FTeamDB: TDB<TTeam>;
    FStadionDB: TDB<TStadion>;

    procedure TeamTabelleZeichnen;
    procedure StadionTabelleZeichnen;
  public
    { Public-Deklarationen }
  end;


var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.TeamTabelleZeichnen;
var
  Rows: TArray<TArray<String>>;
begin

  Rows := FTeamDB.GetUnstructuredTableFromCSV();

  if Length(Rows) <> 0 then
  begin
    Utils.TableFormating.TabelleZeichnen(TeamsStringGrid, Rows);
  end;

end;

procedure TMainForm.StadionTabelleZeichnen;
var
  Rows: TArray<TArray<String>>;
begin

  Rows := FStadionDB.GetUnstructuredTableFromCSV();

  if Length(Rows) <> 0 then
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
  StadionEingabe:= TStadionEingabeFenster.Create(FStadionDB);
  StadionEingabe.Show; // ShowModal;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  Rows: TArray<TArray<String>>;                                                                                                
begin

  FTeamDB    := TDB<TTeam>.Create(TTeamEingabeFenster.GetTableName);
  FStadionDB := TDB<TStadion>.Create('Stadien');

  // Teams laden
  if FTeamDB.Initialized then
  begin
    StadionTabelleZeichnen;
  end;

  FTeamDB.AddDBUpdateEventListener(TeamTabelleZeichnen);

  // Stadien laden
  if FStadionDB.Initialized then
  begin
    StadionTabelleZeichnen;
  end;

  FStadionDB.AddDBUpdateEventListener(StadionTabelleZeichnen);


  // Einen State in src/simulation erstellen


end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  // Aufräumen
  FStadionDB.Destroy;
  FTeamDB.Destroy;
end;


end.
