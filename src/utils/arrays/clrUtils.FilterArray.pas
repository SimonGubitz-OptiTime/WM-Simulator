unit clrUtils.FilterArray;

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
  class function Filter1(AArrayToFilter: TList<T>; AValueToFind: T): TList<T>;

  // Sucht nach Instanzen des Objekts, welche der Condition Funktion zustimmen
  class function Filter2(AArrayToFilter: TList<T>; ACondition: TConditionFunction<T>): TList<T>;
  //  class function Filter(ArrayToFilter: TList<T>; Condition: TConditionFunction): TList<T>; overload; static;
end;

implementation

// O(n)
class function TFilterArrayUtils<T>.Filter1(AArrayToFilter: TList<T>; AValueToFind: T): TList<T>;
var
  i: Integer;
  Item: T;
begin

  Result := TList<T>.Create;

  // Implement filtering logic here
//  for i := 0 to ArrayToFilter.Count - 1 do
  for Item in AArrayToFilter do
  begin
    if ( Item = AValueToFind ) then
    begin
      // Hinzufügen
      Result.Add(AArrayToFilter[i]);
    end;
  end;
end;

 class function TFilterArrayUtils<T>.Filter2(AArrayToFilter: TList<T>; ACondition: TConditionFunction<T>): TList<T>;
//class function TFilterArrayUtils<T>.Filter(ArrayToFilter: TList<T>; Condition: TConditionFunction): TList<T>;
var
  i: Integer;
begin

  Result := TList<T>.Create;

  for i := 0 to AArrayToFilter.Count - 1 do
  begin
    if ( (ACondition(AArrayToFilter[i])) ) then
    // if ( Condition(i) ) then
    begin
      // Hinzufügen
      Result.Add(AArrayToFilter[i]);
    end;
  end;
end;


end.
