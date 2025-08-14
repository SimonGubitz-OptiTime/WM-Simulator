program WMSimulator;

uses
  Vcl.Forms,
  Utils.FixedArrays in 'utils\fixed_arrays\Utils.FixedArrays.pas',
  Utils.DB.Naming in 'utils\db\Utils.DB.Naming.pas',
  types in 'types\types.pas',
  Main in 'ui\Main.pas' {Form1},
  StadionEingabeFenster in 'ui\StadionEingabeFenster.pas' {Form2},
  Utils.RTTI in 'utils\CSV\Utils.RTTI.pas',
  Utils.CSV in 'utils\CSV\Utils.CSV.pas',
  TeamEingabeFenster in 'ui\TeamEingabeFenster.pas' {Form3};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
