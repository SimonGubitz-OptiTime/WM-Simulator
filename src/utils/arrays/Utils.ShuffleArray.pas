unit Utils.ShuffleArray;

interface

type TShuffleArrayUtils<T> = record
  class procedure Shuffle(var ArrayToShuffle: TArray<T>); static;
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

end.
