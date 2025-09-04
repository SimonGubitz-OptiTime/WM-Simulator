unit fraTeamEingabeFenster;

interface

uses
  System.Classes,
  System.Generics.Collections,
  System.ImageList,
  System.SysUtils,
  System.Variants,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Dialogs,
  Vcl.Forms,
  Vcl.StdCtrls,
  Vcl.Menus,
  Vcl.ImgList,
  Winapi.Messages,
  Winapi.Windows,
  clrDB,
  damTypes,
  clrUtils.StringFormating,
  clrUtils.TableFormating;

type
  TTeamEingabeFenster = class(TForm)
    Label1: TLabel;
    NameLabel: TLabel;
    NameEingabeFeld: TEdit;
    FIFACodeLabel: TLabel;
    FIFACodeEingabeFeld: TEdit;
    BestaetigenButton: TButton;
    TeamVerbandLabel: TLabel;
    TeamVerbandEingabeBox: TComboBox;
    HistorischeSiegeLabel: TLabel;
    HistorischeSiegeEingabeFeld: TEdit;
    HeimstadionLabel: TLabel;
    HeimstadionEingabeFeld: TEdit;
    SpielerListeLabel: TLabel;
    SpielerListeAnzeigeLabel: TLabel;
    SpielerListeEingabeFeld: TEdit;
    ImageList1: TImageList;
    TeamRankingLabel: TLabel;
    TeamRankingEingabeBox: TComboBox;
    SpielerListeEingabeButton: TButton;
    SpielerListeEntfernenButton: TButton;

    constructor Create(var ADatabase: IDB<TTeam>);

    procedure BestaetigenButtonClick(Sender: TObject);
    procedure FIFACodeEingabeFeldChange(Sender: TObject);
    procedure EingabeDerListeHinzufuegen;
    procedure EingabeDerListeEntfernen;
    procedure SpielerListeEingabeButtonClick(Sender: TObject);
    procedure SpielerListeEingabeFeldKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpielerListeEntfernenButtonClick(Sender: TObject);
    class function GetTableName: ShortString;

    destructor Destroy; override;

  private
    var
      FSpielerListe: TList<String>;

    var
      FDatabase: IDB<TTeam>;

    const
      FTableName: ShortString = 'Teams';
  end;

implementation

{$R *.dfm}

constructor TTeamEingabeFenster.Create(var ADatabase: IDB<TTeam>);
begin

  inherited Create(nil);

  FDatabase := ADatabase;

  FSpielerListe := TList<String>.Create;


  // Nach dem inherited Create call, sind nun die Children des Forms nicht mehr "nil"
  TeamVerbandEingabeBox.Items.Add('AFC');
  TeamVerbandEingabeBox.Items.Add('CAF');
  TeamVerbandEingabeBox.Items.Add('CONCACAF');
  TeamVerbandEingabeBox.Items.Add('CONMEBOL');
  TeamVerbandEingabeBox.Items.Add('OFC');
  TeamVerbandEingabeBox.Items.Add('UEFA');
  TeamVerbandEingabeBox.ItemIndex := 5;

  TeamRankingEingabeBox.Items.Add('Sehr stark');
  TeamRankingEingabeBox.Items.Add('Stark');
  TeamRankingEingabeBox.Items.Add('Mittel stark');
  TeamRankingEingabeBox.Items.Add('Schwach');
  TeamRankingEingabeBox.ItemIndex := 0;

end;

destructor TTeamEingabeFenster.Destroy;
begin
  // Aufräumen
  FSpielerListe.Free;

  inherited Destroy;
end;

procedure TTeamEingabeFenster.EingabeDerListeHinzufuegen;
begin
  if SpielerListeEingabeFeld.Text = '' then
  begin
    Exit;
  end;

  // Der Liste hinzufügen
  FSpielerListe.Add(SpielerListeEingabeFeld.Text);

  // Das Eingabe Feld wieder leeren
  SpielerListeEingabeFeld.Text := '';

  // Das Ausgabe Feld neu rendern
  SpielerListeAnzeigeLabel.Caption := clrUtils.StringFormating.FormatSpielerListe
    (FSpielerListe);

  // Fokus auf das Eingabefeld setzen
  SpielerListeEingabeFeld.SetFocus;
end;

