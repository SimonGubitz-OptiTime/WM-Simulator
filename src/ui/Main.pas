unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls,
  System.ImageList, Vcl.ImgList;

type
  TForm1 = class(TForm)
    PageControl: TPageControl;
      Stammdaten: TTabSheet;
      Verlosung: TTabSheet;
      Spielplan: TTabSheet;
      Spiel: TTabSheet;
      UeberschriftStammdaten: TLabel;
    ListBox1: TListBox;
    TeamHinzufügenButton: TButton;
    SymbolImageList: TImageList;
    StadionHinzufügenButton: TButton;
    procedure FormCreate(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  // Nachgucken, ob es in der DB Einträge gibt
end;


end.
