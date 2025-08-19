unit Utils.RTTI;

interface

uses
    SysUtils, System.Rtti, System.Generics.Collections;

type TRttiUtils<T> = record
  class function StrToT(ToConvert: TRttiField; ConvertValue: String): TValue; static;
  class function TToStr(ConvertValue: TRttiField): String; static;
end;

implementation

class function TRttiUtils<T>.StrToT(ToConvert: TRttiField; ConvertValue: String): TValue;
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
        tkArray:
        begin
            // Recursive conversion for arrays
        end;
        else
            raise Exception.Create('Utils.RTTI.pas Error: unsupported type.');
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
      Result := ConvertValue.GetValue(@TValue.From<TRttiField>(ConvertValue)).ToString();
    end;
end;

end.