unit DB;

interface

uses
    SysUtils;



function    GetProperty<T>(TableName: String): T;
procedure   SetProperty<T>(TableName: String; Property: String; PropertyValue: T);
function    GetStructuredTable<T>(TableName: String): T;
procedure   SetStructuredTable<T>(TableName: String);
function    GetUnstructuredTable(TableName: String): String;
procedure   SetUnstructuredTable(TableName: String);



implementation


function GetPropertyOfID<T>(TableName: String; RowID: Integer): T;
begin

    

end;

procedure SetPropertyOfID<T>(TableName: String; RowID: Integer);
begin

    // .csv öffnen

end;

function GetUnstructuredTable(TableName: String): TArray<String>;
var
    FS: TFileStream;
    SR: TStreamReader;
begin

    FileName := Utils.DB.Naming.GetFullDBTablePath(TableName);

    try
        FS.Create(FileName);
        SR.Create(FS);

        Result := Utils.CSV.DeerializeCSV(SR.ReadToEnd());

    finally
        FS.Free;
        SR.Free;
    end;
end;

procedure SetUnstructuredTable(TableName: String; TableContent: String);
var
    FS: TFileStream;
    SW: TStreamWriter;
begin

    FileName := Utils.DB.Naming.GetFullDBTablePath(TableName);

    try
        FS.Create(FileName);
        SW.Create(FS);

        SR.Write(Utils.CSV.DeserializeCSV(CSVString));

    finally
        FS.Free;
        SR.Free;
    end;
end;


end.