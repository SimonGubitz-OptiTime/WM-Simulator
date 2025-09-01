unit clrUtils.CSV;

interface

uses
  clrUtils.RTTI,
  System.RTTI,
  System.SysUtils,
  System.Generics.Collections,
  Vcl.Dialogs;

function SerializeCSV(CSVArray: TList<String>): String;
function DeserializeCSV(CSVString: String): TList<String>;

type
  TCSVUtils<T: record > = record
    class function SerializeCSV(CSVArray: TList<T>): String; static;
    class function DeserializeCSV(CSVString: String): TList<T>; static;

    class function SerializeRowCSV(Row: T): String; static;
    class function ParseRowCSVToArray(Row: T): TList<String>; static;
    class function DeserializeRowCSV(CSVString: String): T; static;

    class function GetCSVHeaderAsArray(): TList<String>; static;
    class function GetCSVHeaderAsString(): String; static;

  end;

const
  delimiter: Char = ';';

implementation

function SerializeCSV(CSVArray: TList<String>): String;
var
  Ndx: Integer;
begin

  Result := '';

  if ( CSVArray.Count = 0 ) then
  begin
    raise Exception.Create('Utils.CSV.pas Error: Tried to call function SerializeCSV with empty Array');
  end;

  // Einer weniger, um nicht am ende ein alleiniges ';' stehen zu haben
  for Ndx := 0 to CSVArray.Count - 1 do
  begin
    if ( Ndx > 0 ) then
    begin
      Result := Result + delimiter;
    end;

    Result := Result + CSVArray[Ndx];
  end;

end;

function DeserializeCSV(CSVString: String): TList<String>;
var
  Ndx: Integer;
  TempString: String;
begin

  TempString := '';
  Result := TList<String>.Create;

  for Ndx := 1 to Length(CSVString) do
  begin

    if ( CSVString[Ndx] = delimiter ) then
    begin
      Result.Add(TempString);
      TempString := '';
    end
    else
      TempString := TempString + CSVString[Ndx];

  end;
end;

class function TCSVUtils<T>.SerializeCSV(CSVArray: TList<T>): String;
var
  Ndx: Integer;
begin
  Result := GetCSVHeaderAsString() + sLineBreak;
  for Ndx := 0 to CSVArray.Count - 1 do
  begin
    if ( Ndx > 0 ) then
    begin
      Result := Result + sLineBreak;
    end;

    Result := Result + SerializeRowCSV(CSVArray[Ndx]);
  end;
end;

class function TCSVUtils<T>.DeserializeCSV(CSVString: String): TList<T>;
var
  TempRowArray: TList<String>;
  TempRow: String;
  Ndx: Integer;
