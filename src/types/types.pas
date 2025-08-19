unit types;

interface

type TDBUpdateEvent = procedure of object;

type TStadion = record
    Name: String; // z.B. "Allianz Arena"
    Ort: String; // z.B. "München"
    ZuschauerKapazitaet: UInt32; // Zuschauer Zahl kann größer als WordMax 65'535 sein
    Zuschauer: UInt32; // " - für die Simulation wenn >90% Kapazität, +5% Siegchancen wenn Heimstadion
end;

type TTeamVerband = (AFC, CAF, CONCACAF, CONMEBOL, OFC, UEFA);
type TTeamRanking = (SehrStark, Stark, MittelStark, Schwach);


type TTeam = record
    Name: String;
    FIFACode: string; // 3 Zeichen lang
    TeamVerband: TTeamVerband;
    HistorischeWMSiege: Byte;
    HeimstadionName: String; // in der Simulation vielleicht +5% Siegchancen
    Flagge: Byte; // als index für eine TImageList
    SpielerListe: array[0..10] of String; // Nur Namen
    TeamRanking: TTeamRanking;

    // ↓ für spätere Statistiken - keine Stammdaten
    private
        ToreGeschossen: Byte;
        ToreKassiert: Byte;
        Siege: Byte;
        Unentschieden: Byte;
        Niederlagen: Byte;
end;
type TSpiel = record
    Team1: TTeam;
    Team1Spielstand: Byte; // kein Spiel wird über 255 gehen
    Team2: TTeam;
    Team2Spielstand: Byte; // ↑

    AustragunsDatum: TDate;

    Stadion: TStadion;
end;

type TWMState = class
    Teams: array[0..47] of TTeam;       // 48 Teams in 2026
    Stadien: array[0..15] of TStadion;  // 16 Stadien in 2026
end;




// type TStadienCSVOutput


implementation

end.
