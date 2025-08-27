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


type TState = class(TInterfacedObject, IWMState)
  private
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

constructor TState.Create;
begin
  FTeams.Create;
  FTeamStände.Create;
end;

destructor TState.Destroy;
begin
  FTeams.Free;
  FTeamStände.Free;
end;

function GetTeamStanding(AID: Byte): TTeamStand;
var
  HasValue: Boolean;
  TeamValue: TTeamStand;
begin

  HasValue := FTeamStände.TryGetValue(AID, TeamValue);

  if ( HasValue ) then
  begin
    Result := TeamValue;
  end
  else
  begin
    Result := Default(TTeamStand);
  end;

end;

procedure SetTeamStanding(AID: Byte; ANewStanding: TTemastand);
var
  HasValue: Boolean;
begin

  HasValue := FTeamStände.ContainsKey(AID);

  if ( not(HasValue) ) then
  begin
    Exit;
  end;


  FTeamStände.AddOrSetValue(AID, ANewStanding);

end;


end.
