unit Utils.DB;

interface

uses
    SysUtils, Vcl.Forms;


function GetTablesFilePath(Name: String): String;
function GetTablesDirPath: String; inline;

implementation

function GetTablesFilePath(Name: String): String;
begin
    Result := ExtractFilePath(Application.ExeName) + '..\..\..\database\' + 'custom_database_' + Name + '.csv'
end;

function GetTablesDirPath: String;
begin
    Result := ExtractFilePath(Application.ExeName) + '..\..\..\database\';
end;

end.
