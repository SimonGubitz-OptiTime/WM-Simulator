unit clrUtils.SQL;

interface

uses
  {$IFDEF DEBUG}
  Vcl.Dialogs,
  {$ENDIF}

  System.RTTI,
  System.Generics.Collections,
  System.SysUtils,
  System.TypInfo,
  clrUtils.RTTI,
  clrUtils.ArrToStr;

type
  TSQLUtils = class
    public

      /// <summary>
      /// string wird z.B. zu 'string'
      /// <summary>
      class function FormatSQLConditionNameValue<T: record>(ARow: T; AFormatString: String = '%s=%s'): String; overload;
      class function FormatSQLConditionNameValue<T: record>(ARow: T; AFormatString: String = '%s=%s AND'; ACustomLastFormatString: String = '%s=%s;'): String; overload;

      class function FormatSQLConditionNameType<T: record>(ARow: T; AFormatString: String = '%s=%s'): String; overload;
      class function FormatSQLConditionNameType<T: record>(ARow: T; AFormatString: String = '%s=%s AND'; ACustomLastFormatString: String = '%s=%s;'): String; overload;

      class function FormatVarToSQL<T>(AVar: T): String; overload;
      class function FormatVarToSQL(AVar: TValue): String; overload;

    private
  end;

// ↓ move to utils somewhere
{
const
  DelphiToSQLTypeDict := TDict<TTypeKind, String>

  tkUString: 'varchar(50)'
  tkString: 'varchar(50)'
  tkInt: 'int'
  tkByte: 'char'
  tkArray: ''
  tkEnumeration: 'varchar(50)'


// }


implementation

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

class function TSQLUtils.FormatSQLConditionNameValue<T>(ARow: T; AFormatString: String = '%s=%s AND'; ACustomLastFormatString: String = '%s=%s;'): String;
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


      Result := Result + Format(AFormatString, [RttiFields[Ndx].Name, RttiFields[Ndx].FieldType.Name]);

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

      if Ndx < Length(RttiFields) - 1 then
      begin
        Result := Result + Format(AFormatString, [RttiFields[Ndx].Name, RttiFields[Ndx].FieldType.Name]);
      end
      else if Ndx = Length(RttiFields) - 1 then
      begin
        Result := Result + Format(ACustomLastFormatString, [RttiFields[Ndx].Name, RttiFields[Ndx].FieldType.Name]);
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
var
  Ndx: Integer;
  TempList: TList<String>;
begin
  case AVar.TypeInfo.Kind of
    tkString, tkUString: Result := '''' + AVar.AsType<String> + '''';
    tkEnumeration: Result := '''' + AVar.ToString + '''';
    tkArray, tkDynArray: begin

      TempList := TList<String>.Create;

      for Ndx := 0 to AVar.GetArrayLength - 1 do
      begin
        if ( AVar.GetArrayElement(Ndx).ToString <> '' ) then
          TempList.Add(AVar.GetArrayElement(Ndx).ToString);
      end;

      Result := '''' + '[' + clrUtils.ArrToStr.TArrToStrUtils<TValue>.FormatArrToStr(
        function(Ndx: Integer): String
        begin
          Result := AVar.GetArrayElement(Ndx).ToString;
        end,
        TempList.Count,
        '%s,',
        '%s'
      ) + ']' + '''';


      TempList.Free;

    end
    else Result := AVar.ToString;
  end;
end;


end.
