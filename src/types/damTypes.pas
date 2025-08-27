unit damTypes;

interface

type
  TDBUpdateEvent = procedure of object;

type
  TTeamVerband = (AFC, CAF, CONCACAF, CONMEBOL, OFC, UEFA);

type
  TTeamRanking = (SehrStark, Stark, MittelStark, Schwach);

type TStadion = record
  Name: String; // z.B. "Allianz Arena"
  Ort: String; // z.B. "München"
  ZuschauerKapazitaet: UInt32;
  // Zuschauer Zahl kann größer als WordMax 65'535 sein
  Zuschauer: UInt32;
  // " - für die Simulation wenn >90% Kapazität, +5% Siegchancen wenn Heimstadion
end;

{$RTTI INHERIT [vcPublic]}
type TTeam = record
public
  ID: Byte; // max 255
  Name: String;
  FIFACode: string; // 3 Zeichen lang
  TeamVerband: TTeamVerband;
  HistorischeWMSiege: Byte;
  HeimstadionName: String; // in der Simulation vielleicht +5% Siegchancen
  Flagge: Byte; // als index für eine TImageList
  SpielerListe: array of String;
  // ↑ Nur Namen, muss um Simplizität in der Rtti array bleiben, kein TList<string>
  TeamRanking: TTeamRanking;

// private sind für RTTI unsichtbar
private
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

type TTeamStand = record
  Punkte: Byte;
  ToreGeschossen: Byte;
  ToreKassiert: Byte;
  Siege: Byte;
  Unentschieden: Byte;
  Niederlagen: Byte;
end;

type TGruppe = record
  Teams: TList<TTeam>;
end;

type IState = interface
  ['{af30318b-f132-4cec-be9e-38e05ad71f14}']

    function GetTeams: TList<TTeam>;
    procedure SetTeams(const ATeams: TList<TTeam>);

    function GetStadien: TList<TStadion>;
    procedure SetStadien(const AStadien: TList<TStadion>);

    function GetGroups: TList<TGruppe>;
    procedure AddGroup(const AGroup: TGruppe);
    procedure SetGroups(const AGroups: TList<TGruppe>);

    function GetTeamStanding(AID: Byte): TTeamStand;
    procedure SetTeamStanding(AID: Byte; const ANewStanding: TTeamStand);

    property Teams: TList<TTeam> read GetTeams write SetTeams;
    property Stadien: TList<TStadion> read GetStadien write SetStadien;
    property Groups: TList<TGruppe> read GetGroups write SetGroups;
    property TeamStandings: TDictionary<Byte, TTeamStand> read GetTeamStanding write SetTeamStanding;
end;


implementation

end.
