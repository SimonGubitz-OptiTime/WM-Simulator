unit Utils.FixedArrays;

interface

uses
    System.Generics.Defaults;

function LastFilledIndex<T>(ArrayToSearch: array of T): Integer;

implementation


// Gibt den letzten Index mit Füllung an, wenn alle leer sind, -1.
function LastFilledIndex<T>(ArrayToSearch: array of T): Integer;
var
    i: Byte;
begin

    Result := -1;

    for i := Low(ArrayToSearch) to High(ArrayToSearch) do
    begin
        if TEqualityComparer<T>.Default.Equals(ArrayToSearch[i], Default(T)) then
            Result := i - 1;
    end;

end;

end.
