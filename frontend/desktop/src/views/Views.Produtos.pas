unit Views.Produtos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Views.Base.Cadastro, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.WinXPanels, Services.Produtos, Vcl.DBCtrls, Vcl.Mask;

type
  TFrmProdutos = class(TFrmBaseCadastro)
    lblPesquisaCodigo: TLabel;
    lblPesquisaNome: TLabel;
    edtPesquisaCodigo: TEdit;
    edtPesquisaNome: TEdit;
    lblCodigo: TLabel;
    lblNome: TLabel;
    edtCodigo: TDBEdit;
    edtNome: TDBEdit;
    ckbStatus: TDBCheckBox;
    lblValor: TLabel;
    edtValor: TDBEdit;
    lblEstoque: TLabel;
    edtEstoque: TDBEdit;
    procedure dsCadastroStateChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  protected
    procedure DoBeforeList; override;
  end;

implementation

{$R *.dfm}

procedure TFrmProdutos.DoBeforeList;
begin
  inherited;
  FService.Request
    .ClearParams
    .AddParam('id', edtPesquisaCodigo.Text)
    .AddParam('nome', edtPesquisaNome.Text);
end;

procedure TFrmProdutos.dsCadastroStateChange(Sender: TObject);
begin
  inherited;
  if (dsCadastro.DataSet.State in dsEditModes) then
    edtNome.SetFocus;
end;

procedure TFrmProdutos.FormCreate(Sender: TObject);
begin
  inherited;
  FService := TServiceProdutos.Create(Self);
end;

procedure TFrmProdutos.FormShow(Sender: TObject);
begin
  inherited;
  edtPesquisaCodigo.SetFocus;
end;

end.
