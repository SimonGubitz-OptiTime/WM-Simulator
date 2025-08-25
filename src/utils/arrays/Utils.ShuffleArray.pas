unit Utils.ShuffleArray;

interface

uses
  System.Generics.Collections;

type TShuffleArrayUtils<T> = recordx
  class procedure Shuffle(var ArrayToShuffle: TList<T>); static; overload;
end;

implementation

class procedure TShuffleArrayUtils<T>.Shuffle(var ArrayToShuffle: TArray<T>);
var
  copyI, I, arrayLength: Integer;
  temp: T;
begin
  arrayLength := Length(ArrayToShuffle);
  for I := arrayLength - 1 downto 0 do
  begin
    copyI := Random(I + 1);
    temp := ArrayToShuffle[i];
    ArrayToShuffle[I] := ArrayToShuffle[copyI];
    ArrayToShuffle[copyI] := temp;
  end;
end;

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