begin

  TempRow := '';
  Result := TList<T>.Create;
  TempRowArray := TList<String>.Create;

  try
    if ( Copy(CSVString[High(CSVString)], High(CSVString) - 1, High(CSVString)) <> sLineBreak ) then
    begin
      CSVString := CSVString + sLineBreak;
    end;

    // Bei jedem sLineBreak eine neue Zeile initialisieren
    for Ndx := 1 to Length(CSVString) do
    begin
      if ( (Length(CSVString) - Ndx >= 1) and ( CSVString[Ndx] = #13) and (CSVString[Ndx + 1] = #10) ) then // #13#10 <- 2 Bytes on windows sLineBreak
      begin
        TempRowArray.Add(TempRow);
        TempRow := '';
      end
      else
        TempRow := TempRow + CSVString[Ndx];
    end;

    for Ndx := 0 to TempRowArray.Count - 1 do
    begin
      Result.Add(DeserializeRowCSV(TempRowArray[Ndx]));
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
  Ndx: Integer;
begin

  RttiContext := TRttiContext.Create;

  try
    RttiFields := TObjectList<TRttiField>.Create(false);

    try
      RttiType := RttiContext.GetType(TypeInfo(T));
      RttiFields.AddRange(RttiType.GetFields);

      for Ndx := 0 to RttiFields.Count - 1 do
      begin
        if ( Ndx > 0 ) then
        begin
          Result := Result + delimiter;
        end;

        Result := Result + clrUtils.RTTI.TRttiUtils<T>.TToStr(@Row, RttiFields[Ndx]);

      end;
    finally
      RttiFields.Free;
    end;
  finally
    RttiContext.Free;
  end;

end;

class function TCSVUtils<T>.ParseRowCSVToArray(Row: T): TList<String>;
var
  RttiContext: TRttiContext;
  RttiType: TRttiType;
  RttiFields: TObjectList<TRttiField>;
  Ndx: Integer;
begin

  Result := TList<String>.Create;
  RttiContext := TRttiContext.Create;

  try
    RttiType := RttiContext.GetType(TypeInfo(T));
    RttiFields := TObjectList<TRttiField>.Create(false);
    try
      RttiFields.AddRange(RttiType.GetFields);

      for Ndx := 0 to RttiFields.Count - 1 do
      begin
        Result.Add(clrUtils.RTTI.TRttiUtils<T>.TToStr(@Row, RttiFields[Ndx]));
      end;
    finally
      RttiFields.Free;
    end;
  finally
    RttiContext.Free;
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
  Ndx, j: Integer;
begin
  TempFieldArray := TList<String>.Create;

  try

    // To read in the last value too
    if ( CSVString[High(CSVString)] <> delimiter ) then
    begin
      CSVString := CSVString + delimiter;
    end;

    // Den String mit "delimiter" in Chunks trennen
    for Ndx := 1 to Length(CSVString) do
    begin
      if ( CSVString[Ndx] = delimiter ) then
      begin
        TempFieldArray.Add(TempField);
        TempField := ''; // reset
      end
      else
        TempField := TempField + CSVString[Ndx]; // Buchstaben hinzufügen
    end;

    // Für jedes Feld in TempFieldArray den Wert in das richtige Feld von TempRes schreiben
    RttiContext := TRttiContext.Create;
    try

      RttiType := RttiContext.GetType(TypeInfo(T));
      RttiFields := TObjectList<TRttiField>.Create;

      try
        RttiFields.AddRange(RttiType.GetFields);

        if ( RttiFields.Count <> TempFieldArray.Count ) then
        begin
          raise Exception.Create('Utils.CSV.pas Error: Deserializing CSV with custom type, not enough information for type conversion.');
        end;

        for j := 0 to RttiFields.Count - 1 do // columns / fields
        begin
          // convert string to x
          TempValue := clrUtils.RTTI.TRttiUtils<T>.StrToT(RttiFields[j],
            TempFieldArray[j]);
          RttiFields[j].SetValue(@TempRes, TempValue);
        end;
      finally
        // RttiFields.Free;
      end;
    finally
      RttiContext.Free;
    end;
  finally
    TempFieldArray.Free;
  end;

  Result := TempRes;

end;

class function TCSVUtils<T>.GetCSVHeaderAsArray(): TList<String>;
var
  RttiContext: TRttiContext;
  RttiType: TRttiType;
  RttiFields: TObjectList<TRttiField>;
  Ndx: Integer;
begin

  Result := TList<String>.Create;

  RttiContext := TRttiContext.Create;

  try

    RttiType := RttiContext.GetType(TypeInfo(T));
    RttiFields := TObjectList<TRttiField>.Create;

    try
      RttiFields.AddRange(RttiType.GetFields);
      for Ndx := 0 to RttiFields.Count - 1 do
      begin
        Result.Add(RttiFields[Ndx].Name);
      end;
    finally
      // RttiFields.Free;
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
  Ndx: Integer;
begin
  RttiContext := TRttiContext.Create;

  try

    RttiType := RttiContext.GetType(TypeInfo(T));
    RttiFields := TObjectList<TRttiField>.Create;

    try
      RttiFields.AddRange(RttiType.GetFields);

      Result := '';
      for Ndx := 0 to RttiFields.Count - 1 do
      begin
        if ( Ndx > 0 ) then
        begin
          Result := Result + delimiter;
        end;

        Result := Result + RttiFields[Ndx].Name;
      end;
    finally
      // RttiFields.Free;
    end;
  finally
    RttiContext.Free;
  end;

end;

end.
