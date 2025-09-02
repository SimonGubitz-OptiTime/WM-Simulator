program WMSimulator;

uses
  Vcl.Forms,
  Main in 'ui\Main.pas' {Form1},
  fraTeamEingabeFenster in 'ui\fraTeamEingabeFenster.pas' {Form2},
  fraStadionEingabeFenster in 'ui\fraStadionEingabeFenster.pas' {Form3},
  clrVerlosung in 'ui\verlosung\clrVerlosung.pas',
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
  clrGruppenphase in 'ui\gruppenphase\clrGruppenphase.pas',
  clrSimulation in 'simulation\clrSimulation.pas',
  clrUtils.ShuffleArray in 'utils\arrays\clrUtils.ShuffleArray.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;

end.
