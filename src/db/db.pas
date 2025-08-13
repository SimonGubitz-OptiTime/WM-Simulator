unit DB;

interface

uses
    System.Generics, System.SysUtils, System.IOUtils, System.Rtti;



function    GetProperty<T>(TableName: String): T;
procedure   SetProperty<T>(TableName: String; Property: String; PropertyValue: T);
function    GetStructuredTable<T: record>(TableName: String): T;
procedure   SetStructuredTable<T: record>(TableName: String);
function    GetUnstructuredTable(TableName: String): String;
procedure   SetUnstructuredTable(TableName: String);



implementation


function GetPropertyOfID<T>(TableName: String; RowID: Integer): T;
var
    CSVString: String;
begin

    CSVString := GetStructuredTable<>(TableName);



end;

procedure SetPropertyOfID<T>(TableName: String; RowID: Integer);
begin

    // .csv öffnen

end;


// z.B. TableName := 'Stadien'
// z.B. T := TStadion
function GetStructuredTable<T: record>(TableName: String): TArray<T>;
const
    AverageLines: Byte = 15;
    AverageBytesPerLine: Byte = 40;
var
    FS: TFileStream;
    SR: TStreamReader;
    FileName: String;
    FileSize: Int64;
    Lines: TStringList;
    RttiContext: TRttiContext;
    RttiType: TRttiType;
    RttiFields: TArray<TRttiField>;
begin

    FileName := Utils.DB.Naming.GetFullDBTablePath(TableName);
    FileSize := TFile.GetSize(FileName);

    try
        FS.Create(FileName);
        SR.Create(FS);

        headline := SR.ReadLine();
        TableColumns := Length(Utils.CSV.DeserializeCSV(headline));

        while not(SR.EndOfStream) do
        begin
            line := SR.ReadLine();

            for i := 0 to TableColumns do
            begin

                Row := Utils.CSV.DeserializeCSV(line);

                {
                    RttiContext := TRttiContext.Create;
                    RttiType := RttiContext.GetType(TypeInfo(T));
                    RttiFields := RttiType.GetFields;
                }


                // Utils.CSV.DeserializeCSV<T>();

            end;

        end;


    finally
        FS.Free;
        SR.Free;
    end;

    // Auf das nötige Schrumpfen
    SetLength(Result, );

end;

procedure SetStructuredTable<T: record>(TableName: String);
begin



end;


function GetUnstructuredTable(TableName: String): TArray<String>;
var
    FS: TFileStream;
    SR: TStreamReader;
begin

    FileName := Utils.DB.Naming.GetFullDBTablePath(TableName);

    try
        FS.Create(FileName);
        SR.Create(FS);

        Result := Utils.CSV.DeserializeCSV(SR.ReadToEnd());

    finally
        FS.Free;
        SR.Free;
    end;
end;

procedure SetUnstructuredTable(TableName: String; TableContent: String);
var
    FS: TFileStream;
    SW: TStreamWriter;
begin

    FileName := Utils.DB.Naming.GetFullDBTablePath(TableName);

    try
        FS.Create(FileName);
        SW.Create(FS);

        SR.Write(Utils.CSV.SerializeCSV(CSVString));

    finally
        FS.Free;
        SR.Free;
    end;
end;


end.