procedure TTeamEingabeFenster.EingabeDerListeEntfernen;
begin
  // Wenn das Eingabefeld für Spieler leer ist, wird der letzte Spieler Entfernt, sonst der
  if ( SpielerListeEingabeFeld.Text = '' ) then
  begin
    FSpielerListe.Delete(FSpielerListe.Count - 1);
  end
  else
  begin
    FSpielerListe.Remove(SpielerListeEingabeFeld.Text);
  end;

  // Eingabefeld leeren
  SpielerListeEingabeFeld.Text := '';

  // Neu formatieren
  SpielerListeAnzeigeLabel.Caption := clrUtils.StringFormating.FormatSpielerListe
    (FSpielerListe);

  // Fokus auf das Eingabefeld setzen
  SpielerListeEingabeFeld.SetFocus;
end;

procedure TTeamEingabeFenster.SpielerListeEingabeButtonClick(Sender: TObject);
begin
  EingabeDerListeHinzufuegen;
end;

procedure TTeamEingabeFenster.SpielerListeEingabeFeldKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  // https://adrenalinebot.com/en/api/usefull/delphi-keycodes
  // Wenn Enter gedrückt wird
  if ( Key = 13 ) then
  begin
    EingabeDerListeHinzufuegen;
  end
  // Wenn ENTF gedrückt wird
  else if ( Key = 46 ) then
  begin
    EingabeDerListeEntfernen;
  end;

end;

procedure TTeamEingabeFenster.SpielerListeEntfernenButtonClick(Sender: TObject);
begin
  EingabeDerListeEntfernen;
end;

procedure TTeamEingabeFenster.BestaetigenButtonClick(Sender: TObject);
var
  placeholder: Integer;
  Team: TTeam;
begin

  // Gültigkeitsprüfung der Eingaben
  if ( NameEingabeFeld.Text = '') or (FIFACodeEingabeFeld.Text = '') or
    (TeamVerbandEingabeBox.Text = '') or (TeamRankingEingabeBox.Text = '') or
    (HistorischeSiegeEingabeFeld.Text = '') or
    (HeimstadionEingabeFeld.Text = '') or (FSpielerListe.Count = 0 ) then
  begin
    ShowMessage('Bitte füllen Sie alle Felder aus.');
    Exit;
  end;

  if not ( Length(FIFACodeEingabeFeld.Text) = 3 ) then
  begin
    ShowMessage('FIFACode muss 3 Zeichen lang sein.');
    Exit;
  end;

  if not ( TryStrToInt(HistorischeSiegeEingabeFeld.Text, placeholder) ) then
  begin
    ShowMessage('Bitte tragen sie eine gültige Zahl ein.');
    Exit;
  end;

  if not ( FSpielerListe.Count = 11 ) then
  begin
    ShowMessage('Bitte tragen Sie genau 11 Spieler ein.');
    Exit;
  end;

  Team := Default (TTeam);
  Team.Name := NameEingabeFeld.Text;
  Team.FIFACode := FIFACodeEingabeFeld.Text;
  Team.TeamVerband := TTeamVerband(TeamVerbandEingabeBox.ItemIndex);
  Team.HistorischeWMSiege := StrToInt(HistorischeSiegeEingabeFeld.Text);
  Team.HeimstadionName := HeimstadionEingabeFeld.Text; // record ???
  Team.Flagge := 0; // TODO: Flagge setzen
  Team.TeamRanking := TTeamRanking(TeamRankingEingabeBox.ItemIndex);

  SetLength(Team.FSpielerListe, 11);
  for placeholder := Low(Team.FSpielerListe) to High(Team.FSpielerListe) do
  begin
    var
    s := Team.FSpielerListe[placeholder];
    var
    y := FSpielerListe[placeholder];
    Team.FSpielerListe[placeholder] := FSpielerListe[placeholder];
  end;

  // Team in die Datenbank schreiben
  FDatabase.ZeileHinzufuegen(Team);

  // Fenster schließen
  Self.Close;

end;

procedure TTeamEingabeFenster.FIFACodeEingabeFeldChange(Sender: TObject);
begin
  // constrain the input to 3 characters
  if ( Length(FIFACodeEingabeFeld.Text) > 3 ) then
  begin
    FIFACodeEingabeFeld.Text := Copy(FIFACodeEingabeFeld.Text, 0, 2);
  end;
end;

class function TTeamEingabeFenster.GetTableName: ShortString;
begin
  Result := FTableName;
end;

end.
