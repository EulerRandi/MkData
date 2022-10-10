object FrmPrincipal: TFrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Teste - Euler Randi Coelho'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = MainMenu
  Position = poMainFormCenter
  OnClick = MnuCadastroClientesClick
  TextHeight = 15
  object PnlButtons: TPanel
    Left = 0
    Top = 0
    Width = 624
    Height = 41
    Align = alTop
    BevelKind = bkSoft
    BevelOuter = bvNone
    TabOrder = 0
    object BtnClientes: TSpeedButton
      Left = 0
      Top = 0
      Width = 89
      Height = 37
      Align = alLeft
      Caption = ' &Clientes '
      OnClick = MnuCadastroClientesClick
    end
  end
  object MainMenu: TMainMenu
    Left = 112
    Top = 264
    object MnuCadastro: TMenuItem
      Caption = '&Cadastro'
      object MnuCadastroClientes: TMenuItem
        Caption = '&Clientes'
        OnClick = MnuCadastroClientesClick
      end
    end
  end
end
