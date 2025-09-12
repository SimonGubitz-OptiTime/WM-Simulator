unit clrUtils.SQL;

interface

uses
  {$IFDEF DEBUG}
  Vcl.Dialogs,
  {$ENDIF}

  System.RTTI,
  System.SysUtils,
  System.TypInfo,
  clrUtils.RTTI,
  clrUtils.ArrToStr;

type
  TSQLUtils = class
    private
      class var FDelphiToSQLTypeDict: TDictionary<TTypeKind, String>;
    public

      /// <summary>
      /// string wird z.B. zu 'string'
      /// <summary>
      class function FormatSQLCondition<T: record>(ARow: T; AFormatString: String = '%s=%s'): String; overload;
      class function FormatSQLCondition<T: record>(ARow: T; AFormatString: String = '%s=%s AND'; ACustomLastFormatString: String = '%s=%s;'): String; overload;
      class function FormatVarToSQL<T>(AVar: T): String; overload;
      class function FormatVarToSQL(AVar: TValue): String; overload;

    private
  end;

implementation

class constructor TSQLUtils.Create;
begin
  FDelphiToSQLTypeDict := TDictionary<TTypeKind, String>.Create;

  // Dies ist keine offizielle 1:1-Übersetzung, sondern um eine App spezifische Adaption
  FDelphiToSQLTypeDict.AddOrSetValue(tkUString, 'varchar(50)');
  FDelphiToSQLTypeDict.AddOrSetValue(tkString, 'varchar(50)');
  FDelphiToSQLTypeDict.AddOrSetValue(tkEnumeration, 'varchar(50)');
  FDelphiToSQLTypeDict.AddOrSetValue(tkDynArray, 'varchar(50)'); // Spieler Liste wird als
  FDelphiToSQLTypeDict.AddOrSetValue(tkInteger, 'int');
  FDelphiToSQLTypeDict.AddOrSetValue(tkChar, 'char');
  FDelphiToSQLTypeDict.AddOrSetValue(tkArray, 'varchar(50)');
end;

class destructor TSQLUtils.Destroy;
begin
  FDelphiToSQLTypeDict.Free;
end;

class function TSQLUtils.FormatSQLConditionNameValue<T>(ARow: T; AFormatString: String = '%s=%s'): String;
var
  RttiContext: TRttiContext;
  RttiType: TRttiType;
  RttiFields: TArray<TRttiField>;
  Ndx: Integer;
begin

  RttiContext := TRttiContext.Create;

  try
    RttiType := RttiContext.GetType(TypeInfo(T));
    RttiFields := RttiType.GetFields;

    for Ndx := 0 to Length(RttiFields) - 1 do
    begin
      if Ndx > 0 then
      begin
        Result := Result + sLineBreak;
      end;

      Result := Result + Format(AFormatString, [RttiFields[Ndx].Name, FormatVarToSQL(RttiFields[Ndx].GetValue(@ARow))]);

    end;
  finally
    RttiContext.Free;
  end;
end;

class function TSQLUtils.FormatSQLCondition<T>(ARow: T; AFormatString: String = '%s=%s AND'; ACustomLastFormatString: String = '%s=%s;'): String;
var
  RttiContext: TRttiContext;
  RttiType: TRttiType;
  RttiFields: TArray<TRttiField>;
  Ndx: Integer;
begin

  RttiContext := TRttiContext.Create;

  try
    RttiType := RttiContext.GetType(TypeInfo(T));
    RttiFields := RttiType.GetFields;

    for Ndx := 0 to Length(RttiFields) - 1 do
    begin
      if Ndx > 0 then
      begin
        Result := Result + sLineBreak;
      end;

      if Ndx < Length(RttiFields) - 1 then
      begin
        Result := Result + Format(AFormatString, [RttiFields[Ndx].Name, FormatVarToSQL(RttiFields[Ndx].GetValue(@ARow))]);
      end
      else if Ndx = Length(RttiFields) - 1 then
      begin
        Result := Result + Format(ACustomLastFormatString, [RttiFields[Ndx].Name, FormatVarToSQL(RttiFields[Ndx].GetValue(@ARow))]);
      end;

    end;
  finally
    RttiContext.Free;
  end;
