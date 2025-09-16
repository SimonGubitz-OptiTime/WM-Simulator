unit clrGruppenphaseUI;

interface

uses
  System.Generics.Collections,
  System.SysUtils,
  System.Math,
  Vcl.Dialogs,
  Vcl.Graphics,
  Vcl.Grids,
  Vcl.StdCtrls,
  damTypes,
  clrState,
  clrSimulation,
  clrUtils.SortHashMap,
  clrUtils.TableFormating,
  clrUtils.StringFormating,
  clrUtils.UpdateStandings;


type TGruppenphaseUI = class
  private

    FState: IState;
    FGrid: TStringGrid;
    FGruppenphaseLabels: TArray<TLabel>;
    FSechzehntelfinaleLabels: TArray<TLabel>;
    FGruppenphaseUebersichtGrids: TArray<TStringGrid>;

    procedure ResizeGrids(AGrids: TArray<TStringGrid>);

  public
    constructor Create(AGruppenphaseGrid: TStringGrid;
      AGruppenphaseLabels: TArray<TLabel>;
      ASechzehntelfinaleLabels: TArray<TLabel>;
      AGruppenphaseUebersichtGrids: TArray<TStringGrid>;
      const AState: IState);
    destructor Destroy; override;

    procedure Starten(ASpiel: TSpiel; AGruppe: TGruppe; ANdx: Integer);
    procedure GruppenphaseUebersichtZeichnen();
    procedure SechzehntelFinaleEintragen();

  end;

implementation

constructor TGruppenphaseUI.Create(AGruppenphaseGrid: TStringGrid; AGruppenphaseLabels: TArray<TLabel>; ASechzehntelfinaleLabels: TArray<TLabel>; AGruppenphaseUebersichtGrids: TArray<TStringGrid>; const AState: IState);
var
  j: Integer;
begin
  FState := AState;
  FGrid := AGruppenphaseGrid;
  FGruppenphaseLabels := AGruppenphaseLabels;
  FSechzehntelfinaleLabels := ASechzehntelfinaleLabels;
  FGruppenphaseUebersichtGrids := AGruppenphaseUebersichtGrids;

  var ColSize := Floor(FGrid.Width / FGrid.ColCount) - 2;
  var RowSize := Floor(FGrid.Height / FGrid.RowCount) - 2;

  for j := 0 to FGrid.ColCount - 1 do
  begin
    FGrid.ColWidths[j] := ColSize;
  end;
  for j := 0 to FGrid.RowCount - 1 do
  begin
    FGrid.RowHeights[j] := RowSize;
  end;
end;

destructor TGruppenphaseUI.Destroy;
begin
  inherited Destroy;
end;

procedure TGruppenphaseUI.ResizeGrids(AGrids: TArray<TStringGrid>);
var
  GridNdx, RowNdx, ColNdx: Integer;
  ColSize, RowSize: Integer;
begin
  for GridNdx := 0 to Length(AGrids) - 1 do
  begin

    ColSize := Floor(AGrids[GridNdx].Width / AGrids[GridNdx].ColCount) - 2;
    RowSize := Floor(AGrids[GridNdx].Height / AGrids[GridNdx].RowCount) - 2;

    for RowNdx := 0 to AGrids[GridNdx].ColCount - 1 do
    begin
      AGrids[GridNdx].ColWidths[RowNdx] := ColSize;
    end;

    for ColNdx := 0 to AGrids[GridNdx].RowCount - 1 do
    begin
      AGrids[GridNdx].RowHeights[ColNdx] := RowSize;
    end;
  end;
end;

procedure TGruppenphaseUI.Starten(ASpiel: TSpiel; AGruppe: TGruppe; ANdx: Integer);
begin
  clrUtils.TableFormating.TeamTabelleZeichnenMitPunkten(FState, FGrid, AGruppe);

  FGruppenphaseLabels[ANdx].Caption := clrUtils.StringFormating.FormatSpielString(ASpiel);

  // Das aktuelle Spiel immer grün markieren
  FGruppenphaseLabels[ANdx].Font.Style := [fsBold];
  FGruppenphaseLabels[ANdx].Font.Color := clGreen;

  FGruppenphaseLabels[ANdx].Caption := clrUtils.StringFormating.FormatSpielString(ASpiel);

  FGruppenphaseLabels[ANdx].Font.Style := [];
  FGruppenphaseLabels[ANdx].Font.Color := clWindowText;
end;

procedure TGruppenphaseUI.GruppenphaseUebersichtZeichnen();
var
  GruppenNdx: Integer;
begin

  // Resize all the FGruppenphaseUebersichtGrids
  ResizeGrids(FGruppenphaseUebersichtGrids);


  if ( Length(FGruppenphaseUebersichtGrids) <> FState.Gruppen.Count ) then
  begin
    raise Exception.Create('Fehlermeldung');
  end;

  for GruppenNdx := 0 to FState.Gruppen.Count - 1 do
  begin

    clrUtils.TableFormating.TeamTabelleZeichnenMitPunkten(FState, FGruppenphaseUebersichtGrids[GruppenNdx], FState.Gruppen[GruppenNdx]);
    
  end;
end;

procedure TGruppenphaseUI.SechzehntelFinaleEintragen();
var
  Ndx: Integer;
  Team1: TTeam;
  Team2: TTeam;
begin
    Ndx := 0;
    while Ndx <= FState.SechzehntelFinalisten.Count - 1 do
    begin
      Team1 := FState.Teams[FState.SechzehntelFinalisten[Ndx].Key];
      Team2 := FState.Teams[FState.SechzehntelFinalisten[Ndx].Value];

      FSechzehntelfinaleLabels[Ndx].Caption := clrUtils.StringFormating.FormatSpielString(
        Team1.Name,
        Team2.Name,
        0, 0
      );

      Inc(Ndx, 1);
    end;
end;

end.

