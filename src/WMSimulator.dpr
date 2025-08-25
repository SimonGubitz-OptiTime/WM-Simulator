program WMSimulator;

uses
  Vcl.Forms,
  Main in 'ui\Main.pas' {Form1},
  TeamEingabeFenster in 'ui\TeamEingabeFenster.pas' {Form2},
  StadionEingabeFenster in 'ui\StadionEingabeFenster.pas' {Form3},
  Verlosung in 'ui\verlosung\Verlosung.pas',
  db in 'db\db.pas',
  types in 'types\types.pas',
  Utils.RTTI in 'utils\CSV\Utils.RTTI.pas',
  Utils.CSV in 'utils\CSV\Utils.CSV.pas',
  Utils.DB in 'utils\db\Utils.DB.pas',
  Utils.FixedArrays in 'utils\arrays\Utils.FixedArrays.pas',
  Utils.ShuffleArray in 'utils\arrays\Utils.ShuffleArray.pas',
  Utils.UserInput in 'utils\user_input\Utils.UserInput.pas',
  Utils.TableFormating in 'utils\table_formating\Utils.TableFormating.pas',
  Utils.StringFormating in 'utils\string_formating\Utils.StringFormating.pas',
  animation in 'ui\animations\animation.pas',
  Utils.Routing in 'utils\routing\Utils.Routing.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
