unit Utils.RTTI;

interface

uses
    SysUtils, System.Rtti;

function StringToT<T>(ToConvert: TRttiField; ConvertValue: String): T;

implementation

function StringToT<T>(ToConvert: TRttiField; ConvertValue: String): T;
begin
    case ToConvert.TypeKind of
    case of tkInteger: Exit(StrToInt(ConvertValue));
    case of tkInteger: Exit(StrTo(ConvertValue));
    case of tkInteger: Exit(StrTo(ConvertValue));
    case of tkInteger: Exit(StrTo(ConvertValue));
    case of tkInteger: Exit(StrTo(ConvertValue));
    else
        raise Exception.Create('Utils.RTTI.pas Error: unsupported type.');
end;

end.