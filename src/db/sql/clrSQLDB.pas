unit clrSQLDB;

interface

// {
uses
  ClipBrd,
  Data.DB,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  FireDAC.Phys,
  FireDAC.Phys.Intf,
  FireDAC.Phys.MSSQL,
  FireDAC.Phys.MSSQLDef,
  FireDAC.Stan.Async,
  FireDAC.Stan.Error,
  FireDAC.Stan.Def,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Pool,
  FireDAC.UI.Intf,
  FireDAC.VCLUI.Wait,
  IniFiles,
  SqlExpr,
  System.Classes,
  System.Generics.Collections,
  System.SysUtils,
  System.RTTI,
  Vcl.Dialogs,


  damTypes,
  clrDB,
  clrUtils.DB,
  clrUtils.Rtti,
  clrUtils.SQL,
  clrUtils.ArrToStr;


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
      function    ZeileFinden(AFinderFunction: TDBFinderFunction<T>; out ReturnValue: T): Boolean;

      function   GetInitialisiert: Boolean;

      property Initialisiert: Boolean read FInitialisiert;

    published

      const
        SQLDBName: ShortString = 'WM-Simulator-Test';

  end;

// ↓ move to utils somewhere
{
const
  DelphiToSQLTypeDict<String, String>

  "String": "varchar"
  "Integer": "int"


// }



implementation


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

  FInitialisiert := true;

end;

destructor TSQLDB<T>.Destroy;
begin
  FDConnection1.Free;
  FDBUpdateEventListeners.Free;
  FDQuery1.Free;

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
    if not AQuery.EOF then
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
    if not AQuery.EOF then
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
var
  Names: TList<String>;
  Ndx: Integer;

  TempValue: TValue;
  TempRes: T;

  RttiContext: TRttiContext;
  RttiType: TRttiType;
  RttiFields: TArray<TRttiField>;
begin

  Result := TList<T>.Create;

  Names := clrUtils.Rtti.TRttiUtils<T>.NamesAsArray();


  var SQLQuery := 'SELECT * FROM ' + FSQLTabellenName;
  InitialisiereQuery(FDQuery1, FDConnection1, SQLQuery);

  while not FDQuery1.EOF do
  begin


    RttiContext := TRttiContext.Create;
    try

      RttiType := RttiContext.GetType(TypeInfo(T));
      RttiFields := RttiType.GetFields;

      if ( Names.Count <> Length(RttiFields) ) then
      begin
        raise Exception.Create('clrSQLDB.pas Error: Amount of Columns and Fields in Type do not match.');
      end;

      for Ndx := 0 to Names.Count - 1 do
      begin
        var ref := FDQuery1.FieldByName(Names[Ndx]).AsString;
        TempValue := clrUtils.RTTI.TRttiUtils<T>.StrToT(RttiFields[Ndx], ref);

        RttiFields[Ndx].SetValue(@TempRes, TempValue);
      end;

      Result.Add(TempRes);
    finally
      RttiContext.Free;
    end;

    FDQuery1.Next;
  end;
end;

function TSQLDB<T>.UnstrukturierteTabelleErhalten(): TObjectList<TList<String>>;
var
  TempList: TList<String>;
  Names: TList<String>;
  Name: String;
begin

  Result := TObjectList<TList<String>>.Create;

  Names := clrUtils.Rtti.TRttiUtils<T>.NamesAsArray();
  Result.AddRange(Names); // Überschriften


  var SQLQuery := 'SELECT * FROM ' + FSQLTabellenName;
  InitialisiereQuery(FDQuery1, FDConnection1, SQLQuery);


  while not FDQuery1.EOF do
  begin

    TempList := TList<String>.Create;

    for Name in Names do
    begin
      TempList.Add(FDQuery1.FieldByName(Name).AsString);
    end;

    Result.Add(TempList);

    FDQuery1.Next;

  end;
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
var
  Ndx: Integer;
  SQLQuery: String;

  ColNames: TList<String>;
  ColValues: TList<String>;
  ColVariables: TList<TValue>;
begin

  ColValues := TList<String>.Create;
  ColNames := clrUtils.Rtti.TRttiUtils<T>.NamesAsArray();
  ColVariables := clrUtils.Rtti.TRttiUtils<T>.VariablesAsArray(ARow);

  for Ndx := 0 to ColVariables.Count - 1 do
  begin
    ColValues.Add(clrUtils.SQL.TSQLUtils.FormatVarToSQL(ColVariables[Ndx]));
  end;

  SQLQuery := '';
  SQLQuery := SQLQuery + 'INSERT INTO ' + FSQLTabellenName + ' (' + clrUtils.ArrToStr.TArrToStrUtils<String>.FormatArrToStrSeparator(ColNames, ',') + ')' + sLineBreak;
  SQLQuery := SQLQuery + 'VALUES (' + clrUtils.ArrToStr.TArrToStrUtils<String>.FormatArrToStrSeparator(ColValues, ',') + ')';
  SQLQuery := SQLQuery + ';';


  Clipboard.AsText := SQLQuery;


  InitialisiereQueryInsert(FDQuery1, FDConnection1, SQLQuery);

  CallDBUpdateEventListeners();

end;

procedure TSQLDB<T>.ZeileEntfernen(ARow: T);
var
  SQLQuery: String;

  ColNames: TList<String>;
  ColValues: TList<String>;
begin

  ColNames := clrUtils.Rtti.TRttiUtils<T>.NamesAsArray;
  ColValues := clrUtils.Rtti.TRttiUtils<T>.ValuesAsArray(ARow);

  if (ColValues.Count <> ColNames.Count ) then
  begin
    raise Exception.Create('Error: ColNames and ColValues not the same length.');
  end;


  SQLQuery := '';
  SQLQuery := SQLQuery + 'DELETE TOP(1) FROM ' + FSQLTabellenName + sLineBreak;
  SQLQuery := SQLQuery + 'WHERE ' + clrUtils.SQL.TSQLUtils.FormatSQLCondition<T>(ARow, '%s=%s AND', '%s=%s;');

  Clipboard.AsText := SQLQuery;


  InitialisiereQueryInsert(FDQuery1, FDConnection1, SQLQuery);

  CallDBUpdateEventListeners();

end;

procedure TSQLDB<T>.ZeileEntfernen(ARowString: String);
begin
  raise Exception.Create('Dieser overload ist noch nicht implementiert worden.');

  // ZeileEntfernen(DeserializeRowCSV(ARowString));
end;

function TSQLDB<T>.ZeileFinden(AFinderFunction: TDBFinderFunction<T>; out ReturnValue: T): Boolean;
var
  Row: T;
begin

  Result := false;
  ReturnValue := Default(T);

  // Ineffizientes Design für SQL -> WHERE query
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
