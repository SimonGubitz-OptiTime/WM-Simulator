unit clrUtils.StringFormating;

interface

uses
  System.Generics.Collections,
  System.SysUtils;

function FormatSpielerListe(AList: TList<String>): String;
function FormatMatchString(Team1Name: String; Team2Name: String; Team1Score: Integer; Team2Score: Integer): String;

implementation

function FormatSpielerListe(AList: TList<String>): String;
var
  Ndx: Integer;
begin

  Result := '0' + IntToStr(AList.Count);
  if ( AList.Count >= 10 ) then
  begin
    Result := IntToStr(AList.Count);
  end;

  Result := Result + ' [ ';

  for Ndx := 0 to AList.Count - 1 do
  begin
    if ( Ndx > 0 ) then
    begin
      Result := Result + ', ';
    end;

    Result := Result + AList[Ndx];
  end;

  Result := Result + ' ]';

end;

function FormatMatchString(Team1Name: String; Team2Name: String; Team1Score: Integer; Team2Score: Integer): String;
begin
  Result := Team1Name + ' ' + IntToStr(Team1Score) + ':' + IntToStr(Team2Score) + ' ' + Team2Name;
end;


end.
