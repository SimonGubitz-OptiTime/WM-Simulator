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
    FGroups: TList<TGruppe>;
    FTeamStandings: TDictionary<Byte, TTeamStand>;
  public
    constructor Create;

    function GetTeams: TList<TTeam>;
    procedure SetTeam(const ANdx: Integer; const ATeam: TTeam);
    procedure SetTeams(const ATeams: TList<TTeam>);

    function GetStadien: TList<TStadion>;
    procedure SetStadien(const AStadien: TList<TStadion>);

    function GetGroups: TList<TGruppe>;
    procedure AddGroup(const AGroup: TGruppe);
    procedure SetGroups(const AGroups: TList<TGruppe>);

    function GetTeamStanding: TDictionary<Byte, TTeamStand>;
    procedure SetTeamStanding(const ATeamStanding: TDictionary<Byte, TTeamStand>);

    destructor Destroy;
  published
    property Teams: TList<TTeam> read GetTeams write SetTeams;
    property Stadien: TList<TStadion> read GetStadien write SetStadien;
    property Groups: TList<TGruppe> read GetGroups write SetGroups;
    property TeamStandings: TDictionary<Byte, TTeamStand> read GetTeamStanding write SetTeamStanding;
end;


implementation

constructor TWMState.Create;
begin
  FTeams := TList<TTeam>.Create;
  FStadien := TList<TStadion>.Create;
  FGroups := TList<TGruppe>.Create;
  FTeamStandings := TDictionary<Byte, TTeamStand>.Create;

end;

destructor TWMState.Destroy;
begin
  FTeams.Free;
  FStadien.Free;
  FGroups.Free;

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

function TWMState.GetGroups: TList<TGruppe>;
begin
  Result := FGroups;
end;

procedure TWMState.AddGroup(const AGroup: TGruppe);
begin
  FGroups.Add(AGroup);
end;

procedure TWMState.SetGroups(const AGroups: TList<TGruppe>);
begin
  FGroups := AGroups;
end;

function TWMState.GetTeamStanding: TDictionary<Byte, TTeamStand>;
begin
  Result := FTeamStandings;
end;

procedure TWMState.SetTeamStanding(const ATeamStanding: TDictionary<Byte, TTeamStand>);
begin
  FTeamStandings := ATeamStanding;
end;

end.
