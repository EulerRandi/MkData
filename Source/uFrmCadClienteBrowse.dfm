object FrmCadClienteBrowse: TFrmCadClienteBrowse
  Left = 0
  Top = 0
  Caption = 'Clientes'
  ClientHeight = 637
  ClientWidth = 897
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  TextHeight = 15
  object PnlFilter: TPanel
    Left = 0
    Top = 0
    Width = 897
    Height = 89
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object GroupBox1: TGroupBox
      Left = 0
      Top = 0
      Width = 897
      Height = 89
      Align = alClient
      Caption = ' Filtro '
      TabOrder = 0
      ExplicitLeft = 112
      ExplicitTop = 8
      ExplicitWidth = 185
      ExplicitHeight = 105
      object LblFiltroNome: TLabel
        Left = 27
        Top = 37
        Width = 33
        Height = 15
        Caption = 'Nome'
      end
      object EdtFiltroNome: TEdit
        Left = 72
        Top = 34
        Width = 257
        Height = 23
        TabOrder = 0
        OnChange = EdtFiltroNomeChange
      end
      object RdgFiltroAtivos: TRadioGroup
        Left = 376
        Top = 12
        Width = 249
        Height = 57
        Caption = 'Ativos'
        Columns = 3
        ItemIndex = 0
        Items.Strings = (
          'Ambos'
          'Ativos'
          'Desativos')
        TabOrder = 1
        OnClick = RdgFiltroAtivosClick
      end
    end
  end
  object PnlAction: TPanel
    Left = 0
    Top = 600
    Width = 897
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitTop = 599
    ExplicitWidth = 893
    object BtnIncluir: TBitBtn
      Left = 296
      Top = 6
      Width = 75
      Height = 25
      Caption = '&Incluir'
      TabOrder = 0
      OnClick = BtnIncluirClick
    end
    object BtnAlterar: TBitBtn
      Left = 376
      Top = 6
      Width = 75
      Height = 25
      Caption = '&Alterar'
      TabOrder = 1
      OnClick = BtnAlterarClick
    end
    object BtnClose: TBitBtn
      Left = 816
      Top = 6
      Width = 75
      Height = 25
      Caption = '&Fechar'
      TabOrder = 2
      OnClick = BtnCloseClick
    end
    object BtnExcluir: TButton
      Left = 457
      Top = 6
      Width = 75
      Height = 25
      Caption = '&Excluir'
      TabOrder = 3
      OnClick = BtnExcluirClick
    end
  end
  object PnlBackGround: TPanel
    Left = 0
    Top = 89
    Width = 897
    Height = 511
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitTop = 41
    ExplicitWidth = 893
    ExplicitHeight = 558
    object LblTelefones: TLabel
      Left = 0
      Top = 241
      Width = 897
      Height = 15
      Align = alBottom
      Caption = 'Telefones'
      ExplicitTop = 289
      ExplicitWidth = 49
    end
    object LblEndereco: TLabel
      Left = 0
      Top = 376
      Width = 897
      Height = 15
      Align = alBottom
      Caption = 'Endere'#231'os'
      ExplicitTop = 424
      ExplicitWidth = 54
    end
    object DBGClient: TDBGrid
      Left = 0
      Top = 0
      Width = 897
      Height = 241
      Align = alClient
      DataSource = DsCliente
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'id'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'nome'
          Width = 374
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CalcTipoPessoa'
          Title.Caption = 'Tipo Pessoa'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'cpfCnpj'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'rgIe'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'dataCadastro'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CalcAtivo'
          Title.Caption = 'Ativo'
          Visible = True
        end>
    end
    object DBGrid1: TDBGrid
      Left = 0
      Top = 256
      Width = 897
      Height = 120
      Align = alBottom
      DataSource = DsTelefone
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'ddd'
          Title.Caption = 'DDD'
          Width = 40
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'telefone'
          Title.Caption = 'Telefone'
          Width = 90
          Visible = True
        end>
    end
    object DBGrid2: TDBGrid
      Left = 0
      Top = 391
      Width = 897
      Height = 120
      Align = alBottom
      DataSource = DsEndereco
      TabOrder = 2
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'cep'
          Title.Caption = 'CEP'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'logradouro'
          Title.Caption = 'Logradouro'
          Width = 188
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'numero'
          Title.Caption = 'N'#250'mero'
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'complemento'
          Title.Caption = 'Complemento'
          Width = 163
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'bairro'
          Title.Caption = 'Bairro'
          Width = 140
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'cidade'
          Title.Caption = 'Cidade'
          Width = 132
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'uf'
          Title.Caption = 'UF'
          Width = 25
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'pais'
          Title.Caption = 'Pa'#237's'
          Width = 100
          Visible = True
        end>
    end
  end
  object QryCliente: TFDQuery
    OnCalcFields = QryClienteCalcFields
    Connection = DM.Connection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    SQL.Strings = (
      'SELECT * FROM CLIENTE')
    Left = 600
    Top = 89
    object QryClienteid: TFDAutoIncField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object QryClientenome: TStringField
      DisplayLabel = 'Nome / Raz'#227'o Social'
      FieldName = 'nome'
      Origin = 'nome'
      Required = True
      Size = 100
    end
    object QryClientetipoPessoa: TIntegerField
      DisplayLabel = 'Tipo Pessoa'
      FieldName = 'tipoPessoa'
      Origin = 'tipoPessoa'
      Required = True
    end
    object QryClientecpfCnpj: TStringField
      DisplayLabel = 'CPF / CNPJ'
      FieldName = 'cpfCnpj'
      Origin = 'cpfCnpj'
      Required = True
      Size = 18
    end
    object QryClientergIe: TStringField
      DisplayLabel = 'RG / IE'
      FieldName = 'rgIe'
      Origin = 'rgIe'
      Required = True
    end
    object QryClientedataCadastro: TDateField
      DisplayLabel = 'Data Cadastro'
      FieldName = 'dataCadastro'
      Origin = 'dataCadastro'
      Required = True
    end
    object QryClienteativo: TIntegerField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Ativo'
      FieldName = 'ativo'
      Origin = 'ativo'
    end
    object QryClienteCalcTipoPessoa: TStringField
      FieldKind = fkCalculated
      FieldName = 'CalcTipoPessoa'
      Size = 8
      Calculated = True
    end
    object QryClienteCalcAtivo: TStringField
      FieldKind = fkCalculated
      FieldName = 'CalcAtivo'
      Size = 3
      Calculated = True
    end
  end
  object DsCliente: TDataSource
    AutoEdit = False
    DataSet = QryCliente
    Left = 688
    Top = 89
  end
  object DsTelefone: TDataSource
    AutoEdit = False
    DataSet = QryTelefone
    Left = 696
    Top = 353
  end
  object DsEndereco: TDataSource
    AutoEdit = False
    DataSet = QryEndereco
    Left = 704
    Top = 505
  end
  object QryTelefone: TFDQuery
    IndexFieldNames = 'idCliente'
    MasterSource = DsCliente
    MasterFields = 'id'
    Connection = DM.Connection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    SQL.Strings = (
      'SELECT * FROM TELEFONE')
    Left = 608
    Top = 353
    object QryTelefoneid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object QryTelefoneidCliente: TIntegerField
      FieldName = 'idCliente'
      Origin = 'idCliente'
      Required = True
    end
    object QryTelefoneddd: TStringField
      FieldName = 'ddd'
      Origin = 'ddd'
      Required = True
      Size = 2
    end
    object QryTelefonetelefone: TStringField
      FieldName = 'telefone'
      Origin = 'telefone'
      Required = True
      Size = 10
    end
  end
  object QryEndereco: TFDQuery
    IndexFieldNames = 'idCliente'
    MasterSource = DsCliente
    MasterFields = 'id'
    Connection = DM.Connection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    SQL.Strings = (
      'SELECT * FROM ENDERECO')
    Left = 616
    Top = 505
    object QryEnderecoid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object QryEnderecoidCliente: TIntegerField
      FieldName = 'idCliente'
      Origin = 'idCliente'
      Required = True
    end
    object QryEnderecocep: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'cep'
      Origin = 'cep'
      Size = 9
    end
    object QryEnderecologradouro: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'logradouro'
      Origin = 'logradouro'
      Size = 100
    end
    object QryEndereconumero: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'numero'
      Origin = 'numero'
    end
    object QryEnderecocomplemento: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'complemento'
      Origin = 'complemento'
      Size = 100
    end
    object QryEnderecobairro: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'bairro'
      Origin = 'bairro'
      Size = 50
    end
    object QryEnderecocidade: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'cidade'
      Origin = 'cidade'
      Size = 50
    end
    object QryEnderecouf: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'uf'
      Origin = 'uf'
      Size = 2
    end
    object QryEnderecopais: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'pais'
      Origin = 'pais'
      Size = 50
    end
  end
end
