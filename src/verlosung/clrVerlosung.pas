unit clrVerlosung;

interface

uses
  System.Generics.Collections,
  System.SysUtils,
  Vcl.Dialogs,
  clrDB,
  damTypes,
  clrState,
  clrUtils.FilterArray,
  clrUtils.ShuffleArray;


type TVerlosungLogik = class
  private
    FState: IState;
    FDB: IDB<TTeam>;

    procedure IDSVergeben;
    procedure CreateTeams;

  public

    constructor Create(AState: IState; ADB: IDB<TTeam>);
    destructor Destroy; override;

    procedure Starten;
  end;

implementation

constructor TVerlosungLogik.Create(AState: IState; ADB: IDB<TTeam>);
begin

  inherited Create;

  FState := AState;
  FDB := ADB;

end;

destructor TVerlosungLogik.Destroy;
begin
  inherited Destroy;
end;

procedure TVerlosungLogik.IDSVergeben;
var
  TempTeam: TTeam;
  Ndx: Integer;
begin
  for Ndx := 0 to FState.Teams.Count - 1 do
  begin
    TempTeam := FState.Teams[Ndx];
      // ID für jedes Team setzen
    TempTeam.ID := Ndx;
    FState.SetTeam(Ndx, TempTeam);
  end;
end;

procedure TVerlosungLogik.CreateTeams;
var
  Ndx: Integer;
  TempList: TList<TTeam>;
  SehrStarkeTeams, StarkeTeams, MittelStarkeTeams, SchwacheTeams: TList<TTeam>;
begin


  FState.SetTeams(FDB.StrukturierteTabelleErhalten());
  FState.ClearGruppen();

  if ( (FState.Teams.Count mod 4) <> 0 ) then
  begin
    raise Exception.Create('TVerlosungUI.Starten Error: The number of FUITeams must be divisible by 4.');
  end;


  IDSVergeben;

  // Nur die sehr starken Teams nehmen
  SehrStarkeTeams := clrUtils.FilterArray.TFilterArrayUtils.Filter2<TTeam>(FState.Teams,
    function(Param: TTeam): Boolean
    begin
      Result := Param.TeamRanking = TTeamRanking.SehrStark;
    end
  );

  // Nur die starken Teams nehmen
  StarkeTeams := clrUtils.FilterArray.TFilterArrayUtils.Filter2<TTeam>(FState.Teams,
    function(Param: TTeam): Boolean
    begin
      Result := Param.TeamRanking = TTeamRanking.Stark;
    end
  );

  // Nur die mittel starken Teams nehmen
  MittelStarkeTeams := clrUtils.FilterArray.TFilterArrayUtils.Filter2<TTeam>(FState.Teams,
    function(Param: TTeam): Boolean
    begin
      Result := Param.TeamRanking = TTeamRanking.MittelStark;
    end
  );

  // Nur die schwachen Teams nehmen
  SchwacheTeams := clrUtils.FilterArray.TFilterArrayUtils.Filter2<TTeam>(FState.Teams,
    function(Param: TTeam): Boolean
    begin
      Result := Param.TeamRanking = TTeamRanking.Schwach;
    end
  );


  if ( (SehrStarkeTeams.Count <> StarkeTeams.Count)
    or (StarkeTeams.Count <> MittelStarkeTeams.Count)
    or (MittelStarkeTeams.Count <> SchwacheTeams.Count)
  ) then
  begin
    ShowMessage('Die Anzahl der Teams in den Lostöpfen ist nicht gleich.');
    Exit;
  end;


  clrUtils.ShuffleArray.TShuffleArrayUtils<TTeam>.Shuffle(SehrStarkeTeams);
  clrUtils.ShuffleArray.TShuffleArrayUtils<TTeam>.Shuffle(StarkeTeams);
  clrUtils.ShuffleArray.TShuffleArrayUtils<TTeam>.Shuffle(MittelStarkeTeams);
  clrUtils.ShuffleArray.TShuffleArrayUtils<TTeam>.Shuffle(SchwacheTeams);


  for Ndx := 0 to SehrStarkeTeams.Count - 1 do
  begin
    TempList := TGruppe.Create;
    TempList.AddRange([ SehrStarkeTeams[Ndx], StarkeTeams[Ndx], MittelStarkeTeams[Ndx], SchwacheTeams[Ndx] ]);
    FState.AddGruppe(TempList);
  end;
end;

procedure TVerlosungLogik.Starten;
begin
  CreateTeams;
end;

end.
