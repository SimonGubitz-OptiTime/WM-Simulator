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

    StadionUeberschrift: TLabel;
    NameLabel: TLabel;
    NameEingabeFeld: TEdit;
    OrtLabel: TLabel;
    OrtEingabeFeld: TEdit;
    ZuschauerKapazitaetLabel: TLabel;
    ZuschauerKapazitaetEingabeFeld: TEdit;
    BestaetigenButton: TButton;

    constructor Create(var ADatabase: IDB<TStadion>);

    procedure BestaetigenButtonClick(Sender: TObject);
    class function GetTableName: ShortString;

    destructor Destroy; override;

  private

    var
      FDatabase: IDB<TStadion>;

    // ShortString, weil sonst der Compiler wegen des gemanageten Strings meckert
    const
      // ShortString, weil ich einen Value-Type für const brauche
      FTableName: ShortString = 'Stadien';
  end;

implementation

{$R *.dfm}

constructor TStadionEingabeFenster.Create(var ADatabase: IDB<TStadion>);
begin

  inherited Create(nil);

  FDatabase := ADatabase;

end;

destructor TStadionEingabeFenster.Destroy;
begin
  inherited Destroy;
end;

procedure TStadionEingabeFenster.BestaetigenButtonClick(Sender: TObject);
var
  placeholder: Integer;
  placeholderRow: TStadion;
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
    ShowMessage('Diese Zahl ist zu klein - bitte tragen sie eine gültige Zahl ein.');
    Exit;
  end;

  // Keine Duplikate erlauben
  if ( FDatabase.ZeileFinden(
    function(Param: TStadion): Boolean
    begin
      // Alles außer ID, weil dies erst in clrVerlosungUI gesetzt wird
      // und Spieler Liste, da Array nicht verglichen werden können
      Result := (
            (Param.Name = NameEingabeFeld.Text)
        and (Param.Ort = OrtEingabeFeld.Text)
        and (Param.ZuschauerKapazitaet = StrToInt(ZuschauerKapazitaetEingabeFeld.Text))
       );
    end,
    placeholderRow
  ) ) then
  begin
    ShowMessage('Bitte tragen Sie kein Duplikat ein.');
    Exit;
  end;

  // if ( StrToInt(ZuschauerkapazitaetEingabeFeld.Text) > High(UInt32) ) then
  // begin
  //  ShowMessage('Diese Zahl ist zu groß - bitte tragen sie eine gültige Zahl ein.');
  //  Exit;
  // end;

  Stadion := Default (TStadion);

  Stadion.Name := NameEingabeFeld.Text;
  Stadion.Ort := OrtEingabeFeld.Text;
  Stadion.ZuschauerKapazitaet := StrToInt(ZuschauerKapazitaetEingabeFeld.Text);

  // In die Datenbank schreiben
  FDatabase.ZeileHinzufuegen(Stadion);

  // Fenster schließen
  Self.Close;

end;

class function TStadionEingabeFenster.GetTableName: ShortString;
begin
  Result := FTableName;
end;

end.
