unit Utils.CSV;

interface

uses
    Utils.RTTI,
    System.Rtti,
    System.SysUtils,
    System.Generics.Collections,
    Vcl.Dialogs;

function SerializeCSV(CSVArray: TList<String>): String;
function DeserializeCSV(CSVString: String): TList<String>;

type TCSVUtils<T> = record
    class function SerializeCSV(CSVArray: TObjectList<T>): String; static;
    class function DeserializeCSV(CSVString: String): TObjectList<T>; static;

    class function SerializeRowCSV(Row: T): String; static;
    class function SerializeRowCSVToStringArray(Row: T): TList<String>; static;
    class function DeserializeRowCSV(CSVString: String): T; static;

    class function GetCSVHeaderAsArray(): TList<String>; static;
    class function GetCSVHeaderAsString(): String; static;

end;


const delimiter: Char = ';';

implementation

function SerializeCSV(CSVArray: TList<String>): String;
var
  i: Integer;
begin

    Result := '';

    if CSVArray.Count = 0 then
        raise Exception.Create('Utils.CSV.pas Error: Tried to call function SerializeCSV with empty Array');


    // Einer weniger, um nicht am ende ein alleiniges ';' stehen zu haben
    for i := 0 to CSVArray.Count - 1 do
    begin
        if i > 0 then
            Result := Result + delimiter;

        Result := Result + CSVArray[i];
    end;



end;

function DeserializeCSV(CSVString: String): TList<String>;
var
    I: Integer;
    TempString: String;
begin
    Result := TList<String>.Create;

    TempString := '';

    Result := TList<String>.Create;

    for i := 1 to Length(CSVString) do
    begin

        if CSVString[i] = delimiter then
        begin
            Result.Add(TempString);
            TempString := '';
        end
        else
            TempString := TempString + CSVString[i];

    end;
end;


class function TCSVUtils<T>.SerializeCSV(CSVArray: TObjectList<T>): String;
var
    i: Integer;
begin

    Result := GetCSVHeaderAsString() + sLineBreak;

    for i := 0 to CSVArray.Count - 1 do
    begin
        if i > 0 then
            Result := Result + sLineBreak;

        Result := Result + SerializeRowCSV(CSVArray[i]);
    end;


end;

class function TCSVUtils<T>.DeserializeCSV(CSVString: String): TObjectList<T>;
var
    TempRowArray: TObjectList<String>;
    TempRow: String;
    i: Integer;
begin

    TempRow := '';
    Result := TObjectList<T>.Create;
    TempRowArray := TObjectList<String>.Create;

    try
        if Copy(CSVString[High(CSVString)], High(CSVString)-1, High(CSVString)) <> sLineBreak then
        CSVString := CSVString + sLineBreak;

        // Bei jedem sLineBreak eine neue Zeile initialisieren
        for i := 1 to Length(CSVString) do
        begin
            if ((Length(CSVString)-i >= 1) and (CSVString[i] = #13) and (CSVString[i+1] = #10)) then // #13#10 <- 2 Bytes on windows sLineBreak
            begin
                TempRowArray.Add(TempRow);
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
    finally
        TempRowArray.Free;
    end;
end;

class function TCSVUtils<T>.SerializeRowCSV(Row: T): String;
var
    RttiContext: TRttiContext;
    RttiType: TRttiType;
    RttiFields: TObjectList<TRttiField>;
    i: Integer;
    debugName: String;
begin

    RttiFields := TObjectList<TRttiField>.Create

    try
        RttiContext := TRttiContext.Create;
        RttiType := RttiContext.GetType(TypeInfo(T));
        RttiFields.AddRange(RttiType.GetFields);

        try
            for i := 0 to RttiFields.Count - 1 do
            begin
                if i > 0 then
                    Result := Result + delimiter;

                Result := Result + Utils.RTTI.TRttiUtils<T>.TToStr(@Row, RttiFields[i]);

            end;
        finally
            RttiContext.Free;
        end;
    finally
        RttiFields.Free;
    end;

end;

class function TCSVUtils<T>.DeserializeRowCSV(CSVString: String): T;
var
    RttiContext: TRttiContext;
    RttiType: TRttiType;
    RttiFields: TObjectList<TRttiField>;
    TempFieldArray: TList<String>;
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
            TempFieldArray.Add(TempField);
            TempField := ''; // reset
        end
        else
            TempField := TempField + CSVString[i]; // Buchstaben hinzufügen
    end;


    // Für jedes Feld in TempFieldArray den Wert in das richtige Feld von TempRes schreiben
    RttiContext := TRttiContext.Create;
    try

        RttiType := RttiContext.GetType(TypeInfo(T));

        RttiFields := TObjectList<TRttiField>.Create;

        try
            RttiFields.AddRange(RttiType.GetFields);

            if RttiFields.Count <> TempFieldArray.Count then
                raise Exception.Create('Utils.CSV.pas Error: Deserializing CSV with custom type, not enough information for type conversion.');

            for j := 0 to RttiFields.Count - 1 do // columns / fields
            begin
                // convert string to x
                TempValue := Utils.RTTI.TRttiUtils<T>.StrToT(RttiFields[j], TempFieldArray[j]);
                RttiFields[j].SetValue(@TempRes, TempValue);
            end;
        finally
            RttiFields.Free;
        end;
    finally
        RttiContext.Free;
    end;

    Result := TempRes;

end;


class function TCSVUtils<T>.GetCSVHeaderAsArray(): TList<String>;
var
    RttiContext: TRttiContext;
    RttiType: TRttiType;
    RttiFields: TObjectList<TRttiField>;
    i: Integer;
begin
    RttiContext := TRttiContext.Create;
    RttiType := RttiContext.GetType(TypeInfo(T));
    RttiFields := RttiType.GetFields;

    try

        SetLength(Result, Length(RttiFields));

        for i := 0 to Length(RttiFields) -1 do
        begin
            Result[i] := RttiFields[i].Name;
        end;
    finally
        RttiContext.Free;
    end;

end;

class function TCSVUtils<T>.GetCSVHeaderAsString(): String;
var
    RttiContext: TRttiContext;
    RttiType: TRttiType;
    RttiFields: TObjectList<TRttiField>;
    i: Integer;
begin
    RttiContext := TRttiContext.Create;
    RttiType := RttiContext.GetType(TypeInfo(T));

    RttiFields := TObjectList<TRttiField>.Create;

    try

        RttiFields := RttiType.GetFields;

        try
            Result := '';

            for i := 0 to RttiFields.Count - 1 do
            begin
                if i > Low(RttiFields) then
                    Result := Result + delimiter;

                Result := Result + RttiFields[i].Name;
            end;
        finally
            RttiFields.Free;
        end;
    finally
        RttiContext.Free;
    end;

end;

end.