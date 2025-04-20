unit ds18b20;

// Linearisierung des DS18B20-Sensors basierend auf Herstellerdaten.
// Die Polynomformel wurde mithilfe von OpenOffice aus einem vom Hersteller
// bereitgestellten Datensatz ermittelt, um die Nichtlinearität im Temperaturverlauf
// zu korrigieren. Diese Linearisierung reduziert die Abweichung
// auf ca. 0,01 °C (vorher ca. 0,2 °C).
// Hinweis: Ein konstanter Offset durch individuelle Kalibrierung ist weiterhin möglich.
// value := value - (0.03268 + (-0.0127637 * value) + (value * value * 0.00015565));


{$mode ObjFPC}{$H+}

interface

uses
  baseunix, SysUtils;

type
  TStringArray = array of string;

function DsRead(device: integer; Value: pdouble): integer;
function Get1WireDevices: Tstringarray;
function DsOpen(sensorid: string): integer;
procedure DsClose(device:integer);

implementation

var
  Buffer: array[1..255] of ansichar;
  BytesRead, messwert: integer;
  s: string;
  p: integer;


function DsOpen(sensorid: string): integer;
begin
  Result := fpOpen('/sys/devices/w1_bus_master1/' + sensorid + '/w1_slave', O_RDONLY);
end;

procedure DsClose(device:integer);
begin
  fpclose(device);
end;


function DsRead(device: integer; Value: pdouble): integer;
var
  v:double;
begin
  FillChar(buffer, SizeOf(buffer), 0);
  if fpLseek(device, 0, SEEK_SET) = -1 then
  begin
    Result := -1;
    exit;
  end;

  Bytesread := fpRead(Device, buffer, SizeOf(buffer));
  if bytesread = 0 then
  begin
    Result := -2;
    exit;
  end;
  s := trim(string(buffer));
  p := pos('YES', s);
  if p = 0 then
  begin
    Result := -3;
    exit;
  end;
  p := Pos('t=', s, p);
  if p = 0 then
  begin
    Result := -4;
    exit;
  end;
  Delete(s, 1, p + 1);

  if not TryStrToInt(s, messwert) then
  begin
    Result := -5;
    exit;
  end;
  V := messwert / 1000;
  V := V - (0.03268 + (-0.0127637 * V) + (V * V * 0.00015565));
  Result := 0;
  value^:=v;
end;



function Get1WireDevices: Tstringarray;
var
  SRec: TSearchRec;
  DeviceList: array of string;
  Path: string;
  Count: integer;
begin
  Path := '/sys/bus/w1/devices/';
  Count := 0;

  if FindFirst(Path + '*', faAnyFile and faDirectory, SRec) = 0 then
  begin
    repeat
      // Prüfen, ob es ein Verzeichnis mit gültigem 1-Wire-Namen ist
      if (SRec.Attr and faDirectory) = faDirectory then
        if (Length(SRec.Name) > 2) and (SRec.Name[3] = '-') then
        begin
          SetLength(DeviceList, Count + 1);
          DeviceList[Count] := SRec.Name;
          Inc(Count);
        end;
    until FindNext(SRec) <> 0;
    FindClose(SRec);
  end;

  Result := DeviceList;
end;


end.
