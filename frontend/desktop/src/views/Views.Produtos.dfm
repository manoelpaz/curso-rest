inherited FrmProdutos: TFrmProdutos
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlHeader: TPanel
    inherited lblTitle: TLabel
      Width = 63
      Caption = 'Produtos'
      ExplicitWidth = 63
    end
  end
  inherited CardPanel: TCardPanel
    ActiveCard = CardCadastro
    inherited CardVisualizar: TCard
      inherited DBGrid: TDBGrid
        Columns = <
          item
            Expanded = False
            FieldName = 'id'
            Title.Alignment = taCenter
            Title.Caption = 'C'#243'digo'
            Width = 85
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nome'
            Title.Caption = 'Nome'
            Width = 350
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'valor'
            Title.Alignment = taCenter
            Title.Caption = 'Valor'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'status'
            Title.Alignment = taCenter
            Title.Caption = 'Status'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'estoque'
            Title.Alignment = taCenter
            Title.Caption = 'Estoque'
            Width = 100
            Visible = True
          end>
      end
      inherited pnlFiltros: TPanel
        object lblPesquisaCodigo: TLabel
          Left = 10
          Top = 10
          Width = 38
          Height = 13
          Caption = 'C'#243'digo'
        end
        object lblPesquisaNome: TLabel
          Left = 76
          Top = 10
          Width = 30
          Height = 13
          Caption = 'Nome'
        end
        object edtPesquisaCodigo: TEdit
          Left = 10
          Top = 29
          Width = 60
          Height = 21
          Alignment = taRightJustify
          NumbersOnly = True
          TabOrder = 0
        end
        object edtPesquisaNome: TEdit
          Left = 76
          Top = 29
          Width = 700
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 1
        end
      end
    end
    inherited CardCadastro: TCard
      inherited pnlCadastro: TPanel
        ExplicitTop = -2
        object lblCodigo: TLabel
          Left = 14
          Top = 18
          Width = 38
          Height = 13
          Caption = 'C'#243'digo'
        end
        object lblNome: TLabel
          Left = 80
          Top = 18
          Width = 30
          Height = 13
          Caption = 'Nome'
        end
        object lblValor: TLabel
          Left = 14
          Top = 64
          Width = 26
          Height = 13
          Caption = 'Valor'
        end
        object lblEstoque: TLabel
          Left = 120
          Top = 64
          Width = 42
          Height = 13
          Caption = 'Estoque'
        end
        object edtCodigo: TDBEdit
          Left = 14
          Top = 37
          Width = 60
          Height = 21
          DataField = 'id'
          DataSource = dsCadastro
          Enabled = False
          TabOrder = 0
        end
        object edtNome: TDBEdit
          Left = 80
          Top = 37
          Width = 605
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          DataField = 'nome'
          DataSource = dsCadastro
          TabOrder = 1
        end
        object ckbStatus: TDBCheckBox
          Left = 691
          Top = 39
          Width = 97
          Height = 17
          Anchors = [akTop, akRight]
          Caption = 'Ativo?'
          DataField = 'status'
          DataSource = dsCadastro
          TabOrder = 2
          ValueChecked = '1'
          ValueUnchecked = '0'
        end
        object edtValor: TDBEdit
          Left = 14
          Top = 83
          Width = 100
          Height = 21
          DataField = 'valor'
          DataSource = dsCadastro
          TabOrder = 3
        end
        object edtEstoque: TDBEdit
          Left = 120
          Top = 83
          Width = 100
          Height = 21
          DataField = 'estoque'
          DataSource = dsCadastro
          TabOrder = 4
        end
      end
    end
  end
end
