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

    FSechzehntelFinalisten: TList<TSpielIDs>;
    FAchtelFinalisten: TList<TSpielIDs>;
    FViertelFinalisten: TList<TSpielIDs>;
    FHalbFinalisten: TList<TSpielIDs>;
    FFinalisten: TSpielIDs;
    FSpielUmPlatz3: TSpielIDs;
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

    function    GetSechzehntelFinalisten: TList<TSpielIDs>;
    function    GetAchtelFinalisten: TList<TSpielIDs>;
    function    GetViertelFinalisten: TList<TSpielIDs>;
    function    GetHalbFinalisten: TList<TSpielIDs>;
    function    GetFinalisten: TSpielIDs;
    function    GetSpielUmPlatz3: TSpielIDs;

    procedure   SetSechzehntelFinalisten(const SechzehntelFinalisten: TList<TSpielIDs>);
    procedure   AddSechzehntelFinalist(const SechzehntelFinalist: TSpielIDs);

    procedure   SetAchtelFinalisten(const AchtelFinalisten: TList<TSpielIDs>);
    procedure   AddAchtelFinalist(const AchtelFinalist: TSpielIDs);

    procedure   SetViertelFinalisten(const ViertelFinalisten: TList<TSpielIDs>);
    procedure   AddViertelFinalist(const ViertelFinalist: TSpielIDs);

    procedure   SetHalbFinalisten(const HalbFinalisten: TList<TSpielIDs>);
    procedure   AddHalbFinalist(const HalbFinalist: TSpielIDs);

    procedure   SetFinalisten(const Finalisten: TSpielIDs);
    procedure   SetSpielUmPlatz3(const SpielUmPlatz3: TSpielIDs);


    destructor  Destroy; override;

  published
    property Teams: TList<TTeam> read GetTeams write SetTeams;
    property Stadien: TList<TStadion> read GetStadien write SetStadien;
    property Gruppen: TList<TGruppe> read GetGruppen write SetGruppen;
    property TeamStands: TDictionary<TTeamID, TTeamStatistik> read GetTeamStand write SetTeamStand;

    property SechzehntelFinalisten: TList<TSpielIDs> read GetSechzehntelFinalisten write SetSechzehntelFinalisten;
    property AchtelFinalisten: TList<TSpielIDs> read GetAchtelFinalisten write SetAchtelFinalisten;
    property ViertelFinalisten: TList<TSpielIDs> read GetViertelFinalisten write SetViertelFinalisten;
    property HalbFinalisten: TList<TSpielIDs> read GetHalbFinalisten write SetHalbFinalisten;
    property Finalisten: TSpielIDs read GetFinalisten write SetFinalisten;
    property SpielUmPlatz3: TSpielIDs read GetSpielUmPlatz3 write SetSpielUmPlatz3;
end;


implementation

constructor TWMState.Create;
begin
  FTeams := TList<TTeam>.Create;
  FStadien := TList<TStadion>.Create;
  FGruppen := TList<TGruppe>.Create;
  FTeamStands := TDictionary<TTeamID, TTeamStatistik>.Create;


  FSechzehntelFinalisten := TList<TSpielIDs>.Create;
  FAchtelFinalisten := TList<TSpielIDs>.Create;
  FViertelFinalisten := TList<TSpielIDs>.Create;
  FHalbFinalisten := TList<TSpielIDs>.Create;
end;

destructor TWMState.Destroy;
begin
  FSechzehntelFinalisten.Free;
  FAchtelFinalisten.Free;
  FViertelFinalisten.Free;
  FHalbFinalisten.Free;


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
  FTeams.Destroy;
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

function TWMState.GetTeamStand: TDictionary<TTeamID, TTeamStatistik>;
begin
  Result := FTeamStands;
end;

function TWMState.ForceGetTeamStandByID(const ID: Integer): TTeamStatistik;
begin
  Result := FTeamStands[ID];
end;

function TWMState.TryGetTeamStandByID(const ID: TTeamID; out Return: TTeamStatistik): Boolean;
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

procedure TWMState.AddOrSetTeamStandByID(const ID: TTeamID; const Stand: TTeamStatistik);
begin
  FTeamStands.AddOrSetValue(ID, Stand);
end;

procedure TWMState.SetTeamStand(const ATeamStand: TDictionary<TTeamID, TTeamStatistik>);
begin
  FTeamStands := ATeamStand;
end;

function TWMState.GetSechzehntelFinalisten: TList<TSpielIDs>;
begin
  Result := FSechzehntelFinalisten;
end;

function TWMState.GetAchtelFinalisten: TList<TSpielIDs>;
begin
  Result := FAchtelFinalisten;
end;

function TWMState.GetViertelFinalisten: TList<TSpielIDs>;
begin
  Result := FViertelFinalisten;
end;

function TWMState.GetHalbFinalisten: TList<TSpielIDs>;
begin
  Result := FHalbFinalisten;
end;

function TWMState.GetFinalisten: TSpielIDs;
begin
  Result := FFinalisten;
end;

function TWMState.GetSpielUmPlatz3: TSpielIDs;
begin
  Result := FSpielUmPlatz3;
end;


procedure TWMState.SetSechzehntelFinalisten(const SechzehntelFinalisten: TList<TSpielIDs>);
begin
  FSechzehntelFinalisten.Destroy;
  FSechzehntelFinalisten := SechzehntelFinalisten;
end;

procedure TWMState.AddSechzehntelFinalist(const SechzehntelFinalist: TSpielIDs);
begin
  FSechzehntelFinalisten.Add(SechzehntelFinalist);
end;

procedure TWMState.SetAchtelFinalisten(const AchtelFinalisten: TList<TSpielIDs>);
begin
  FAchtelFinalisten.Destroy;
  FAchtelFinalisten := AchtelFinalisten;
end;

procedure TWMState.AddAchtelFinalist(const AchtelFinalist: TSpielIDs);
begin
  FAchtelFinalisten.Add(AchtelFinalist);
end;

procedure TWMState.SetViertelFinalisten(const ViertelFinalisten: TList<TSpielIDs>);
begin
  FViertelFinalisten.Destroy;
  FViertelFinalisten := ViertelFinalisten;
end;

procedure TWMState.AddViertelFinalist(const ViertelFinalist: TSpielIDs);
begin
  FViertelFinalisten.Add(ViertelFinalist);
end;

procedure TWMState.SetHalbFinalisten(const HalbFinalisten: TList<TSpielIDs>);
begin
  FHalbFinalisten.Destroy;
  FHalbFinalisten := HalbFinalisten;
end;

procedure TWMState.AddHalbFinalist(const HalbFinalist: TSpielIDs);
begin
  FHalbFinalisten.Add(HalbFinalist);
end;

procedure TWMState.SetFinalisten(const Finalisten: TSpielIDs);
begin
  FFinalisten := Finalisten;
end;

procedure TWMState.SetSpielUmPlatz3(const SpielUmPlatz3: TSpielIDs);
begin
  FSpielUmPlatz3 := SpielUmPlatz3;
end;


end.
