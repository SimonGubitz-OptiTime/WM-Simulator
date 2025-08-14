unit Main;

interface

uses
  DB,
  Types,
  StadionEingabeFenster,
  TeamEingabeFenster,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls,
  System.ImageList, Vcl.ImgList;

type
  TMainForm = class(TForm)
    PageControl: TPageControl;
      Stammdaten: TTabSheet;
        UeberschriftStammdaten: TLabel;
        ListBox1: TListBox;
        TeamHinzufuegenButton: TButton;
        StadionHinzufuegenButton: TButton;
    Verlosung: TTabSheet;
    Spielplan: TTabSheet;
    Spiel: TTabSheet;
    SymbolImageList: TImageList;
    TeamEingabe: TTeamEingabeFenster;
    StadionEingabe: TStadionEingabeFenster;

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

procedure TMainForm.DrawTListBox();
var
  i: Byte;
begin




end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  // Nachgucken, ob es in der DB Einträge gibt
  // Has


  // Einen State in src/simulation erstellen
end;

end.
