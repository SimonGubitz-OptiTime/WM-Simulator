unit damTypes;

interface

uses
  System.Generics.Collections;


type
  TDBUpdateEvent = procedure of object;

type
  TTeamVerband = (AFC, CAF, CONCACAF, CONMEBOL, OFC, UEFA);

type
  TTeamRanking = (SehrStark, Stark, MittelStark, Schwach);

type TStadion = record
  Name: String;
  Ort: String;
  ZuschauerKapazitaet: UInt32;
end;

type TTeamStatistik = record
  Punkte: Byte;
  ToreGeschossen: Byte;
  ToreKassiert: Byte;
  Siege: Byte;
  Unentschieden: Byte;
  Niederlagen: Byte;
end;

//{$RTTI EXPLICIT Fields([vcPublished])}
type TTeam = record
public
  Name: String;
  FIFACode: String; // 3 Zeichen lang
  TeamVerband: TTeamVerband;
  HistorischeWMSiege: Byte;
  HeimstadionName: String; // in der Simulation vielleicht +5% Siegchancen
  Flagge: Byte; // als index für eine TImageList
  FSpielerListe: array of String; // ← Nur Namen, muss um Simplizität in der Rtti array bleiben, kein TList<string>
  TeamRanking: TTeamRanking;

  ID: Byte;
end;

type TSpiel = record
  Team1: TTeam;
  Team1Spielstand: Byte; // kein Spiel wird über 255 gehen
  Team2: TTeam;
  Team2Spielstand: Byte; // ↑

  AustragunsDatum: TDate;

  Stadion: TStadion;
end;

type TGruppe = TList<TTeam>;

type IState = interface
  ['{af30318b-f132-4cec-be9e-38e05ad71f14}']

    function GetTeams: TList<TTeam>;
    procedure SetTeams(const ATeams: TList<TTeam>);

    function GetStadien: TList<TStadion>;
    procedure SetStadien(const AStadien: TList<TStadion>);

    function GetGruppen: TList<TGruppe>;
    procedure AddGruppe(const AGroup: TGruppe);
    procedure SetGruppen(const AGruppen: TList<TGruppe>);

    function GetTeamStand: TDictionary<Byte, TTeamStatistik>;
    procedure SetTeamStand(const ANewStanding: TDictionary<Byte, TTeamStatistik>);

    property Teams: TList<TTeam> read GetTeams write SetTeams;
    property Stadien: TList<TStadion> read GetStadien write SetStadien;
    property Gruppen: TList<TGruppe> read GetGruppen write SetGruppen;
    property TeamStands: TDictionary<Byte, TTeamStatistik> read GetTeamStand write SetTeamStand;
end;


implementation

end.
