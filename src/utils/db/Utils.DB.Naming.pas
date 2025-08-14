unit Utils.DB.Naming;

interface

uses
    SysUtils, Vcl.Forms;


function GetFullCSVDBTablePath(Name: String): String;

implementation

function GetFullCSVDBTablePath(Name: String): String;
begin

    Result := ExtractFilePath(Application.ExeName) + 'custom_database_' + Name + '.csv'

end;

end.
