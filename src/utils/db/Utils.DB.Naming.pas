unit Utils.DB.Naming;

interface

uses
    SysUtils, Vcl.Forms;


function GetFullDBTablePath(Name: String): String;

implementation

function GetFullDBTablePath(Name: String): String;
begin

    Result := ExtractFilePath(Application.ExeName) + 'custom_database_' + Name + '.csv'

end;

end.
