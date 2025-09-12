unit clrUtils.StringFormating;

interface

uses
  System.Generics.Collections,
  System.SysUtils,
  damTypes;

function FormatSpielerListe(AList: TList<String>): String;
function FormatSpielString(ASpiel: TSpiel): String;

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

function FormatSpielString(ASpiel: TSpiel): String;
begin
  Result := ASpiel.Team1.Name + ' ' + IntToStr(ASpiel.Team1Tore) + ':' + IntToStr(ASpiel.Team2Tore) + ' ' + ASpiel.Team2.Name;
end;


end.
