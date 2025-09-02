unit clrUtils.HashMap;

interface

uses
  System.Generics.Collections,
  clrUtils.SortArray;

procedure Sort(var HashMap: TDictionary<Byte, TTeamStatistik>; InPlace: Boolean = true);

// checks if Param is !=<> NextParam
type TCallbackFn<T> = reference to function(Param: T; NextParam: T): Boolean;

type THashMapUtils = class

  class procedure Sort<TKey, TValue>(var HashMap: TDictionary<TKey, TValue>);

end;

implementation

procedure Sort(var HashMap: TDictionary<Byte, TTeamStatistik>; InPlace: Boolean = true);
begin
  
  HashMap.Values
end;

end.