unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Grids,
  ExtCtrls, ds18b20;

type

  { TForm1 }

  TForm1 = class(TForm)
    StringGrid1: TStringGrid;
    Timer1: TTimer;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.frm}

{ TForm1 }

var
Tsl:Tstringarray;
DeviceHdl:TintegerArray;
DeviceCount:integer;
readsensor:integer;

procedure TForm1.Memo1Change(Sender: TObject);
begin

end;

procedure TForm1.Timer1Timer(Sender: TObject);   // mehr als einen Sensor jede sekunde zu lesen macht keinen sinn das nur die werte eines sensors pro sekunde übertragen werden
var
Sensorvalue:Double;
begin
 //if DsRead(Devicehdl[readsensor],@Sensorvalue)>=0 then
 //                        stringgrid1.Cells[2,readsensor+1]:=floattostrf(sensorvalue,fffixed,4,3);
 //inc(readsensor);
 //readsensor:=readsensor mod Devicecount;
 for readsensor:=0 to devicecount-1 do
    begin
        if DsRead(Devicehdl[readsensor],@Sensorvalue)>=0 then
                         stringgrid1.Cells[2,readsensor+1]:=floattostrf(sensorvalue,fffixed,4,3);
    end;


end;

procedure TForm1.FormCreate(Sender: TObject);
var
x:integer;
begin
    tsl:= Get1WireDevices;
    DeviceCount:= high(tsl)+1;
    for x:= 0 to high(tsl) do
       begin
       stringgrid1.Cells[1,x+1] := tsl[x];
       Devicehdl[x]:=DsOpen(tsl[x]);
       end;
end;


procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var x:integer;
begin
   for x:= 0 to devicecount-1 do DsClose(Devicehdl[x]);
end;






end.

