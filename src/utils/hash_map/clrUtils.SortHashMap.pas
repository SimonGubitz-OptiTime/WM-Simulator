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
  Ndx: Integer;
  KeysArray: TArray<Byte>;
  ValuesArray: TArray<TTeamStatistik>;
begin

  KeysArray := HashMap.Keys.ToArray;
  ValuesArray := HashMap.Values.ToArray;

  Result := TList<TPair<Byte, TTeamStatistik>>.Create;

  // Insertion sort
  for Ndx := 1 to HashMap.Count - 1 do
  begin

    var key := KeysArray[Ndx];
    var val := ValuesArray[Ndx];
    var j := Ndx - 1;

    while ( (j >= 0)
      and (val.Punkte < ValuesArray[j].Punkte) ) do
    begin
      ValuesArray[j + 1] := ValuesArray[j];
      KeysArray[j + 1] := KeysArray[j];
      Result.Add(TPair<Byte, TTeamStatistik>.Create(KeysArray[j + 1], ValuesArray[j]));
      j := j - 1;
    end;

    KeysArray[j + 1] := key;
    ValuesArray[j + 1] := val;
    Result.Add(TPair<Byte, TTeamStatistik>.Create(KeysArray[j + 1], ValuesArray[j + 1]));

  end;

end;

class function THashMapUtils.Sort<TKey, TValue>(HashMap: TDictionary<TKey, TValue>; ConditionFn: clrUtils.SortArray.TConditionFn<TValue>): TList<TPair<TKey, TValue>>;
var
  Ndx: Integer;
  KeysArray: TArray<TKey>;
  ValuesArray: TArray<TValue>;
begin

  KeysArray := HashMap.Keys.ToArray;
  ValuesArray := HashMap.Values.ToArray;

  Result := TList<TPair<TKey, TValue>>.Create;

  // Insertion sort
  for Ndx := 1 to HashMap.Count - 1 do
  begin

    var key := KeysArray[Ndx];
    var val := ValuesArray[Ndx];
    var j := Ndx - 1;

    while ( (j >= 0)
      and (ConditionFn(val, ValuesArray[j])) ) do
    begin
      ValuesArray[j + 1] := ValuesArray[j];
      KeysArray[j + 1] := KeysArray[j];
      Result.Add(TPair<TKey, TValue>.Create(KeysArray[j + 1], ValuesArray[j]));
      j := j - 1;
    end;

    KeysArray[j + 1] := key;
    ValuesArray[j + 1] := val;
    Result.Add(TPair<TKey, TValue>.Create(KeysArray[j + 1], ValuesArray[j + 1]));

  end;


end;

class function THashMapUtils.Sort<TKey, TValue>(HashMap: TDictionary<TKey, TValue>; ConditionFn: clrUtils.SortArray.TConditionFn<TValue>; AAsArray: Boolean): TArray<TPair<TKey, TValue>>;
var
  Ndx: Integer;
  KeysArray: TArray<TKey>;
  ValuesArray: TArray<TValue>;
begin
  if not AAsArray then
    raise Exception.Create('clrUtils.SortHashMap.pas Error: maybe you meant to call the overload with TList');

  KeysArray := HashMap.Keys.ToArray;
  ValuesArray := HashMap.Values.ToArray;

  SetLength(Result, HashMap.Count);

  // Insertion sort
  for Ndx := 1 to HashMap.Count - 1 do
  begin
    var key := KeysArray[Ndx];
    var val := ValuesArray[Ndx];
    var j := Ndx - 1;

    while ( (j >= 0)
      and (ConditionFn(val, ValuesArray[j])) ) do
    begin
      ValuesArray[j + 1] := ValuesArray[j];
      KeysArray[j + 1] := KeysArray[j];
      Result[j + 1] := TPair<TKey, TValue>.Create(KeysArray[j + 1], ValuesArray[j]);
      j := j - 1;
    end;

    KeysArray[j + 1] := key;
    ValuesArray[j + 1] := val;
    Result[j + 1] := TPair<TKey, TValue>.Create(KeysArray[j + 1], ValuesArray[j + 1]);
  end;
end;


end.
