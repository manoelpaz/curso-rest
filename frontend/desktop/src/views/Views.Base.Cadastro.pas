unit Views.Base.Cadastro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Views.Base, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.WinXPanels, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons,
  Services.Base.Cadastro;

type
  TFrmBaseCadastro = class(TFrmBase)
    pnlHeader: TPanel;
    lblTitle: TLabel;
    CardPanel: TCardPanel;
    CardVisualizar: TCard;
    CardCadastro: TCard;
    pnlBotoes: TPanel;
    btnIncluir: TSpeedButton;
    btnPesquisar: TSpeedButton;
    btnExcluir: TSpeedButton;
    btnAlterar: TSpeedButton;
    pnlFooter: TPanel;
    DBGrid: TDBGrid;
    pnlFiltros: TPanel;
    Shape1: TShape;
    Shape2: TShape;
    dsPesquisa: TDataSource;
    pnlCadastro: TPanel;
    pnlFooterCadastro: TPanel;
    btnConfirmar: TSpeedButton;
    btnCancelar: TSpeedButton;
    dsCadastro: TDataSource;
    btnPrimeiro: TSpeedButton;
    btnAnterior: TSpeedButton;
    btnProximo: TSpeedButton;
    btnUltimo: TSpeedButton;
    lblPagina: TLabel;
    pnlRegistros: TPanel;
    cmbRegistros: TComboBox;
    lblRegistros: TLabel;
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure dsCadastroStateChange(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGridDblClick(Sender: TObject);
    procedure btnPrimeiroClick(Sender: TObject);
    procedure btnAnteriorClick(Sender: TObject);
    procedure btnUltimoClick(Sender: TObject);
    procedure btnProximoClick(Sender: TObject);
    procedure cmbRegistrosChange(Sender: TObject);
    procedure dsCadastroDataChange(Sender: TObject; Field: TField);
  private
    function GetPageLimit: Integer;
    procedure CalcularPaginacao;
    procedure ListarRegistros;
  protected
    FService: TServiceBaseCadastro;
    procedure DoBeforeList; virtual;
  end;

implementation

{$R *.dfm}

procedure TFrmBaseCadastro.btnAlterarClick(Sender: TObject);
begin
  inherited;
  FService.Alterar;
end;

procedure TFrmBaseCadastro.btnAnteriorClick(Sender: TObject);
begin
  inherited;

  if (FService.Page = 1) then
    Exit;

  FService.Page := FService.Page - 1;
  ListarRegistros;
end;

procedure TFrmBaseCadastro.btnCancelarClick(Sender: TObject);
begin
  inherited;
  dsCadastro.DataSet.Cancel;
end;

procedure TFrmBaseCadastro.btnConfirmarClick(Sender: TObject);
begin
  inherited;
  pnlFooterCadastro.SetFocus;
  FService.Salvar;
end;

procedure TFrmBaseCadastro.btnExcluirClick(Sender: TObject);
begin
  inherited;
  FService.Excluir;
end;

procedure TFrmBaseCadastro.btnIncluirClick(Sender: TObject);
begin
  inherited;
  FService.Incluir;
end;

procedure TFrmBaseCadastro.btnPesquisarClick(Sender: TObject);
begin
  inherited;
  ListarRegistros;
end;

procedure TFrmBaseCadastro.btnPrimeiroClick(Sender: TObject);
begin
  inherited;

  if (FService.Page = 1) then
    Exit;

  FService.Page := 1;
  ListarRegistros;
end;

procedure TFrmBaseCadastro.btnProximoClick(Sender: TObject);
begin
  inherited;

  if (FService.Page = FService.Pages) then
    Exit;

  FService.Page := FService.Page + 1;
  ListarRegistros;
end;

procedure TFrmBaseCadastro.btnUltimoClick(Sender: TObject);
begin
  inherited;

  if (FService.Page = FService.Pages) then
    Exit;

  FService.Page := FService.Pages;
  ListarRegistros;

end;

procedure TFrmBaseCadastro.CalcularPaginacao;
var
  LTotalPaginas: Double;

begin
  if (FService.Page <= 0) then
    FService.Page := 1;

  LTotalPaginas := (FService.Records / GetPageLimit);
  FService.Pages := Trunc(LTotalPaginas);

  if ((LTotalPaginas - FService.Pages) > 0) or (FService.Pages = 0) then
    FService.Pages := FService.Pages + 1;

end;

procedure TFrmBaseCadastro.cmbRegistrosChange(Sender: TObject);
begin
  inherited;
  FService.PageLimit := GetPageLimit;
  FService.Page := 1;
  ListarRegistros;
end;

procedure TFrmBaseCadastro.DBGridDblClick(Sender: TObject);
begin
  inherited;
  btnAlterar.Click;
end;

procedure TFrmBaseCadastro.DoBeforeList;
begin

end;

procedure TFrmBaseCadastro.dsCadastroDataChange(Sender: TObject; Field: TField);
//var
//  i: Integer;
//  LComponent: TComponent;
//
begin
//  inherited;
//
//  if (dsCadastro.DataSet.State in dsEditModes) then begin
//    for i := 0 to pnlCadastro.ComponentCount - 1 do begin
//      if LComponent is TEdit then begin
//        if TEdit(LComponent).Enabled then begin
//          TEdit(LComponent).SetFocus;
//          Exit;
//        end;
//      end;
//    end;
//  end;
end;

procedure TFrmBaseCadastro.dsCadastroStateChange(Sender: TObject);
begin
  inherited;

  if (dsCadastro.DataSet.State in dsEditModes) then
    CardCadastro.Show
  else
    CardVisualizar.Show;
end;

procedure TFrmBaseCadastro.FormDestroy(Sender: TObject);
begin
  if Assigned(FService) then
    FService.Free;
  inherited;
end;

procedure TFrmBaseCadastro.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_INSERT:
      if CardVisualizar.Visible then
        btnIncluir.Click;
    VK_F3:
      if CardVisualizar.Visible then
        btnAlterar.Click;
    VK_DELETE:
      if CardVisualizar.Visible then
        btnExcluir.Click;
    VK_F5:
      if CardVisualizar.Visible then
        btnPesquisar.Click;
    VK_F2:
      if CardCadastro.Visible then
        btnConfirmar.Click;
    VK_F4:
      if CardCadastro.Visible then
        btnCancelar.Click;
  end;
end;

procedure TFrmBaseCadastro.FormShow(Sender: TObject);
//var
//  i: Integer;
//  LComponent: TComponent;

begin
  inherited;
  dsPesquisa.DataSet := FService.mtPesquisa;
  dsCadastro.DataSet := FService.mtCadastro;
  CardVisualizar.Show;

//  for i := 0 to pnlFiltros.ComponentCount - 1 do begin
//    if LComponent is TEdit then begin
//      if TEdit(LComponent).Enabled then begin
//        TEdit(LComponent).SetFocus;
//        Exit;
//      end;
//    end;
//  end;
end;

function TFrmBaseCadastro.GetPageLimit: Integer;
begin
  Result := StrToIntDef(cmbRegistros.Text, 50);
end;

procedure TFrmBaseCadastro.ListarRegistros;
begin
  DoBeforeList;
  FService.ListarRegistro;
  CalcularPaginacao;
  lblPagina.Caption := Format('Pagina %d de %d', [FService.Page, FService.Pages]);
end;

end.