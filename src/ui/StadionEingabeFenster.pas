unit StadionEingabeFenster;

interface

uses
  DB,
  Types,
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


    constructor Create(var database: TDB<TStadion>); reintroduce;

    procedure BestaetigenButtonClick(Sender: TObject);
    class function GetTableName: ShortString;

    destructor Destroy(Sender: TObject); reintroduce;

  private
    var FDatabase: TDB<TStadion>;
    const FTableName: ShortString = 'Stadien';
  end;



implementation

{$R *.dfm}

constructor TStadionEingabeFenster.Create(var database: TDB<TStadion>);
begin
  FDatabase := database;
  if not(FDatabase.Initialized) then
  begin
    FDatabase := TDB<TStadion>.Create(FTableName);
  end;

  inherited Create(nil);
end;

procedure TStadionEingabeFenster.BestaetigenButtonClick(Sender: TObject);
var
  placeholder: Integer;
  Stadion: TStadion;
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

//  if (StrToInt(ZuschauerkapazitaetEingabeFeld.Text) > High(UInt32)) then
//  begin
//    ShowMessage('Diese Zahl ist zu groß - bitte tragen sie eine gültige Zahl ein.');
//    Exit;
//  end;


  Stadion := Default(TStadion);

  Stadion.Name := NameEingabeFeld.Text;
  Stadion.Ort := OrtEingabeFeld.Text;
  Stadion.ZuschauerKapazitaet := StrToInt(ZuschauerKapazitaetEingabeFeld.Text);


  // In die Datenbank schreiben
  FDatabase.AddRowToCSV(Stadion);

  Self.Close;


end;

class function TStadionEingabeFenster.GetTableName: ShortString;
begin
  Result := FTableName;
end;

destructor TStadionEingabeFenster.Destroy;
begin
  // Aufräumen
  FDatabase.Destroy;
end;


end.