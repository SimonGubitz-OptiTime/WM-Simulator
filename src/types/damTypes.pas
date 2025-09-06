unit dams;

interface

uses
  System.Generics.Collections;


type
  TTeamVerband = (AFC, CAF, CONCACAF, CONMEBOL, OFC, UEFA);


  TTeamRanking = (SehrStark, Stark, MittelStark, Schwach);

  TStadion = record
    Name: String;
    Ort: String;
    ZuschauerKapazitaet: UInt32;
  end;

  PStadion = ^Stadion;

  TTeamStatistik = record
    Punkte: Byte;
    ToreGeschossen: Byte;
    ToreKassiert: Byte;
    Siege: Byte;
    Unentschieden: Byte;
    Niederlagen: Byte;
  end;

  //{$RTTI EXPLICIT Fields([vcPublished])}
  TTeam = record
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

  PTeam = ^TTeam;

  TSpiel = record
    Team1: PTeam;
    Team2: PTeam;
    Stadion: PStadion;
  end;

  TGruppe = TList<TTeam>;

  IState = interface
    ['{af30318b-f132-4cec-be9e-38e05ad71f14}']

      function    GetTeams: TList<TTeam>;
      procedure   SetTeam(const ANdx: Integer; const ATeam: TTeam);
      procedure   SetTeams(const ATeams: TList<TTeam>);

      function    GetStadien: TList<TStadion>;
      procedure   SetStadien(const AStadien: TList<TStadion>);

      function    GetGruppen: TList<TGruppe>;
      procedure   AddGruppe(const AGroup: TGruppe);
      procedure   SetGruppen(const AGruppen: TList<TGruppe>);
      procedure   ClearGruppen();

      function    GetTeamStand: TDictionary<Byte, TTeamStatistik>;
      function    ForceGetTeamStandByID(const ID: Integer): TTeamStatistik;
      function    TryGetTeamStandByID(const ID: Byte; out Return: TTeamStatistik): Boolean;
      procedure   AddOrSetTeamStandByID(const ID: Byte; const Stand: TTeamStatistik);
      procedure   SetTeamStand(const ATeamStand: TDictionary<Byte, TTeamStatistik>);

      function    GetSechzehntelFinalisten: TList<TPair<Byte, Byte>>;
      function    GetAchtelFinalisten: TList<TPair<Byte, Byte>>;
      function    GetViertelFinalisten: TList<TPair<Byte, Byte>>;
      function    GetHalbFinalisten: TList<TPair<Byte, Byte>>;
      function    GetFinalisten: TPair<Byte, Byte>;
      function    GetSpielUmPlatz3: TPair<Byte, Byte>;

      procedure   SetSechzehntelFinalisten(const SechzehntelFinalisten: TList<TPair<Byte, Byte>>);
      procedure   AddSechzehntelFinalist(const SechzehntelFinalist: TPair<Byte, Byte>);

      procedure   SetAchtelFinalisten(const AchtelFinalisten: TList<TPair<Byte, Byte>>);
      procedure   AddAchtelFinalist(const AchtelFinalist: TPair<Byte, Byte>);

      procedure   SetViertelFinalisten(const ViertelFinalisten: TList<TPair<Byte, Byte>>);
      procedure   AddViertelFinalist(const ViertelFinalist: TPair<Byte, Byte>);

      procedure   SetHalbFinalisten(const HalbFinalisten: TList<TPair<Byte, Byte>>);
      procedure   AddHalbFinalist(const HalbFinalist: TPair<Byte, Byte>);

      procedure   SetFinalisten(const Finalisten: TPair<Byte, Byte>);
      procedure   SetSpielUmPlatz3(const SpielUmPlatz3: TPair<Byte, Byte>);

      property Teams: TList<TTeam> read GetTeams write SetTeams;
      property Stadien: TList<TStadion> read GetStadien write SetStadien;
      property Gruppen: TList<TGruppe> read GetGruppen write SetGruppen;
      property TeamStands: TDictionary<Byte, TTeamStatistik> read GetTeamStand write SetTeamStand;

      property SechzehntelFinalisten: TList<TPair<Byte, Byte>> read GetSechzehntelFinalisten write SetSechzehntelFinalisten;
      property AchtelFinalisten: TList<TPair<Byte, Byte>> read GetAchtelFinalisten write SetAchtelFinalisten;
      property ViertelFinalisten: TList<TPair<Byte, Byte>> read GetViertelFinalisten write SetViertelFinalisten;
      property HalbFinalisten: TList<TPair<Byte, Byte>> read GetHalbFinalisten write SetHalbFinalisten;
      property Finalisten: TPair<Byte, Byte> read GetFinalisten write SetFinalisten;
      property SpielUmPlatz3: TPair<Byte, Byte> read GetSpielUmPlatz3 write SetSpielUmPlatz3;
  end;


  implementation

  end.
