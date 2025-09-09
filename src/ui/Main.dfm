object MainForm: TMainForm
  Left = 184
  Top = 145
  Anchors = []
  Caption = 'WM-Simulator'
  ClientHeight = 801
  ClientWidth = 1306
  Color = clBtnFace
  Constraints.MinHeight = 840
  Constraints.MinWidth = 1310
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = []
  Position = poDesigned
  PrintScale = poNone
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    1306
    801)
  TextHeight = 15
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 1309
    Height = 797
    ActivePage = Stammdaten
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    OnChanging = PageControlChanging
    object Stammdaten: TTabSheet
      Caption = 'Stammdaten'
      DesignSize = (
        1301
        767)
      object UeberschriftStammdaten: TLabel
        Left = 3
        Top = 3
        Width = 193
        Height = 40
        Caption = 'Stammdaten'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -35
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object StadionAnzahlLabel: TLabel
        Left = 703
        Top = 85
        Width = 14
        Height = 15
        Anchors = [akTop, akRight]
        Caption = '00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object StadionVergleichsLabel: TLabel
        Left = 723
        Top = 85
        Width = 7
        Height = 15
        Anchors = [akTop, akRight]
        Caption = '<'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object StadionGewollteAnzahlLabel: TLabel
        Left = 744
        Top = 85
        Width = 14
        Height = 15
        Anchors = [akTop, akRight]
        Caption = '16'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object TeamAnzahlLabel: TLabel
        Left = 3
        Top = 85
        Width = 14
        Height = 15
        Caption = '00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object TeamVergleichsLabel: TLabel
        Left = 23
        Top = 85
        Width = 7
        Height = 15
        Caption = '<'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object TeamGewollteAnzahlLabel: TLabel
        Left = 41
        Top = 85
        Width = 14
        Height = 15
        Caption = '48'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object TeamHinzufuegenButton: TButton
        Left = 3
        Top = 54
        Width = 146
        Height = 25
        Caption = 'Team Hinzuf'#252'gen'
        ImageIndex = 2
        Images = SymbolImageList
        TabOrder = 0
        OnClick = TeamHinzufuegenButtonClick
      end
      object StadionHinzufuegenButton: TButton
        Left = 703
        Top = 54
        Width = 146
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Stadion Hinzuf'#252'gen'
        ImageIndex = 4
        Images = SymbolImageList
        TabOrder = 1
        OnClick = StadionHinzufuegenButtonClick
      end
      object StadienStringGrid: TStringGrid
        Left = 703
        Top = 106
        Width = 595
        Height = 658
        Anchors = [akTop, akRight, akBottom]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object TeamsStringGrid: TStringGrid
        Left = 3
        Top = 106
        Width = 598
        Height = 658
        Anchors = [akLeft, akTop, akBottom]
        TabOrder = 3
      end
      object ZurVerlosungButton: TButton
        Left = 1223
        Top = 3
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Verlosen'
        Enabled = False
        TabOrder = 4
        OnClick = ZurVerlosungButtonClick
      end
      object TeamEntfernenButton: TButton
        Left = 163
        Top = 54
        Width = 146
        Height = 25
        Caption = 'Team Entfernen'
        ImageIndex = 1
        Images = SymbolImageList
        TabOrder = 5
        OnClick = TeamEntfernenButtonClick
      end
      object StadionEntfernenButton: TButton
        Left = 864
        Top = 54
        Width = 146
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Stadion Entfernen'
        ImageIndex = 1
        Images = SymbolImageList
        TabOrder = 6
        OnClick = StadionEntfernenButtonClick
      end
    end
    object VerlosungSheet: TTabSheet
      Caption = 'Verlosung'
      ImageIndex = -1
      DesignSize = (
        1301
        767)
      object UeberschriftVerlosung: TLabel
        Left = 3
        Top = 3
        Width = 151
        Height = 40
        Caption = 'Verlosung'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -35
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label9: TLabel
        Left = 3
        Top = 49
        Width = 34
        Height = 15
        Caption = 'Name'
      end
      object Label11: TLabel
        Left = 88
        Top = 49
        Width = 35
        Height = 15
        Caption = 'St'#228'rke'
      end
      object Label14: TLabel
        Left = 244
        Top = 49
        Width = 79
        Height = 15
        Caption = 'Team Verband'
      end
      object Label12: TLabel
        Left = 168
        Top = 49
        Width = 32
        Height = 15
        Caption = 'Siege'
      end
      object Label26: TLabel
        Left = 1211
        Top = 49
        Width = 79
        Height = 15
        Caption = 'Team Verband'
      end
      object Label27: TLabel
        Left = 1135
        Top = 49
        Width = 32
        Height = 15
        Caption = 'Siege'
      end
      object Label28: TLabel
        Left = 1055
        Top = 49
        Width = 35
        Height = 15
        Caption = 'St'#228'rke'
      end
      object Label29: TLabel
        Left = 970
        Top = 49
        Width = 34
        Height = 15
        Caption = 'Name'
      end
      object Label16: TLabel
        Left = 748
        Top = 467
        Width = 79
        Height = 15
        Caption = 'Team Verband'
      end
      object Label17: TLabel
        Left = 672
        Top = 467
        Width = 32
        Height = 15
        Caption = 'Siege'
      end
      object Label20: TLabel
        Left = 592
        Top = 467
        Width = 35
        Height = 15
        Caption = 'St'#228'rke'
      end
      object Label21: TLabel
        Left = 507
        Top = 467
        Width = 34
        Height = 15
        Caption = 'Name'
      end
      object ZurGruppenphaseButton: TButton
        Left = -11916
        Top = 3
        Width = 94
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Gruppenphase'
        Enabled = False
        TabOrder = 0
        OnClick = ZurGruppenphaseButtonClick
      end
      object StringGrid1: TStringGrid
        Left = 3
        Top = 70
        Width = 320
        Height = 120
        ColCount = 4
        FixedCols = 0
        RowCount = 4
        FixedRows = 0
        TabOrder = 1
      end
      object StringGrid2: TStringGrid
        Left = 3
        Top = 203
        Width = 320
        Height = 120
        ColCount = 4
        FixedCols = 0
        RowCount = 4
        FixedRows = 0
        TabOrder = 3
      end
      object StringGrid3: TStringGrid
        Left = 3
        Top = 346
        Width = 320
        Height = 120
        ColCount = 4
        FixedCols = 0
        RowCount = 4
        FixedRows = 0
        TabOrder = 4
      end
      object StringGrid4: TStringGrid
        Left = 3
        Top = 488
        Width = 320
        Height = 120
        ColCount = 4
        FixedCols = 0
        RowCount = 4
        FixedRows = 0
        TabOrder = 5
      end
      object StringGrid5: TStringGrid
        Left = 3
        Top = 630
        Width = 320
        Height = 120
        ColCount = 4
        FixedCols = 0
        RowCount = 4
        FixedRows = 0
        TabOrder = 6
      end
      object StringGrid6: TStringGrid
        Left = 967
        Top = 70
        Width = 323
        Height = 120
        Anchors = [akTop, akRight]
        ColCount = 4
        FixedCols = 0
        RowCount = 4
        FixedRows = 0
        TabOrder = 7
      end
      object StringGrid7: TStringGrid
        Left = 967
        Top = 203
        Width = 323
        Height = 120
        Anchors = [akTop, akRight]
        ColCount = 4
        FixedCols = 0
        RowCount = 4
        FixedRows = 0
        TabOrder = 8
      end
      object StringGrid8: TStringGrid
        Left = 967
        Top = 346
        Width = 323
        Height = 120
        Anchors = [akTop, akRight]
        ColCount = 4
        FixedCols = 0
        RowCount = 4
        FixedRows = 0
        TabOrder = 9
      end
      object StringGrid9: TStringGrid
        Left = 967
        Top = 488
        Width = 323
        Height = 120
        Anchors = [akTop, akRight]
        ColCount = 4
        FixedCols = 0
        RowCount = 4
        FixedRows = 0
        TabOrder = 10
      end
      object StringGrid10: TStringGrid
        Left = 967
        Top = 630
        Width = 323
        Height = 120
        Anchors = [akTop, akRight]
        ColCount = 4
        FixedCols = 0
        RowCount = 4
        FixedRows = 0
        TabOrder = 2
      end
      object VerlosungStartenButton: TButton
        Left = 610
        Top = 384
        Width = 82
        Height = 27
        Anchors = [akLeft, akRight, akBottom]
        Caption = 'Shuffle'
        Constraints.MaxWidth = 100
        Constraints.MinHeight = 27
        Constraints.MinWidth = 70
        ImageIndex = 2
        Images = SymbolImageList
        TabOrder = 11
        OnClick = VerlosungStartenButtonClick
      end
      object StringGrid11: TStringGrid
        Left = 507
        Top = 488
        Width = 320
        Height = 120
        ColCount = 4
        FixedCols = 0
        RowCount = 4
        FixedRows = 0
        TabOrder = 12
      end
      object StringGrid12: TStringGrid
        Left = 507
        Top = 630
        Width = 320
        Height = 120
        ColCount = 4
        FixedCols = 0
        RowCount = 4
        FixedRows = 0
        TabOrder = 13
      end
    end
    object GruppenphaseSheet: TTabSheet
      Caption = 'Gruppenphase'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ImageIndex = 2
      ParentFont = False
      DesignSize = (
        1301
        767)
      object UeberschriftGruppenphase: TLabel
        Left = 3
        Top = 3
        Width = 225
        Height = 40
        Caption = 'Gruppenphase'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -35
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Spiel1Label: TLabel
        Left = 1062
        Top = 88
        Width = 66
        Height = 15
        Anchors = [akTop, akRight]
        Caption = 'Spiel1Label'
      end
      object Spiel2Label: TLabel
        Left = 1062
        Top = 136
        Width = 66
        Height = 15
        Anchors = [akTop, akRight]
        Caption = 'Spiel2Label'
      end
      object Spiel3Label: TLabel
        Left = 1062
        Top = 193
        Width = 66
        Height = 15
        Anchors = [akTop, akRight]
        Caption = 'Spiel3Label'
      end
      object Spiel4Label: TLabel
        Left = 1062
        Top = 256
        Width = 66
        Height = 15
        Anchors = [akTop, akRight]
        Caption = 'Spiel4Label'
      end
      object Spiel5Label: TLabel
        Left = 1062
        Top = 312
        Width = 66
        Height = 15
        Anchors = [akTop, akRight]
        Caption = 'Spiel5Label'
      end
      object Spiel6Label: TLabel
        Left = 1062
        Top = 368
        Width = 66
        Height = 15
        Anchors = [akTop, akRight]
        Caption = 'Spiel6Label'
      end
      object ZumSpielButton: TButton
        Left = 1223
        Top = 3
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Spielen'
        Enabled = False
        TabOrder = 0
        OnClick = ZumSpielButtonClick
      end
      object GruppenphaseStartenButton: TButton
        Left = 588
        Top = 596
        Width = 166
        Height = 27
        Anchors = [akLeft, akRight, akBottom]
        Caption = 'Gruppenphase starten'
        Constraints.MinHeight = 27
        Constraints.MinWidth = 150
        TabOrder = 1
        OnClick = GruppenphaseStartenButtonClick
      end
      object GruppenphaseStringGrid: TStringGrid
        Left = 32
        Top = 88
        Width = 320
        Height = 120
        ColCount = 4
        FixedCols = 0
        RowCount = 4
        FixedRows = 0
        TabOrder = 2
      end
    end
    object GruppenstatistikenSheet: TTabSheet
      Caption = 'Gruppenstatistiken'
      ImageIndex = 4
      DesignSize = (
        1301
        767)
      object Label4: TLabel
        Left = 11
        Top = 3
        Width = 501
        Height = 40
        Caption = #220'bersicht der Gruppenstatistiken'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -35
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label31: TLabel
        Left = 11
        Top = 57
        Width = 34
        Height = 15
        Caption = 'Name'
      end
      object Label32: TLabel
        Left = 96
        Top = 57
        Width = 35
        Height = 15
        Caption = 'St'#228'rke'
      end
      object Label33: TLabel
        Left = 176
        Top = 57
        Width = 32
        Height = 15
        Caption = 'Siege'
      end
      object Label34: TLabel
        Left = 252
        Top = 57
        Width = 79
        Height = 15
        Caption = 'Team Verband'
      end
      object Label51: TLabel
        Left = 748
        Top = 467
        Width = 79
        Height = 15
        Caption = 'Team Verband'
      end
      object Label52: TLabel
        Left = 507
        Top = 467
        Width = 34
        Height = 15
        Caption = 'Name'
      end
      object Label55: TLabel
        Left = 592
        Top = 467
        Width = 35
        Height = 15
        Caption = 'St'#228'rke'
      end
      object Label57: TLabel
        Left = 672
        Top = 467
        Width = 32
        Height = 15
        Caption = 'Siege'
      end
      object Label59: TLabel
        Left = 975
        Top = 56
        Width = 34
        Height = 15
        Caption = 'Name'
      end
      object Label62: TLabel
        Left = 1140
        Top = 56
        Width = 32
        Height = 15
        Caption = 'Siege'
      end
      object Label65: TLabel
        Left = 1060
        Top = 56
        Width = 35
        Height = 15
        Caption = 'St'#228'rke'
      end
      object Label66: TLabel
        Left = 1216
        Top = 56
        Width = 79
        Height = 15
        Caption = 'Team Verband'
      end
      object StringGrid13: TStringGrid
        Left = 3
        Top = 77
        Width = 320
        Height = 120
        ColCount = 4
        FixedCols = 0
        RowCount = 4
        FixedRows = 0
        TabOrder = 0
      end
      object StringGrid14: TStringGrid
        Left = 3
        Top = 203
        Width = 320
        Height = 120
        ColCount = 4
        FixedCols = 0
        RowCount = 4
        FixedRows = 0
        TabOrder = 1
      end
      object StringGrid15: TStringGrid
        Left = 3
        Top = 346
        Width = 320
        Height = 120
        ColCount = 4
        FixedCols = 0
        RowCount = 4
        FixedRows = 0
        TabOrder = 2
      end
      object StringGrid16: TStringGrid
        Left = 3
        Top = 488
        Width = 320
        Height = 120
        ColCount = 4
        FixedCols = 0
        RowCount = 4
        FixedRows = 0
        TabOrder = 3
      end
      object StringGrid17: TStringGrid
        Left = 507
        Top = 488
        Width = 320
        Height = 120
        ColCount = 4
        FixedCols = 0
        RowCount = 4
        FixedRows = 0
        TabOrder = 4
      end
      object StringGrid18: TStringGrid
        Left = 975
        Top = 488
        Width = 323
        Height = 120
        Anchors = [akTop, akRight]
        ColCount = 4
        FixedCols = 0
        RowCount = 4
        FixedRows = 0
        TabOrder = 5
      end
      object StringGrid19: TStringGrid
        Left = 975
        Top = 346
        Width = 323
        Height = 120
        Anchors = [akTop, akRight]
        ColCount = 4
        FixedCols = 0
        RowCount = 4
        FixedRows = 0
        TabOrder = 6
      end
      object StringGrid20: TStringGrid
        Left = 975
        Top = 203
        Width = 323
        Height = 120
        Anchors = [akTop, akRight]
        ColCount = 4
        FixedCols = 0
        RowCount = 4
        FixedRows = 0
        TabOrder = 7
      end
      object StringGrid21: TStringGrid
        Left = 975
        Top = 77
        Width = 323
        Height = 120
        Anchors = [akTop, akRight]
        ColCount = 4
        FixedCols = 0
        RowCount = 4
        FixedRows = 0
        TabOrder = 8
      end
      object StringGrid22: TStringGrid
        Left = 3
        Top = 630
        Width = 320
        Height = 120
        ColCount = 4
        FixedCols = 0
        RowCount = 4
        FixedRows = 0
        TabOrder = 9
      end
      object StringGrid23: TStringGrid
        Left = 507
        Top = 630
        Width = 320
        Height = 120
        ColCount = 4
        FixedCols = 0
        RowCount = 4
        FixedRows = 0
        TabOrder = 10
      end
      object StringGrid24: TStringGrid
        Left = 975
        Top = 630
        Width = 323
        Height = 120
        Anchors = [akTop, akRight]
        ColCount = 4
        FixedCols = 0
        RowCount = 4
        FixedRows = 0
        TabOrder = 11
      end
    end
    object SpielSheet: TTabSheet
      Caption = 'Spiel'
      ImageIndex = 3
      DesignSize = (
        1301
        767)
      object FinaleLabel: TLabel
        Left = 1147
        Top = 342
        Width = 115
        Height = 12
        Anchors = [akTop, akRight]
        Caption = 'XXXXXXXXXXXXXXXXXXXXXXX'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label179: TLabel
        Left = 1147
        Top = 325
        Width = 28
        Height = 11
        Anchors = [akTop, akRight]
        Caption = 'Finale'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Platz3Label: TLabel
        Left = 1147
        Top = 397
        Width = 73
        Height = 11
        Anchors = [akTop, akRight]
        Caption = 'Spiel um Platz 3'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Font.Quality = fqDraft
        ParentFont = False
      end
      object SpielUmPlatz3Label: TLabel
        Left = 1147
        Top = 414
        Width = 124
        Height = 12
        Anchors = [akTop, akRight]
        Caption = 'XXXXXXXXXXX : XXXXXXXXXXXX'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label1: TLabel
        Left = 1147
        Top = 360
        Width = 78
        Height = 12
        Anchors = [akTop, akRight]
        Caption = 'FinaleStadionLabel'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel
        Left = 1066
        Top = 342
        Width = 75
        Height = 84
        Anchors = [akTop, akRight]
        Caption = 
          '----'#9488'             '#9484'----'#13#10'     |             '#9474#13#10'     |           ' +
          '  '#9474#13#10'     '#9500'------------'#9508#13#10'     |             '#9474#13#10'     |          ' +
          '   '#9474#13#10'----'#9496'             '#9492'----'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label10: TLabel
        Left = 1147
        Top = 432
        Width = 78
        Height = 12
        Anchors = [akTop, akRight]
        Caption = 'Platz3StadionLabel'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object HalbfinaleLabel1: TLabel
        Left = 936
        Top = 342
        Width = 124
        Height = 12
        Anchors = [akTop, akRight]
        Caption = 'XXXXXXXXXXX : XXXXXXXXXXXX'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label13: TLabel
        Left = 936
        Top = 325
        Width = 46
        Height = 11
        Anchors = [akTop, akRight]
        Caption = 'Halbfinale'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object ViertelfinaleLabel4: TLabel
        Left = 740
        Top = 533
        Width = 124
        Height = 12
        Anchors = [akTop, akRight]
        Caption = 'XXXXXXXXXXX : XXXXXXXXXXXX'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object ViertelfinaleLabel3: TLabel
        Left = 740
        Top = 459
        Width = 124
        Height = 12
        Anchors = [akTop, akRight]
        Caption = 'XXXXXXXXXXX : XXXXXXXXXXXX'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label22: TLabel
        Left = 740
        Top = 516
        Width = 54
        Height = 11
        Anchors = [akTop, akRight]
        Caption = 'Viertelfinale'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label23: TLabel
        Left = 740
        Top = 442
        Width = 54
        Height = 11
        Anchors = [akTop, akRight]
        Caption = 'Viertelfinale'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label3: TLabel
        Left = 936
        Top = 397
        Width = 46
        Height = 11
        Anchors = [akTop, akRight]
        Caption = 'Halbfinale'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object HalbfinaleLabel2: TLabel
        Left = 936
        Top = 414
        Width = 124
        Height = 12
        Anchors = [akTop, akRight]
        Caption = 'XXXXXXXXXXX : XXXXXXXXXXXX'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label5: TLabel
        Left = 870
        Top = 426
        Width = 63
        Height = 108
        Anchors = [akTop, akRight]
        Caption = 
          '                    /'#13#10'                   /'#13#10'----'#9488'            /'#13 +
          #10'     |          /'#13#10'     |        /'#13#10'    '#9500'-----'#9496#13#10'     |        ' +
          '  '#13#10'     |'#13#10'----'#9496
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label6: TLabel
        Left = 870
        Top = 211
        Width = 66
        Height = 108
        Anchors = [akTop, akRight]
        Caption = 
          '----'#9488'              '#13#10'     |           '#13#10'     |        '#13#10'    '#9500'---' +
          '--'#9488#13#10'     |        \'#13#10'     |           \'#13#10'----'#9496'             \'#13#10' ' +
          '                   \'#13#10'                     \'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label7: TLabel
        Left = 674
        Top = 409
        Width = 63
        Height = 84
        Anchors = [akTop, akRight]
        Caption = 
          '----'#9488#13#10'     |'#13#10'     |'#13#10'    '#9500'------------'#9488#13#10'     |              \' +
          #13#10'     |'#13#10'----'#9496
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label8: TLabel
        Left = 740
        Top = 266
        Width = 54
        Height = 11
        Anchors = [akTop, akRight]
        Caption = 'Viertelfinale'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object ViertelfinaleLabel2: TLabel
        Left = 740
        Top = 283
        Width = 124
        Height = 12
        Anchors = [akTop, akRight]
        Caption = 'XXXXXXXXXXX : XXXXXXXXXXXX'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object ViertelfinaleLabel1: TLabel
        Left = 740
        Top = 211
        Width = 124
        Height = 12
        Anchors = [akTop, akRight]
        Caption = 'XXXXXXXXXXX : XXXXXXXXXXXX'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label15: TLabel
        Left = 740
        Top = 194
        Width = 54
        Height = 11
        Anchors = [akTop, akRight]
        Caption = 'Viertelfinale'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label18: TLabel
        Left = 674
        Top = 104
        Width = 60
        Height = 84
        Anchors = [akTop, akRight]
        Caption = 
          '----'#9488'              '#13#10'     |           '#13#10'     |        '#13#10'    '#9500'---' +
          '--'#9488#13#10'     |        \'#13#10'     |           \'#13#10'----'#9496'             \'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label19: TLabel
        Left = 674
        Top = 266
        Width = 63
        Height = 84
        Anchors = [akTop, akRight]
        Caption = 
          '----'#9488#13#10'     |'#13#10'     |              /'#13#10'    '#9500'------------'#9496#13#10'     |' +
          #13#10'     |'#13#10'----'#9496
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label24: TLabel
        Left = 674
        Top = 551
        Width = 60
        Height = 84
        Anchors = [akTop, akRight]
        Caption = 
          '----'#9488'             /'#13#10'     |           /'#13#10'     |        /'#13#10'    '#9500'-' +
          '----'#9496#13#10'     |          '#13#10'     |'#13#10'----'#9496
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label25: TLabel
        Left = 544
        Top = 534
        Width = 52
        Height = 11
        Anchors = [akTop, akRight]
        Caption = 'Achtelfinale'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object AchtelfinaleLabel7: TLabel
        Left = 544
        Top = 551
        Width = 124
        Height = 12
        Anchors = [akTop, akRight]
        Caption = 'XXXXXXXXXXX : XXXXXXXXXXXX'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object AchtelfinaleLabel8: TLabel
        Left = 544
        Top = 623
        Width = 124
        Height = 12
        Anchors = [akTop, akRight]
        Caption = 'XXXXXXXXXXX : XXXXXXXXXXXX'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object AchtelfinaleLabel6: TLabel
        Left = 544
        Top = 481
        Width = 124
        Height = 12
        Anchors = [akTop, akRight]
        Caption = 'XXXXXXXXXXX : XXXXXXXXXXXX'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object AchtelfinaleLabel5: TLabel
        Left = 544
        Top = 409
        Width = 124
        Height = 12
        Anchors = [akTop, akRight]
        Caption = 'XXXXXXXXXXX : XXXXXXXXXXXX'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object AchtelfinaleLabel4: TLabel
        Left = 544
        Top = 342
        Width = 124
        Height = 12
        Anchors = [akTop, akRight]
        Caption = 'XXXXXXXXXXX : XXXXXXXXXXXX'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object AchtelfinaleLabel3: TLabel
        Left = 544
        Top = 266
        Width = 124
        Height = 12
        Anchors = [akTop, akRight]
        Caption = 'XXXXXXXXXXX : XXXXXXXXXXXX'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object AchtelfinaleLabel1: TLabel
        Left = 544
        Top = 104
        Width = 124
        Height = 12
        Anchors = [akTop, akRight]
        Caption = 'XXXXXXXXXXX : XXXXXXXXXXXX'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object AchtelfinaleLabel2: TLabel
        Left = 544
        Top = 176
        Width = 124
        Height = 12
        Anchors = [akTop, akRight]
        Caption = 'XXXXXXXXXXX : XXXXXXXXXXXX'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label35: TLabel
        Left = 478
        Top = 14
        Width = 60
        Height = 84
        Anchors = [akTop, akRight]
        Caption = 
          '----'#9488'              '#13#10'     |           '#13#10'     |        '#13#10'    '#9500'---' +
          '--'#9488#13#10'     |        \'#13#10'     |           \'#13#10'----'#9496'             \'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label36: TLabel
        Left = 478
        Top = 640
        Width = 60
        Height = 84
        Anchors = [akTop, akRight]
        Caption = 
          '----'#9488'             /'#13#10'     |           /'#13#10'     |        /'#13#10'    '#9500'-' +
          '----'#9496#13#10'     |          '#13#10'     |'#13#10'----'#9496
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label37: TLabel
        Left = 475
        Top = 460
        Width = 63
        Height = 84
        Anchors = [akTop, akRight]
        Caption = 
          '----'#9488#13#10'     |'#13#10'     |              /'#13#10'    '#9500'------------'#9496#13#10'     |' +
          #13#10'     |'#13#10'----'#9496
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label40: TLabel
        Left = 544
        Top = 606
        Width = 52
        Height = 11
        Anchors = [akTop, akRight]
        Caption = 'Achtelfinale'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label41: TLabel
        Left = 544
        Top = 464
        Width = 52
        Height = 11
        Anchors = [akTop, akRight]
        Caption = 'Achtelfinale'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label42: TLabel
        Left = 544
        Top = 392
        Width = 52
        Height = 11
        Anchors = [akTop, akRight]
        Caption = 'Achtelfinale'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label43: TLabel
        Left = 544
        Top = 87
        Width = 52
        Height = 11
        Anchors = [akTop, akRight]
        Caption = 'Achtelfinale'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label44: TLabel
        Left = 544
        Top = 159
        Width = 52
        Height = 11
        Anchors = [akTop, akRight]
        Caption = 'Achtelfinale'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label45: TLabel
        Left = 544
        Top = 249
        Width = 52
        Height = 11
        Anchors = [akTop, akRight]
        Caption = 'Achtelfinale'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label46: TLabel
        Left = 544
        Top = 325
        Width = 52
        Height = 11
        Anchors = [akTop, akRight]
        Caption = 'Achtelfinale'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label39: TLabel
        Left = 475
        Top = 550
        Width = 63
        Height = 84
        Anchors = [akTop, akRight]
        Caption = 
          '----'#9488#13#10'     |'#13#10'     |              /'#13#10'    '#9500'------------'#9496#13#10'     |' +
          #13#10'     |'#13#10'----'#9496
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label48: TLabel
        Left = 475
        Top = 104
        Width = 63
        Height = 84
        Anchors = [akTop, akRight]
        Caption = 
          '----'#9488#13#10'     |'#13#10'     |'#13#10'    '#9500'------------'#9488#13#10'     |              \' +
          #13#10'     |'#13#10'----'#9496
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label49: TLabel
        Left = 478
        Top = 370
        Width = 60
        Height = 84
        Anchors = [akTop, akRight]
        Caption = 
          '----'#9488' '#13#10'     |'#13#10'     |'#13#10'    '#9500'--------------'#13#10'     |'#13#10'     |'#13#10'---' +
          '-'#9496
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label47: TLabel
        Left = 478
        Top = 288
        Width = 60
        Height = 84
        Anchors = [akTop, akRight]
        Caption = 
          '----'#9488' '#13#10'     |'#13#10'     |'#13#10'    '#9500'--------------'#13#10'     |'#13#10'     |'#13#10'---' +
          '-'#9496
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label50: TLabel
        Left = 475
        Top = 194
        Width = 63
        Height = 84
        Anchors = [akTop, akRight]
        Caption = 
          '----'#9488#13#10'     |'#13#10'     |'#13#10'    '#9500'------------'#9488#13#10'     |              \' +
          #13#10'     |'#13#10'----'#9496
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object SechzehntelfinaleLabel1: TLabel
        Left = 348
        Top = 22
        Width = 124
        Height = 12
        Anchors = [akTop, akRight]
        Caption = 'XXXXXXXXXXX : XXXXXXXXXXXX'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object SechzehntelfinaleLabel2: TLabel
        Left = 348
        Top = 86
        Width = 124
        Height = 12
        Anchors = [akTop, akRight]
        Caption = 'XXXXXXXXXXX : XXXXXXXXXXXX'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object SechzehntelfinaleLabel3: TLabel
        Left = 348
        Top = 121
        Width = 124
        Height = 12
        Anchors = [akTop, akRight]
        Caption = 'XXXXXXXXXXX : XXXXXXXXXXXX'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label30: TLabel
        Left = 348
        Top = 104
        Width = 80
        Height = 11
        Anchors = [akTop, akRight]
        Caption = 'Sechzehntelfinale'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label38: TLabel
        Left = 348
        Top = 159
        Width = 80
        Height = 11
        Anchors = [akTop, akRight]
        Caption = 'Sechzehntelfinale'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object SechzehntelfinaleLabel4: TLabel
        Left = 348
        Top = 176
        Width = 124
        Height = 12
        Anchors = [akTop, akRight]
        Caption = 'XXXXXXXXXXX : XXXXXXXXXXXX'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object SechzehntelfinaleLabel5: TLabel
        Left = 348
        Top = 211
        Width = 124
        Height = 12
        Anchors = [akTop, akRight]
        Caption = 'XXXXXXXXXXX : XXXXXXXXXXXX'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label53: TLabel
        Left = 348
        Top = 194
        Width = 80
        Height = 11
        Anchors = [akTop, akRight]
        Caption = 'Sechzehntelfinale'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label54: TLabel
        Left = 348
        Top = 249
        Width = 80
        Height = 11
        Anchors = [akTop, akRight]
        Caption = 'Sechzehntelfinale'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object SechzehntelfinaleLabel6: TLabel
        Left = 348
        Top = 266
        Width = 124
        Height = 12
        Anchors = [akTop, akRight]
        Caption = 'XXXXXXXXXXX : XXXXXXXXXXXX'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label56: TLabel
        Left = 348
        Top = 69
        Width = 80
        Height = 11
        Anchors = [akTop, akRight]
        Caption = 'Sechzehntelfinale'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object SechzehntelfinaleLabel7: TLabel
        Left = 348
        Top = 305
        Width = 124
        Height = 12
        Anchors = [akTop, akRight]
        Caption = 'XXXXXXXXXXX : XXXXXXXXXXXX'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label58: TLabel
        Left = 348
        Top = 288
        Width = 80
        Height = 11
        Anchors = [akTop, akRight]
        Caption = 'Sechzehntelfinale'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object SechzehntelfinaleLabel8: TLabel
        Left = 348
        Top = 352
        Width = 124
        Height = 12
        Anchors = [akTop, akRight]
        Caption = 'XXXXXXXXXXX : XXXXXXXXXXXX'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label60: TLabel
        Left = 348
        Top = 370
        Width = 80
        Height = 11
        Anchors = [akTop, akRight]
        Caption = 'Sechzehntelfinale'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label61: TLabel
        Left = 348
        Top = 335
        Width = 80
        Height = 11
        Anchors = [akTop, akRight]
        Caption = 'Sechzehntelfinale'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object SechzehntelfinaleLabel9: TLabel
        Left = 348
        Top = 387
        Width = 124
        Height = 12
        Anchors = [akTop, akRight]
        Caption = 'XXXXXXXXXXX : XXXXXXXXXXXX'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label63: TLabel
        Left = 348
        Top = 5
        Width = 80
        Height = 11
        Anchors = [akTop, akRight]
        Caption = 'Sechzehntelfinale'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label64: TLabel
        Left = 348
        Top = 425
        Width = 80
        Height = 11
        Anchors = [akTop, akRight]
        Caption = 'Sechzehntelfinale'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object SechzehntelfinaleLabel10: TLabel
        Left = 348
        Top = 442
        Width = 124
        Height = 12
        Anchors = [akTop, akRight]
        Caption = 'XXXXXXXXXXX : XXXXXXXXXXXX'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object SechzehntelfinaleLabel11: TLabel
        Left = 348
        Top = 481
        Width = 124
        Height = 12
        Anchors = [akTop, akRight]
        Caption = 'XXXXXXXXXXX : XXXXXXXXXXXX'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label67: TLabel
        Left = 348
        Top = 464
        Width = 80
        Height = 11
        Anchors = [akTop, akRight]
        Caption = 'Sechzehntelfinale'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label68: TLabel
        Left = 348
        Top = 516
        Width = 80
        Height = 11
        Anchors = [akTop, akRight]
        Caption = 'Sechzehntelfinale'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object SechzehntelfinaleLabel12: TLabel
        Left = 348
        Top = 532
        Width = 124
        Height = 12
        Anchors = [akTop, akRight]
        Caption = 'XXXXXXXXXXX : XXXXXXXXXXXX'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label70: TLabel
        Left = 348
        Top = 551
        Width = 80
        Height = 11
        Anchors = [akTop, akRight]
        Caption = 'Sechzehntelfinale'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object SechzehntelfinaleLabel13: TLabel
        Left = 348
        Top = 568
        Width = 124
        Height = 12
        Anchors = [akTop, akRight]
        Caption = 'XXXXXXXXXXX : XXXXXXXXXXXX'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object SechzehntelfinaleLabel14: TLabel
        Left = 348
        Top = 622
        Width = 124
        Height = 12
        Anchors = [akTop, akRight]
        Caption = 'XXXXXXXXXXX : XXXXXXXXXXXX'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label73: TLabel
        Left = 348
        Top = 606
        Width = 80
        Height = 11
        Anchors = [akTop, akRight]
        Caption = 'Sechzehntelfinale'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label74: TLabel
        Left = 348
        Top = 640
        Width = 80
        Height = 11
        Anchors = [akTop, akRight]
        Caption = 'Sechzehntelfinale'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object SechzehntelfinaleLabel15: TLabel
        Left = 348
        Top = 657
        Width = 124
        Height = 12
        Anchors = [akTop, akRight]
        Caption = 'XXXXXXXXXXX : XXXXXXXXXXXX'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object SechzehntelfinaleLabel16: TLabel
        Left = 348
        Top = 718
        Width = 124
        Height = 12
        Anchors = [akTop, akRight]
        Caption = 'XXXXXXXXXXX : XXXXXXXXXXXX'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label77: TLabel
        Left = 348
        Top = 701
        Width = 80
        Height = 11
        Anchors = [akTop, akRight]
        Caption = 'Sechzehntelfinale'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object kophaseStartenButton: TButton
        Left = 56
        Top = 371
        Width = 145
        Height = 25
        Caption = 'KO-Phase starten'
        TabOrder = 0
        OnClick = kophaseStartenButtonClick
      end
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 782
    Width = 1306
    Height = 19
    Panels = <>
  end
  object SymbolImageList: TImageList
    Left = 384
    Top = 32
    Bitmap = {
      494C010106000800040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001002000000000000020
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000030000000CF000000FF000000FF000000BF000000400000
      0000000000000000000000000000000000000000000000000000000000000000
      001000000080000000FF000000FF0000000000000000000000FF000000FF0000
      0080000000100000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000020000000FF000000FF000000FF000000FF000000FF000000FF0000
      00400000000000000000000000000000000000000000000000000000009F0000
      00FF000000FF000000FF000000FF0000000000000000000000FF000000FF0000
      00FF000000FF000000AF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00FF000000FF000000FF00000000000000000000000000000000000000FF0000
      00FF000000FF00000000000000000000000000000000000000FF000000FF0000
      00000000000000000000000000FF0000000000000000000000FF000000000000
      000000000000000000FF000000FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000400000
      00FF000000FF000000FF00000000000000000000000000000000000000FF0000
      00FF000000FF00000020000000000000000000000000000000FF000000FF0000
      00000000000000000000000000FF000000FF000000FF000000FF000000000000
      000000000000000000FF000000FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000040000000FF0000
      000000000000000000FF000000FF000000FF000000FF000000FF000000FF0000
      000000000000000000FF000000300000000000000000000000FF000000FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000FF000000FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000BF000000FF0000
      000000000000000000FF0000009F00000000000000000000009F000000FF0000
      000000000000000000FF000000CF0000000000000000000000FF000000FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000FF000000FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000FF000000FF0000
      000000000010000000FF00000000000000000000000000000000000000FF0000
      000000000000000000FF000000FF0000000000000000000000FF000000FF0000
      00100000006F000000FF000000FF000000FF000000FF000000FF000000FF0000
      006F00000010000000FF000000FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000FF000000FF0000
      0000000000AF0000009F000000000000000000000000000000000000009F0000
      00AF00000000000000FF000000FF0000000000000000000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000CF000000FF0000
      00FF000000DF000000FF000000FF0000000000000000000000FF000000FF0000
      00DF000000FF000000FF000000BF0000000000000000000000FF000000FF0000
      00FF0000009F0000000000000000000000000000000000000000000000000000
      009F000000FF000000FF000000FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000030000000FF0000
      0080000000000000008F000000FF000000EF000000EF000000FF0000008F0000
      00000000006F000000FF000000400000000000000000000000000000008F0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF0000009F00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000200000
      00FF000000200000000000000000000000FF000000FF00000000000000000000
      0020000000FF0000004000000000000000000000000000000000000000EF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000EF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00FF000000FF0000000000000000000000FF000000FF00000000000000000000
      00FF000000FF0000000000000000000000000000000000000000000000FF0000
      00EF000000100000000000000000000000EF0000001000000000000000000000
      0000000000FF000000EF00000010000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000040000000FF000000FF000000FF000000FF000000FF000000FF0000
      0020000000000000000000000000000000000000000000000000000000DF0000
      0000000000000000000000000000000000FF000000FF00000020000000000000
      0000000000DF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000040000000BF000000FF000000FF000000CF000000300000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000DF0000002000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0028000000C7000000FF000000FF000000D70000002800000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000FF000000FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000280000
      00FF000000FF000000FF000000FF000000FF000000FF00000028000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000FF000000FF00000000000000000000
      00000000000000000000000000000000000000000000000000FF000000FF0000
      00000000000000000000000000000000000000000000000000FF000000FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      00FF000000FF00000000000000000000000000000000000000FF000000FF0000
      00FF000000FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000FF000000FF00000000000000000000
      00000000000000000000000000000000000000000030000000FF000000100000
      0000000000000000000000000000000000000000000000000008000000FF0000
      0030000000000000000000000000000000000000000000000000000000000000
      00FF000000FF0000000000000000000000000000000000000000000000000000
      00FF000000FF000000000000000000000000000000FF000000FF000000FF0000
      0000000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF00000000000000FF000000FF000000FF0000000000000000000000000000
      0000000000000000000000000000000000FF000000FF00000000000000000000
      000000000000000000000000000000000000000000FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00FF000000300000000000000000000000C70000000000000000000000000000
      000000000000000000FF000000FF0000000000000000000000FF000000FF0000
      0000000000FF000000000000000000000000000000DF000000FF000000FF0000
      0000000000FF000000AF00000000000000000000000000000000000000AF0000
      00FF00000000000000FF000000FF000000EF0000000000000000000000000000
      0000000000000000000000000000000000FF000000FF00000000000000000000
      000000000000000000000000000000000000000000FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00FF000000BF0000000000000000000000FF0000000000000000000000000000
      000000000000000000FF000000FF0000000000000000000000FF000000FF0000
      0000000000FF00000000000000000000000000000000000000FF000000FF0000
      000000000020000000FF000000FF000000FF000000FF000000FF000000FF0000
      002000000000000000FF000000FF000000000000000000000000000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF0000000000000000000000FF00000000000000000000
      00FF000000FF000000FF000000FF000000FF000000FF00000000000000000000
      00FF000000FF0000000000000000000000FF0000000000000000000000000000
      0000000000000000000000000000000000FF000000FF00000000000000000000
      0000000000000000000000000000000000000000000000000020000000FF0000
      0030000000000000000000000000000000000000000000000000000000000000
      000000000020000000FF00000030000000000000000000000000000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF0000000000000000000000FF00000000000000000000
      00FF000000FF000000FF000000FF000000FF000000FF00000000000000000000
      00FF000000FF0000000000000000000000FF0000000000000000000000000000
      0000000000000000000000000000000000FF000000FF00000000000000000000
      00000000000000000000000000000000000000000000000000FF000000FF0000
      00FF000000000000000000000000000000FF000000FF00000000000000000000
      0000000000FF000000FF000000FF000000000000000000000000000000000000
      0000000000000000000000000000000000FF000000FF00000000000000000000
      000000000000000000000000000000000000000000FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00FF000000CF0000000000000000000000380000000000000000000000000000
      000000000000000000FF000000FF0000000000000000000000FF000000FF0000
      0000000000FF0000000000000000000000000000000000000020000000FF0000
      00300000000000000000000000FF0000000000000000000000FF000000000000
      000000000020000000FF00000030000000000000000000000000000000000000
      0000000000000000000000000000000000FF000000FF00000000000000000000
      000000000000000000000000000000000000000000FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00FF000000300000000000000000000000000000000000000000000000000000
      000000000000000000FF000000FF0000000000000000000000FF000000FF0000
      0000000000FF0000000000000000000000000000000000000000000000000000
      00000000000000000000000000FF0000000000000000000000FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000FF000000FF00000000000000000000
      00000000000000000000000000000000000000000030000000FF000000100000
      0000000000000000000000000000000000000000000000000008000000FF0000
      0030000000000000000000000000000000000000000000000000000000000000
      00FF000000FF0000000000000000000000000000000000000000000000000000
      00FF000000FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000FF000000FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000FF000000FF00000000000000000000
      00000000000000000000000000000000000000000000000000FF000000FF0000
      00000000000000000000000000000000000000000000000000FF000000FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      00FF000000FF00000000000000000000000000000000000000FF000000FF0000
      00FF000000FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000FF000000FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000280000
      00FF000000FF000000FF000000FF000000FF000000FF00000030000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0028000000CF000000FF000000FF000000D70000003000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFF00000000F81FE18700000000
      F00FC18300000000E3C79DB900000000C3C39C390000000098199FF900000000
      99999FF90000000093D980010000000093C9800100000000818187E100000000
      8811C00300000000C663DFF700000000E667C67100000000F00FDE3700000000
      F81FFE7F00000000FFFFFFFF00000000FFFFFFFFFFFFFFFFFFFFE07FFFFFFFFF
      FE7FC03FFFFFFFFFFE7F9F9FE787FFFFFE7F1F8FE7E71008FE7F7FE6F99713C8
      FE7F7FE6F9979009C0036066FE7F8FF1C0036066FE7F8E71FE7F7FE6F9978DB1
      FE7F7FE7F997FDBFFE7F1F8FE7E7FE7FFE7F9F9FE787FFFFFE7FC03FFFFFFFFF
      FFFFE07FFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 50
    Left = 972
    Top = 26
  end
end
