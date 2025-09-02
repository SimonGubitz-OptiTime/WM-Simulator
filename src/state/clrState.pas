unit clrState;

interface

uses
  System.Classes,
  System.IOUtils,
  System.Generics.Collections,
  System.SysUtils,
  Vcl.Dialogs,
  damTypes,
  clrDB;


type TWMState = class(TInterfacedObject, IState)
  private
    FTeams: TList<TTeam>;
    FStadien: TList<TStadion>;
    FGruppen: TList<TGruppe>;
    FTeamStands: TDictionary<Byte, TTeamStatistik>;
    AchtelFinalisten: TList<TPair<Byte, Byte>>;
    ViertelFinalisten: TList<TPair<Byte, Byte>>;
    HablFinalisten: TList<TPair<Byte, Byte>>;
    Finalisten: TPair<Byte, Byte>;
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
    procedure   SetTeamStand(const ATeamStand: TDictionary<Byte, TTeamStatistik>);

    destructor  Destroy; override;
  published
    property Teams: TList<TTeam> read GetTeams write SetTeams;
    property Stadien: TList<TStadion> read GetStadien write SetStadien;
    property Gruppen: TList<TGruppe> read GetGruppen write SetGruppen;
    property TeamStands: TDictionary<Byte, TTeamStatistik> read GetTeamStand write SetTeamStand;
end;


implementation

constructor TWMState.Create;
begin
  FTeams := TList<TTeam>.Create;
  FStadien := TList<TStadion>.Create;
  FGruppen := TList<TGruppe>.Create;
  FTeamStands := TDictionary<Byte, TTeamStatistik>.Create;

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

procedure TWMState.SetTeamStand(const ATeamStand: TDictionary<Byte, TTeamStatistik>);
begin
  FTeamStands := ATeamStand;
end;

end.
