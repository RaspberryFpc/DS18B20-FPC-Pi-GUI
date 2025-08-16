object Form1: TForm1
  Left = 199
  Height = 316
  Top = 101
  Width = 465
  Caption = 'DS18B20'
  ClientHeight = 316
  ClientWidth = 465
  DesignTimePPI = 102
  LCLVersion = '8.7'
  OnClose = FormClose
  OnCreate = FormCreate
  object StringGrid1: TStringGrid
    Left = 16
    Height = 283
    Top = 16
    Width = 416
    ColCount = 3
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goAutoAddRows, goSmoothScroll, goFixedRowNumbering]
    RowCount = 9
    TabOrder = 0
    ColWidths = (
      68
      198
      145
    )
    Cells = (
      2
      1
      0
      'SensorID'
      2
      0
      'Temperatur'
    )
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 376
    Top = 248
  end
end
