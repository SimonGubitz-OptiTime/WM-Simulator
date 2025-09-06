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

    constructor Create(var ADatabase: IDB<TTeam>);

    destructor Destroy; override;

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


end.
