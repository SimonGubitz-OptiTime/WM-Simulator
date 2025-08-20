unit Utils.CSV;

interface

uses
    Utils.RTTI,
    System.Rtti,
    System.SysUtils,
    System.Generics.Collections,
    Vcl.Dialogs;

function SerializeCSV(CSVArray: array of String): String;
function DeserializeCSV(CSVString: String): TArray<String>;

type TCSVUtils<T> = record
    class function SerializeCSV(CSVArray: TArray<T>): String; static;
    class function DeserializeCSV(CSVString: String): TArray<T>; static;

    class function SerializeRowCSV(Row: T): String; static;
    class function DeserializeRowCSV(CSVString: String): T; static;

    class function GetCSVHeaderAsArray(): TArray<String>; static;
    class function GetCSVHeaderAsString(): String; static;

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
    i: Integer;
begin

    Result := GetCSVHeaderAsString() + sLineBreak;

    for i := Low(CSVArray) to High(CSVArray) do
    begin
        if i > Low(CSVArray) then
            Result := Result + sLineBreak;
        
        Result := Result + SerializeRowCSV(CSVArray[i]);
    end;


end;

class function TCSVUtils<T>.DeserializeCSV(CSVString: String): TArray<T>;
var
    RttiContext: TRttiContext;
    RttiType: TRttiType;
    RttiFields: TArray<TRttiField>;
    TempRowArray: TArray<String>;
    TempRow: String;
    TempValue: TValue;
    i: Integer;
begin

    TempRow := '';
    SetLength(Result, 0);
    SetLength(TempRowArray, 0);

    if Copy(CSVString[High(CSVString)], High(CSVString)-1, High(CSVString)) <> sLineBreak then
      CSVString := CSVString + sLineBreak;

    // Bei jedem sLineBreak eine neue Zeile inizialisieren
    for i := 1 to Length(CSVString) do
    begin

        if ((Length(CSVString)-i >= 1) and (CSVString[i] = #13) and (CSVString[i+1] = #10)) then // #13#10 <- 2 Bytes on windows sLineBreak
        begin
            SetLength(TempRowArray, Length(TempRowArray)+1);
            TempRowArray[High(TempRowArray)] := TempRow;

            TempRow := '';
        end
        else
            TempRow := TempRow + CSVString[i];

    end;


    for i := 0 to Length(TempRowArray) -1 do
    begin
        SetLength(Result, Length(Result) + 1);
        Result[High(Result)] := DeserializeRowCSV(TempRowArray[i]);
    end;

end;

class function TCSVUtils<T>.SerializeRowCSV(Row: T): String;
var
    RttiContext: TRttiContext;
    RttiType: TRttiType;
    RttiFields: TArray<TRttiField>;
    i: Integer;
    debugName: String;
begin

    RttiContext := TRttiContext.Create;
    RttiType := RttiContext.GetType(TypeInfo(T));
    RttiFields := RttiType.GetFields;

    for i := 0 to Length(RttiFields)-1 do
    begin

        debugName := RttiFields[i].Name;

        if i > Low(RttiFields) then
            Result := Result + delimiter;

        Result := Result + Utils.RTTI.TRttiUtils<T>.TToStr(@Row, RttiFields[i]);

    end;

end;

class function TCSVUtils<T>.DeserializeRowCSV(CSVString: String): T;
var
    RttiContext: TRttiContext;
    RttiType: TRttiType;
    RttiFields: TArray<TRttiField>;
    TempFieldArray: TArray<String>;
    TempValue: TValue;
    TempField: String;
    TempRes: T;
    i, j: Integer;
begin
    // raise Exception.Create('Utils.CSV.pas Error: DeserializeRowFromCSV is not implemented yet.');


    // To read in the last value too
    if CSVString[High(CSVString)] <> delimiter then
      CSVString := CSVString + delimiter;

    // Den String mit "delimiter" in Chunks trennen
    for i := 1 to Length(CSVString) do
    begin

        if (CSVString[i] = delimiter) then
        begin
            SetLength(TempFieldArray, Length(TempFieldArray)+1);
            TempFieldArray[High(TempFieldArray)] := TempField;
            TempField := ''; // reset
        end
        else
            TempField := TempField + CSVString[i]; // Buchstaben hinzufügen

    end;


    // Für jedes Feld in TempFieldArray den Wert in das richtige Feld von TempRes schreiben
    try

        RttiContext := TRttiContext.Create;
        RttiType := RttiContext.GetType(TypeInfo(T));
        RttiFields := RttiType.GetFields;

        if Length(RttiFields) <> Length(TempFieldArray) then
            raise Exception.Create('Utils.CSV.pas Error: Deserializing CSV with custom type, not enough information for type conversion.');

        for j := 0 to Length(RttiFields)-1 do // columns / fields
        begin
            // convert string to x
            TempValue := Utils.RTTI.TRttiUtils<T>.StrToT(RttiFields[j], TempFieldArray[j]);
            RttiFields[j].SetValue(@TempRes, TempValue);
        end;

    finally
        RttiContext.Free;
    end;

    Result := TempRes;

end;


class function TCSVUtils<T>.GetCSVHeaderAsArray(): TArray<String>;
var
    RttiContext: TRttiContext;
    RttiType: TRttiType;
    RttiFields: TArray<TRttiField>;
    i: Integer;
begin
    RttiContext := TRttiContext.Create;
    RttiType := RttiContext.GetType(TypeInfo(T));
    RttiFields := RttiType.GetFields;

    SetLength(Result, Length(RttiFields));

    for i := 0 to Length(RttiFields) -1 do
    begin
        Result[i] := RttiFields[i].Name;
    end;

end;

class function TCSVUtils<T>.GetCSVHeaderAsString(): String;
var
    RttiContext: TRttiContext;
    RttiType: TRttiType;
    RttiFields: TArray<TRttiField>;
    i: Integer;
begin
    RttiContext := TRttiContext.Create;
    RttiType := RttiContext.GetType(TypeInfo(T));
    RttiFields := RttiType.GetFields;

    Result := '';

    for i := 0 to Length(RttiFields) -1 do
    begin
        if i > Low(RttiFields) then
            Result := Result + delimiter;

        Result := Result + RttiFields[i].Name;
    end;

end;

end.