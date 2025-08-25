unit Utils.FilterArray;

interface

uses
  System.SysUtils,
  System.Generics.Defaults,
  System.Generics.Collections;

// type TConditionFunction = reference to function(Param: T): Boolean; // Fehler - "T" nicht deklariert
// type TConditionFunction = reference to function(index: Integer): Boolean; // Fehler
type TConditionFunction<T> = reference to function(Param: T): Boolean; // Fehler

type TFilterArrayUtils<T> = class
public
  // Sucht nach Instanzen des Objekts, welche den gleichen Wert wie "ValueToFind" haben, und fügt sie dem Result an.
  class function Filter(ArrayToFilter: TList<T>; ValueToFind: T): TList<T>; overload; static;

  // Sucht nach Instanzen des Objekts, welche der Condition Funktion zustimmen
  class function Filter(ArrayToFilter: TList<T>; Condition: TConditionFunction<T>): TList<T>; overload; static;
//  class function Filter(ArrayToFilter: TList<T>; Condition: TConditionFunction): TList<T>; overload; static;
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

 class function TFilterArrayUtils<T>.Filter(ArrayToFilter: TList<T>; Condition: TConditionFunction<T>): TList<T>;
//class function TFilterArrayUtils<T>.Filter(ArrayToFilter: TList<T>; Condition: TConditionFunction): TList<T>;
var
  i: Integer;
begin

  Result := TList<T>.Create;

  for i := 0 to ArrayToFilter.Count - 1 do
  begin
     if Condition(ArrayToFilter[i]) then
//    if Condition(i) then
    begin
      // Hinzufügen
      Result.Add(ArrayToFilter[i]);
    end;
  end;
end;


end.
