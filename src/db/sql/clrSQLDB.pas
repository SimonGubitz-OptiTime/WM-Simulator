unit clrSQLDB;

interface

// {
uses
  System.Classes,
  System.Generics.Collections,
  System.SysUtils,
  SqlExpr,
  damTypes,
  clrDB,
  clrUtils.DB,
  clrUtils.Rtti,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, IniFiles,
  FireDAC.Phys.MSSQL,
  FireDAC.Phys.MSSQLDef,
  Vcl.Dialogs;


type
  TSQLDB<T: record> = class(TInterfacedObject, IDB<T>)
    private
      FInitialisiert: Boolean;
      FDBUpdateEventListeners: TList<TDBUpdateEvent>;

      FSQLTabellenName: String;
      FDConnection1: TFDConnection;
      FDQuery1: TFDQuery;

      function InitialisiereQuery(AQuery: TFDQuery; AFDConnection: TFDConnection; ASql: String): Boolean;
      function InitialisiereQueryInsert(AQuery: TFDQuery; AFDConnection: TFDConnection; ASql: String): Boolean;

    public
      constructor Create(ATableName: String);
      destructor  Destroy; override;

      function    StrukturierteTabelleErhalten(): TList<T>;
      function    UnstrukturierteTabelleErhalten(): TObjectList<TList<String>>;

      procedure   AddDBUpdateEventListener(ACallbackFunction: TDBUpdateEvent);
      procedure   CallDBUpdateEventListeners();

      procedure   ZeileHinzufuegen(ARow: T);
      procedure   ZeileEntfernen(ARow: T); overload;
      procedure   ZeileEntfernen(ARowString: String); overload;
      function    ZeileFinden(AFinderFunction: TDBFinderFunction<T>; out ReturlVal: T): Boolean;

      function   GetInitialisiert: Boolean;

      property Initialisiert: Boolean read FInitialisiert;

    published

      const
        SQLDBName: ShortString = 'WM-Simulator-Test';

  end;
// }
implementation

// {
constructor TSQLDB<T>.Create(ATableName: String);
begin
  inherited Create;


  FInitialisiert := false;

  // SQL
  FSQLTabellenName := clrUtils.DB.GetSQLDBName(ATableName);
  FDConnection1 := TFDConnection.Create(nil);
  FDQuery1 := TFDQuery.Create(nil);

  // Versuchen zu verbinden
  try 
    FDConnection1.LoginPrompt := false;

    with FDConnection1.Params do
    begin
      Add('DriverID='   + 'MSSQL');
      Add('Server='     + 'PC-BRUM\WMSIMULATORTEST');
      Add('Database='   + SQLDBName);
      Add('User_Name='  + 'sa');
      Add('Password='   + 'WMSimulator-Password');
    end;

    FDConnection1.Connected := true;

    //ShowMessage('Verbindung erfolgreich');
  except
    ShowMessage('Verbindung zur Datenbank konnte nicht hergestellt werden.');
  end;


  FDBUpdateEventListeners := TList<TDBUpdateEvent>.Create();

end;

destructor TSQLDB<T>.Destroy;
begin
  FDConnection1.Free;
  FDBUpdateEventListeners.Free;

  inherited Destroy;
end;

function TSQLDB<T>.GetInitialisiert: Boolean;
begin
  Result := FInitialisiert;
end;

function TSQLDB<T>.InitialisiereQuery(AQuery: TFDQuery; AFDConnection: TFDConnection; ASql: string): boolean;
begin
  Result := True;
  try
    AQuery.Close;
    AQuery.Connection := AFDConnection;
    AQuery.SQL.Clear;
    AQuery.SQL.Add(ASql);
    AQuery.Open;
    if not AQuery.Eof then
    begin
      AQuery.First;
    end;
  except
    Result := False;
    showMessage('Abfrage fehlgeschlagen.');
  end;
end;

function TSQLDB<T>.InitialisiereQueryInsert(AQuery: TFDQuery; AFDConnection: TFDConnection; ASql: string): boolean;
begin
  Result := True;
  try
    AQuery.Close;
    AQuery.Connection := AFDConnection;
    AQuery.SQL.Clear;
    AQuery.SQL.Add(ASql);
    AQuery.ExecSQL;
    if not AQuery.Eof then
    begin
      AQuery.First;
    end;
  except
    on E: Exception do
    begin
      Result := False;
     showMessage(E.Message + 'Abfrage fehlgeschlagen.');
    end;
  end;
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
var
  Ndx: Integer;
  SQLWhereQuery: String;

  ColNames: TList<String>;
  ColValues: TList<String>;
begin

  ColNames := clrUtils.Rtti.TRttiUtils<T>.NamesAsArray;
  ColValues := clrUtils.Rtti.TRttiUtils<T>.ValuesAsArray(ARow);

  if (ColValues.Count <> ColNames.Count ) then
  begin
    raise Exception.Create('Error: ColNames and ColValues not the same length.');
  end;

  for Ndx := 0 to ColValues.Count do
  begin
    SQLWhereQuery := SQLWhereQuery + sLineBreak + ColNames[Ndx] + '=' + ColValues[Ndx];
  end;

  // Versuchen zu löschen, bei einer Exception Fehler ausgeben
  //try

  // DELETE FROM :table_name (TRttiUtils<T>.TNamesAsString)
  // WHERE SQLWhereQuery
end;

procedure TSQLDB<T>.ZeileEntfernen(ARowString: String);
begin
  raise Exception.Create('Dieser overload ist noch nicht implementiert worden.');
end;

function TSQLDB<T>.ZeileFinden(AFinderFunction: TDBFinderFunction<T>; out ReturlVal: T): Boolean;
var
  SQLQuery: String;
begin
  // SELECT * FROM :table_name (TRttiUtils<T>.TNamesAsString)
  // WHERE

  SQLQuery := 'SELECT * FROM ' + FSQLTabellenName + ' WHERE x==1';

  // {
  InitialisiereQuery(FDQuery1, FDConnection1, SQLQuery);
  //}

end;
// }

end.
