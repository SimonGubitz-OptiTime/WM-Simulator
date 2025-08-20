unit Utils.RTTI;

interface

uses
    SysUtils, System.Rtti, System.Generics.Collections,
    TypInfo,
    Vcl.Dialogs;

type TRttiUtils<T> = record
  class function StrToT(ToConvert: TRttiField; ConvertValue: String): TValue; static;
  class function TToStr(ConvertValue: TRttiField): String; static;

private
  const ArrayDelimiter: Char = ',';
end;

implementation

class function TRttiUtils<T>.StrToT(ToConvert: TRttiField; ConvertValue: String): TValue;
var
  EnumType: TRttiEnumerationType;
  i: Integer;
  digits: String;
  StrArray: array of TValue;
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
            Result := TValue.FromOrdinal(EnumType.Handle, GetEnumValue(EnumType.Handle, ConvertValue));
        end;
        tkArray, tkDynArray:
        begin
            // Pre-allocate
            SetLength(StrArray, 11); // Für das Spieler Array, welches am meisten genutzt werden wird
            StrArrayIndex := 0;

            // input: [ d, d, d, d, d, d ]
            if ((ConvertValue[Low(ConvertValue)] <> '[') or (ConvertValue[High(ConvertValue)] <> ']')) then
              raise Exception.Create('Utils.RTTI.pas Error: Invalid Array Structure');

            ConvertValue := Copy(ConvertValue, 2, Length(ConvertValue)-2);
            ConvertValue := ConvertValue + ArrayDelimiter;

            for I := Low(ConvertValue) to High(ConvertValue) do
            begin

                if ConvertValue[i] = ArrayDelimiter then
                begin
                    if StrArrayIndex = Length(StrArray)-1 then
                        SetLength(StrArray, Length(StrArray)+1);

                    StrArray[StrArrayIndex] := TValue.From<string>(Trim(digits));
                    Inc(StrArrayIndex);
                    digits := '';
                end
                else
                begin
                    digits := digits + ConvertValue[i];
                end;
            end;

            // wieder einschränken
            if Length(StrArray)-1 <> StrArrayIndex then
              SetLength(StrArray, StrArrayIndex+1);

            ArrayType := TRttiDynamicArrayType(ToConvert.FieldType);
            Result := TValue.FromArray(ArrayType.Handle, StrArray);
        end;
        else
            raise Exception.Create('Utils.RTTI.pas Error: unsupported type. Type: ' + ToConvert.FieldType.Name);
    end;
end;

class function TRttiUtils<T>.TToStr(ConvertValue: TRttiField): String;
var
  tempType: TValue;
  i: Integer;
begin

    tempType := TValue.From<TRttiField>(ConvertValue);

    if (tempType.IsArray) then
    begin
        for i := 0 to tempType.GetArrayLength()-1 do
        begin
            Result := Result + tempType.GetArrayElement(i).ToString() + ', '
        end;
    end
    else
    begin
//      Result := ConvertValue.GetValue(@TValue.From<TRttiField>(ConvertValue)).ToString();
    end;
end;

end.