unit DB;

interface

uses
  Types,
  Utils.DB,
  Utils.CSV,
  Utils.RTTI,
  System.Generics.Collections, System.Classes, System.SysUtils, System.IOUtils, System.Rtti, Vcl.Dialogs;


type TDB<T: record> = class
private
  FFS: TFileStream;
  FDBUpdateEventListeners: TList<TDBUpdateEvent>;
  FTableName: String;
  FInitialized: Boolean;
  FFileName: String;
  FFileDirectory: String;

  class var CachedCSV: TArray<T>;
  class var CachedUnstructuredCSV: String;
  class var CachedHeader: TArray<String>;
  class var CachedHeaderString: String;


  procedure   CallDBUpdateEventListeners();
  procedure   AddCSVTableToDB(CSVObject: T);

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

  function    GetUnstructuredTableFromCSV(): TArray<TArray<String>>;
  procedure   SetUnstructuredTableInCSV(CSVString: String); // unnötig eigentlich

  procedure   RemoveCSVTableFromDB();


  // Event listener JS equivalent
  // adding function pointers to be called when the CSV table changes
  procedure AddDBUpdateEventListener(CallbackFunction: TDBUpdateEvent);

  destructor Destroy;

end;



implementation

constructor TDB<T>.Create(TableName: String);
begin
  FInitialized := false;
  FTableName := TableName;

  FFileName := Utils.DB.GetTablesFilePath(FTableName);
  FFileDirectory := Utils.DB.GetTablesDirPath();
  if not(TDirectory.Exists(FFileDirectory)) then
    TDirectory.CreateDirectory(FFileDirectory);

  FFS := TFileStream.Create(FFileName, fmOpenReadWrite or fmShareDenyWrite);
  FDBUpdateEventListeners := TList<TDBUpdateEvent>.Create();

  FInitialized := true;
end;


function TDB<T>.GetPropertyFromCSV(PropertyName: String): T;
var
  CSVArray: TArray<T>;
begin

  if not FInitialized then
    raise Exception.Create('db.pas Error: TDB is not initialized. Call AddCSVTableToDB first.');


  // CSVArray := GetStructuredTableFromCSV()[line];


end;

procedure TDB<T>.SetPropertyInCSV(PropertyName: String; PropertyValue: T);
begin

  if not FInitialized then
    raise Exception.Create('db.pas Error: TDB is not initialized. Call AddCSVTableToDB first.');

  // .csv öffnen


  // Call the event listeners
  CallDBUpdateEventListeners();
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


  // Call the event listeners
  CallDBUpdateEventListeners();
end;

procedure TDB<T>.AddRowToCSV(RowValues: T);
var
  SW: TStreamWriter;
  WriterString: String;
begin

  if not(FileExists(FFileName)) then
  begin
    AddCSVTableToDB(RowValues);
    Exit;
  end
  else
  begin

    if not FInitialized then
      raise Exception.Create('db.pas Error: TDB is not initialized. Call AddCSVTableToDB first.');

    SW := TStreamWriter.Create(FFS);

    try
      SW.BaseStream.Position := FFS.size;
      {if SW.Encoding = TEncoding.UTF16 then
        SW.BaseStream.Position := FFS.size / 2;} // 2 byte pro character

      WriterString := Utils.CSV.TCSVUtils<T>.SerializeRowCSV(RowValues);
      SW.WriteLine(WriterString);

    finally
      SW.Free;
    end;
  end;

  // Call the event listeners
  CallDBUpdateEventListeners();
end;


// Returns a structured table from the CSV file
// There will be no error if the file is empty, just an empty array
// The State of the File is determined by the FInitialized variable
function TDB<T>.GetStructuredTableFromCSV(): TArray<T>;
var
  SR: TStreamReader;
  FileSize: Int64;
  Lines: TStringList;
  Row: T;

  line: String;
  i: Integer;
begin

  if not FInitialized then
      raise Exception.Create('db.pas Error: TDB is not initialized. Call AddCSVTableToDB first.');

  SR := nil;

  Row := Default(T);

  try
    FFS.Position := 0;
    SR := TStreamReader.Create(FFS);

    // headline ignorieren
    line := SR.ReadLine();

    while not(SR.EndOfStream) do
    begin
      line := SR.ReadLine();

      Row := Utils.CSV.TCSVUtils<T>.DeserializeRowCSV(line);


      SetLength(Result, Length(Result) + 1);
      Result[High(Result)] := Row;

    end;
  finally
      SR.Free;
  end;
end;

