unit Main;

interface

uses
  Types,
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

    TeamEingabeFenster: TTeamEingabeFenster;
    StadionEingabeFenster: TStadionEingabeFenster;

    procedure FormCreate(Sender: TObject);
    procedure TeamHinzufuegenButtonClick(Sender: TObject);
    procedure StadionHinzufuegenButtonClick(Sender: TObject);

  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;


var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TeamHinzufuegenButtonClick(Sender: TObject);
begin
  TeamEingabeFenster := TTeamEingabeFenster.Create(nil);
  TeamEingabeFenster.Show; // ShowModal;
end;

procedure StadionHinzufuegenButtonClick(Sender: TObject);
begin
  StadionEingabeTeamEingabeFenster := TStadionEingabeTeamEingabeFenster.Create(nil);
  StadionEingabeTeamEingabeFenster.Show; // ShowModal;
end;

procedure TMainForm.DrawTListBox();
var
  i: Byte;
begin

  // GetStructured ^

end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  // Nachgucken, ob es in der DB Einträge gibt
  // Has


  // Einen State in src/simulation erstellen
end;

end.
