unit clrVerlosungUI;

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
  damTypes,
  clrState,
  clrAnimation,
  clrUtils.ShuffleArray,
  clrUtils.FilterArray,
  clrUtils.TableFormating;


type TVerlosungUI = class
  private

    FInitialisiert: Boolean;

    FState: IState;
    FGrids: TObjectList<TStringGrid>;
    // array due to multiple Grids → meistens nur 12 Grids
    FColSize: array [0 .. 11] of Integer;
    FRowSize: array [0 .. 11] of Integer;


    procedure ResizeGrids;
    procedure AnimationCallbackFn(Count: Integer; SecondCount: Integer; ThirdCount: Integer);

  public
    property Initialisiert: Boolean read FInitialisiert;

    constructor Create(AGrids: array of TStringGrid; AState: IState);
    destructor Destroy; override;

    function VerlosungStarten(AOwner: TControl): Boolean;

  end;

implementation

constructor TVerlosungUI.Create(AGrids: array of TStringGrid; AState: IState);
begin

  inherited Create;

  FState := AState;

  if ( Length(AGrids) <> 12 ) then
  begin
    raise Exception.Create('TVerlosungUI.Create Error: There must be exactly 12 Grids.');
  end;
  FGrids := TObjectList<TStringGrid>.Create(false);
  FGrids.AddRange(AGrids);
  ResizeGrids;


  FInitialisiert := true;

end;

destructor TVerlosungUI.Destroy;
begin
  FGrids.Destroy;

  inherited Destroy;
end;

procedure TVerlosungUI.ResizeGrids;
var
  GridNdx, RowNdx, ColNdx: Integer;
begin
  for GridNdx := 0 to FGrids.Count - 1 do
  begin

    FColSize[GridNdx] := Floor(FGrids[GridNdx].Width / FGrids[GridNdx].ColCount) - 2;
    FRowSize[GridNdx] := Floor(FGrids[GridNdx].Height / FGrids[GridNdx].RowCount) - 2;

    for RowNdx := 0 to FGrids[GridNdx].ColCount - 1 do
    begin
      FGrids[GridNdx].ColWidths[RowNdx] := FColSize[GridNdx];
    end;

    for ColNdx := 0 to FGrids[GridNdx].RowCount - 1 do
    begin
      FGrids[GridNdx].RowHeights[ColNdx] := FRowSize[GridNdx];
    end;

  end;
end;

function TVerlosungUI.VerlosungStarten(AOwner: TControl): Boolean;
var
  Grid: TStringGrid;
  TempLabel: TStaticText;
  RowNdx, GridNdx, TeamNdx: Integer;
  AnimationList: TObjectList<TAnimations>;
begin

  for Grid in FGrids do
  begin
    clrUtils.TableFormating.TabelleLeeren(Grid);
  end;


  AnimationList := TObjectList<TAnimations>.Create(true);

  try
    // Für alle Grids je 4 Teams eintragen
    TeamNdx := 0;
    GridNdx := 0;
    for Grid in FGrids do
    begin

      with Grid do
      begin

        for RowNdx := 0 to 3 do
        begin

          // hier die Animation
          TempLabel := TStaticText.Create(nil);

          TempLabel.Parent := AOwner as TWinControl;
          TempLabel.Caption := FState.Teams[TeamNdx].Name;
          TempLabel.Top := Round((AOwner.Height / 2) - (TempLabel.Height / 2));
          // Middle
          TempLabel.Left := Round((AOwner.Width / 2) - (TempLabel.Width / 2)); // Middle

          var
          MoveTop := Grid.Top + Round(TempLabel.Height / 2) +
            (RowNdx * FRowSize[GridNdx]);

          AnimationList.Add(TAnimations.Create(TControl(TempLabel), 150)); // .150 sek
          AnimationList.Last.ObjektBewegen(AnimationCallbackFn, MoveTop, Grid.Left + 15, RowNdx, GridNdx, TeamNdx);

          Inc(TeamNdx);
        end;
      end;
      Inc(GridNdx);
    end;

    ShowMessage('Die Verlosung ist abgeschlossen.');
  finally
    AnimationList.Free;
  end;

  Result := true;

end;

//                                         Col             Grid                  Team
procedure TVerlosungUI.AnimationCallbackFn(Count: Integer; SecondCount: Integer; ThirdCount: Integer);
begin

  clrUtils.TableFormating.TeamZeileZeichnen(FGrids[SecondCount], FState.Gruppen[SecondCount][Count], Count);

end;

end.
