unit clrUtils.SQL;

interface

uses
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
      class function FormatSQLCondition<T: record>(ARow: T; AFormatString: String = '%s=%s'): String;
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
  TempRes: String;
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


      if ( (RttiType.TypeKind = tkString) or (RttiType.TypeKind = tkUString) ) then
      begin
        Result := Result + Format(AFormatString, [RttiFields[Ndx].Name, '''' + clrUtils.RTTI.TRttiUtils<T>.TToStr(@ARow, RttiFields[Ndx]) + '''']);
      end
      else
      begin
        Result := Result + Format(AFormatString, [RttiFields[Ndx].Name, clrUtils.RTTI.TRttiUtils<T>.TToStr(@ARow, RttiFields[Ndx])]);
      end





    end;
  finally
    RttiContext.Free;
  end;

  {
  case AType.TypeInfo.Kind of
    tkString, tkUString: Result := AColumnName + '=' + '''' + TValue.GetValue(AType).ToString + '''';
    else      Result := AColumnName + '=' + TValue.From(AType).ToString;
  end;
  //}

end;

class function TSQLUtils.FormatVarToSQL<T>(AVar: T): String;
var
  MyVar: TValue;
begin

  MyVar := TValue.From<T>(AVar);

  if ( (MyVar.TypeInfo.Kind = tkString)
    or (MyVar.TypeInfo.Kind = tkUString) ) then
  begin
    Result := '''' + MyVar.AsType<String> + '''';
  end
  else
  begin
    Result := MyVar.AsType<String>;
  end;
end;

class function TSQLUtils.FormatVarToSQL(AVar: TValue): String;
begin


  case AVar.TypeInfo.Kind of
    tkString, tkUString: Result := '''' + AVar.AsType<String> + '''';
    tkInteger: Result := 'Integer';
    else Result := AVar.AsType<String>;
  end;


end;


end.
