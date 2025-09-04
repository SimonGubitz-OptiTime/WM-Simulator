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
    ActivePage = SpielSheet
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
        Top = 54
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
        Left = 975
        Top = 54
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
        Left = 975
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
        Left = 975
        Top = 338
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
        Left = 975
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
        Left = 975
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
        ImageIndex = 1
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
      494C010105000800040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
      001000000080000000FF000000FF0000000000000000000000FF000000FF0000
      0080000000100000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000009F0000
      00FF000000FF000000FF000000FF0000000000000000000000FF000000FF0000
      00FF000000FF000000AF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000FF000000FF0000
      00000000000000000000000000FF0000000000000000000000FF000000000000
      000000000000000000FF000000FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000FF000000FF0000
      00000000000000000000000000FF000000FF000000FF000000FF000000000000
      000000000000000000FF000000FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000FF000000FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000FF000000FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000FF000000FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000FF000000FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000FF000000FF0000
      00100000006F000000FF000000FF000000FF000000FF000000FF000000FF0000
      006F00000010000000FF000000FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000FF000000FF0000
      00FF0000009F0000000000000000000000000000000000000000000000000000
      009F000000FF000000FF000000FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000008F0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF0000009F00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000EF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000EF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000FF0000
      00EF000000100000000000000000000000EF0000001000000000000000000000
      0000000000FF000000EF00000010000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000DF0000
      0000000000000000000000000000000000FF000000FF00000020000000000000
      0000000000DF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000030000000CF000000FF000000FF000000BF000000400000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000FF000000FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000020000000FF000000FF000000FF000000FF000000FF000000FF0000
      0040000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000FF000000FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00FF000000FF00000000000000000000000000000000000000FF000000FF0000
      00FF000000FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00FF000000FF000000FF00000000000000000000000000000000000000FF0000
      00FF000000FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000FF000000FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00FF000000FF0000000000000000000000000000000000000000000000000000
      00FF000000FF000000000000000000000000000000FF000000FF000000FF0000
      0000000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF00000000000000FF000000FF000000FF0000000000000000000000400000
      00FF000000FF000000FF00000000000000000000000000000000000000FF0000
      00FF000000FF0000002000000000000000000000000000000000000000000000
      0000000000000000000000000000000000FF000000FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000FF000000FF0000000000000000000000FF000000FF0000
      0000000000FF000000000000000000000000000000DF000000FF000000FF0000
      0000000000FF000000AF00000000000000000000000000000000000000AF0000
      00FF00000000000000FF000000FF000000EF0000000000000040000000FF0000
      000000000000000000FF000000FF000000FF000000FF000000FF000000FF0000
      000000000000000000FF00000030000000000000000000000000000000000000
      0000000000000000000000000000000000FF000000FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000FF000000FF0000000000000000000000FF000000FF0000
      0000000000FF00000000000000000000000000000000000000FF000000FF0000
      000000000020000000FF000000FF000000FF000000FF000000FF000000FF0000
      002000000000000000FF000000FF0000000000000000000000BF000000FF0000
      000000000000000000FF0000009F00000000000000000000009F000000FF0000
      000000000000000000FF000000CF000000000000000000000000000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000FF000000FF00000000000000000000
      0000000000000000000000000000000000000000000000000020000000FF0000
      0030000000000000000000000000000000000000000000000000000000000000
      000000000020000000FF000000300000000000000000000000FF000000FF0000
      000000000010000000FF00000000000000000000000000000000000000FF0000
      000000000000000000FF000000FF000000000000000000000000000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000FF000000FF00000000000000000000
      00000000000000000000000000000000000000000000000000FF000000FF0000
      00FF000000000000000000000000000000FF000000FF00000000000000000000
      0000000000FF000000FF000000FF0000000000000000000000FF000000FF0000
      0000000000AF0000009F000000000000000000000000000000000000009F0000
      00AF00000000000000FF000000FF000000000000000000000000000000000000
      0000000000000000000000000000000000FF000000FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000FF000000FF0000000000000000000000FF000000FF0000
      0000000000FF0000000000000000000000000000000000000020000000FF0000
      00300000000000000000000000FF0000000000000000000000FF000000000000
      000000000020000000FF000000300000000000000000000000CF000000FF0000
      00FF000000DF000000FF000000FF0000000000000000000000FF000000FF0000
      00DF000000FF000000FF000000BF000000000000000000000000000000000000
      0000000000000000000000000000000000FF000000FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000FF000000FF0000000000000000000000FF000000FF0000
      0000000000FF0000000000000000000000000000000000000000000000000000
      00000000000000000000000000FF0000000000000000000000FF000000000000
      0000000000000000000000000000000000000000000000000030000000FF0000
      0080000000000000008F000000FF000000EF000000EF000000FF0000008F0000
      00000000006F000000FF00000040000000000000000000000000000000000000
      0000000000000000000000000000000000FF000000FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00FF000000FF0000000000000000000000000000000000000000000000000000
      00FF000000FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000FF000000FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000200000
      00FF000000200000000000000000000000FF000000FF00000000000000000000
      0020000000FF0000004000000000000000000000000000000000000000000000
      0000000000000000000000000000000000FF000000FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00FF000000FF00000000000000000000000000000000000000FF000000FF0000
      00FF000000FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00FF000000FF0000000000000000000000FF000000FF00000000000000000000
      00FF000000FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000FF000000FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000040000000FF000000FF000000FF000000FF000000FF000000FF0000
      0020000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000040000000BF000000FF000000FF000000CF000000300000
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
      000000000000000000000000FFFFFF00FFFF000000000000E187000000000000
      C1830000000000009DB90000000000009C390000000000009FF9000000000000
      9FF90000000000008001000000000000800100000000000087E1000000000000
      C003000000000000DFF7000000000000C671000000000000DE37000000000000
      FE7F000000000000FFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF81F
      FE7FFFFFFFFFF00FFE7FE787FFFFE3C7FE7FE7E71008C3C3FE7FF99713C89819
      FE7FF99790099999C003FE7F8FF193D9C003FE7F8E7193C9FE7FF9978DB18181
      FE7FF997FDBF8811FE7FE7E7FE7FC663FE7FE787FFFFE667FE7FFFFFFFFFF00F
      FFFFFFFFFFFFF81FFFFFFFFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 50
    Left = 972
    Top = 26
  end
end
