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

type IWMState = interface
  ['{00000115-0000-0000-C000-000000000049}']
  private
    Teams: array [0 .. 47] of TTeam; // 48 Teams in 2026
    Stadien: array [0 .. 15] of TStadion; // 16 Stadien in 2026
    FTeams: TList<TTeam>;
    FTeamStände: TDictionary<Byte, TTeamStand>;
  public
    constructor Create;

    function GetTeamStanding(AID: Byte): TTeamStand;
    procedure SetTeamStanding(AID: Byte; ANewStanding: TTeamStand);

    function GetGruppe(): TGruppe;
    procedure AddGruppe(AGroup: TGruppe); overload;
    procedure AddGruppe(AGroup: TList<TTeam>); overload;

    destructor Destroy;
end;

implementation

end.
