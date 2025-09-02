unit clrUtils.ArrayMischen;

interface

uses
  System.Generics.Collections;

type
  TShuffleArrayUtils<T> = class
  public
    class procedure Shuffle(var ArrayToShuffle: TList<T>); static;
  end;

implementation

class procedure TShuffleArrayUtils<T>.Shuffle(var ArrayToShuffle: TList<T>);
var
  copyI, I, arrayLength: Integer;
  temp: T;
begin
  arrayLength := ArrayToShuffle.Count;
  for I := arrayLength - 1 downto 0 do
  begin
    copyI := Random(I + 1);
    temp := ArrayToShuffle[I];
    ArrayToShuffle[I] := ArrayToShuffle[copyI];
    ArrayToShuffle[copyI] := temp;
  end;
end;

end.
