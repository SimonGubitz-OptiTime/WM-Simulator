unit clrUtils.DB;

interface

uses
  SysUtils, Vcl.Forms;

function GetTablesFilePath(AName: String): String; inline;
function GetTablesDirPath: String; inline;
function GetSQLDBName(AName: String): String;

implementation

function GetTablesFilePath(AName: String): String;
begin
  Result := ExtractFilePath(Application.ExeName) + '..\..\..\database\' +
    'custom_database_' + AName + '.csv'
end;

function GetTablesDirPath: String;
begin
  Result := ExtractFilePath(Application.ExeName) + '..\..\..\database\';
end;

function GetSQLDBName(AName: String): String;
begin
  Result := 'dbo.WMSimulation' + AName;
end;


end.
