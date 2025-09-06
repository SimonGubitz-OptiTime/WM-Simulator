object StadionEntfernenFenster: TStadionEntfernenFenster
  Left = 0
  Top = 0
  Caption = 'Stadion entfernen'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 277
    Height = 47
    Caption = 'Stadion entfernen'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -35
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 88
    Width = 32
    Height = 15
    Caption = 'Name'
  end
  object BestaetigenButton: TButton
    Left = 541
    Top = 408
    Width = 75
    Height = 25
    Caption = 'Best'#228'tigen'
    TabOrder = 0
    OnClick = BestaetigenButtonClick
  end
  object StadionNameEdit: TEdit
    Left = 8
    Top = 109
    Width = 121
    Height = 23
    TabOrder = 1
    TextHint = 'Stadion Name'
  end
end
