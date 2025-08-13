program WMSimulator;

uses
  Vcl.Forms,
  Main in 'Main.pas' {Form1},
  Utils.FixedArrays in 'utils\fixed_arrays\Utils.FixedArrays.pas',
  Utils.DB.Naming in 'utils\db\Utils.DB.Naming.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
