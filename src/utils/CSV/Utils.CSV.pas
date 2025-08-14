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
  class function SerializeCSV(CSVArray: TArray<T>): String; static;
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
    begin
        if i > Low(CSVArray) then
            Result := Result + delimiter;

        Result := Result + CSVArray[i];
    end;



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


class function TCSVUtils<T>.SerializeCSV(CSVArray: TArray<T>): String;
var
    RttiContext: TRttiContext;
    RttiType: TRttiType;
    RttiFields: TArray<TRttiField>;

    i, j: Integer;
begin
    // raise Exception.Create('Utils.CSV.pas: Error: function TCSVUtils<T>.SerializeCSV not implemented');

    RttiContext := TRttiContext.Create;
    RttiType := RttiContext.GetType(TypeInfo(T));
    RttiFields := RttiType.GetFields;

    for i := 0 to Length(RttiFields) -1 do
    begin
        if i > Low(RttiFields) then
            Result := Result + delimiter;

        Result := Result + RttiFields[i].Name;
    end;
    
    Result := Result + sLineBreak;


    for i := Low(CSVArray) to High(CSVArray) do
    begin
        if i > Low(CSVArray) then
            Result := Result + delimiter;

//        RttiType := RttiContext.GetType();

        for j := 0 to Length(RttiFields)-1 do
        begin
            if j > Low(RttiFields) then
                Result := Result + delimiter;

            Result := Result + RttiFields[j].GetValue(@CSVArray[i]).ToString

        end;

        Result := Result + sLineBreak;
    end;


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
            TempValue := Utils.RTTI.TRttiUtils<T>.StrToT(RttiFields[i], TempStringArray[i]);

            RttiFields[i].SetValue(@TempRes, TempValue);
        end;

    finally
        RttiContext.Free;
    end;

end;

end.