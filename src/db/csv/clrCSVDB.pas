unit clrCSVDB;

interface

uses
  System.Classes,
  System.Generics.Collections,
  System.IOUtils,
  System.Math,
  System.RTTI,
  System.SysUtils,
  Vcl.Dialogs,
  Vcl.Forms,
  damTypes,
  clrDB,
  clrUtils.DB,
  clrUtils.CSV,
  clrUtils.RTTI,
  clrUtils.StreamPosition;

type
  TCSVDB<T: record> = class(TInterfacedObject, IDB<T>)
    private
      FFS: TFileStream;
      FDBUpdateEventListeners: TList<TDBUpdateEvent>;
      FTabellenName: String;

      /// Gibt an, ob die Datei bereit ist geöffnet und beschrieben zu werden
      FInitialisiert: Boolean;
      FDateiName: String;
      FOrdnerPfad: String;

      FCachedCSV: TList<T>;
      FCachedUnstructuredCSV: TObjectList<TList<String>>;

      procedure CallDBUpdateEventListeners();
      procedure AddCSVTableToDB(CSVObject: T);

    public
      constructor Create(ATableName: String);
      destructor  Destroy; override;

      function    StrukturierteTabelleErhalten(): TList<T>;
      function    UnstrukturierteTabelleErhalten(): TObjectList<TList<String>>;

      procedure   AddDBUpdateEventListener(ACallbackFunction: TDBUpdateEvent);

      procedure   ZeileHinzufuegen(ARowValues: T);
      procedure   ZeileEntfernen(ARow: T); overload;
      procedure   ZeileEntfernen(ARowString: String); overload;
      function    ZeileFinden(AFinderFunction: TDBFinderFunction<T>; out ReturnValue: T): Boolean;

      function   GetInitialisiert: Boolean;

      property Initialisiert: Boolean read FInitialisiert;
  end;

implementation

constructor TCSVDB<T>.Create(ATableName: String);
begin

  inherited Create;

  FInitialisiert := false;
  FTabellenName := ATableName;

  // Dateien
  FDateiName := clrUtils.DB.GetTablesFilePath(FTabellenName);
  FOrdnerPfad := clrUtils.DB.GetTablesDirPath();
  if not ( TDirectory.Exists(FOrdnerPfad) ) then
  begin
    TDirectory.CreateDirectory(FOrdnerPfad);
  end;

  if not ( FileExists(FDateiName) ) then
  begin
    TFile.Create(FDateiName).Free; // Schnell erstellen und wieder schließen
  end;

  FFS := TFileStream.Create(FDateiName, fmOpenReadWrite or fmShareDenyNone); // or fmShareDenyWrite

  FDBUpdateEventListeners := TList<TDBUpdateEvent>.Create();

  // Um als Ziel anzugeben, ob die Datei sicher geöffnet und beschrieben werden kann
  FInitialisiert := true;

  {if ( FFS.Size <> 0 ) then
  begin
    // Write cache
    FCachedCSV              := StrukturierteTabelleErhalten();
    FCachedUnstructuredCSV  := UnstrukturierteTabelleErhalten();
  end;}

end;

destructor TCSVDB<T>.Destroy;
begin

  // Clear the filestream
  FFS.Free;

  // Free the list of event listeners
  FDBUpdateEventListeners.Free;

  // Clear the cached data
  FCachedCSV.Free;
  // FCachedUnstructuredCSV.Free;


  // Call the inherited destructor
  inherited Destroy;
end;

function TCSVDB<T>.GetInitialisiert: Boolean;
begin
  Result := FInitialisiert;
end;

// Returns a structured table from the CSV file
// There will be no error if the file is empty, just an empty array
// The State of the File is determined by the FInitialisiert variable
function TCSVDB<T>.StrukturierteTabelleErhalten(): TList<T>;
var
  SR: TStreamReader;
  Row: T;

  Line: String;
begin

  if not ( FInitialisiert ) then
  begin
    raise Exception.Create('db.pas Error: TCSVDB is not Initialisiert. Please add to the database first.');
  end;

  Result := TList<T>.Create;

  if ( Assigned(FCachedCSV)) and ( FCachedCSV.Count > 0 ) then
  begin
    Result.AddRange(FCachedCSV);
    Exit;
  end
  else
  begin
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

