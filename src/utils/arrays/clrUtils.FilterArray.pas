unit clrUtils.FilterArray;

interface

uses
  System.SysUtils,
  System.Generics.Defaults,
  System.Generics.Collections;


type TConditionFunction<T> = reference to function(Param: T): Boolean; // Fehler

type TFilterArrayUtils = class
public
  /// Sucht nach Instanzen des Objekts, welche den gleichen Wert wie "ValueToFind" haben, und fügt sie dem Result an.
  class function Filter1<T>(AArrayToFilter: TList<T>; AValueToFind: T): TList<T>;

  /// <summary>
  /// Sucht nach Instanzen des Objekts, welche der Condition Funktion zustimmen
  /// </summary>
  class function Filter2<T>(AArrayToFilter: TList<T>; ACondition: TConditionFunction<T>): TList<T>;
end;

implementation

// O(n)
class function TFilterArrayUtils.Filter1<T>(AArrayToFilter: TList<T>; AValueToFind: T): TList<T>;
var
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
      Result.Add(Item);
    end;
  end;
end;

class function TFilterArrayUtils.Filter2<T>(AArrayToFilter: TList<T>; ACondition: TConditionFunction<T>): TList<T>;
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
