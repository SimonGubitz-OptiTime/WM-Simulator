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
    property Teams: TList<TTeam> read GetTeams write SetTeams;
    property Stadien: TList<TStadion> read GetStadien write SetStadien;
    property Groups: TList<TGruppe> read GetGroups write SetGroups;
    property TeamStandings: TDictionary<Byte, TTeamStand> read GetTeamStanding write SetTeamStanding;
  public
    constructor Create;

    function GetTeams: TList<TTeam>;
    procedure SetTeams(const ATeams: TList<TTeam>);

    function GetStadien: TList<TStadion>;
    procedure SetStadien(const AStadien: TList<TStadion>);

    function GetGroups: TList<TGruppe>;
    procedure AddGroup(const AGroup: TGruppe);
    procedure SetGroups(const AGroups: TList<TGruppe>);

    function GetTeamStanding(AID: Byte): TTeamStand;
    procedure SetTeamStanding(AID: Byte; const ANewStanding: TTeamStand);

    destructor Destroy;
end;


implementation

constructor TWMState.Create;
begin
  FTeams.Create;
  FTeamStände.Create;
end;

destructor TWMState.Destroy;
begin
  FTeams.Free;
  FTeamStände.Free;
end;

function GetTeams: TList<TTeam>;
begin
  Result := FTeams;
end;

procedure SetTeams(const ATeams: TList<TTeam>);
begin
  FTeams := ATeams;
end;

function GetStadien: TList<TStadion>;
begin
  Result := FStadien;
end;

procedure SetStadien(const AStadien: TList<TStadion>);
begin
  FStadien := AStadien;
end;

function GetGroups: TList<TGruppe>;
begin
  Result := FGroups;
end;

procedure AddGroup(const AGroup: TGruppe);
begin
  FGroups.Add(AGroup);
end;

procedure SetGroups(const AGroups: TList<TGruppe>);
begin
  FGroups := AGroups;
end;

function GetTeamStanding(AID: Byte): TTeamStand;
begin
  Result := FTeamStanding;
end;

procedure SetTeamStanding(AID: Byte; const ANewStanding: TTeamStand);
begin
  FTeamStanding := ATeamStanding;
end;

end.
