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

  class var CachedCSV: TList<T>;
  class var CachedUnstructuredCSV: TObjectList<TList<String>>;


  procedure   CallDBUpdateEventListeners();
  procedure   AddCSVTableToDB(CSVObject: T);

public
  property Initialized: Boolean read FInitialized;

  constructor Create(TableName: String);

  // function    GetRowFromCSV(RowID: Integer): T;
  // procedure   SetRowInCSV(RowID: Integer; Line: Integer);
  procedure   AddRowToCSV(RowValues: T);

  function    GetStructuredTableFromCSV(): TList<T>;
  // procedure   SetStructuredTableInCSV(CSVArray: TObjectList<T>);

  function    GetUnstructuredTableFromCSV(): TObjectList<TList<String>>;


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

  // reset all cache
  CachedCSV := TList<T>.Create;
  CachedUnstructuredCSV := TObjectList<TList<String>>.Create;

  FInitialized := true;
end;

// procedure TDB<T>.SetRowInCSV(RowID: Integer; Line: Integer);
// begin
//   if not FInitialized then
//     raise Exception.Create('db.pas Error: TDB is not initialized. Please add to the database first.');

//   // .csv öffnen


//   // Call the event listeners
//   CallDBUpdateEventListeners();
// end;

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
      raise Exception.Create('db.pas Error: TDB is not initialized. Please add to the database first.');

    SW := TStreamWriter.Create(FFS);

    try
      SW.BaseStream.Position := FFS.size;
      {if SW.Encoding = TEncoding.UTF16 then
        SW.BaseStream.Position := FFS.size / 2;} // 2 byte pro character

      WriterString := Utils.CSV.TCSVUtils<T>.SerializeRowCSV(RowValues);
      SW.WriteLine(WriterString);

      // Append to cache as well
      CachedCSV.Add(RowValues);
      CachedUnstructuredCSV.Add(Utils.CSV.TCSVUtils<T>.ParseRowCSVToArray(RowValues));

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
function TDB<T>.GetStructuredTableFromCSV(): TList<T>;
var
  SR: TStreamReader;
  FileSize: Int64;
  Lines: TStringList;
  Row: T;

  line: String;
  i: Integer;
begin

  if not FInitialized then
      raise Exception.Create('db.pas Error: TDB is not initialized. Please add to the database first.');

  Result := TList<T>.Create;

  if (Assigned(CachedCSV)) and (CachedCSV.Count > 0) then
  begin
    Result := CachedCSV;
    Exit;
  end
  else
  begin
    Row := Default(T);
    SR := TStreamReader.Create(FFS);

    try
      FFS.Position := 0;

      // headline ignorieren
      line := SR.ReadLine();

      while not(SR.EndOfStream) do
      begin
        line := SR.ReadLine();

        // Zeile direkt als serialisiertes Objekt speichern
        Row := Utils.CSV.TCSVUtils<T>.DeserializeRowCSV(line);
        Result.Add(Row);
      end;
    finally
        SR.Free;
    end;
  end;
end;


function TDB<T>.GetUnstructuredTableFromCSV(): TObjectList<TList<String>>;
var
  SR: TStreamReader;
  Temp: TList<String>;
begin

  if not FInitialized then
    raise Exception.Create('db.pas Error: TDB is not initialized. Please add to the database first.');

  Result := TObjectList<TList<String>>.Create;



  if (Assigned(CachedUnstructuredCSV)) and (CachedUnstructuredCSV.Count > 0) then
  begin
    Result := CachedUnstructuredCSV;
    Exit;
  end
  else
  begin
    Result := TObjectList<TList<String>>.Create;

    SR := TStreamReader.Create(FFS);

    try
      FFS.Position := 0;
      while not(SR.EndOfStream) do
      begin
        Temp := Utils.CSV.DeserializeCSV(SR.ReadLine());
        Result.Add(Temp);
      end;
    finally
      SR.Free;
    end;
  end;
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

      // Append to cache as well
      CachedUnstructuredCSV.Add(Utils.CSV.TCSVUtils<T>.ParseRowCSVToArray(CSVObject));
      CachedCSV.Add(CSVObject);

      FInitialized := true;

    finally
      SW.Free;
    end;
  end;

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

  // Clear the cached data
  CachedCSV.Free;
  CachedUnstructuredCSV.Free;

  // Call the inherited destructor
  inherited Destroy;
end;

end.