unit Utils.FixedArrays;

interface

uses
    System.Generics;

//function LastFilledIndex<T>(): Integer;
function LastFilledIndex(): Integer;

implementation


// Gibt den letzten Index mit Füllung an, wenn alle leer sind, -1.
function LastFilledIndex(ArrayToSearch: array of String): Integer;
var
    i: Byte;
begin

    Result := -1;

    for i := Low(ArrayToSearch) to High(ArrayToSearch) do
    begin
        if ((ArrayToSearch[i] = '') and (i - 1 > Low(ArrayToSearch))) then
            Result := i - 1;
    end;

end;

end.
