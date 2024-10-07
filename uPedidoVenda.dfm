object frmPedido: TfrmPedido
  Left = 0
  Top = 0
  Caption = 'frmPedido'
  ClientHeight = 521
  ClientWidth = 757
  Color = clWhite
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Roboto Cn'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 19
  object pnlPrincipal: TPanel
    Left = 4
    Top = 1
    Width = 743
    Height = 514
    Align = alCustom
    Anchors = [akLeft, akTop, akBottom]
    BevelOuter = bvNone
    Color = 10395294
    ParentBackground = False
    TabOrder = 0
    object pnlItens: TPanel
      Left = 0
      Top = 185
      Width = 743
      Height = 281
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 2
      Visible = False
      object DBGrid1: TDBGrid
        Left = 0
        Top = 54
        Width = 743
        Height = 227
        Align = alClient
        DataSource = dtsPedidoItens
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgTitleClick, dgTitleHotTrack]
        TabOrder = 0
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -16
        TitleFont.Name = 'Roboto Cn'
        TitleFont.Style = []
        OnColExit = DBGrid1ColExit
        Columns = <
          item
            Expanded = False
            FieldName = 'ItemId'
            ReadOnly = True
            Width = 40
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CodProduto'
            ReadOnly = True
            Width = 60
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DescProduto'
            ReadOnly = True
            Width = 300
            Visible = True
          end
          item
            Color = clMoneyGreen
            Expanded = False
            FieldName = 'Quantidade'
            Visible = True
          end
          item
            Color = clMoneyGreen
            Expanded = False
            FieldName = 'ValorUnitario'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ValorTotal'
            ReadOnly = True
            Visible = True
          end>
      end
      object Panel4: TPanel
        Left = 0
        Top = 0
        Width = 743
        Height = 54
        Align = alTop
        BevelOuter = bvNone
        Color = 10395294
        ParentBackground = False
        TabOrder = 1
        ExplicitTop = -3
        object Label5: TLabel
          Left = 16
          Top = 0
          Width = 51
          Height = 19
          Caption = 'Produto'
        end
        object Label6: TLabel
          Left = 475
          Top = -3
          Width = 74
          Height = 19
          Caption = 'Quantidade'
        end
        object Label8: TLabel
          Left = 78
          Top = 2
          Width = 156
          Height = 14
          Caption = '(Digite o produto para pesquisa)'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Roboto Cn'
          Font.Style = []
          ParentFont = False
        end
        object cb_Produto: TComboBox
          Left = 16
          Top = 18
          Width = 451
          Height = 27
          TabOrder = 0
          OnKeyUp = cb_ProdutoKeyUp
          OnSelect = cb_ProdutoSelect
        end
        object btnIncluirItem: TBitBtn
          AlignWithMargins = True
          Left = 576
          Top = 13
          Width = 74
          Height = 35
          Caption = 'Incluir'
          TabOrder = 1
          OnClick = btnIncluirItemClick
        end
        object edtQtde: TEdit
          Left = 474
          Top = 18
          Width = 79
          Height = 27
          TabOrder = 2
          OnKeyPress = edtQtdeKeyPress
        end
      end
    end
    object Panel3: TPanel
      Left = 0
      Top = 466
      Width = 743
      Height = 48
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 3
      object btnGravar: TBitBtn
        AlignWithMargins = True
        Left = 639
        Top = 6
        Width = 73
        Height = 35
        Caption = 'Gravar'
        TabOrder = 0
        OnClick = btnGravarClick
      end
    end
    object Panel5: TPanel
      Left = 0
      Top = 0
      Width = 743
      Height = 69
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object Label1: TLabel
        Left = 16
        Top = 13
        Width = 64
        Height = 19
        Caption = 'N'#186' Pedido'
      end
      object Bevel2: TBevel
        AlignWithMargins = True
        Left = 10
        Top = 65
        Width = 730
        Height = 1
        Margins.Left = 10
        Align = alBottom
        ExplicitLeft = 0
        ExplicitTop = 114
        ExplicitWidth = 743
      end
      object edtPedido: TEdit
        Left = 16
        Top = 32
        Width = 137
        Height = 27
        Enabled = False
        MaxLength = 10
        TabOrder = 0
        OnKeyDown = edtPedidoKeyDown
        OnKeyPress = SomenteNumero
      end
      object btnNovo: TBitBtn
        AlignWithMargins = True
        Left = 483
        Top = 24
        Width = 73
        Height = 35
        Caption = 'Novo'
        TabOrder = 1
        OnClick = btnNovoClick
      end
      object btnSair: TBitBtn
        AlignWithMargins = True
        Left = 639
        Top = 24
        Width = 73
        Height = 35
        Caption = 'Sair'
        TabOrder = 2
        OnClick = btnSairClick
      end
      object btnCancelar: TBitBtn
        AlignWithMargins = True
        Left = 560
        Top = 24
        Width = 73
        Height = 35
        Caption = 'Limpar'
        TabOrder = 3
        OnClick = btnCancelarClick
      end
    end
    object pnlDados: TPanel
      Left = 0
      Top = 69
      Width = 743
      Height = 116
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      Visible = False
      ExplicitTop = 65
      object Label2: TLabel
        Left = 16
        Top = 2
        Width = 107
        Height = 19
        Caption = 'Data de Emiss'#227'o'
      end
      object Label3: TLabel
        Left = 16
        Top = 57
        Width = 44
        Height = 19
        Caption = 'Cliente'
      end
      object Label4: TLabel
        Left = 576
        Top = 55
        Width = 101
        Height = 19
        Caption = 'Total do Pedido'
      end
      object Bevel1: TBevel
        AlignWithMargins = True
        Left = 10
        Top = 112
        Width = 730
        Height = 1
        Margins.Left = 10
        Align = alBottom
        ExplicitLeft = 0
        ExplicitTop = 114
        ExplicitWidth = 743
      end
      object Label7: TLabel
        Left = 78
        Top = 60
        Width = 149
        Height = 14
        Caption = '(Digite o cliente para pesquisa)'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Roboto Cn'
        Font.Style = []
        ParentFont = False
      end
      object dtpEmissao: TDateTimePicker
        Left = 16
        Top = 24
        Width = 129
        Height = 27
        Date = 45563.000000000000000000
        Time = 0.494950219908787400
        TabOrder = 0
      end
      object cb_Cliente: TComboBox
        Left = 78
        Top = 80
        Width = 475
        Height = 27
        TabOrder = 1
        OnKeyUp = cb_ClienteKeyUp
        OnSelect = cb_ClienteSelect
      end
      object edtCodCliente: TDBEdit
        Left = 16
        Top = 79
        Width = 56
        Height = 27
        DataField = 'CodCliente'
        DataSource = dtsPedido
        TabOrder = 2
        OnExit = edtCodClienteExit
      end
      object DBEdit2: TDBEdit
        Left = 576
        Top = 79
        Width = 121
        Height = 27
        DataField = 'ValorTotal'
        DataSource = dtsPedido
        TabOrder = 3
      end
    end
  end
  object cdsPedido: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 308
    Top = 78
    object cdsPedidoPedidoId: TIntegerField
      FieldName = 'PedidoId'
    end
    object cdsPedidoDataEmissao: TDateTimeField
      FieldName = 'DataEmissao'
    end
    object cdsPedidoCodCliente: TIntegerField
      FieldName = 'CodCliente'
    end
    object cdsPedidoValorTotal: TFloatField
      FieldName = 'ValorTotal'
      DisplayFormat = '#,##0.00'
    end
  end
  object cdsPedidoItens: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 380
    Top = 78
    object cdsPedidoItensItemId: TIntegerField
      DisplayLabel = 'Item'
      FieldName = 'ItemId'
    end
    object cdsPedidoItensCodProduto: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CodProduto'
      Size = 50
    end
    object cdsPedidoItensDescProduto: TStringField
      DisplayLabel = 'Produto'
      FieldName = 'DescProduto'
      Size = 100
    end
    object cdsPedidoItensQuantidade: TIntegerField
      FieldName = 'Quantidade'
    end
    object cdsPedidoItensValorUnitario: TFloatField
      FieldName = 'ValorUnitario'
      DisplayFormat = '#,##0.00'
    end
    object cdsPedidoItensValorTotal: TFloatField
      FieldName = 'ValorTotal'
      DisplayFormat = '#,##0.00'
    end
    object cdsPedidoItensPedidoId: TIntegerField
      FieldName = 'PedidoId'
    end
  end
  object dtsPedidoItens: TDataSource
    DataSet = cdsPedidoItens
    Left = 380
    Top = 126
  end
  object dtsPedido: TDataSource
    DataSet = cdsPedido
    Left = 308
    Top = 126
  end
  object FDQuery1: TFDQuery
    Connection = dmPedido.FDConnection
    Left = 244
    Top = 86
  end
end
