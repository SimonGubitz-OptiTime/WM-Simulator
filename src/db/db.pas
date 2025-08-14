unit DB;

interface

uses
    Utils.DB,
    Utils.CSV,
    System.Classes, System.SysUtils, System.IOUtils, System.Rtti;



type TDB<T: record> = class
  private
    FTableName: String;
  public
    constructor Create(TableName: String);
    
    function    GetPropertyFromCSV(PropertyName: String): T;
    procedure   SetPropertyInCSV(PropertyName: String; PropertyValue: T);

    function    GetRowFromCSV(RowID: Integer): T;
    procedure   SetRowInCSV(RowID: Integer; RowType: T);
    procedure   AddRowToCSV(RowType: T);

    function    GetStructuredTableFromCSV(): TArray<T>;
    procedure   SetStructuredTableInCSV();

    function    GetUnstructuredTableFromCSV(): String;
    procedure   SetUnstructuredTableInCSV(CSVString: String); // unnötig eigentlich

    procedure   AddCSVTableToDB(CSVObject: T);
    procedure   RemoveCSVTableFromDB();

end;



implementation

constructor TDB<T>.Create(TableName: String);
begin
    FTableName := TableName;
end;


function TDB<T>.GetPropertyFromCSV(PropertyName: String): T;
var
    CSVArray: TArray<T>;
begin

    CSVArray := GetStructuredTableFromCSV<T>();



end;

procedure TDB<T>.SetPropertyInCSV(PropertyName: String; PropertyValue: T);
begin

    // .csv öffnen

end;


function TDB<T>.GetRowFromCSV(RowID: Integer): T;
begin
end;

procedure TDB<T>.SetRowInCSV(RowID: Integer; RowType: T);
begin
end;

procedure TDB<T>.AddRowToCSV(RowType: T);
begin
end;


function TDB<T>.GetStructuredTableFromCSV(): TArray<T>;
const
    AverageLines: Byte = 15;
    AverageBytesPerLine: Byte = 40;
var
    FS: TFileStream;
    SR: TStreamReader;
    FileName: String;
    FileSize: Int64;
    Lines: TStringList;
    Row: T;
    TableColumns: Byte;

    line, headline: String;
    i: Integer;
begin

    FileName := Utils.DB.GetFullCSVDBTablePath(FTableName);
    FileSize := TFile.GetSize(FileName);

    Row := Default(T);

    try
        FS.Create(FileName, fmOpenRead);
        SR.Create(FS);

        headline := SR.ReadLine();
        TableColumns := Length(Utils.CSV.DeserializeCSV(headline));

        while not(SR.EndOfStream) do
        begin
            line := SR.ReadLine();

            for i := 0 to TableColumns do
            begin

                // mit line nur ein mögliches Ergebnis
                Row := Utils.CSV.TCSVUtils<T>.DeserializeCSV(line)[0];

                SetLength(Result, Length(Result) + 1);
                Result[High(Result)] := Row;

            end;

        end;


    finally
        FS.Free;
        SR.Free;
    end;

end;

procedure TDB<T>.SetStructuredTableInCSV();
begin

    // .csv öffnen
    // .csv schreiben
    // .csv schließen

end;


function TDB<T>.GetUnstructuredTableFromCSV(): String;
var
    FS: TFileStream;
    SR: TStreamReader;
    FileName: String;
    TempRes: TArray<String>;
    i: Integer;
begin

    FileName := Utils.DB.GetFullCSVDBTablePath(FTableName);

    try
        FS.Create(FileName, fmOpenRead);
        SR.Create(FS);

        TempRes := Utils.CSV.DeserializeCSV(SR.ReadToEnd());

        for i := 0 to High(TempRes) do
            Result := Result + TempRes[i];

    finally
        FS.Free;
        SR.Free;
    end;
end;

procedure TDB<T>.SetUnstructuredTableInCSV(CSVString: String);
var
    FS: TFileStream;
    SW: TStreamWriter;
    FileName: String;
begin

    FileName := Utils.DB.GetFullCSVDBTablePath(FTableName);

    try
        FS.Create(FileName, fmOpenWrite);
        SW.Create(FS);

        SW.Write(Utils.CSV.SerializeCSV(CSVString));

    finally
        FS.Free;
        SW.Free;
    end;
end;


procedure TDB<T>.AddCSVTableToDB(CSVObject: T);
var
    FS: TFileStream;
    SW: TStreamWriter;
    FileName: String;
begin

    FileName := Utils.DB.GetFullCSVDBTablePath(FTableName);

    if (FileExists(FileName)) then
        raise Exception.Create('db.pas Error: Database table already exists.');
    

    try
        FS.Create(FileName, fmCreate);
        SW.Create(FS);


        SW.Write(Utils.CSV.TCSVUtils<T>.SerializeCSV(CSVObject));




    finally
        FS.Free;
        SW.Free;
    end;
end;


end.