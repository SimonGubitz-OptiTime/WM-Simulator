unit fraTeamEntfernenFenster;

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
  clrDB;

type
  TTeamEntfernenFenster = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    BestaetigenButton: TButton;
    StadionNameEdit: TEdit;

    constructor Create(var ADatabase: IDB<TTeam>);
    destructor Destroy; override;

    procedure TTeamEntfernenFenster.BestaetigenButtonClick(Sender: TObject);

  private

    var
      FDatabase: IDB<TTeam>;
  end;

var
  Form3: TTeamEntfernenFenster;

implementation

{$R *.dfm}

constructor TTeamEntfernenFenster.Create(var ADatabase: IDB<TTeam>);
begin
  inherited Create(nil);

  FDatabase := ADatabase;
end;

destructor TTeamEntfernenFenster.Destroy;
begin
  inherited Destroy;
end;

procedure TTeamEntfernenFenster.BestaetigenButtonClick(Sender: TObject);
var
  Row: TStadion;
  HasRow: Boolean;
begin

  HasRow := FDatabase.ZeileFinden(
    function(Param: TStadion): Boolean
    begin
       Result := Param.Name = TeamNameEdit.Text;
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
