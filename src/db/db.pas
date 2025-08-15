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
  FFileName: String;
  FFileDirectory: String;

  CachedCSV: TArray<T>; static;
  CachedUnstructuredCSV: String; static;
  CachedHeader: TArray<String>; static;
  CachedHeaderString: String; static;

public
  property Initialized: Boolean read FInitialized;

  constructor Create(TableName: String);
  
  function    GetPropertyFromCSV(PropertyName: String): T;
  procedure   SetPropertyInCSV(PropertyName: String; PropertyValue: T);

  function    GetRowFromCSV(RowID: Integer): T;
  procedure   SetRowInCSV(RowID: Integer; RowType: T);
  procedure   AddRowToCSV(RowValues: T);

  function    GetStructuredTableFromCSV(): TArray<T>;
  procedure   SetStructuredTableInCSV(CSVArray: TArray<T>);

  function    GetUnstructuredTableFromCSV(): TArray<String>;
  procedure   SetUnstructuredTableInCSV(CSVString: String); // unnötig eigentlich

  procedure   AddCSVTableToDB(CSVObject: T);
  procedure   RemoveCSVTableFromDB();

end;



implementation

constructor TDB<T>.Create(TableName: String);
begin
FInitialized := false;
FTableName := TableName;

  FFileName := Utils.DB.GetTablesFilePath(FTableName);
  FFileDirectory := Utils.DB.GetTablesDirPath();
  if ((TDirectory.Exists(FFileDirectory)) and FileExists(FFileName)) then
    FInitialized := true;


end;


function TDB<T>.GetPropertyFromCSV(PropertyName: String): T;
var
  CSVArray: TArray<T>;
begin

  if not FInitialized then
    raise Exception.Create('db.pas Error: TDB is not initialized. Call AddCSVTableToDB first.');


//    CSVArray := GetStructuredTableFromCSV()[line];



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

procedure TDB<T>.AddRowToCSV(RowValues: T);
var
  SW: TStreamWriter;
  writerString: String;
begin

  SW := nil;

  if not FInitialized then
    raise Exception.Create('db.pas Error: TDB is not initialized. Call AddCSVTableToDB first.');

  // Read in the full CSV file
  // CSVArray := GetStructuredTableFromCSV();

  try
    SW := TStreamWriter.Create(FFileName, true);

    writerString := Utils.CSV.TCSVUtils<T>.SerializeRowCSV(RowValues);

    SW.WriteLine(writerString);

  finally
    SW.Free;
  end;

  

end;


// Returns a structured table from the CSV file
// There will be no error if the file is empty, just an empty array
// The State of the File is determined by the FInitialized variable
function TDB<T>.GetStructuredTableFromCSV(): TArray<T>;
var
  FS: TFileStream;
  SR: TStreamReader;
  FileSize: Int64;
  Lines: TStringList;
  Row: T;

  line: String;
  i: Integer;
begin

  if not FInitialized then
      raise Exception.Create('db.pas Error: TDB is not initialized. Call AddCSVTableToDB first.');

  FS := nil;
  SR := nil;

  Row := Default(T);

  try
    FS := TFileStream.Create(FFileName, fmOpenRead);
    SR := TStreamReader.Create(FS);

    // headline ignorieren
    SR.ReadLine();

    while not(SR.EndOfStream) do
    begin
      line := SR.ReadLine();

      Row := Utils.CSV.TCSVUtils<T>.DeserializeCSV(line)[0];

      SetLength(Result, Length(Result) + 1);
      Result[High(Result)] := Row;

    end;
  finally
      FS.Free;
      SR.Free;
  end;

end;

procedure TDB<T>.SetStructuredTableInCSV(CSVArray: TArray<T>);
var
  FS: TFileStream;
  SW: TStreamWriter;
  i: Integer;
begin

  if not FInitialized then
    raise Exception.Create('db.pas Error: TDB is not initialized. Call AddCSVTableToDB first.');

  FS := nil;
  SW := nil;

  try
    FS := TFileStream.Create(FFileName, fmCreate or fmShareExclusive);
    SW := TStreamWriter.Create(FS);

    // Write the header line
    SW.WriteLine(Utils.CSV.TCSVUtils<T>.GetCSVHeaderAsString());


    // Write each row to the CSV file
    for i := Low(CSVArray) to High(CSVArray) do
    begin
      SW.WriteLine(Utils.CSV.TCSVUtils<T>.SerializeCSV(CSVArray));
    end;

  finally
    FS.Free;
    SW.Free;
  end;
end;


function TDB<T>.GetUnstructuredTableFromCSV(): TArray<String>;
var
  FS: TFileStream;
  SR: TStreamReader;
begin

  if not FInitialized then
    raise Exception.Create('db.pas Error: TDB is not initialized. Call AddCSVTableToDB first.');

  FS := nil;
  SR := nil;

  try
    FS := TFileStream.Create(FFileName, fmOpenRead);
    SR := TStreamReader.Create(FS);

    Result := Utils.CSV.DeserializeCSV(SR.ReadToEnd());

  finally
    FS.Free;
    SR.Free;
  end;
end;

procedure TDB<T>.SetUnstructuredTableInCSV(CSVString: String);
var
  FS: TFileStream;
  SW: TStreamWriter;
begin

  if not FInitialized then
    raise Exception.Create('db.pas Error: TDB is not initialized. Call AddCSVTableToDB first.');

  FS := nil;
  SW := nil;

  try
    FS := TFileStream.Create(FFileName, fmOpenWrite);
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
begin

  FS := nil;
  SW := nil;


  if not(TDirectory.Exists(FFileDirectory)) then
    TDirectory.CreateDirectory(FFileDirectory);



  if (FileExists(FFileName)) then
  begin
    FInitialized := true;

    AddRowToCSV(CSVObject);
  end
  else
  begin
    try
      FS := TFileStream.Create(FFileName, fmCreate or fmShareExclusive);
      SW := TStreamWriter.Create(FS);

      SW.Write(Utils.CSV.TCSVUtils<T>.SerializeRowCSV(CSVObject));
          

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
  if FileExists(FFileName) then
  begin  
    TFile.Delete(FFileName);
    FInitialized := false;
  end
  else
    raise Exception.Create('db.pas Error: Table "' + FTableName + '" does not exist.');


end;


end.