object StadionEingabeFenster: TStadionEingabeFenster
  Left = 429
  Top = 187
  Caption = 'Stadion Eingabe'
  ClientHeight = 441
  ClientWidth = 624
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = []
  Position = poDesigned
  TextHeight = 15
  object StadionUeberschrift: TLabel
    Left = 8
    Top = 8
    Width = 309
    Height = 40
    Caption = 'Stadion beschreiben'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -35
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object NameLabel: TLabel
    Left = 8
    Top = 80
    Width = 34
    Height = 15
    Caption = 'Name'
  end
  object OrtLabel: TLabel
    Left = 8
    Top = 138
    Width = 16
    Height = 15
    Caption = 'Ort'
  end
  object ZuschauerKapazitaetLabel: TLabel
    Left = 8
    Top = 192
    Width = 112
    Height = 15
    Caption = 'Zuschauer Kapazit'#228't'
  end
  object NameEingabeFeld: TEdit
    Left = 8
    Top = 101
    Width = 145
    Height = 23
    TabOrder = 0
    Text = 'aaa'
    TextHint = 'Allianz Arena'
  end
  object OrtEingabeFeld: TEdit
    Left = 8
    Top = 152
    Width = 145
    Height = 23
    TabOrder = 1
    Text = 'bbb'
    TextHint = 'M'#252'nchen'
  end
  object ZuschauerKapazitaetEingabeFeld: TEdit
    Left = 8
    Top = 213
    Width = 145
    Height = 23
    TabOrder = 2
    Text = '123'
    TextHint = '75024'
  end
  object BestaetigenButton: TButton
    Left = 541
    Top = 408
    Width = 75
    Height = 25
    Caption = 'Best'#228'tigen'
    TabOrder = 3
    OnClick = BestaetigenButtonClick
  end
end
