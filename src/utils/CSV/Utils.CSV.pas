unit Utils.CSV;

interface

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


end.