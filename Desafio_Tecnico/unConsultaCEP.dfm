object frmConsultaCEP: TfrmConsultaCEP
  Left = 0
  Top = 0
  Caption = 'Consulta de CEP'
  ClientHeight = 620
  ClientWidth = 967
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnClose = FormClose
  OnCreate = FormCreate
  TextHeight = 15
  object lblCEP: TLabel
    Left = 32
    Top = 19
    Width = 24
    Height = 15
    Caption = 'CEP:'
  end
  object lblRua: TLabel
    Left = 32
    Top = 45
    Width = 23
    Height = 15
    Caption = 'Rua:'
  end
  object lblComplemento: TLabel
    Left = 32
    Top = 77
    Width = 80
    Height = 15
    Caption = 'Complemento:'
  end
  object lblBairro: TLabel
    Left = 32
    Top = 106
    Width = 34
    Height = 15
    Caption = 'Bairro:'
  end
  object lblCidade: TLabel
    Left = 32
    Top = 135
    Width = 40
    Height = 15
    Caption = 'Cidade:'
  end
  object lblEstado: TLabel
    Left = 32
    Top = 161
    Width = 38
    Height = 15
    Caption = 'Estado:'
  end
  object btnCarregar: TBitBtn
    Left = 639
    Top = 31
    Width = 75
    Height = 25
    Caption = 'Carregar'
    TabOrder = 0
    OnClick = btnCarregarClick
  end
  object edtCEP: TEdit
    Left = 128
    Top = 16
    Width = 121
    Height = 23
    TabOrder = 1
  end
  object rgTipoResult: TRadioGroup
    Left = 753
    Top = 16
    Width = 185
    Height = 105
    Caption = 'Tipo Retorno'
    ItemIndex = 0
    Items.Strings = (
      '1 - Json'
      '2 - XML')
    TabOrder = 2
  end
  object btnSalvar: TBitBtn
    Left = 639
    Top = 62
    Width = 75
    Height = 25
    Caption = 'Salvar'
    TabOrder = 3
    OnClick = btnSalvarClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 192
    Width = 967
    Height = 428
    Align = alBottom
    Caption = 'Panel1'
    TabOrder = 4
    ExplicitTop = 191
    ExplicitWidth = 963
    object mmoResultRaw: TMemo
      Left = 1
      Top = 1
      Width = 965
      Height = 426
      Align = alClient
      ReadOnly = True
      TabOrder = 0
      ExplicitWidth = 961
    end
  end
  object edtRua: TEdit
    Left = 128
    Top = 45
    Width = 297
    Height = 23
    TabOrder = 5
  end
  object edtComplemento: TEdit
    Left = 128
    Top = 74
    Width = 121
    Height = 23
    TabOrder = 6
  end
  object edtBairro: TEdit
    Left = 128
    Top = 103
    Width = 297
    Height = 23
    TabOrder = 7
  end
  object edtCidade: TEdit
    Left = 128
    Top = 132
    Width = 297
    Height = 23
    TabOrder = 8
  end
  object edtEstado: TEdit
    Left = 128
    Top = 161
    Width = 297
    Height = 23
    TabOrder = 9
  end
end
