unit clrUtils.SortArray;

interface

uses
  System.Generics.Collections;


procedure Sort(var ArrayToSort: TList<Integer>);

// checks if Left is > 0, 0, < 0 Right
type TConditionFn<T> = reference to function(Left: T; Right: T): Boolean;

type TSortArrayUtils<T> = class
  public
    class procedure Sort(ArrayToSort: TList<T>; ConditionFn: TConditionFn<T>);
end;

implementation

class procedure TSortArrayUtils<T>.Sort(ArrayToSort: TList<T>; ConditionFn: TConditionFn<T>);
var
  Ndx: Integer;
begin
  for Ndx := 1 to ArrayToSort.Count -1  do
  begin
    var key := ArrayToSort[Ndx];
    var j := Ndx - 1;

    while ( (j >= 0)
      and (ConditionFn(ArrayToSort[j], key))) do
    begin
      ArrayToSort[j + 1] := ArrayToSort[j];
      j := j - 1;
    end;

    ArrayToSort[j + 1] := key;
  end;
end;

procedure Sort(var ArrayToSort: TList<Integer>);
var
  Ndx: Integer;
begin
  for Ndx := 1 to ArrayToSort.Count -1  do
  begin
    var key := ArrayToSort[Ndx];
    var j := Ndx - 1;

    while ( (j >= 0)
      and (key < ArrayToSort[j]) ) do
    begin
      ArrayToSort[j + 1] := ArrayToSort[j];
      j := j - 1;
    end;

    ArrayToSort[j + 1] := key;
  end;
end;

end.
