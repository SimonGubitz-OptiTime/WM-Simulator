unit Utils.CSV;

interface

uses
    Utils.RTTI,
    System.Rtti,
    System.SysUtils,
    System.Generics.Collections;

function SerializeCSV(CSVArray: array of String): String;
function DeserializeCSV(CSVString: String): TArray<String>;

type TCSVUtils<T> = record
  class function SerializeCSV(CSVArray: array of String): String; static;
  class function DeserializeCSV(CSVString: String): TArray<T>; static;
end;


const delimiter: Char = ';';

implementation

function SerializeCSV(CSVArray: array of String): String;
var
  i: Integer;
begin

    Result := '';

    if Length(CSVArray) = 0 then
        raise Exception.Create('Utils.CSV.pas Error: Tried to call function SerializeCSV with empty Array');


    // Einer weniger, um nicht am ende ein alleiniges ';' stehen zu haben
    for i := Low(CSVArray) to High(CSVArray)-1 do
        Result := Result + CSVArray[i] + delimiter;

    Result := Result + CSVArray[i];

end;

function DeserializeCSV(CSVString: String): TArray<String>;
var
    I: Integer;
    TempString: String;
begin

    TempString := '';

    SetLength(Result, 0);

    for i := 1 to Length(CSVString) do
    begin

        if CSVString[i] = delimiter then
        begin
            SetLength(Result, Length(Result)+1);
            Result[High(Result)] := TempString;
            TempString := '';
        end
        else
            TempString := TempString + CSVString[i];

    end;
end;


class function TCSVUtils<T>.SerializeCSV(CSVArray: array of String): String;
begin
  raise Exception.Create('Utils.CSV.pas: Error: function TCSVUtils<T>.SerializeCSV not implemented');
end;

class function TCSVUtils<T>.DeserializeCSV(CSVString: String): TArray<T>;
var
    RttiContext: TRttiContext;
    RttiType: TRttiType;
    RttiFields: TArray<TRttiField>;
    TempString: String;
    TempStringArray: TArray<String>;
    TempValue: TValue;
    TempRes: T;
    i: Integer;
begin

    TempString := '';

    SetLength(TempStringArray, 0);

    for i := 1 to Length(CSVString) do
    begin

        if CSVString[i] = delimiter then
        begin
            SetLength(TempStringArray, Length(TempStringArray)+1);
            TempStringArray[High(TempStringArray)] := TempString;
            TempString := ''; // reset
        end
        else
            TempString := TempString + CSVString[i];

    end;

    try

        RttiContext := TRttiContext.Create;
        RttiType := RttiContext.GetType(TypeInfo(T));
        RttiFields := RttiType.GetFields;

        TempRes := Default(T);

        if Length(RttiFields) <> Length(TempStringArray) then
            raise Exception.Create('Utils.CSV.pas Error: Deserializing CSV with custom type, not enough information for type conversion.');

        for i := 0 to Length(RttiFields) -1 do
        begin
            // convert string to x
            TempValue := Utils.RTTI.TRttiUtils<T>.StringToT(RttiFields[i], TempStringArray[i]);

            RttiFields[i].SetValue(@TempRes, TempValue);
        end;

    finally
        RttiContext.Free;
    end;

end;

end.