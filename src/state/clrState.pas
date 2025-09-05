unit clrState;

interface

uses
  System.Classes,
  System.IOUtils,
  System.Generics.Collections,
  System.SysUtils,
  Vcl.Dialogs,
  damTypes;

type TWMState = class(TInterfacedObject, IState)
  private
    FTeams: TList<TTeam>;
    FStadien: TList<TStadion>;
    FGruppen: TList<TGruppe>;

    FTeamStands: TDictionary<Byte, TTeamStatistik>;

    FSechzehntelFinalisten: TList<TPair<Byte, Byte>>;
    FAchtelFinalisten: TList<TPair<Byte, Byte>>;
    FViertelFinalisten: TList<TPair<Byte, Byte>>;
    FHalbFinalisten: TList<TPair<Byte, Byte>>;
    FFinalisten: TPair<Byte, Byte>;
    FSpielUmPlatz3: TPair<Byte, Byte>;
  public
    constructor Create;

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


    destructor  Destroy; override;

  published
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

constructor TWMState.Create;
begin
  FTeams := TList<TTeam>.Create;
  FStadien := TList<TStadion>.Create;
  FGruppen := TList<TGruppe>.Create;
  FTeamStands := TDictionary<Byte, TTeamStatistik>.Create;


  FSechzehntelFinalisten := TList<TPair<Byte, Byte>>.Create;
  FAchtelFinalisten := TList<TPair<Byte, Byte>>.Create;
  FViertelFinalisten := TList<TPair<Byte, Byte>>.Create;
  FHalbFinalisten := TList<TPair<Byte, Byte>>.Create;
end;

destructor TWMState.Destroy;
begin
  FTeams.Free;
  FStadien.Free;
  FGruppen.Free;
  FTeamStands.Free;

  inherited Destroy;
end;

function TWMState.GetTeams: TList<TTeam>;
begin
  Result := FTeams;
end;

procedure TWMState.SetTeam(const ANdx: Integer; const ATeam: TTeam);
begin
  if ( (ANdx < 0) or (ANdx >= FTeams.Count) ) then
  begin
    raise Exception.Create('TWMState.SetTeam Error: Index out of bounds.');
  end;

  FTeams[ANdx] := ATeam;
end;

procedure TWMState.SetTeams(const ATeams: TList<TTeam>);
begin
  FTeams := ATeams;
end;

function TWMState.GetStadien: TList<TStadion>;
begin
  Result := FStadien;
end;

procedure TWMState.SetStadien(const AStadien: TList<TStadion>);
begin
  FStadien := AStadien;
end;

function TWMState.GetGruppen: TList<TGruppe>;
begin
  Result := FGruppen;
end;

procedure TWMState.AddGruppe(const AGroup: TGruppe);
begin
  FGruppen.Add(AGroup);
end;

procedure TWMState.SetGruppen(const AGruppen: TList<TGruppe>);
begin
  FGruppen := AGruppen;
end;

procedure TWMState.ClearGruppen();
begin
  FGruppen.Clear;
end;

function TWMState.GetTeamStand: TDictionary<Byte, TTeamStatistik>;
begin
  Result := FTeamStands;
end;

function TWMState.ForceGetTeamStandByID(const ID: Integer): TTeamStatistik;
begin
  Result := FTeamStands[ID];
end;

function TWMState.TryGetTeamStandByID(const ID: Byte; out Return: TTeamStatistik): Boolean;
begin
  if ( FTeamStands.ContainsKey(ID) ) then
  begin
    Return := FTeamStands[ID];
    Result := true;
  end
  else
  begin
    Return := Default(TTeamStatistik);
    Result := false;
  end;
end;

procedure TWMState.AddOrSetTeamStandByID(const ID: Byte; const Stand: TTeamStatistik);
begin
  FTeamStands.AddOrSetValue(ID, Stand);
end;

procedure TWMState.SetTeamStand(const ATeamStand: TDictionary<Byte, TTeamStatistik>);
begin
  FTeamStands := ATeamStand;
end;

function TWMState.GetSechzehntelFinalisten: TList<TPair<Byte, Byte>>;
begin
  Result := FSechzehntelFinalisten;
end;

function TWMState.GetAchtelFinalisten: TList<TPair<Byte, Byte>>;
begin
  Result := FAchtelFinalisten;
end;

function TWMState.GetViertelFinalisten: TList<TPair<Byte, Byte>>;
begin
  Result := FViertelFinalisten;
end;

function TWMState.GetHalbFinalisten: TList<TPair<Byte, Byte>>;
begin
  Result := FHalbFinalisten;
end;

function TWMState.GetFinalisten: TPair<Byte, Byte>;
begin
  Result := FFinalisten;
end;

function TWMState.GetSpielUmPlatz3: TPair<Byte, Byte>;
begin
  Result := FSpielUmPlatz3;
end;


procedure TWMState.SetSechzehntelFinalisten(const SechzehntelFinalisten: TList<TPair<Byte, Byte>>);
begin
  FSechzehntelFinalisten := SechzehntelFinalisten;
end;

procedure TWMState.AddSechzehntelFinalist(const SechzehntelFinalist: TPair<Byte, Byte>);
begin
  FSechzehntelFinalisten.Add(SechzehntelFinalist);
end;

procedure TWMState.SetAchtelFinalisten(const AchtelFinalisten: TList<TPair<Byte, Byte>>);
begin
  FAchtelFinalisten := AchtelFinalisten;
end;

procedure TWMState.AddAchtelFinalist(const AchtelFinalist: TPair<Byte, Byte>);
begin
  FAchtelFinalisten.Add(AchtelFinalist);
end;

procedure TWMState.SetViertelFinalisten(const ViertelFinalisten: TList<TPair<Byte, Byte>>);
begin
  FViertelFinalisten := ViertelFinalisten;
end;

procedure TWMState.AddViertelFinalist(const ViertelFinalist: TPair<Byte, Byte>);
begin
  FViertelFinalisten.Add(ViertelFinalist);
end;

procedure TWMState.SetHalbFinalisten(const HalbFinalisten: TList<TPair<Byte, Byte>>);
begin
  FHalbFinalisten := HalbFinalisten;
end;

procedure TWMState.AddHalbFinalist(const HalbFinalist: TPair<Byte, Byte>);
begin
  FHalbFinalisten.Add(HalbFinalist);
end;

procedure TWMState.SetFinalisten(const Finalisten: TPair<Byte, Byte>);
begin
  FFinalisten := Finalisten;
end;

procedure TWMState.SetSpielUmPlatz3(const SpielUmPlatz3: TPair<Byte, Byte>);
begin
  FSpielUmPlatz3 := SpielUmPlatz3;
end;


end.
