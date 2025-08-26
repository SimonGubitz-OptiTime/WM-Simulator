unit clrDB;

interface

uses
  damTypes,
  clrUtils.DB,
  clrUtils.CSV,
  clrUtils.RTTI,
  System.Generics.Collections, System.Classes, System.SysUtils, System.IOUtils,
  System.RTTI, Vcl.Dialogs;

type
  TDB<T: record> = class
  private
    FFS: TFileStream;
    FDBUpdateEventListeners: TList<TDBUpdateEvent>;
    FTableName: String;
    FInitialized: Boolean;
    FFileName: String;
    FFileDirectory: String;

    var FCachedCSV: TList<T>;
    var FCachedUnstructuredCSV: TObjectList<TList<String>>;

    procedure CallDBUpdateEventListeners();
    procedure AddCSVTableToDB(CSVObject: T);

  public
    property Initialized: Boolean read FInitialized;

    constructor Create(ATableName: String);

    // function    GetRowFromCSV(RowID: Integer): T;
    // procedure   SetRowInCSV(RowID: Integer; Line: Integer);
    procedure AddRowToCSV(ARowValues: T; SizeCheck: Boolean = true);

    function GetStructuredTableFromCSV(): TList<T>;
    // procedure   SetStructuredTableInCSV(CSVArray: TObjectList<T>);

    function GetUnstructuredTableFromCSV(): TObjectList<TList<String>>;

    // Event listener JS equivalent
    // adding function pointers to be called when the CSV table changes
    procedure AddDBUpdateEventListener(ACallbackFunction: TDBUpdateEvent);

    destructor Destroy;

  end;

implementation

constructor TDB<T>.Create(ATableName: String);
begin
  FInitialized := false;
  FTableName := ATableName;

  // Dateien
  FFileName := clrUtils.DB.GetTablesFilePath(FTableName);
  FFileDirectory := clrUtils.DB.GetTablesDirPath();
  if not ( TDirectory.Exists(FFileDirectory) ) then
  begin
    TDirectory.CreateDirectory(FFileDirectory);
  end;

  if not ( FileExists(FFileName) ) then
  begin
    TFile.Create(FFileName).Free; // Schnell erstellen und wieder schließen
  end;

  FFS := TFileStream.Create(FFileName, fmOpenReadWrite or fmShareDenyNone); // or fmShareDenyWrite
  FDBUpdateEventListeners := TList<TDBUpdateEvent>.Create();

  // Um als Ziel anzugeben, ob die Datei sicher geöffnet und beschrieben werden kann
  FInitialized := true;


  // reset all cache
  FCachedCSV := TList<T>.Create;
  FCachedUnstructuredCSV := TObjectList<TList<String>>.Create(true);

  if ( FFS.Size <> 0 ) then
  begin
    // Write cache
    FCachedCSV              := GetStructuredTableFromCSV();
    FCachedUnstructuredCSV  := GetUnstructuredTableFromCSV();
  end;

end;

// procedure TDB<T>.SetRowInCSV(ARowID: Integer; ALine: Integer);
// begin
// if not ( FInitialized ) then
// begin
//  raise Exception.Create('db.pas Error: TDB is not initialized. Please add to the database first.');
// end;

// // .csv öffnen


// // Call the event listeners
// CallDBUpdateEventListeners();
// end;

procedure TDB<T>.AddRowToCSV(ARowValues: T; SizeCheck: Boolean = true);
var
  SW: TStreamWriter;
  WriterString: String;
begin

  if ( not(FileExists(FFileName))
       or ( SizeCheck
            and (FFS.size = 0))
  ) then
  begin
    AddCSVTableToDB(ARowValues);
    Exit;
  end
  else
  begin

    SW := TStreamWriter.Create(FFS);
    FCachedCSV.Clear;
    FCachedUnstructuredCSV.Clear;

    try
      SW.BaseStream.Position := FFS.size;
      { if SW.Encoding = TEncoding.UTF16 then
      begin
        SW.BaseStream.Position := FFS.size / 2; // 2 byte pro character
      end; }

      WriterString := clrUtils.CSV.TCSVUtils<T>.SerializeRowCSV(ARowValues);
      SW.WriteLine(WriterString);

      // Append to cache as well
      FCachedCSV.Add(ARowValues);
      FCachedUnstructuredCSV.Add(clrUtils.CSV.TCSVUtils<T>.ParseRowCSVToArray(ARowValues));

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

  Line: String;
