unit clrUtils.SQL;

interface

uses
  {$IFDEF DEBUG}
  Vcl.Dialogs,
  {$ENDIF}

  System.RTTI,
  System.SysUtils,
  System.TypInfo,
  clrUtils.RTTI;

type
  TSQLUtils = class
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

class function TSQLUtils.FormatSQLCondition<T>(ARow: T; AFormatString: String = '%s=%s'): String;
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
      {$IFDEF DEBUG}
        ShowMessage('array !!!');
      {$ENDIF}
      Result := clrUtils.ArrToStr.TArrToStrUtils<TValue>.FormatArrToStr(
        function(Value: TValue; Ndx: Integer): String
        begin
          Result := Value.GetArrayElement(Ndx).ToString;
        end,
        AVar,
        '[%s]',
        ','
      );
    end
    else Result := AVar.ToString;
  end;
end;


end.
