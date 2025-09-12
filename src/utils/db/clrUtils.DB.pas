unit clrUtils.DB;

interface

uses
  SysUtils, Vcl.Forms;

function GetTablesFilePath(AName: String): String; inline;
function GetTablesDirPath: String; inline;
function GetSQLTableName(AName: String): String;

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

function GetSQLTableName(AName: String): String;
begin
  Result := 'WMSimulation' + AName;
end;


end.