function TCSVDB<T>.UnstrukturierteTabelleErhalten(): TObjectList<TList<String>>;
var
  SR: TStreamReader;
  Temp: TList<String>;
  Line: String;
begin

  if not ( FInitialisiert ) then
  begin
    raise Exception.Create('db.pas Error: TCSVDB is not Initialisiert. Please add to the database first.');
  end;

  Result := TObjectList<TList<String>>.Create(true);

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
      while not(SR.EndOfStream) do
      begin
        Line := SR.ReadLine();
        Temp := clrUtils.CSV.DeserializeCSV(Line);
        Result.Add(Temp);
      end;
    finally
      SR.Free;
    end;
  end;
end;

procedure TCSVDB<T>.AddCSVTableToDB(CSVObject: T);
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

    FInitialisiert := true;

  finally
    SW.Free;
  end;

  // Call the event listeners
  CallDBUpdateEventListeners();
end;

procedure TCSVDB<T>.AddDBUpdateEventListener(ACallbackFunction: TDBUpdateEvent);
begin

  // Add "CallbackFunction" to a list of event listeners
  // This will be called whenever the CSV table changes
  FDBUpdateEventListeners.Add(ACallbackFunction);

  // ShowMessage('DB Update Event Listener added: ' + IntToStr(FDBUpdateEventListeners.Count) + ' listeners.');
end;

procedure TCSVDB<T>.CallDBUpdateEventListeners();
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

procedure TCSVDB<T>.ZeileHinzufuegen(ARowValues: T);
var
  SW: TStreamWriter;
  WriterString: String;
begin

  if ( not(FileExists(FDateiName))
       or (FFS.size = 0)
  ) then
  begin
    AddCSVTableToDB(ARowValues);
    Exit;
  end
  else
  begin

    SW := TStreamWriter.Create(FFS);

    try
      SW.BaseStream.Position := FFS.size;
      // Position in Bytes in the Stream
      if SW.Encoding = TEncoding.Unicode then
      begin
        SW.BaseStream.Position := Floor(FFS.size / 2); // 2 byte pro character
      end;

      WriterString := clrUtils.CSV.TCSVUtils<T>.SerializeRowCSV(ARowValues);
      SW.WriteLine(WriterString);

      // Append to cache as well
      {FCachedCSV.Add(ARowValues);
      FCachedUnstructuredCSV.Add(clrUtils.CSV.TCSVUtils<T>.ParseRowCSVToArray(ARowValues));}

    finally
      SW.Free;
    end;
  end;

  // Call the event listeners
  CallDBUpdateEventListeners();
end;

procedure TCSVDB<T>.ZeileEntfernen(ARow: T);
var
  RowString: String;
begin

  RowString := clrUtils.CSV.TCSVUtils<T>.SerializeRowCSV(ARow);
  ZeileEntfernen(RowString);

end;

procedure TCSVDB<T>.ZeileEntfernen(ARowString: String);
var
  ZeileZuEntfernen: T;
  SW: TStreamWriter;
  SR: TStreamReader;
  RowStartPosition: Integer;
begin


  SW := TStreamWriter.Create(FFS);
  SR := TStreamReader.Create(FFS);

  try

    // ignore headline
    var headline: String;
    headline :=    SR.ReadLine();
    ShowMessage(headline);

    while not(SR.EndOfStream) do
    begin
      RowStartPosition := clrUtils.StreamPosition.GetStreamPositionInChars(SR);
      if (SR.ReadLine() = ARowString) then
      begin
        // Nur diese Zeile löschen
        //   nichts, von             , bis biherige länge     - Anfang
        SW.Write([], RowStartPosition, SR.BaseStream.Position - RowStartPosition);
        Exit;
      end;
    end;
  finally
    SW.Free;
    SR.Free;
  end;

  CallDBUpdateEventListeners();
end;

function TCSVDB<T>.ZeileFinden(AFinderFunction: TDBFinderFunction<T>; out ReturnValue: T): Boolean;
var
  Row: T;
begin

  ReturnValue := Default(T);
  Result := false;

  for Row in StrukturierteTabelleErhalten do
  begin
    if AFinderFunction(Row) then
    begin
      ReturnValue := Row;
      Result := true;
      Exit;
    end;
  end;

end;


end.

