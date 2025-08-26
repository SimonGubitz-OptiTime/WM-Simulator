unit clrVerlosung;

interface

uses
  System.Classes,
  System.Generics.Collections,
  System.Math,
  System.SysUtils,
  Vcl.Controls,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.Forms,
  Vcl.Grids,
  Vcl.StdCtrls,
  clrDB,
  damTypes,
  clrAnimation,
  clrUtils.ShuffleArray,
  clrUtils.FilterArray;

type
  TVerlosungUI = class
  private
    FGrids: TObjectList<TStringGrid>;

    FInitialized: Boolean;
    FTeams: TList<TTeam>; // for the AnimationCallback

    // array due to multiple Grids
    FColSize: array [0 .. 11] of Integer;
    FRowSize: array [0 .. 11] of Integer;

    procedure AnimationCallbackFn(Count: Integer = -1;
      SecondCount: Integer = -1; ThirdCount: Integer = -1);

  public
    property Initialized: Boolean read FInitialized;
    constructor Create(Grids: array of TStringGrid);

    function VerlosungStarten(var ATeamDB: TDB<TTeam>; ATimer: TTimer;
      AOwner: TControl): Boolean;

    destructor Destroy; override;
  end;

implementation

constructor TVerlosungUI.Create(Grids: array of TStringGrid);
var
  i, j: Integer;
begin
  if ( Length(Grids) <> 12 ) then
  begin
    raise Exception.Create('TVerlosungUI.Create Error: There must be exactly 12 Grids.');
  end;

  FGrids := TObjectList<TStringGrid>.Create;

  for i := 0 to 11 do
  begin

    FColSize[i] := Floor(Grids[i].Width / Grids[i].ColCount) - 2;
    FRowSize[i] := Floor(Grids[i].Height / Grids[i].RowCount) - 2;

    for j := 0 to Grids[i].ColCount - 1 do
    begin
      Grids[i].ColWidths[j] := FColSize[i];
    end;
    for j := 0 to Grids[i].RowCount - 1 do
    begin
      Grids[i].RowHeights[j] := FRowSize[i];
    end;
    FGrids.Add(Grids[i]);
  end;

  FInitialized := true;

end;

function TVerlosungUI.VerlosungStarten(var ATeamDB: TDB<TTeam>; ATimer: TTimer;
  AOwner: TControl): Boolean;
var
  Grid: TStringGrid;
  TempLabel: TStaticText;
  ShuffledTeamsItem: TTeam;
  ColNdx, GridNdx, TeamNdx, Ndx: Integer;
  AnimationList: TObjectList<TAnimations>;
  SehrStarkeTeams, StarkeTeams, MittelStarkeTeams, SchwacheTeams: TList<TTeam>;
