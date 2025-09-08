unit fraStadionEntfernenFenster;

interface

uses
  System.Classes,
  System.SysUtils,
  System.Variants,
  Vcl.Controls,
  Vcl.Dialogs,
  Vcl.Forms,
  Vcl.Graphics,
  Winapi.Windows,
  Winapi.Messages,
  damTypes,
  clrDB, Vcl.StdCtrls;

type
  TStadionEntfernenFenster = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    BestaetigenButton: TButton;
    StadionNameEdit: TEdit;

    constructor Create(var ADatabase: IDB<TStadion>);
    destructor Destroy; override;

    procedure BestaetigenButtonClick(Sender: TObject);

  private

    var
      FDatabase: IDB<TStadion>;
  end;

var
  Form2: TStadionEntfernenFenster;

implementation

{$R *.dfm}

constructor TStadionEntfernenFenster.Create(var ADatabase: IDB<TStadion>);
begin
  inherited Create(nil);

  FDatabase := ADatabase;
end;

destructor TStadionEntfernenFenster.Destroy;
begin
  inherited Destroy;
end;

procedure TStadionEntfernenFenster.BestaetigenButtonClick(Sender: TObject);
var
  Row: TStadion;
  HasRow: Boolean;
begin

  HasRow := FDatabase.ZeileFinden(
    function(Param: TStadion): Boolean
    begin
       Result := Param.Name = StadionNameEdit.Text;
    end,
    Row
  );

  if ( not(HasRow) ) then
  begin
    ShowMessage('Dieses Stadion existiert in der Datenbank nicht. Bitte versuche es erneut.');
    Exit;
  end
  else
  begin
    FDatabase.ZeileEntfernen(Row);
    Self.Close;
  end;
end;

end.