begin

  if not ( FInitialized ) then
  begin
    raise Exception.Create('db.pas Error: TDB is not initialized. Please add to the database first.');
  end;

  Result := TList<T>.Create;

  if ( Assigned(FCachedCSV)) and ( FCachedCSV.Count > 0 ) then
  begin
    Result.AddRange(FCachedCSV);
    Exit;
  end
  else
  begin
    Row := Default (T);
    SR := TStreamReader.Create(FFS);

    try
      FFS.Position := 0;

      // headline ignorieren
      Line := SR.ReadLine();

      while not(SR.EndOfStream) do
      begin
        Line := SR.ReadLine();

        // Zeile direkt als serialisiertes Objekt speichern
        Row := clrUtils.CSV.TCSVUtils<T>.DeserializeRowCSV(Line);
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
  Line: String;
begin

  if not ( FInitialized ) then
  begin
    raise Exception.Create('db.pas Error: TDB is not initialized. Please add to the database first.');
  end;

  Result := TObjectList<TList<String>>.Create;

  if ( Assigned(FCachedUnstructuredCSV)) and ( FCachedUnstructuredCSV.Count > 0) then
  begin
    Result.AddRange(FCachedUnstructuredCSV);
    Exit;
  end
  else
  begin

    SR := TStreamReader.Create(FFS);

    try
      FFS.Position := 0;
      FCachedUnstructuredCSV.Clear;
      while not(SR.EndOfStream) do
      begin
        Line := SR.ReadLine();
        Temp := clrUtils.CSV.DeserializeCSV(Line);
        FCachedUnstructuredCSV.Add(Temp);
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

  SW := TStreamWriter.Create(FFS);


  try
    FFS.Position := 0;


    SW.WriteLine(clrUtils.CSV.TCSVUtils<T>.GetCSVHeaderAsString);
    SW.WriteLine(clrUtils.CSV.TCSVUtils<T>.SerializeRowCSV(CSVObject));

    // Append to cache as well
    FCachedUnstructuredCSV.Add(clrUtils.CSV.TCSVUtils<T>.ParseRowCSVToArray(CSVObject));
    FCachedCSV.Add(CSVObject);

    FInitialized := true;

  finally
    SW.Free;
  end;

  // Call the event listeners
  CallDBUpdateEventListeners();
end;

procedure TDB<T>.AddDBUpdateEventListener(ACallbackFunction: TDBUpdateEvent);
begin

  // Add "CallbackFunction" to a list of event listeners
  // This will be called whenever the CSV table changes
  FDBUpdateEventListeners.Add(ACallbackFunction);

  // ShowMessage('DB Update Event Listener added: ' + IntToStr(FDBUpdateEventListeners.Count) + ' listeners.');
end;

procedure TDB<T>.CallDBUpdateEventListeners();
var
  Ndx: Integer;
begin
  for Ndx := 0 to FDBUpdateEventListeners.Count - 1 do
  begin
    try
      FDBUpdateEventListeners[Ndx]();
    except
      on E: Exception do
      begin
        ShowMessage('Error in DB Update Event Listener' + IntToStr(Ndx) + ': ' + E.Message);
        // ErrorLogger.Log('Error in DB Update Event Listener: ' + E.Message);
        continue; // Continue with the next listener
      end;
    end;
  end;
  // ShowMessage('DB Update Event Listener called: ' + IntToStr(FDBUpdateEventListeners.Count) + ' listeners.');
end;

destructor TDB<T>.Destroy;
begin

  // Clear the cached data
  FCachedCSV.Free;
//  FCachedUnstructuredCSV.Free;

  // Free the list of event listeners
  FDBUpdateEventListeners.Free;

  // Close the file stream
  FFS.Free;

  // Call the inherited destructor
  inherited Destroy;
end;

end.