begin

  if not ( FInitialized ) then
  begin
    raise Exception.Create
      ('TVerlosungUI.VerlosungStarten Error: The UI is not initialized.');
  end;

  try
    AnimationList := TObjectList<TAnimations>.Create;
    FTeams := ATeamDB.GetStructuredTableFromCSV();

    if ( (FTeams.Count mod 4) <> 0 ) then
    begin
      raise Exception.Create
        ('TVerlosungUI.VerlosungStarten Error: The number of FTeams must be divisible by 4.');
    end;
    if ( TeamNdx >= FTeams.Count ) then
    begin
      TeamNdx := 0;
    end;


    SehrStarkeTeams   := TList<TTeam>.Create;
    StarkeTeams       := TList<TTeam>.Create;
    MittelStarkeTeams := TList<TTeam>.Create;
    SchwacheTeams     := TList<TTeam>.Create;

    try

      // Nur die sehr starken Teams nehmen
      SehrStarkeTeams := clrUtils.FilterArray.TFilterArrayUtils.Filter2<TTeam>(FTeams,
        function(Param: TTeam): Boolean
        begin
          Result := Param.TeamRanking = TTeamRanking.SehrStark;
        end
      );
      
      // Nur die starken Teams nehmen
      StarkeTeams := clrUtils.FilterArray.TFilterArrayUtils.Filter2<TTeam>(FTeams,
        function(Param: TTeam): Boolean
        begin
          Result := Param.TeamRanking = TTeamRanking.Stark;
        end
      );
      
      // Nur die mittel starken Teams nehmen
      MittelStarkeTeams := clrUtils.FilterArray.TFilterArrayUtils.Filter2<TTeam>(FTeams,
        function(Param: TTeam): Boolean
        begin
          Result := Param.TeamRanking = TTeamRanking.MittelStark;
        end
      );

      // Nur die schwachen Teams nehmen
      SchwacheTeams := clrUtils.FilterArray.TFilterArrayUtils.Filter2<TTeam>(FTeams,
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


      FTeams.Clear;

      for Ndx := 0 to SehrStarkeTeams.Count - 1 do
      begin
        // Jedes Sehr starke Team wird mit den anderen Stärken in eine Gruppe gepackt
        FTeams.AddRange([ SehrStarkeTeams[Ndx], StarkeTeams[Ndx], MittelStarkeTeams[Ndx], SchwacheTeams[Ndx] ]);
      end;


      // Für alle Grids je 4 Teams eintragen
      TeamNdx := 0;
      GridNdx := 0;
      for Grid in FGrids do
      begin

        if ( TeamNdx >= FTeams.Count ) then
        begin
          break;
        end;

        with Grid do
        begin

          for ColNdx := 0 to 3 do
          begin

            // hier die Animation
            TempLabel := TStaticText.Create(nil);

            TempLabel.Parent := AOwner as TWinControl;
            TempLabel.Caption := FTeams[TeamNdx].Name;
            TempLabel.Top := Round((AOwner.Height / 2) - (Height / 2));
            // Middle
            TempLabel.Left := Round((AOwner.Width / 2) - (Width / 2)); // Middle

            var
            MoveTop := Grid.Top + Round(TempLabel.Height / 2) +
              (ColNdx * FRowSize[GridNdx]);

            AnimationList.Add(TAnimations.Create(ATimer, TControl(TempLabel),
              MoveTop, Grid.Left + 15, 150)); // .6 sek
            AnimationList.Last.MoveObject(AnimationCallbackFn, ColNdx, GridNdx,
              TeamNdx);

            Inc(TeamNdx);
          end;
        end;
        Inc(GridNdx);
      end;
    finally
      AnimationList.Free;
      SehrStarkeTeams.Free;
      StarkeTeams.Free;
      MittelStarkeTeams.Free;
      SchwacheTeams.Free;
    end;

    Result := true;

  except
    on E: Exception do
    begin
      ShowMessage('TVerlosungUI.VerlosungStarten Error: ' + E.Message);
      Exit(false);
    end;
  end;
end;

                                        // cols               // grids                   // teams
procedure TVerlosungUI.AnimationCallbackFn(Count: Integer = -1; SecondCount: Integer = -1; ThirdCount: Integer = -1);
begin

  if ( (Count = -1) or (SecondCount = -1) ) then
  begin
    raise Exception.Create('Fehlermeldung');
  end;

  // ShowMessage('Team: ' + FTeams[ThirdCount].Name);

  try
    with FGrids[SecondCount] do
    begin
      // Hier können weitere Aktionen nach der Animation erfolgen, z.B.:
      Cells[0, Count] := FTeams[ThirdCount].Name;
      case FTeams[ThirdCount].TeamRanking of
        TTeamRanking.SehrStark:
          Cells[1, Count] := 'Sehr Stark';
        TTeamRanking.Stark:
          Cells[1, Count] := 'Stark';
        TTeamRanking.MittelStark:
          Cells[1, Count] := 'Mittel Stark';
        TTeamRanking.Schwach:
          Cells[1, Count] := 'Schwach Stark';
      end;

      Cells[2, Count] := IntToStr(FTeams[ThirdCount].HistorischeWMSiege);

      case FTeams[ThirdCount].TeamVerband of
        TTeamVerband.AFC:
          Cells[3, Count] := 'AFC';
        TTeamVerband.CAF:
          Cells[3, Count] := 'CAF';
        TTeamVerband.CONCACAF:
          Cells[3, Count] := 'CONCACAF';
        TTeamVerband.CONMEBOL:
          Cells[3, Count] := 'CONMEBOL';
        TTeamVerband.OFC:
          Cells[3, Count] := 'OFC';
        TTeamVerband.UEFA:
          Cells[3, Count] := 'UEFA';
      end;

    end;
  except
    on ERangeError do
    begin
      ShowMessage('ThirdCount: ' + IntToStr(ThirdCount));
    end;
  end;
end;

destructor TVerlosungUI.Destroy;
begin
  FGrids.Free;
  FTeams.Free;

  inherited Destroy;
end;

end.
