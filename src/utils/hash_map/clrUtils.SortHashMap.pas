unit clrUtils.SortHashMap;

interface

uses
  System.Generics.Collections,
  clrUtils.SortArray,
  damTypes;



type THashMapUtils = class

  class procedure Sort<T>(var HashMap: TDictionary<Byte, TTeamStatistik>; CallbackFn: clrUtils.SortArray.TCallbackFn<T>); overload;
  class procedure Sort<T>(HashMap: TDictionary<Byte, TTeamStatistik>; CallbackFn: clrUtils.SortArray.TCallbackFn<T>; out OutputHashMap: TDictionary<Byte, TTeamStatistik>; InPlace: Boolean = false); overload;

  class procedure Sort<TKey, TValue>(var HashMap: TDictionary<TKey, TValue>); overload;

end;

implementation

procedure Sort(var HashMap: TDictionary<Byte, TTeamStatistik>);
var
  MyList: TList<Integer>;
begin
  MyList := TList<Integer>.Create;
  MyList.AddRange([12, 4, 7, 9]);

  clrUtils.SortArray.Sort(MyList);

  MyList.Free;
end;

procedure Sort(HashMap: TDictionary<Byte, TTeamStatistik>; out OutputHashMap: TDictionary<Byte, TTeamStatistik>; InPlace: Boolean = false);
var
  MyList: TList<Integer>;
begin
  MyList := TList<Integer>.Create;
  MyList.AddRange([12, 4, 7, 9]);

  clrUtils.SortArray.Sort(MyList);

  MyList.Free;
end;

class procedure THashMapUtils.Sort<TKey, TValue>(var HashMap: TDictionary<TKey, TValue>);
begin

end;

end.