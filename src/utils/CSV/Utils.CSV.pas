unit Utils.CSV;

interface

uses
    Utils.RTTI,
    System.Generics.Collections;

function SerializeCSV(Object: array of String): String;
function DeserializeCSV(Object: String): TArray<String>;

// function SerializeCSV<T>(Object: array of String): T;
// function DeserializeCSV<T>(Object: String): TArray<T>;


const delimiter: Char = ';';

implementation

function SerializeCSV(CSVArray: array of String): String;
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
    ArrayCounter, I: Integer;
    TempString: String;
begin

    ArrayCounter := 0;
    TempString := '';

    SetLength(Result, 0);

    for i := 1 to Length(CSVString) do
    begin

        if CSVString[i] = delimiter then
        begin
            Inc(ArrayCounter);
            SetLength(Result, Length(Result)+1);
            Result[High(Result)] := TempString;
            TempString := '';
        end
        else
            TempString := TempString + CSVString[i];

    end;
end;


function DeserializeCSV<T>(CSVString: String): TArray<T>;
var
    RttiContext: TRttiContext;
    RttiType: TRttiType;
    RttiFields: TArray<TRttiField>;
    ArrayCounter, I: Integer;
    TempString: String;
    TempStringArray: TArray<String>;
    TempValue: TValue;
    TempRes: T;
begin

    ArrayCounter := 0;
    TempString := '';

    SetLength(TempStringArray, 0);

    for i := 1 to Length(CSVString) do
    begin

        if CSVString[i] = delimiter then
        begin
            Inc(ArrayCounter);
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
            TempValue := TValue.From<String>(TempStringArray[i]);

            RttiFields[i].SetValue(@TempRes, TempValue);
        end;

    finally
        RttiContext.Free;
    end;

end;

end.