program WMSimulator;

uses
  Vcl.Forms,
  Main in 'ui\Main.pas' {Form1},
  fraTeamEingabeFenster in 'ui\team-eingabe\fraTeamEingabeFenster.pas' {TeamEingabeFenster},
  fraStadionEingabeFenster in 'ui\stadion-eingabe\fraStadionEingabeFenster.pas' {StadionEingabeFenster},
  fraTeamEntfernenFenster in 'ui\team-eingabe\fraTeamEntfernenFenster.pas' {Form3},
  fraStadionEntfernenFenster in 'ui\stadion-eingabe\fraStadionEntfernenFenster.pas' {Form2},
  clrVerlosungUI in 'ui\verlosung\clrVerlosungUI.pas',
  clrAnimation in 'ui\animations\clrAnimation.pas',
  clrDB in 'db\clrDB.pas',
  damTypes in 'types\damTypes.pas',
  clrUtils.RTTI in 'utils\CSV\clrUtils.RTTI.pas',
  clrUtils.CSV in 'utils\CSV\clrUtils.CSV.pas',
  clrUtils.DB in 'utils\db\clrUtils.DB.pas',
  clrUtils.Routing in 'utils\routing\clrUtils.Routing.pas',
  clrUtils.TableFormating in 'utils\table_formating\clrUtils.TableFormating.pas',
  clrUtils.StringFormating in 'utils\string_formating\clrUtils.StringFormating.pas',
  clrUtils.FilterArray in 'utils\arrays\clrUtils.FilterArray.pas',
  clrUtils.FixedArrays in 'utils\arrays\clrUtils.FixedArrays.pas',
  clrState in 'state\clrState.pas',
  clrGruppenphaseUI in 'ui\gruppenphase\clrGruppenphaseUI.pas',
  clrSimulation in 'simulation\clrSimulation.pas',
  clrUtils.ShuffleArray in 'utils\arrays\clrUtils.ShuffleArray.pas',
  clrUtils.UpdateStandings in 'utils\match_standings\clrUtils.UpdateStandings.pas',
  clrUtils.SortArray in 'utils\arrays\clrUtils.SortArray.pas',
  clrUtils.SortHashMap in 'utils\hash_map\clrUtils.SortHashMap.pas',
  clrEndspiele in 'ui\endspiele\clrEndspiele.pas',
  clrCSVDB in 'db\csv\clrCSVDB.pas',
  clrKOPhase in 'ui\ko-phase\clrKOPhase.pas',
  clrSQLDB in 'db\sql\clrSQLDB.pas',
  clrUtils.StreamPosition in 'utils\streams\clrUtils.StreamPosition.pas',
  clrVerlosung in 'verlosung\clrVerlosung.pas',
  clrUtils.SQL in 'utils\SQL\clrUtils.SQL.pas',
  clrUtils.ArrToStr in 'utils\arrays\clrUtils.ArrToStr.pas';

{$R *.res}

begin
  {$IFDEF DEBUG}
    ReportMemoryLeaksOnShutdown := True;
  {$ENDIF}
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;

end.
