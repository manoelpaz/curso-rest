inherited FrmUsuarios: TFrmUsuarios
  Caption = 'FrmUsuarios'
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlHeader: TPanel
    inherited lblTitle: TLabel
      Width = 61
      Caption = 'Usu'#225'rios'
      ExplicitWidth = 61
    end
  end
  inherited CardPanel: TCardPanel
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
            Width = 300
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'login'
            Title.Alignment = taCenter
            Title.Caption = 'Login'
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
            FieldName = 'sexo'
            Title.Alignment = taCenter
            Title.Caption = 'Sexo'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'telefone'
            Title.Alignment = taCenter
            Title.Caption = 'Telefone'
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
        ExplicitLeft = -8
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
        object lblLogin: TLabel
          Left = 14
          Top = 64
          Width = 29
          Height = 13
          Caption = 'Login'
        end
        object lblSenha: TLabel
          Left = 220
          Top = 64
          Width = 32
          Height = 13
          Anchors = [akTop, akRight]
          Caption = 'Senha'
        end
        object lblTelefone: TLabel
          Left = 426
          Top = 64
          Width = 44
          Height = 13
          Anchors = [akTop, akRight]
          Caption = 'Telefone'
        end
        object lblSexo: TLabel
          Left = 582
          Top = 64
          Width = 24
          Height = 13
          Anchors = [akTop, akRight]
          Caption = 'Sexo'
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
        object edtLogin: TDBEdit
          Left = 14
          Top = 83
          Width = 200
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          DataField = 'login'
          DataSource = dsCadastro
          TabOrder = 3
        end
        object edtSenha: TDBEdit
          Left = 220
          Top = 83
          Width = 200
          Height = 21
          Anchors = [akTop, akRight]
          DataField = 'senha'
          DataSource = dsCadastro
          PasswordChar = '*'
          TabOrder = 4
        end
        object edtTelefone: TDBEdit
          Left = 426
          Top = 83
          Width = 150
          Height = 21
          Anchors = [akTop, akRight]
          DataField = 'telefone'
          DataSource = dsCadastro
          TabOrder = 5
        end
        object btnAlterarFotoPerfil: TButton
          Left = 15
          Top = 316
          Width = 95
          Height = 25
          Caption = 'Alterar'
          TabOrder = 6
          OnClick = btnAlterarFotoPerfilClick
        end
        object btnLimparFotoPerfil: TButton
          Left = 116
          Top = 316
          Width = 95
          Height = 25
          Caption = 'Limpar'
          TabOrder = 7
          OnClick = btnLimparFotoPerfilClick
        end
        object pnlImage: TPanel
          Left = 15
          Top = 110
          Width = 200
          Height = 200
          BevelInner = bvLowered
          TabOrder = 8
          object imgPerfil: TImage
            Left = 2
            Top = 2
            Width = 196
            Height = 196
            Align = alClient
            Center = True
            Proportional = True
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 200
            ExplicitHeight = 200
          end
        end
        object cmbSexo: TDBComboBox
          Left = 582
          Top = 83
          Width = 155
          Height = 21
          Style = csDropDownList
          DataField = 'sexo'
          DataSource = dsCadastro
          Items.Strings = (
            'Masculino'
            'Feminino')
          TabOrder = 9
        end
      end
    end
  end
  object OpenDialog: TOpenDialog
    Left = 40
    Top = 392
  end
end