procedure TDB<T>.SetStructuredTableInCSV(CSVArray: TArray<T>);
var
  SW: TStreamWriter;
  i: Integer;
begin

  if not FInitialized then
    raise Exception.Create('db.pas Error: TDB is not initialized. Call .Create first.');

  SW := nil;

  try
    SW := TStreamWriter.Create(FFS);

    // Write the header line
    SW.WriteLine(Utils.CSV.TCSVUtils<T>.GetCSVHeaderAsString());


    // Write each row to the CSV file
    for i := Low(CSVArray) to High(CSVArray) do
    begin
      SW.WriteLine(Utils.CSV.TCSVUtils<T>.SerializeCSV(CSVArray));
    end;

  finally
    SW.Free;
  end;
  
  // Call the event listeners 
  CallDBUpdateEventListeners();
end;


function TDB<T>.GetUnstructuredTableFromCSV(): TArray<TArray<String>>;
var
  SR: TStreamReader;
begin

  if not FInitialized then
    raise Exception.Create('db.pas Error: TDB is not initialized. Call AddCSVTableToDB first.');


  SetLength(Result, 0);

  SR := nil;

  try
    FFS.Position := 0;
    SR := TStreamReader.Create(FFS);

    while not(SR.EndOfStream) do
    begin

      SetLength(Result, Length(Result) + 1);
      Result[High(Result)] := Utils.CSV.DeserializeCSV(SR.ReadLine());

      // Result := Result + Utils.CSV.DeserializeCSV(SR.ReadLine());

    end;

  finally
    SR.Free;
  end;
end;

procedure TDB<T>.SetUnstructuredTableInCSV(CSVString: String);
var
  SW: TStreamWriter;
begin

  if not FInitialized then
    raise Exception.Create('db.pas Error: TDB is not initialized. Call AddCSVTableToDB first.');

  SW := nil;

  try
    FFS.Position := 0;
    SW := TStreamWriter.Create(FFS);

    SW.Write(Utils.CSV.SerializeCSV(CSVString));

  finally
    SW.Free;
  end;

  // Call the event listeners
  CallDBUpdateEventListeners();
end;


procedure TDB<T>.AddCSVTableToDB(CSVObject: T);
var
  SW: TStreamWriter;
begin

  SW := nil;


  if (FileExists(FFileName)) then
  begin
    FInitialized := true;
    AddRowToCSV(CSVObject);
  end
  else
  begin
    try
      FFS.Position := 0;
      SW := TStreamWriter.Create(FFS);

      SW.WriteLine(Utils.CSV.TCSVUtils<T>.GetCSVHeaderAsString);
      SW.WriteLine(Utils.CSV.TCSVUtils<T>.SerializeRowCSV(CSVObject));


      FInitialized := true;

    finally
      SW.Free;
    end;
  end;

  // Call the event listeners 
  CallDBUpdateEventListeners();
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

  // Clear the cached data
  SetLength(CachedCSV, 0);
  CachedUnstructuredCSV := '';
  SetLength(CachedHeader, 0);
  CachedHeaderString := '';

  // Call the event listeners
  CallDBUpdateEventListeners();
end;

procedure TDB<T>.AddDBUpdateEventListener(CallbackFunction: TDBUpdateEvent);
begin

  // Add "CallbackFunction" to a list of event listeners
  // This will be called whenever the CSV table changes
  FDBUpdateEventListeners.Add(CallbackFunction);

  // ShowMessage('DB Update Event Listener added: ' + IntToStr(FDBUpdateEventListeners.Count) + ' listeners.');
end;

procedure TDB<T>.CallDBUpdateEventListeners();
var
  i: Integer;
begin
  for i := 0 to FDBUpdateEventListeners.Count -1  do
  begin
    try
      FDBUpdateEventListeners[i]();
    except
      on E: Exception do
      begin
        ShowMessage('Error in DB Update Event Listener: ' + E.Message);
        // ErrorLogger.Log('Error in DB Update Event Listener: ' + E.Message);
        continue; // Continue with the next listener
      end;
    end;
  end;
  // ShowMessage('DB Update Event Listener called: ' + IntToStr(FDBUpdateEventListeners.Count) + ' listeners.');
end;

destructor TDB<T>.Destroy;
begin
  // Free the list of event listeners
  FDBUpdateEventListeners.Free;
  FDBUpdateEventListeners.Clear;

  // Call the inherited destructor
  inherited Destroy;

  // Clear the cached data
  SetLength(CachedCSV, 0);
  CachedUnstructuredCSV := '';
  SetLength(CachedHeader, 0);
  CachedHeaderString := '';
end;

end.