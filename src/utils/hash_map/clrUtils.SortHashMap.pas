unit clrUtils.SortHashMap;

interface

uses
  System.Generics.Collections,
  clrUtils.SortArray,
  damTypes;


function Sort(var HashMap: TDictionary<Byte, Integer>): TList<TPair<Byte, Integer>>; overload;


type THashMapUtils = class


  // class function Sort<TValue>(var HashMap: TDictionary<Byte, TTeamStatistik>; ConditionFn: clrUtils.SortArray.TConditionFn<TValue>); overload;
  class function Sort(HashMap: TDictionary<Byte, TTeamStatistik>): TList<TPair<Byte, TTeamStatistik>>; overload;

  // class function Sort<TKey, TValue>(var HashMap: TDictionary<TKey, TValue>): TList<TPair<TKey, TValue>>; overload;
  class function Sort<TKey, TValue>(var HashMap: TDictionary<TKey, TValue>; ConditionFn: clrUtils.SortArray.TConditionFn<TValue>): TList<TPair<TKey, TValue>>; overload;

end;

implementation

function Sort(var HashMap: TDictionary<Byte, Integer>): TList<TPair<Byte, Integer>>;
var
  Ndx: Integer;
  KeysArray: TArray<Byte>; //TArray<TKey>;
  ValuesArray: TArray<Integer>; //TArray<TValue>;
begin
  // THashMapUtils.Sort<Byte, Integer>(HashMap, );
end;


class function THashMapUtils.Sort(HashMap: TDictionary<Byte, TTeamStatistik>): TList<TPair<Byte, TTeamStatistik>>;
var
  Ndx: Integer;
  KeysArray: TArray<Byte>;
  ValuesArray: TArray<TTeamStatistik>;
  Map: TDictionary<Byte, TTeamStatistik>;
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


class function THashMapUtils.Sort<TKey, TValue>(var HashMap: TDictionary<TKey, TValue>; ConditionFn: clrUtils.SortArray.TConditionFn<TValue>): TList<TPair<TKey, TValue>>;
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
      and (ConditionFn(ValuesArray[j], val)) ) do
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


end.
