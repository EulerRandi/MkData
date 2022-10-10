object FrmCadCliente: TFrmCadCliente
  Left = 0
  Top = 0
  Caption = 'Cadastro de Cliente'
  ClientHeight = 747
  ClientWidth = 1025
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  TextHeight = 15
  object GrbDadosBasicos: TGroupBox
    Left = 0
    Top = 0
    Width = 1025
    Height = 225
    Align = alTop
    Caption = ' Dados B'#225'sicos '
    TabOrder = 0
    ExplicitWidth = 1021
    object LblCodigo: TLabel
      Left = 5
      Top = 30
      Width = 100
      Height = 15
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'C'#243'digo'
    end
    object LblNome: TLabel
      Left = 72
      Top = 88
      Width = 33
      Height = 15
      Alignment = taRightJustify
      Caption = 'Nome'
    end
    object LblCPF: TLabel
      Left = 5
      Top = 117
      Width = 100
      Height = 15
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'CPF'
    end
    object LblRG: TLabel
      Left = 5
      Top = 146
      Width = 100
      Height = 15
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'RG'
    end
    object LblDataCadastro: TLabel
      Left = 5
      Top = 176
      Width = 100
      Height = 15
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Data Cadastro'
    end
    object LblTipoPessoa: TLabel
      Left = 43
      Top = 59
      Width = 62
      Height = 15
      Alignment = taRightJustify
      Caption = 'Tipo Pessoa'
    end
    object EdtNome: TEdit
      Left = 110
      Top = 85
      Width = 435
      Height = 23
      TabOrder = 2
    end
    object EdtRG: TEdit
      Left = 110
      Top = 143
      Width = 121
      Height = 23
      TabOrder = 4
    end
    object EdtDataCadastro: TDateTimePicker
      Left = 110
      Top = 172
      Width = 186
      Height = 23
      Date = 44838.000000000000000000
      Time = 0.966163923614658400
      TabOrder = 5
    end
    object ChkAtivo: TCheckBox
      Left = 110
      Top = 201
      Width = 97
      Height = 17
      Caption = 'Ativo'
      TabOrder = 6
    end
    object EdtCodigo: TEdit
      Left = 110
      Top = 27
      Width = 121
      Height = 23
      NumbersOnly = True
      ReadOnly = True
      TabOrder = 0
    end
    object CmbTipoPessoa: TComboBox
      Left = 110
      Top = 56
      Width = 145
      Height = 23
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 1
      Text = 'F'#237'sica'
      OnChange = CmbTipoPessoaChange
      Items.Strings = (
        'F'#237'sica'
        'Jur'#237'dica')
    end
    object EdtCPF: TMaskEdit
      Left = 110
      Top = 114
      Width = 120
      Height = 23
      EditMask = '000.000.000-00;1;_'
      MaxLength = 14
      TabOrder = 3
      Text = '   .   .   -  '
    end
  end
  object GrbTelefone: TGroupBox
    Left = 0
    Top = 225
    Width = 1025
    Height = 176
    Align = alTop
    Caption = ' Telefone '
    TabOrder = 1
    ExplicitTop = 224
    object LblDDD: TLabel
      Left = 5
      Top = 30
      Width = 100
      Height = 15
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'DDD'
    end
    object LblTelefone: TLabel
      Left = 149
      Top = 30
      Width = 44
      Height = 15
      Alignment = taRightJustify
      Caption = 'Telefone'
    end
    object EdtDDD: TEdit
      Left = 111
      Top = 27
      Width = 26
      Height = 23
      TabOrder = 0
    end
    object EdtTelefone: TEdit
      Left = 199
      Top = 27
      Width = 121
      Height = 23
      TabOrder = 1
    end
    object LtvTelefone: TListView
      Left = 420
      Top = 27
      Width = 217
      Height = 143
      Columns = <
        item
          Caption = 'DDD'
          Width = 40
        end
        item
          Caption = 'Telefone'
          Width = 150
        end>
      TabOrder = 4
      ViewStyle = vsReport
    end
    object BtnAdicionarTelefone: TButton
      Left = 339
      Top = 29
      Width = 75
      Height = 25
      Caption = '&Adicionar'
      TabOrder = 2
      OnClick = BtnAdicionarTelefoneClick
    end
    object BtnRemoverTelefone: TButton
      Left = 339
      Top = 60
      Width = 75
      Height = 25
      Caption = '&Remover'
      TabOrder = 3
      OnClick = BtnRemoverTelefoneClick
    end
  end
  object PnlAction: TPanel
    Left = 0
    Top = 706
    Width = 1025
    Height = 41
    Align = alBottom
    BevelKind = bkSoft
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitTop = 705
    ExplicitWidth = 1021
    object BtnGravar: TButton
      Left = 608
      Top = 8
      Width = 75
      Height = 25
      Caption = '&Gravar'
      TabOrder = 0
      OnClick = BtnGravarClick
    end
    object BtnCancelar: TButton
      Left = 936
      Top = 8
      Width = 75
      Height = 25
      Caption = '&Cancelar'
      TabOrder = 1
      OnClick = BtnCancelarClick
    end
  end
  object GrbEndereco: TGroupBox
    Left = 0
    Top = 401
    Width = 1025
    Height = 299
    Align = alTop
    Caption = ' Endere'#231'o '
    TabOrder = 3
    ExplicitWidth = 1021
    object LblCEP: TLabel
      Left = 16
      Top = 32
      Width = 21
      Height = 15
      Caption = 'CEP'
    end
    object LblLogradouro: TLabel
      Left = 16
      Top = 64
      Width = 62
      Height = 15
      Caption = 'Logradouro'
    end
    object Label12: TLabel
      Left = 401
      Top = 64
      Width = 44
      Height = 15
      Caption = 'N'#250'mero'
    end
    object LblComplemento: TLabel
      Left = 16
      Top = 90
      Width = 77
      Height = 15
      Caption = 'Complemento'
    end
    object LblBairro: TLabel
      Left = 16
      Top = 127
      Width = 31
      Height = 15
      Caption = 'Bairro'
    end
    object LblCidade: TLabel
      Left = 344
      Top = 127
      Width = 37
      Height = 15
      Caption = 'Cidade'
    end
    object Lbl: TLabel
      Left = 16
      Top = 151
      Width = 35
      Height = 15
      Caption = 'Estado'
    end
    object Label17: TLabel
      Left = 360
      Top = 151
      Width = 21
      Height = 15
      Caption = 'Pa'#237's'
    end
    object EdtCEP: TMaskEdit
      Left = 97
      Top = 32
      Width = 120
      Height = 23
      EditMask = '00000\-999;1;_'
      MaxLength = 9
      TabOrder = 0
      Text = '     -   '
    end
    object BtnPesquisarCEP: TButton
      Left = 221
      Top = 32
      Width = 75
      Height = 23
      Caption = 'Pesquisar'
      TabOrder = 1
      OnClick = BtnPesquisarCEPClick
    end
    object EdtLogradouro: TEdit
      Left = 97
      Top = 61
      Width = 300
      Height = 23
      TabOrder = 2
    end
    object EdtNumero: TEdit
      Left = 451
      Top = 61
      Width = 121
      Height = 23
      TabOrder = 3
    end
    object EdtComplemento: TEdit
      Left = 99
      Top = 90
      Width = 473
      Height = 23
      TabOrder = 4
    end
    object EdtBairro: TEdit
      Left = 99
      Top = 119
      Width = 121
      Height = 23
      TabOrder = 5
    end
    object EdtCidade: TEdit
      Left = 392
      Top = 119
      Width = 180
      Height = 23
      TabOrder = 7
    end
    object EdtPais: TEdit
      Left = 392
      Top = 148
      Width = 180
      Height = 23
      TabOrder = 8
    end
    object LtvEndereco: TListView
      Left = 2
      Top = 186
      Width = 1021
      Height = 111
      Align = alBottom
      Columns = <
        item
          Caption = 'CEP'
          Width = 90
        end
        item
          Caption = 'Logradouro'
          Width = 300
        end
        item
          Caption = 'N'#250'mero'
          Width = 60
        end
        item
          Caption = 'Complemento'
          Width = 300
        end
        item
          Caption = 'Bairro'
          Width = 150
        end
        item
          Caption = 'Cidade'
          Width = 150
        end
        item
          Caption = 'Estado'
        end
        item
          Caption = 'Pa'#237's'
          Width = 150
        end>
      TabOrder = 11
      ViewStyle = vsReport
      ExplicitWidth = 1017
    end
    object BtnAdicionarCEP: TButton
      Left = 610
      Top = 144
      Width = 75
      Height = 25
      Caption = 'A&dicionar'
      TabOrder = 9
      OnClick = BtnAdicionarCEPClick
    end
    object BtnRemoverCEP: TButton
      Left = 691
      Top = 144
      Width = 75
      Height = 25
      Caption = 'R&emover'
      TabOrder = 10
      OnClick = BtnRemoverCEPClick
    end
    object EdtEstado: TEdit
      Left = 99
      Top = 148
      Width = 121
      Height = 23
      TabOrder = 6
    end
  end
end
