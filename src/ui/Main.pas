unit Main;

interface

uses
  DB,
  Types,
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

    procedure FormCreate(Sender: TObject);
    procedure TeamHinzufuegenButtonClick(Sender: TObject);
    procedure StadionHinzufuegenButtonClick(Sender: TObject);

    procedure DrawTListBox();

  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;


var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.TeamHinzufuegenButtonClick(Sender: TObject);
begin
  TeamEingabe := TTeamEingabeFenster.Create(nil);
  TeamEingabe.Show; // ShowModal;
end;

procedure TMainForm.StadionHinzufuegenButtonClick(Sender: TObject);
begin
  StadionEingabe:= TStadionEingabeFenster.Create(self);
  StadionEingabe.Show; // ShowModal;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  StadionDB: TDB<TStadion>;
  TeamDB: TDB<TTeam>;

  Rows: TArray<String>;
  i, j: Integer;
begin

  TeamDB    := TDB<TTeam>.Create('Teams');
  StadionDB := TDB<TStadion>.Create('Stadien');

  // Load Teams
  if TeamDB.Initialized then
  begin
    Rows := TeamDB.GetStructuredTableFromCSV();

    TeamsStringGrid.RowCount := Length(Rows);
    TeamsStringGrid.ColCount := Length(Rows[0]);

    TeamsStringGrid.Cells := Rows;
  end;

  // Load Stadien
  if StadionDB.Initialized then
  begin
    Rows := StadionDB.GetUnstructuredTableFromCSV();

    StadienStringGrid.RowCount := Length(Rows);
    StadienStringGrid.ColCount := Length(Rows[0]);

    StadienStringGrid.Cells := Rows;


  end;


  // Einen State in src/simulation erstellen

end;

end.
