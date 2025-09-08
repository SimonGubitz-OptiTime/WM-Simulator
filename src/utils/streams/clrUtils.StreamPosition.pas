unit clrUtils.StreamPosition;

interface

uses
  System.SysUtils;

/// <summary>
///   Da die TStream.BaseStream.Position in Byte gegeben ist, wird sie hiermit basierend auf der Encodierung in Char position umgewandelt
/// </summary>
/// <param value="ABytePosition">
///   Int64, da dies der selbe Typ wie von https://docwiki.embarcadero.com/Libraries/Sydney/de/System.Classes.TStream.Position ist
/// </param>
function GetStreamPositionInChars(AStream: TStreamReader): Integer;

implementation

function GetStreamPositionInChars(AStream: TStreamReader): Integer;
var
  Bytes: TBytes;
  StreamPosition: Int64;
begin

  StreamPosition := AStream.BaseStream.Position;

  // Bytes präperieren
  SetLength(Bytes, StreamPosition);

  // Bytes Array mit den bisherigen Daten füllen
  // von index 0 bis zu der Byte-Position
  AStream.BaseStream.Position := 0;
  AStream.BaseStream.ReadBuffer(Bytes[0], StreamPosition);

  // Basierend auf BOM (big-endian/little-endian) und spezifischem Encoding
  Result := AStream.CurrentEncoding.GetCharCount(Bytes, 0, StreamPosition);

  // Zurücksetzen, da sonst eine Funktion wie clrCSVDB.ZeileEntfernen mit while not(SR.EndOfStream) fehlschlagen würde
  AStream.BaseStream.Position := StreamPosition;

end;


end.
