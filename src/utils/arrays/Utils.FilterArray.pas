unit Utils.FilterArray;

interface

uses
  System.Generics.Collections;

type TConditionFunction = procedure(Param: T);

type TFilterArrayUtils<T> = class
  // Sucht nach Instanzen des Objekts, welche den gleichen Wert wie "ValueToFind" haben, und fügt sie dem Result an.
  class function Filter(ArrayToFilter: TList<T>; ValueToFind: T): TList<T>; overload; static;

  {Sucht nach Instanzen des Objekts, welche der Condition z.B. procedure
   begin
    return Param > 10;
   end; oder procedure
   begin
    if (Param is TTeam)
      Result := Param.TeamRanking = TTeamRanking.SehrStark;
    else
      Result := false;
   end; zustimmen
  }
  class function Filter(ArrayToFilter: TList<T>; Condition: TConditionFunction): TList<T>; overload; static;
end;

implementation

// O(n)
class function TFilterArrayUtils<T>.Filter(ArrayToFilter: TList<T>; ValueToFind: T): TList<T>;
var
  i: Integer;
begin

  Result := TList<T>.Create;

  // Implement filtering logic here
  for i := 0 to ArrayToFilter.Count - 1 do
  begin
    if ArrayToFilter[i] = ValueToFind then
    begin
      // Hinzufügen
      Result.Add(ArrayToFilter[i]);
    end;
  end;
end;

class function Filter(ArrayToFilter: TList<T>; Condition: TConditionFunction): TList<T>; overload; static;
begin

  Result := TList<T>.Create;

  for i := ArrayToFilter.Count - 1 do
  begin
    if Condition(ArrayToFilter[i]) then
    begin
      // Hinzufügen
      Result.Add(ArrayToFilter[i]);
  end;
end;


end.
