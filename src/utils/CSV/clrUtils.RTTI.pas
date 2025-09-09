unit clrUtils.RTTI;

interface

uses
  System.Generics.Collections,
  System.RTTI,
  System.SysUtils,
  TypInfo,
  Vcl.Dialogs;

type
  // record, da es auf dem Stack lebt und keinen State braucht
  TRttiUtils<T: record> = record
  private const
    ArrayDelimiter: Char = ',';

  public
    class function StrToT(ToConvert: TRttiField; ConvertValue: String): TValue; static;
    class function TToStr(TempRes: Pointer; ConvertField: TRttiField): String; static;

    class function NamesAsArray(AsArray: Boolean = true): TList<String>; static;
    class function NamesAsString(): String; static;

    class function ValuesAsArray(Values: T; AsArray: Boolean = true): TList<String>; static;
    class function ValuesAsString(Values: T): String; static;

    class function VariablesAsArray(Values: T): TList<TValue>; static;
  end;

const
  DEFAULT_PRE_ALLOC = 11;
  // da es sich meistens um Spieler Arrays handelt, die 11 Spieler haben -> aus Effizienzgründen

implementation

class function TRttiUtils<T>.StrToT(ToConvert: TRttiField; ConvertValue: String): TValue;
var
  EnumType: TRttiEnumerationType;
  Ndx: Integer;
  Digits: String;
  StrArray: TArray<TValue>;
  StrArrayIndex: Integer;
  ArrayType: TRttiDynamicArrayType;
begin

  case ToConvert.FieldType.TypeKind of
    tkInteger:
      Result := TValue.From<Integer>(StrToInt(ConvertValue));
    tkInt64:
      Result := TValue.From<Int64>(StrToInt64(ConvertValue));
    tkString, tkLString, tkWString, tkUString:
      Result := TValue.From<String>(ConvertValue);
    tkChar:
      Result := TValue.From<Char>(ConvertValue[1]);
    tkFloat:
      Result := TValue.From<Double>(StrToFloatDef(ConvertValue, 0.0));
    tkEnumeration:
      begin
        EnumType := TRttiEnumerationType(ToConvert.FieldType);
        Result := TValue.FromOrdinal(EnumType.Handle,
          GetEnumValue(EnumType.Handle, ConvertValue));
      end;
    // Muss Array bleiben, und darf nicht zu einem TObjectList<TValue> werden
    tkArray, tkDynArray:
      begin
        // Pre-allocate
        SetLength(StrArray, DEFAULT_PRE_ALLOC);
        // Für das Spieler Array, welches am meisten genutzt werden wird
        StrArrayIndex := 0;

        // input: [ d, d, d, d, d, d ]
        if ( (ConvertValue[Low(ConvertValue)] <> '[') or
          (ConvertValue[High(ConvertValue)] <> ']') ) then
        begin
          raise Exception.Create('Utils.RTTI.pas Error: Invalid Array Structure: ' + ConvertValue + '.');
        end;

        ConvertValue := Copy(ConvertValue, 2, Length(ConvertValue) - 2);
        ConvertValue := ConvertValue + ArrayDelimiter;

        for Ndx := Low(ConvertValue) to High(ConvertValue) do
        begin

          if ( ConvertValue[Ndx] = ArrayDelimiter ) then
          begin
            // wenn es doch mehr als DEFAULT_PRE_ALLOC gibt, aufstocken
            if ( StrArrayIndex = Length(StrArray) - 1 ) then
            begin
              SetLength(StrArray, Length(StrArray) + 1);
            end;

            StrArray[StrArrayIndex] := TValue.From<String>(Trim(Digits));
            Inc(StrArrayIndex);
            Digits := '';
          end
          else
          begin
            Digits := Digits + ConvertValue[Ndx];
          end;
        end;

        // wieder einschränken
        if ( Length(StrArray) - 1 <> StrArrayIndex ) then
        begin
          SetLength(StrArray, StrArrayIndex + 1);
        end;

        ArrayType := TRttiDynamicArrayType(ToConvert.FieldType);
        Result := TValue.FromArray(ArrayType.Handle, StrArray);
      end;
  else
    raise Exception.Create('Utils.RTTI.pas Error: unsupported type. Type: ' +
      ToConvert.FieldType.Name);
  end;
end;

class function TRttiUtils<T>.TToStr(TempRes: Pointer; ConvertField: TRttiField): String;
var
  tempField: TValue;
  Ndx: Integer;
