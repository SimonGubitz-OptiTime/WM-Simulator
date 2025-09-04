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
  clrState,
  clrAnimation,
  clrUtils.ShuffleArray,
  clrUtils.FilterArray,
  clrUtils.TableFormating;

type TVerlosungUI = class
  private
    FGrids: TObjectList<TStringGrid>;

    FState: TWMState;

    FInitialisiert: Boolean;
    FUITeams: TList<TTeam>; // ist eine reine Kopie, welche verändert wird, um visuelle Veränderung zu erstellen

    // array due to multiple Grids → meistens nur 12 Grids
    FColSize: array [0 .. 11] of Integer;
    FRowSize: array [0 .. 11] of Integer;

    procedure AnimationCallbackFn(Count: Integer; SecondCount: Integer; ThirdCount: Integer);

  public
    property Initialisiert: Boolean read FInitialisiert;

    constructor Create(AGrids: array of TStringGrid; AState: TWMState);

    function VerlosungStarten(ATeamDB: IDB<TTeam>; AOwner: TControl): Boolean;

    destructor Destroy; override;
  end;

implementation

constructor TVerlosungUI.Create(AGrids: array of TStringGrid; AState: TWMState);
var
  i, j: Integer;
begin

  inherited Create;

  FUITeams := nil;
  FState := AState;
  FGrids := TObjectList<TStringGrid>.Create(false);

  if ( Length(AGrids) <> 12 ) then
  begin
    raise Exception.Create('TVerlosungUI.Create Error: There must be exactly 12 Grids.');
  end;

  for i := 0 to 11 do
  begin

    FColSize[i] := Floor(AGrids[i].Width / AGrids[i].ColCount) - 2;
    FRowSize[i] := Floor(AGrids[i].Height / AGrids[i].RowCount) - 2;

    for j := 0 to AGrids[i].ColCount - 1 do
    begin
      AGrids[i].ColWidths[j] := FColSize[i];
    end;
    for j := 0 to AGrids[i].RowCount - 1 do
    begin
      AGrids[i].RowHeights[j] := FRowSize[i];
    end;
    FGrids.Add(AGrids[i]);
  end;

  FInitialisiert := true;

end;

destructor TVerlosungUI.Destroy;
begin
  FGrids.Destroy;
  FUITeams.Free;

  inherited Destroy;
end;

function TVerlosungUI.VerlosungStarten(ATeamDB: IDB<TTeam>; AOwner: TControl): Boolean;
var
  Grid: TStringGrid;
  TempList: TList<TTeam>;
  TempTeam: TTeam;
  TempLabel: TStaticText;
  ShuffledTeamsItem: TTeam;
  ColNdx, GridNdx, TeamNdx, Ndx: Integer;
  AnimationList: TObjectList<TAnimations>;
  SehrStarkeTeams, StarkeTeams, MittelStarkeTeams, SchwacheTeams: TList<TTeam>;
begin

  for Grid in FGrids do
  begin
    clrUtils.TableFormating.TabelleLeeren(Grid);
  end;


  try
    AnimationList := TObjectList<TAnimations>.Create(true);

    // `StrukturierteTabelleErhalten` erstellt für jeden Aufruf ein komplett neues Element/Objekt
    FUITeams := ATeamDB.StrukturierteTabelleErhalten();
    FState.SetTeams(ATeamDB.StrukturierteTabelleErhalten());
    FState.ClearGruppen();

    // potenziell ineffizient
    for Ndx := 0 to FState.Teams.Count - 1 do
    begin
      TempTeam := FState.Teams[Ndx];
      TempTeam.ID := Ndx;
      FState.SetTeam(Ndx, TempTeam);
       // ID für jedes Team setzen
    end;

    // als debug showmessage mit jeder ID als neue Zeile
    var Msg: String := '';
    for TempTeam in FState.Teams do
    begin
      Msg := Msg + IntToStr(TempTeam.ID) + ': ' + TempTeam.Name + sLineBreak;
    end;
    ShowMessage(Msg);


    if ( (FUITeams.Count mod 4) <> 0 ) then
    begin
      raise Exception.Create('TVerlosungUI.VerlosungStarten Error: The number of FUITeams must be divisible by 4.');
    end;


    try

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


      FUITeams.Clear;
      
      for Ndx := 0 to SehrStarkeTeams.Count - 1 do
      begin
        // Jedes Sehr starke Team wird mit den anderen Stärken in eine Gruppe gepackt

        // Allein für die Darstellung
        FUITeams.AddRange([ SehrStarkeTeams[Ndx], StarkeTeams[Ndx], MittelStarkeTeams[Ndx], SchwacheTeams[Ndx] ]);

        TempList := TGruppe.Create;

        TempList.AddRange([ SehrStarkeTeams[Ndx], StarkeTeams[Ndx], MittelStarkeTeams[Ndx], SchwacheTeams[Ndx] ]);

        // und für die zentrale Lagerung
        FState.AddGruppe(TempList); // hier
      end;

      // Für alle Grids je 4 Teams eintragen
      TeamNdx := 0;
      GridNdx := 0;
      for Grid in FGrids do
      begin

        if ( TeamNdx >= FUITeams.Count ) then
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
            TempLabel.Caption := FUITeams[TeamNdx].Name;
            TempLabel.Top := Round((AOwner.Height / 2) - (TempLabel.Height / 2));
            // Middle
            TempLabel.Left := Round((AOwner.Width / 2) - (TempLabel.Width / 2)); // Middle

            var
            MoveTop := Grid.Top + Round(TempLabel.Height / 2) +
              (ColNdx * FRowSize[GridNdx]);

            AnimationList.Add(TAnimations.Create(TControl(TempLabel), 150)); // .150 sek
            AnimationList.Last.ObjektBewegen(AnimationCallbackFn, MoveTop, Grid.Left + 15, ColNdx, GridNdx, TeamNdx);

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

procedure TVerlosungUI.AnimationCallbackFn(Count: Integer; SecondCount: Integer; ThirdCount: Integer);
begin

  clrUtils.TableFormating.TeamZeileZeichnen(FGrids[SecondCount], FUITeams[ThirdCount], Count);

end;

end.
