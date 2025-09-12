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
    FSimulation: TSimulation;
    FGrid: TStringGrid;
    FGruppenphaseLabels: TArray<TLabel>;
    FSechzehntelfinaleLabels: TArray<TLabel>;
    FGruppenphaseUebersichtGrids: TArray<TStringGrid>;

  public
    constructor Create(AGruppenphaseGrid: TStringGrid;
      AGruppenphaseLabels: TArray<TLabel>;
      ASechzehntelfinaleLabels: TArray<TLabel>;
      AGruppenphaseUebersichtGrids: TArray<TStringGrid>;
      const AState: IState);
    destructor Destroy; override;

    procedure Starten(ASpiel: TSpiel; AGruppe: TGruppe; ANdx: Integer);
    procedure GruppenphaseUebersichtZeichnen();

  end;

implementation

constructor TGruppenphaseUI.Create(AGruppenphaseGrid: TStringGrid; AGruppenphaseLabels: TArray<TLabel>; ASechzehntelfinaleLabels: TArray<TLabel>; AGruppenphaseUebersichtGrids: TArray<TStringGrid>; const AState: IState);
var
  j: Integer;
begin
  FState := AState;
  FGrid := AGruppenphaseGrid;
  FSimulation := TSimulation.Create;
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

//{
procedure TGruppenphaseUI.Starten(ASpiel: TSpiel; AGruppe: TGruppe; ANdx: Integer);
var
  SimulationList: TObjectList<TSimulation>;
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
  TeamNdx, GruppenNdx: Integer;
begin

  ShowMessage('Amount Groups: ' + IntToStr(FState.Gruppen.Count));
  ShowMessage('Amount Grids: ' + IntToStr(Length(FGruppenphaseUebersichtGrids)));

  if ( Length(FGruppenphaseUebersichtGrids) <> FState.Gruppen.Count ) then
  begin
    raise Exception.Create('Fehlermeldung');
  end;


  for GruppenNdx := 0 to FState.Gruppen.Count - 1 do
  begin
    for TeamNdx := 0 to FState.Gruppen[GruppenNdx].Count - 1 do
    begin
      clrUtils.TableFormating.TeamZeileZeichnen(FGruppenphaseUebersichtGrids[GruppenNdx], FState.Gruppen[GruppenNdx][TeamNdx], TeamNdx);    
    end;      
  end;
end;


end.

