unit clrUtils.ArrToStr;

interface

uses
  System.Generics.Collections,
  System.Rtti,
  System.SysUtils;

type
  TItemProcessor = reference to function(Ndx: Integer): String;

  TArrToStrUtils<T> = class
  public
    class function ArrToStr(AList: TList<T>): String; overload;
    class function FormatArrToStr(AList: TList<T>; AFormatString: String): String; overload;
    class function FormatArrToStrSeparator(AList: TList<T>; ASeparator: String): String; overload;
    class function FormatArrToStr(AList: TList<T>; AFormatString: String; ACustomLastFormatString: String): String; overload;

    class function FormatArrToStr(ItemPreProcessorFunc: TItemProcessor; ALength: Integer; AFormatString: String): String; overload;
    class function FormatArrToStr(ItemPreProcessorFunc: TItemProcessor; ALength: Integer; AFormatString: String; ACustomLastFormatString: String): String; overload;

    class function ArrToStr(AArray: TArray<T>): String; overload;
    class function FormatArrToStr(AArray: TArray<T>; AFormatString: String): String; overload;
    class function FormatArrToStrSeparator(AArray: TArray<T>; ASeparator: String): String; overload;
    class function FormatArrToStr(AArray: TArray<T>; AFormatString: String; ACustomLastFormatString: String): String; overload;
  end;

implementation

class function TArrToStrUtils<T>.ArrToStr(AList: TList<T>): String;
var
  Ndx: Integer;
begin
  for Ndx := 0 to AList.Count - 1 do
    Result := Result + TValue.From<T>(AList[Ndx]).AsType<String>;
end;

class function TArrToStrUtils<T>.FormatArrToStr(AList: TList<T>; AFormatString: String): String;
var
  Ndx: Integer;
begin
  for Ndx := 0 to AList.Count - 1 do
    Result := Result + Format(AFormatString, [TValue.From<T>(AList[Ndx]).AsType<String>]);
end;

class function TArrToStrUtils<T>.FormatArrToStr(AList: TList<T>; AFormatString, ACustomLastFormatString: String): String;
var
  Ndx: Integer;
begin
  for Ndx := 0 to AList.Count - 1 do
  begin
    if Ndx = AList.Count - 1 then
      Result := Result + Format(ACustomLastFormatString, [TValue.From<T>(AList[Ndx]).AsType<String>])
    else
      Result := Result + Format(AFormatString, [TValue.From<T>(AList[Ndx]).AsType<String>]);
  end;
end;

class function TArrToStrUtils<T>.FormatArrToStrSeparator(AList: TList<T>; ASeparator: String): String;
var
  Ndx: Integer;
begin
  for Ndx := 0 to AList.Count - 1 do
  begin
    if Ndx > 0 then
    begin
      Result := Result + ASeparator;
    end;
    Result := Result + TValue.From<T>(AList[Ndx]).AsType<String>;
  end;
end;

class function TArrToStrUtils<T>.FormatArrToStr(ItemPreProcessorFunc: TItemProcessor; ALength: Integer; AFormatString: String): String;
var
  Ndx: Integer;
begin
  for Ndx := 0 to ALength - 1 do
  begin
    Result := Result + Format(AFormatString, [ItemPreProcessorFunc(Ndx)]);
  end;
end;

class function TArrToStrUtils<T>.FormatArrToStr(ItemPreProcessorFunc: TItemProcessor; ALength: Integer; AFormatString, ACustomLastFormatString: String): String;
var
  Ndx: Integer;
begin
  for Ndx := 0 to ALength - 1 do
  begin
    if Ndx = ALength - 1 then
      Result := Result + Format(ACustomLastFormatString, [ItemPreProcessorFunc(Ndx)])
    else
      Result := Result + Format(AFormatString, [ItemPreProcessorFunc(Ndx)]);
  end;
end;

class function TArrToStrUtils<T>.ArrToStr(AArray: TArray<T>): String;
var
  Ndx: Integer;
begin
  for Ndx := 0 to Length(AArray) - 1 do
    Result := Result + TValue.From<T>(AArray[Ndx]).AsType<String>;
end;

class function TArrToStrUtils<T>.FormatArrToStr(AArray: TArray<T>; AFormatString: String): String;
var
  Ndx: Integer;
begin
  for Ndx := 0 to Length(AArray) - 1 do
    Result := Result + Format(AFormatString, [TValue.From<T>(AArray[Ndx]).AsType<String>]);
end;

class function TArrToStrUtils<T>.FormatArrToStr(AArray: TArray<T>; AFormatString, ACustomLastFormatString: String): String;
var
  Ndx: Integer;
begin
  for Ndx := 0 to Length(AArray) - 1 do
  begin
    if Ndx = Length(AArray) - 1 then
      Result := Result + Format(ACustomLastFormatString, [TValue.From<T>(AArray[Ndx]).AsType<String>])
    else
      Result := Result + Format(AFormatString, [TValue.From<T>(AArray[Ndx]).AsType<String>]);
  end;
end;

class function TArrToStrUtils<T>.FormatArrToStrSeparator(AArray: TArray<T>; ASeparator: String): String;
var
  Ndx: Integer;
begin
  for Ndx := 0 to Length(AArray) - 1 do
  begin
    if Ndx > 0 then
      Result := Result + ASeparator;
    Result := Result + TValue.From<T>(AArray[Ndx]).AsType<String>;
  end;
end;


end.
