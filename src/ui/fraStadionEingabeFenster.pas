unit fraStadionEingabeFenster;

interface

uses
  System.Classes,
  System.SysUtils,
  System.Variants,
  Vcl.Controls,
  Vcl.Dialogs,
  Vcl.Forms,
  Vcl.Graphics,
  Vcl.StdCtrls,
  Winapi.Messages,
  Winapi.Windows,
  clrDB,
  damTypes;

type
  TStadionEingabeFenster = class(TForm)
  private

    var
      FDatabase: TDB<TStadion>;

    // ShortString, weil sonst der Compiler wegen des gemanageten Strings meckert
    const
      FTableName: ShortString = 'Stadien';
  public

    StadionUeberschrift: TLabel;
    NameLabel: TLabel;
    NameEingabeFeld: TEdit;
    OrtLabel: TLabel;
    OrtEingabeFeld: TEdit;
    ZuschauerKapazitaetLabel: TLabel;
    ZuschauerKapazitaetEingabeFeld: TEdit;
    BestaetigenButton: TButton;

    constructor Create(var ADatabase: TDB<TStadion>); reintroduce;

    procedure BestaetigenButtonClick(Sender: TObject);
    class function GetTableName: ShortString;

  
end;

implementation

{$R *.dfm}

constructor TStadionEingabeFenster.Create(var ADatabase: TDB<TStadion>);
begin
  FDatabase := ADatabase;
  if not ( FDatabase.Initialized ) then
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
  if ( NameEingabeFeld.Text = '') or (OrtEingabeFeld.Text = '') or
    (ZuschauerKapazitaetEingabeFeld.Text = '' ) then
  begin
    ShowMessage('Bitte füllen Sie alle Felder aus.');
    Exit;
  end;

  if not ( TryStrToInt(ZuschauerKapazitaetEingabeFeld.Text, placeholder) ) then
  begin
    ShowMessage('Bitte tragen sie eine gültige Zahl ein.');
    Exit;
  end;

  if ( StrToInt(ZuschauerKapazitaetEingabeFeld.Text) < 0 ) then
  begin
    ShowMessage
      ('Diese Zahl ist zu klein - bitte tragen sie eine gültige Zahl ein.');
    Exit;
  end;

  // if ( StrToInt(ZuschauerkapazitaetEingabeFeld.Text) > High(UInt32) ) then
  // begin
  // ShowMessage('Diese Zahl ist zu groß - bitte tragen sie eine gültige Zahl ein.');
  // Exit;
  // end;

  Stadion := Default (TStadion);

  Stadion.Name := NameEingabeFeld.Text;
  Stadion.Ort := OrtEingabeFeld.Text;
  Stadion.ZuschauerKapazitaet := StrToInt(ZuschauerKapazitaetEingabeFeld.Text);

  // In die Datenbank schreiben
  FDatabase.AddRowToCSV(Stadion);

  // Fenster schließen
  Self.Close;

end;

class function TStadionEingabeFenster.GetTableName: ShortString;
begin
  Result := FTableName;
end;

end.
