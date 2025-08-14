unit DB;

interface

uses
    Utils.DB,
    Utils.CSV,
    Utils.RTTI,
    System.Classes, System.SysUtils, System.IOUtils, System.Rtti, Vcl.Dialogs;



type TDB<T: record> = class
  private
    FTableName: String;
    FInitialized: Boolean;
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
    FInitialized := false;
end;


function TDB<T>.GetPropertyFromCSV(PropertyName: String): T;
var
    CSVArray: TArray<T>;
begin

    if not FInitialized then
        raise Exception.Create('db.pas Error: TDB is not initialized. Call AddCSVTableToDB first.');


    CSVArray := GetStructuredTableFromCSV();



end;

procedure TDB<T>.SetPropertyInCSV(PropertyName: String; PropertyValue: T);
begin

    if not FInitialized then
        raise Exception.Create('db.pas Error: TDB is not initialized. Call AddCSVTableToDB first.');

    // .csv öffnen

end;


function TDB<T>.GetRowFromCSV(RowID: Integer): T;
begin

    if not FInitialized then
        raise Exception.Create('db.pas Error: TDB is not initialized. Call AddCSVTableToDB first.');

    // .csv öffnen
end;

procedure TDB<T>.SetRowInCSV(RowID: Integer; RowType: T);
begin
    if not FInitialized then
        raise Exception.Create('db.pas Error: TDB is not initialized. Call AddCSVTableToDB first.');

    // .csv öffnen
end;

procedure TDB<T>.AddRowToCSV(RowType: T);
begin

    if not FInitialized then
        raise Exception.Create('db.pas Error: TDB is not initialized. Call AddCSVTableToDB first.');

    // Read in the full CSV file
    var CSVArray: TArray<T> := GetStructuredTableFromCSV();

    // Add the new row to the end of the array

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

    if not FInitialized then
        raise Exception.Create('db.pas Error: TDB is not initialized. Call AddCSVTableToDB first.');

    FileName := Utils.DB.GetTablesFilePath(FTableName);
    FileSize := TFile.GetSize(FileName);

    Row := Default(T);

    try
        FS := TFileStream.Create(FileName, fmOpenRead);
        SR := TStreamReader.Create(FS);

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

    if not FInitialized then
        raise Exception.Create('db.pas Error: TDB is not initialized. Call AddCSVTableToDB first.');

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

    if not FInitialized then
        raise Exception.Create('db.pas Error: TDB is not initialized. Call AddCSVTableToDB first.');

    FS := nil;
    SR := nil;

    FileName := Utils.DB.GetTablesFilePath(FTableName);

    try
        FS := TFileStream.Create(FileName, fmOpenRead);
        SR := TStreamReader.Create(FS);

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

    if not FInitialized then
        raise Exception.Create('db.pas Error: TDB is not initialized. Call AddCSVTableToDB first.');

    FS := nil;
    SW := nil;

    FileName := Utils.DB.GetTablesFilePath(FTableName);

    try
        FS := TFileStream.Create(FileName, fmOpenWrite);
        SW := TStreamWriter.Create(FS);

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
    FileName, DirectoryPath: String;

    CSVArray: TArray<T>;
begin

    FS := nil;
    SW := nil;

    FileName := Utils.DB.GetTablesFilePath(FTableName);
    DirectoryPath := Utils.DB.GetTablesDirPath();


    if not(TDirectory.Exists(DirectoryPath)) then
      TDirectory.CreateDirectory(DirectoryPath);



    if (FileExists(FileName)) then
    begin
        FInitialized := true;

        // just add T as a new row
        AddRowToCSV(CSVObject);
    end
    else
    begin
        try
            FS := TFileStream.Create(FileName, fmCreate or fmShareExclusive);
            SW := TStreamWriter.Create(FS);


            SetLength(CSVArray, 1);
            CSVArray[High(CSVArray)] := CSVObject;
                    
            SW.Write(Utils.CSV.TCSVUtils<T>.SerializeCSV(CSVArray));
            

            FInitialized := true;

        finally
            FS.Free;
            SW.Free;
        end;
    end;
end;

procedure TDB<T>.RemoveCSVTableFromDB();
begin
    if not FInitialized then
        raise Exception.Create('db.pas Error: TDB is not initialized. Call AddCSVTableToDB first.');
    
    // Delete the file
    var FileName := Utils.DB.GetTablesFilePath(FTableName);
    if FileExists(FileName) then
    begin  
        TFile.Delete(FileName);
        FInitialized := false;
    end
    else
        raise Exception.Create('db.pas Error: Table "' + FTableName + '" does not exist.');


end;


end.