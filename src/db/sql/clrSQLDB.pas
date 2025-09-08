unit clrSQLDB;

interface

{
uses
  System.Generics.Collections,
  SqlExpr,
  damTypes,
  clrDB,
  u_global_database;


type
  TSQLDB<T: record> = class(TInterfacedObject, IDB<T>)
    private
      FTabellenName: String;
      FInitialisiert: Boolean;
    public
      constructor Create(ATableName: String);
      destructor  Destroy; override;

      function    StrukturierteTabelleErhalten(): TList<T>;
      function    UnstrukturierteTabelleErhalten(): TObjectList<TList<String>>;

      procedure   AddDBUpdateEventListener(ACallbackFunction: TDBUpdateEvent);

      procedure   ZeileHinzufuegen(ARow: T);
      procedure   ZeileEntfernen(ARow: T); overload;
      procedure   ZeileEntfernen(ARowString: String); overload;
      function    ZeileFinden(AFinderFunction: TDBFinderFunction<T>; out ReturlVal: T): Boolean;

      function   GetInitialisiert: Boolean;

      property Initialisiert: Boolean read FInitialisiert;
  end;
// }
implementation

{
constructor TSQLDB<T>.Create(ATableName: String);
begin
  inherited Create;

  FDBUpdateEventListeners := TList<TDBUpdateEvent>.Create();
end;

destructor TSQLDB<T>.Destroy;
begin
  FDBUpdateEventListeners.Free;

  inherited Destroy;
end;

function TSQLDB<T>.GetInitialisiert: Boolean;
begin
  Result := FInitialisiert;
end;

function TSQLDB<T>.StrukturierteTabelleErhalten(): TList<T>;
begin
end;

function TSQLDB<T>.UnstrukturierteTabelleErhalten(): TObjectList<TList<String>>;
begin
end;

procedure TSQLDB<T>.AddDBUpdateEventListener(ACallbackFunction: TDBUpdateEvent);
begin
  FDBUpdateEventListeners.Add(ACallbackFunction);
end;

procedure TSQLDB<T>.CallDBUpdateEventListeners();
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
        continue;
      end;
    end;
  end;
  // ShowMessage('DB Update Event Listener called: ' + IntToStr(FDBUpdateEventListeners.Count) + ' listeners.');
end;

procedure TSQLDB<T>.ZeileHinzufuegen(ARow: T);
begin
  // INSERT INTO :table_name ()
  // VALUES
end;

procedure TSQLDB<T>.ZeileEntfernen(ARow: T);
begin
  where_query: string

  (TRttiUtils<T>.NamesAsArray)
  (TRttiUtils<T>.Values)


  // DELETE FROM :table_name (TRttiUtils<T>.TNamesAsString)
  // WHERE 
end;

function TSQLDB<T>.ZeileFinden(AFinderFunction: TDBFinderFunction<T>; out ReturlVal: T): Boolean;
begin
  // SELECT FROM :table_name (TRttiUtils<T>.TNamesAsString)
  // WHERE 
end;
// }

end.