begin

  tempField := ConvertField.GetValue(TempRes);

  if ( tempField.IsArray ) then
  begin
    Result := '[';
    for Ndx := 0 to tempField.GetArrayLength() - 1 do
    begin
      if ( Ndx > 0 ) then
      begin
        Result := Result + ArrayDelimiter;
      end;

      Result := Result + tempField.GetArrayElement(Ndx).ToString();
    end;
    Result := Result + ']';

    ShowMessage(Result);
  end
  else
  begin
    Result := tempField.ToString;
  end;
end;

class function TRttiUtils<T>.NamesAsArray(AsArray: Boolean = true): TList<String>;
var
  RttiContext: TRttiContext;
  RttiType: TRttiType;
  RttiFields: TObjectList<TRttiField>;
  Ndx: Integer;
begin

  Result := TList<String>.Create;

  RttiFields := TObjectList<TRttiField>.Create(false);
  try

    RttiType := RttiContext.GetType(TypeInfo(T));
    RttiContext := TRttiContext.Create;

    try
      RttiFields.AddRange(RttiType.GetFields);
      for Ndx := 0 to RttiFields.Count - 1 do
      begin
        Result.Add(RttiFields[Ndx].Name);
      end;
    finally
      RttiContext.Free;
    end;
  finally
    RttiFields.Free;
  end;

end;

class function TRttiUtils<T>.NamesAsString(): String;
var
  RttiContext: TRttiContext;
  RttiType: TRttiType;
  RttiFields: TObjectList<TRttiField>;
  Ndx: Integer;
begin
  RttiContext := TRttiContext.Create;

  try

    RttiType := RttiContext.GetType(TypeInfo(T));
    RttiFields := TObjectList<TRttiField>.Create;

    try
      RttiFields.AddRange(RttiType.GetFields);

      Result := '';
      for Ndx := 0 to RttiFields.Count - 1 do
      begin
        if ( Ndx > 0 ) then
        begin
          Result := Result + ArrayDelimiter;
        end;

        Result := Result + RttiFields[Ndx].Name;
      end;
    finally
      // RttiFields.Free;
    end;
  finally
    RttiContext.Free;
  end;

end;

class function TRttiUtils<T>.ValuesAsString(Values: T): String;
var
  RttiContext: TRttiContext;
  RttiType: TRttiType;
  RttiFields: TObjectList<TRttiField>;
  Ndx: Integer;
  Row: T;
begin
  RttiContext := TRttiContext.Create;

  try
    RttiFields := TObjectList<TRttiField>.Create(false);

    try
      RttiType := RttiContext.GetType(TypeInfo(T));
      RttiFields.AddRange(RttiType.GetFields);

      for Ndx := 0 to RttiFields.Count - 1 do
      begin
        if ( Ndx > 0 ) then
        begin
          Result := Result + ArrayDelimiter;
        end;

        Result := Result + TToStr(@Row, RttiFields[Ndx]);

      end;
    finally
      RttiFields.Free;
    end;
  finally
    RttiContext.Free;
  end;
end;

class function TRttiUtils<T>.ValuesAsArray(Values: T; AsArray: Boolean = true): TList<String>;
var
  RttiContext: TRttiContext;
  RttiType: TRttiType;
  RttiFields: TObjectList<TRttiField>;
  Ndx: Integer;
begin

  Result := TList<String>.Create;

  RttiContext := TRttiContext.Create;
  try
    RttiFields := TObjectList<TRttiField>.Create(false);

    try
      RttiType := RttiContext.GetType(TypeInfo(T));
      RttiFields.AddRange(RttiType.GetFields);

      for Ndx := 0 to RttiFields.Count - 1 do
      begin
        Result.Add(TToStr(@Values, RttiFields[Ndx]));
      end;
    finally
      RttiFields.Free;
    end;
  finally
    RttiContext.Free;
  end;
end;


class function TRttiUtils<T>.VariablesAsArray(Values: T): TList<TValue>;
var
  RttiContext: TRttiContext;
  RttiType: TRttiType;
  RttiFields: TArray<TRttiField>;
  Ndx: Integer;
begin

  Result := TList<TValue>.Create;

  RttiContext := TRttiContext.Create;
  try

    RttiType := RttiContext.GetType(TypeInfo(T));
    RttiFields := RttiType.GetFields;

    for Ndx := 0 to Length(RttiFields) - 1 do
    begin
      Result.Add(RttiFields[Ndx].GetValue(@Values));
      ShowMessage(RttiFields[Ndx].FieldType.Name); // string, string, cardinal
      ShowMessage(Result[Ndx].ToString);
    end;
    
  finally
    RttiContext.Free;
  end;
end;


end.
