unit Utils.FixedArrays;

interface

uses
    System.Generics.Collections, System.Generics.Defaults;


type TFixedArrayUtils<T> = record
  class function LastFilledIndex(ArrayToSearch: TArray<T>): Integer; static; overload;
  class function LastFilledIndex(ArrayToSearch: TObjectList<T>): Integer; static; overload;
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

class function TFixedArrayUtils<T>.LastFilledIndex(ArrayToSearch: TObjectList<T>): Integer;
var
    i: Byte;
begin
    Result := -1;
    for i := ArrayToSearch.Count - 1 downto 0 do
    begin
        if TEqualityComparer<T>.Default.Equals(ArrayToSearch[i], Default(T)) then
            Result := i - 1;
    end;
end;


end.
