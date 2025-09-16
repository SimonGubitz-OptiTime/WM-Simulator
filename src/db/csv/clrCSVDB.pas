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

      /// Gibt an, ob die Datei bereit ist geöffnet und beschrieben zu werden
      FInitialisiert: Boolean;
      FDateiName: String;
      FOrdnerPfad: String;
      procedure CallDBUpdateEventListeners();

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

  // Dateien
  FDateiName := clrUtils.DB.GetTablesFilePath(ATableName);
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
  FFS.Position := 0;

  FDBUpdateEventListeners := TList<TDBUpdateEvent>.Create();

  // Um als Ziel anzugeben, ob die Datei sicher geöffnet und beschrieben werden kann
  FInitialisiert := true;

end;

destructor TCSVDB<T>.Destroy;
begin
  FFS.Free;
  FDBUpdateEventListeners.Free;

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

  SR := TStreamReader.Create(FFS);

  try
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
    FFS.Position := 0;
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
    FFS.Position := 0;
  end;
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
  SW := TStreamWriter.Create(FFS);

  try
    SW.BaseStream.Position := FFS.size;
    // Position in Bytes in the Stream
    if SW.Encoding = TEncoding.Unicode then
    begin
      SW.BaseStream.Position := Floor(FFS.size / 2); // 2 byte pro character
    end;



    WriterString := '';
    if ( FFS.size = 0 ) then
    begin
      WriterString := clrUtils.CSV.TCSVUtils<T>.GetCSVHeaderAsString() + sLineBreak;
    end;
    WriterString := WriterString + clrUtils.CSV.TCSVUtils<T>.SerializeRowCSV(ARowValues);
    SW.WriteLine(WriterString);

  finally
    SW.Free;
    FFS.Position := 0;
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
  SW: TStreamWriter;
  SR: TStreamReader;
  SL: TStringList;
  Ndx: Integer;
  Line: String;
begin

  SL := TStringList.Create;
  try
    SR := TStreamReader.Create(FFS);

    try
      while not(SR.EndOfStream) do
      begin
        Line := SR.ReadLine();
        if ( Line <> ARowString ) then
        begin
          SL.Add(Line);
        end;
      end;
    finally
      SR.Free;
      FFS.Position := 0;
    end;

    SW := TStreamWriter.Create(FFS);
    try
      for Ndx := 0 to SL.Count - 1 do
      begin
        SW.WriteLine(SL[Ndx]);
      end;
      SW.Flush;
      FFS.Size := FFS.Position;
    finally
      SW.Free;
      FFS.Position := 0;
    end;
  finally
    SL.Free;
  end;

  CallDBUpdateEventListeners();
end;

function TCSVDB<T>.ZeileFinden(AFinderFunction: TDBFinderFunction<T>; out ReturnValue: T): Boolean;
var
  Row: T;
  Rows: TList<T>;
begin

  ReturnValue := Default(T);
  Result := false;

  Rows := StrukturierteTabelleErhalten;
  try
    for Row in Rows do
    begin
      if AFinderFunction(Row) then
      begin
        ReturnValue := Row;
        Result := true;
        Exit;
      end;
    end;
  finally
    Rows.Free;
  end;

end;


end.

