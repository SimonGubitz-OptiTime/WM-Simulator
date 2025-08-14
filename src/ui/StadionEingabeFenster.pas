unit StadionEingabeFenster;

interface

uses
  Types,
  DB,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TStadionEingabeFenster = class(TForm)
    StadionUeberschrift: TLabel;
    NameLabel: TLabel;
    NameEingabeFeld: TEdit;
    OrtLabel: TLabel;
    OrtEingabeFeld: TEdit;
    ZuschauerKapazitaetLabel: TLabel;
    ZuschauerKapazitaetEingabeFeld: TEdit;
    BestaetigenButton: TButton;
    procedure BestaetigenButtonClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;



implementation

{$R *.dfm}

procedure TStadionEingabeFenster.BestaetigenButtonClick(Sender: TObject);
var
  placeholder: Integer;
  Stadion: TStadion;
  database: TDB<TStadion>;
begin
  
  // Gültigkeitsprüfung der Nutzereingabe
  if (NameEingabeFeld.Text = '') or (OrtEingabeFeld.Text = '') or (ZuschauerKapazitaetEingabeFeld.Text = '') then
  begin
    ShowMessage('Bitte füllen Sie alle Felder aus.');
    Exit;
  end;

  if not(TryStrToInt(ZuschauerKapazitaetEingabeFeld.Text, placeholder)) then
  begin
    ShowMessage('Bitte tragen sie eine gültige Zahl ein.');
    Exit;
  end;

  if (StrToInt(ZuschauerKapazitaetEingabeFeld.Text) < 0) then
  begin
    ShowMessage('Diese Zahl ist zu klein - bitte tragen sie eine gültige Zahl ein.');
    Exit;
  end;

  if (StrToInt(ZuschauerkapazitaetEingabeFeld.Text) > High(UInt32)) then
  begin
    ShowMessage('Diese Zahl ist zu groß - bitte tragen sie eine gültige Zahl ein.');
    Exit;
  end;


  Stadion := Default(TStadion);

  Stadion.Name := NameEingabeFeld.Text;
  Stadion.Ort := OrtEingabeFeld.Text;
  Stadion.ZuschauerKapazitaet := StrToInt(ZuschauerKapazitaetEingabeFeld.Text);


  // Write into DB

  database := TDB<TStadion>.Create('Stadien');
  database.AddCSVTableToDB(Stadion);


end;

end.

