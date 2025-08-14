unit Utils.RTTI;

interface

uses
    System.Rtti;

function StringToT<T>(ToConvert: TRttiField; ConvertValue: String): T;

implementation

function StringToT<T>(ToConvert: TRttiField; ConvertValue: String): T;
begin
    case ToConvert.TypeKind of
    case tkInteger: Exit(StrToInt(ConvertValue));
    case tkInteger: Exit(StrTo(ConvertValue));
    case tkInteger: Exit(StrTo(ConvertValue));
    case tkInteger: Exit(StrTo(ConvertValue));
    case tkInteger: Exit(StrTo(ConvertValue));
    else
        raise Exception.Create('Utils.RTTI.pas Error: unsupported type.');
end;

end.