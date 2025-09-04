unit clrUtils.SortHashMap;

interface

uses
  System.Generics.Collections,
  System.SysUtils,
  clrUtils.SortArray,
  damTypes;


function Sort(var HashMap: TDictionary<Byte, Integer>): TList<TPair<Byte, Integer>>; overload;


type THashMapUtils = class


  // class function Sort<TValue>(HashMap: TDictionary<Byte, TTeamStatistik>; ConditionFn: clrUtils.SortArray.TConditionFn<TValue>); overload;
  class function Sort(HashMap: TDictionary<Byte, TTeamStatistik>): TList<TPair<Byte, TTeamStatistik>>; overload;

  // class function Sort<TKey, TValue>(HashMap: TDictionary<TKey, TValue>): TList<TPair<TKey, TValue>>; overload;
  class function Sort<TKey, TValue>(HashMap: TDictionary<TKey, TValue>; ConditionFn: clrUtils.SortArray.TConditionFn<TValue>): TList<TPair<TKey, TValue>>; overload;
  class function Sort<TKey, TValue>(HashMap: TDictionary<TKey, TValue>; ConditionFn: clrUtils.SortArray.TConditionFn<TValue>; AAsArray: Boolean): TArray<TPair<TKey, TValue>>; overload;


end;

implementation

function Sort(var HashMap: TDictionary<Byte, Integer>): TList<TPair<Byte, Integer>>;
begin
  Result := THashMapUtils.Sort<Byte, Integer>(
    HashMap,
    function(Right: Integer; Left: Integer): Boolean
    begin
      Result := Left < Right;
    end
  );
end;

class function THashMapUtils.Sort(HashMap: TDictionary<Byte, TTeamStatistik>): TList<TPair<Byte, TTeamStatistik>>;
var
  key: TPair<Byte, TTeamStatistik>;
  Ndx, j: Integer;
  HashMapArray: TArray<TPair<Byte, TTeamStatistik>>;
begin
  HashMapArray := HashMap.ToArray;

  // Insertion sort by Punkte
  for Ndx := 1 to High(HashMapArray) do
  begin
    key := HashMapArray[Ndx];
    j := Ndx - 1;
    while ( (j >= 0)
      and (key.Value.Punkte < HashMapArray[j].Value.Punkte) ) do
    begin
      HashMapArray[j + 1] := HashMapArray[j];
      j := j - 1;
    end;
    HashMapArray[j + 1] := key;
  end;

  Result := TList<TPair<Byte, TTeamStatistik>>.Create;
  for var Pair in HashMapArray do
    Result.Add(Pair);
end;

class function THashMapUtils.Sort<TKey, TValue>(HashMap: TDictionary<TKey, TValue>; ConditionFn: clrUtils.SortArray.TConditionFn<TValue>): TList<TPair<TKey, TValue>>;
var
  key: TPair<TKey, TValue>;
  Ndx, j: Integer;
  HashMapArray: TArray<TPair<TKey, TValue>>;
begin
  HashMapArray := HashMap.ToArray;

  // Insertion sort
  for Ndx := 1 to High(HashMapArray) do
  begin
    key := HashMapArray[Ndx];
    j := Ndx - 1;
    while (j >= 0) and ConditionFn(key.Value, HashMapArray[j].Value) do
    begin
      HashMapArray[j + 1] := HashMapArray[j];
      j := j -1;
    end;
    HashMapArray[j + 1] := key;
  end;

  Result := TList<TPair<TKey, TValue>>.Create;
  for var Pair in HashMapArray do
    Result.Add(Pair);
end;


class function THashMapUtils.Sort<TKey, TValue>(HashMap: TDictionary<TKey, TValue>; ConditionFn: clrUtils.SortArray.TConditionFn<TValue>; AAsArray: Boolean): TArray<TPair<TKey, TValue>>;
var
  key: TPair<TKey, TValue>;
  Ndx, j: Integer;
  HashMapArray: TArray<TPair<TKey, TValue>>;
begin
  if not AAsArray then
    raise Exception.Create('clrUtils.SortHashMap.pas Error: maybe you meant to call the overload with TList');

  HashMapArray := HashMap.ToArray;

  // Insertion sort
  for Ndx := 1 to High(HashMapArray) do
  begin
    key := HashMapArray[Ndx];
    j := Ndx - 1;
    while ( (j >= 0)
      and ConditionFn(key.Value, HashMapArray[j].Value)) do
    begin
      HashMapArray[j + 1] := HashMapArray[j];
      j := j -1;
    end;
    HashMapArray[j + 1] := key;
  end;

  Result := HashMapArray;
end;



end.
