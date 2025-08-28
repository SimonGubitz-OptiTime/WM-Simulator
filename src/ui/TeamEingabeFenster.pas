unit TeamEingabeFenster;

interface

uses
  DB,
  Types,
  Utils.StringFormating,
  Utils.TableFormating,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus,
  System.ImageList, Vcl.ImgList, System.Generics.Collections;

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

    constructor Create(var database: TDB<TTeam>); reintroduce;

    procedure BestaetigenButtonClick(Sender: TObject);
    procedure FIFACodeEingabeFeldChange(Sender: TObject);
    procedure EingabeDerListeHinzufuegen;
    procedure EingabeDerListeEntfernen;
    procedure SpielerListeEingabeButtonClick(Sender: TObject);
    procedure SpielerListeEingabeFeldKeyDown(Sender: TObject; var Key: Word; Shift:
        TShiftState);
    procedure SpielerListeEntfernenButtonClick(Sender: TObject);
    class function GetTableName: ShortString;

    destructor Destroy; reintroduce;

  private
    var SpielerListe: TList<String>;
    var FDatabase: TDB<TTeam>;
    const FTableName: ShortString = 'Teams';
  end;


implementation

{$R *.dfm}

constructor TTeamEingabeFenster.Create(var database: TDB<TTeam>);
begin

  FDatabase := database;
  if not(FDatabase.Initialized) then
  begin
    FDatabase := TDB<TTeam>.Create(FTableName);
  end;

  SpielerListe := TList<String>.Create();

  inherited Create(nil);

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

procedure TTeamEingabeFenster.EingabeDerListeHinzufuegen;
begin
    if SpielerListeEingabeFeld.Text = '' then
    Exit;

  // Der Liste hinzufügen
  SpielerListe.Add(SpielerListeEingabeFeld.Text);

  // Das Eingabe Feld wieder leeren
  SpielerListeEingabeFeld.Text := '';

  // Das Ausgabe Feld neu rendern
  SpielerListeAnzeigeLabel.Caption := Utils.StringFormating.FormatSpielerListe(SpielerListe);

  // Fokus auf das Eingabefeld setzen
  SpielerListeEingabeFeld.SetFocus;
end;

procedure TTeamEingabeFenster.EingabeDerListeEntfernen;
begin
  // Wenn das Eingabefeld für Spieler leer ist, wird der letzte Spieler Entfernt, sonst der
  if (SpielerListeEingabeFeld.Text = '') then
  begin
    SpielerListe.Delete(SpielerListe.Count-1);
  end
  else
  begin
    SpielerListe.Remove(SpielerListeEingabeFeld.Text);
  end;

  // Eingabefeld leeren
  SpielerListeEingabeFeld.Text := '';

  // Neu formatieren
  SpielerListeAnzeigeLabel.Caption := Utils.StringFormating.FormatSpielerListe(SpielerListe);

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
  if (Key = 13) then
  begin
    EingabeDerListeHinzufuegen;
  end
  // Wenn ENTF gedrückt wird
  else if (Key = 46) then
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
  if (NameEingabeFeld.Text = '') or (FifaCodeEingabeFeld.Text = '') or (TeamVerbandEingabeBox.Text = '') or (TeamRankingEingabeBox.Text = '') or (HistorischeSiegeEingabeFeld.Text = '') or (HeimstadionEingabeFeld.Text = '') or (SpielerListe.Count = 0) then
  begin
    ShowMessage('Bitte füllen Sie alle Felder aus.');
    Exit;
  end;

  if not(Length(FIFACodeEingabeFeld.Text) = 3) then
  begin
    ShowMessage('FIFACode muss 3 Zeichen lang sein.');
    Exit;
  end;

  if not(TryStrToInt(HistorischeSiegeEingabeFeld.Text, placeholder)) then
  begin
    ShowMessage('Bitte tragen sie eine gültige Zahl ein.');
    Exit;
  end;

  if not(SpielerListe.Count = 11) then
  begin
    ShowMessage('Bitte tragen Sie genau 11 Spieler ein.');
    Exit;
  end;


  Team := Default(TTeam);
  Team.Name := NameEingabeFeld.Text;
  Team.FIFACode := FIFACodeEingabeFeld.Text;
  Team.TeamVerband := TTeamVerband(TeamVerbandEingabeBox.ItemIndex);
  Team.HistorischeWMSiege := StrToInt(HistorischeSiegeEingabeFeld.Text);
  Team.HeimstadionName := HeimstadionEingabeFeld.Text; // record ???
  Team.Flagge := 0; // TODO: Flagge setzen
  Team.TeamRanking := TTeamRanking(TeamRankingEingabeBox.ItemIndex);

  SetLength(Team.SpielerListe, 11);
  for placeholder := Low(Team.SpielerListe) to High(Team.SpielerListe) do
  begin
    var s := Team.SpielerListe[placeholder];
    var y := SpielerListe[placeholder];
    Team.SpielerListe[placeholder] := SpielerListe[placeholder];
  end;

  // Team in die Datenbank schreiben
  FDatabase.AddRowToCSV(Team);


  Self.Close;

end;

procedure TTeamEingabeFenster.FIFACodeEingabeFeldChange(Sender: TObject);
begin
  // constrain the input to 3 characters
  if Length(FIFACodeEingabeFeld.Text) > 3 then
  begin
    FIFACodeEingabeFeld.Text := Copy(FIFACodeEingabeFeld.Text, 0, 2);
  end;
end;

class function TTeamEingabeFenster.GetTableName: ShortString;
begin
  Result := FTableName;
end;

destructor TTeamEingabeFenster.Destroy;
begin
  // Aufräumen
  SpielerListe.Free;
  FDatabase.Free;

  inherited Destroy;
end;


end.