end;

class function TSQLUtils.FormatSQLConditionNameType<T>(ARow: T; AFormatString: String = '%s=%s'): String;
var
  RttiContext: TRttiContext;
  RttiType: TRttiType;
  RttiFields: TArray<TRttiField>;
  Ndx: Integer;
begin

  RttiContext := TRttiContext.Create;

  try
    RttiType := RttiContext.GetType(TypeInfo(T));
    RttiFields := RttiType.GetFields;

    for Ndx := 0 to Length(RttiFields) - 1 do
    begin
      if Ndx > 0 then
      begin
        Result := Result + sLineBreak;
      end;

      var _Type := FDelphiToSQLTypeDict[RttiFields[Ndx].FieldType.TypeKind];
      Result := Result + Format(AFormatString, [RttiFields[Ndx].Name, _Type]);

    end;
  finally
    RttiContext.Free;
  end;
end;

class function TSQLUtils.FormatSQLConditionNameType<T>(ARow: T; AFormatString: String = '%s=%s AND'; ACustomLastFormatString: String = '%s=%s;'): String;
var
  RttiContext: TRttiContext;
  RttiType: TRttiType;
  RttiFields: TArray<TRttiField>;
  Ndx: Integer;
begin

  RttiContext := TRttiContext.Create;

  try
    RttiType := RttiContext.GetType(TypeInfo(T));
    RttiFields := RttiType.GetFields;

    for Ndx := 0 to Length(RttiFields) - 1 do
    begin
      if Ndx > 0 then
      begin
        Result := Result + sLineBreak;
      end;


      ShowMessage(RttiFields[Ndx].FieldType.Name);

      var _Type := FDelphiToSQLTypeDict[RttiFields[Ndx].FieldType.TypeKind];

      if Ndx < Length(RttiFields) - 1 then
      begin
        Result := Result + Format(AFormatString, [RttiFields[Ndx].Name, _Type]);
      end
      else if Ndx = Length(RttiFields) - 1 then
      begin
        Result := Result + Format(ACustomLastFormatString, [RttiFields[Ndx].Name, _Type]);
      end;

    end;
  finally
    RttiContext.Free;
  end;
end;

class function TSQLUtils.FormatVarToSQL<T>(AVar: T): String;
var
  MyVar: TValue;
begin
  MyVar := TValue.From<T>(AVar);
  Result := FormatVarToSQL(MyVar);
end;

class function TSQLUtils.FormatVarToSQL(AVar: TValue): String;
begin
  case AVar.TypeInfo.Kind of
    tkString, tkUString: Result := '''' + AVar.AsType<String> + '''';
    tkEnumeration: Result := '''' + AVar.ToString + '''';
    tkArray, tkDynArray: begin

      //
      {$IFDEF DEBUG}
        ShowMessage(IntToStr(AVar.GetArrayLength));
        var msg: String;
        for var i := 0 to AVar.GetArrayLength() - 1 do
        begin
          ShowMessage(AVar.GetArrayElement(i).ToString);

          if AVar.GetArrayElement(i).IsEmpty then
            ShowMessage('Empty');
        end;

      {$ENDIF}

      Result := '''' + '[' + clrUtils.ArrToStr.TArrToStrUtils<TValue>.FormatArrToStr(
        function(Ndx: Integer): String
        begin
          var l := AVar.GetArrayElement(Ndx).ToString;
          ShowMessage(l);
          Result := l;
        end,
        AVar.GetArrayLength,
        '%s,',
        '%s'
      ) + ']' + '''';

    end
    else Result := AVar.ToString;
  end;
end;


end.
