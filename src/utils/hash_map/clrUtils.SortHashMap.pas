unit clrUtils.SortHashMap;

interface

uses
  System.Generics.Collections,
  clrUtils.SortArray,
  damTypes;


procedure Sort(var HashMap: TDictionary<Byte, Integer>); overload;


type THashMapUtils = class

//  class procedure Sort<T>(var HashMap: TDictionary<Byte, TTeamStatistik>; CallbackFn: clrUtils.SortArray.TCallbackFn<T>); overload;
 class procedure Sort(HashMap: TDictionary<Byte, TTeamStatistik>; out OutputHashMap: TDictionary<Byte, TTeamStatistik>; InPlace: Boolean = false); // overload;

//  class procedure Sort<TKey, TValue>(var HashMap: TDictionary<TKey, TValue>); overload;

end;

implementation

procedure Sort(var HashMap: TDictionary<Byte, Integer>);
var
  Ndx: Integer;
  KeysArray: TArray<Byte>; //TArray<TKey>;
  ValuesArray: TArray<Integer>; //TArray<TValue>;
  Map: TDictionary<Byte, Integer>; //TDictionary<TKey, TValue>;
begin

  KeysArray := HashMap.Keys.ToArray;
  ValuesArray := HashMap.Values.ToArray;

  Map := TDictionary<Byte, Integer>.Create;

  // Insertion sort
  for Ndx := 1 to HashMap.Count - 1 do
  begin

    var key := KeysArray[Ndx];
    var val := ValuesArray[Ndx];
    var j := Ndx - 1;

    while ( (j >= 0)
      and (val < ValuesArray[j]) ) do
    begin
      ValuesArray[Ndx] := ValuesArray[j];
      KeysArray[Ndx] := KeysArray[j];
      Map.Add(KeysArray[Ndx], ValuesArray[Ndx]);
      j := j - 1;
    end;

    KeysArray[j + 1] := key;
    ValuesArray[j + 1] := val;
    HashMap.Add(KeysArray[j + 1], ValuesArray[j + 1]);

  end;

end;


class procedure THashMapUtils.Sort(HashMap: TDictionary<Byte, TTeamStatistik>; out OutputHashMap: TDictionary<Byte, TTeamStatistik>; InPlace: Boolean = false);
var
  Ndx: Integer;
  KeysArray: TArray<Byte>; //TArray<TKey>;
  ValuesArray: TArray<TTeamStatistik>; //TArray<TValue>;
  Map: TDictionary<Byte, TTeamStatistik>; //TDictionary<TKey, TValue>;
begin

  KeysArray := HashMap.Keys.ToArray;
  ValuesArray := HashMap.Values.ToArray;

  Map := TDictionary<Byte, TTeamStatistik>.Create;

  // Insertion sort
  for Ndx := 1 to HashMap.Count - 1 do
  begin

    var key := KeysArray[Ndx];
    var val := ValuesArray[Ndx];
    var j := Ndx - 1;

    while ( (j >= 0)
      and (val.Punkte < ValuesArray[j].Punkte) ) do
    begin
      ValuesArray[Ndx] := ValuesArray[j];
      KeysArray[Ndx] := KeysArray[j];
      Map.Add(KeysArray[Ndx], ValuesArray[Ndx]);
      j := j - 1;
    end;

    KeysArray[j + 1] := key;
    ValuesArray[j + 1] := val;
    HashMap.Add(KeysArray[j + 1], ValuesArray[j + 1]);

  end;

end;

end.