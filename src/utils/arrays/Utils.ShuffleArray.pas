unit Utils.FixedArrays;

interface

uses
    System.Generics.Defaults;


type TFixedArrayUtils<T> = record
  class function LastFilledIndex(ArrayToSearch: array of T): Integer; static;
end;

implementation


// Gibt den letzten Index mit Füllung an, wenn alle leer sind, -1.
class function TFixedArrayUtils<T>.LastFilledIndex(ArrayToSearch: array of T): Integer;
var
    i: Byte;
begin

    Result := -1;

    for i := High(ArrayToSearch) downto Low(ArrayToSearch) do
    begin
        if TEqualityComparer<T>.Default.Equals(ArrayToSearch[i], Default(T)) then
            Result := i - 1;
    end;

end;

end.
