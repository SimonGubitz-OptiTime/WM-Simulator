unit clrSQLDB;

interface

uses
  System.Generics.Collections,
  damTypes,
  clrDB;
  // U_Global_Database;


{
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
      procedure   ZeileEntfernen(ARow: T);
      function    ZeileFinden(AFinderFunction: TDBFinderFunction<T>; out ReturlVal: T): Boolean;

      function   GetInitialisiert: Boolean;

      property Initialisiert: Boolean read FInitialisiert;
  end;}

implementation

{constructor TSQLDB<T>.Create(ATableName: String);
begin
  inherited Create;
end;

destructor TSQLDB<T>.Destroy;
begin
  inherited Destroy;
end;

function TSQLDB<T>.GetInitialisiert: Boolean;
begin
  Result := FInitialisiert;
end;

function    StrukturierteTabelleErhalten(): TList<T>;

function    UnstrukturierteTabelleErhalten(): TObjectList<TList<String>>;

procedure   AddDBUpdateEventListener(ACallbackFunction: TDBUpdateEvent);

procedure   ZeileHinzufuegen(ARow: T);

procedure   ZeileEntfernen(ARow: T);

function    ZeileFinden(AFinderFunction: TDBFinderFunction<T>; out ReturlVal: T): Boolean;
}

end.
