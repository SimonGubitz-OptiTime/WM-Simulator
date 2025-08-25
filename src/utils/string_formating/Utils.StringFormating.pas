unit Utils.StringFormating;

interface

uses
  SysUtils, System.Generics.Collections;

function FormatSpielerListe(AList: TList<String>): String;

implementation

function FormatSpielerListe(AList: TList<String>): String;
var
  i: Integer;
  s: String;
begin

  s := '0' + IntToStr(AList.Count);
  if (AList.Count >= 10) then
    s := IntToStr(AList.Count);

  Result := s + ' [ ';

  for i := 0 to AList.Count - 1 do
  begin
    if i > 0 then
    begin
      Result := Result + ', ';
    end;

    Result := Result + AList[i];
  end;

  Result := Result + ' ]';

end;

end.
