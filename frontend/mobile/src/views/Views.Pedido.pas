unit Views.Pedido;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, Data.DB,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, Providers.Frames.Base.View, FMX.Layouts,
  FMX.Objects, FMX.TabControl, FMX.Controls.Presentation, Services.Pedido, Providers.Frames.Pedido, Providers.Aguarde,
  Views.Consulta.Cliente, Views.Consulta.Produto, Providers.Frames.Pedido.Item;

type
  TFrmPedido = class(TFrameBaseView)
    retContentConsulta: TRectangle;
    tabControlPedido: TTabControl;
    tabConsulta: TTabItem;
    tabCadastro: TTabItem;
    retContentCadastro: TRectangle;
    btnAdicionarVenda: TButton;
    imgAdicionarVenda: TPath;
    vsbPedidos: TVertScrollBox;
    lytNenhumaVenda: TLayout;
    txtNenhumaVenda: TLabel;
    imgLogo: TPath;
    retHeaderCadastro: TRectangle;
    btnVoltar: TButton;
    imgVoltar: TPath;
    btnAdicionarProduto: TButton;
    imgAdicionarProduto: TPath;
    lineSeparatorHeader: TLine;
    lytContentCliente: TLayout;
    lytCliente: TLayout;
    lblNomeCliente: TLabel;
    txtNomeCliente: TLabel;
    btnBuscaCliente: TButton;
    imgBuscaCliente: TPath;
    vsbProdutos: TVertScrollBox;
    lytTotalVenda: TLayout;
    txtTotalVenda: TLabel;
    btnConfirmar: TButton;
    retOffset: TRectangle;
    procedure btnAdicionarVendaClick(Sender: TObject);
    procedure btnBuscaClienteClick(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
    procedure btnAdicionarProdutoClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
  private
    FService: TServicePedido;
    FEhInclusao: Boolean;
    function GetFrameProduto(const AIdProduto: string): TFramePedidoItem;
    procedure DesignPedidos;
    procedure NovaVenda;
    procedure OnSelectClient(const ADataSet: TDataSet);
    procedure OnSelectProduto(const ADataSet: TDataSet);
    procedure OnDeleteItem(ASender: TObject);
    procedure OnEditItem(ASender: TObject);
    procedure OnEditPedido(ASender: TObject);
    procedure OnDeletePedido(ASender: TObject);
    procedure AtualizarTotal;
    procedure ListarPedidos;
    procedure DoAdicionarItem;
  public
    constructor Create(AOwner: TComponent); override;
    procedure DoAfterShow; override;
    destructor Destroy; override;
  end;

implementation

{$R *.fmx}

procedure TFrmPedido.AtualizarTotal;
begin
  txtTotalVenda.Text := FormatFloat('R$ ,0.00', FService.mtCadastrototal.AsCurrency);
end;

procedure TFrmPedido.btnAdicionarProdutoClick(Sender: TObject);
var
  LFrame: TFrmConsultaProduto;
begin
  inherited;
  LFrame := TFrmConsultaProduto.Create(Self);
  LFrame.Align := TAlignLayout.Contents;
  LFrame.CallBack := Self.OnSelectProduto;
  lytContent.AddObject(LFrame);
  LFrame.BringToFront;
end;

procedure TFrmPedido.btnAdicionarVendaClick(Sender: TObject);
begin
  inherited;
  NovaVenda;
end;

procedure TFrmPedido.btnBuscaClienteClick(Sender: TObject);
var
  LFrame: TFrmConsultaCliente;
begin
  inherited;
  LFrame := TFrmConsultaCliente.Create(Self);
  LFrame.Align := TAlignLayout.Contents;
  LFrame.CallBack := Self.OnSelectClient;
  lytContent.AddObject(LFrame);
  LFrame.BringToFront;
end;

procedure TFrmPedido.btnConfirmarClick(Sender: TObject);
begin
  inherited;
  tabControlPedido.Previous();
  ListarPedidos;
end;

procedure TFrmPedido.btnVoltarClick(Sender: TObject);
begin
  inherited;
  if FEhInclusao then
  begin
    if FService.mtCadastro.Active and (FService.mtCadastroid.AsLargeInt > 0) then
      FService.DeletarPedido(FService.mtCadastroid.AsString);
  end;
  tabControlPedido.Previous();
end;

constructor TFrmPedido.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FService := TServicePedido.Create(Self);
  vsbPedidos.Visible := False;
end;

procedure TFrmPedido.DesignPedidos;
var
  I: Integer;
  LFramePedido: TFramePedido;
begin
  lytNenhumaVenda.Visible := FService.mtPedidos.IsEmpty;
  vsbPedidos.Visible := not FService.mtPedidos.IsEmpty;
  if lytNenhumaVenda.Visible then
    Exit;
  vsbPedidos.BeginUpdate;
  try
    for I := Pred(vsbPedidos.Content.ControlsCount) downto 0 do
    begin
      if not (vsbPedidos.Content.Controls.Items[I] = retOffset) then
        vsbPedidos.Content.Controls.Items[I].DisposeOf;
    end;
    FService.mtPedidos.First;
    while not FService.mtPedidos.Eof do
    begin
      LFramePedido := TFramePedido.Create(vsbPedidos);
      LFramePedido.Align := TAlignLayout.Top;
      LFramePedido.txtNumero.Text := FService.mtPedidosid.AsString;
      LFramePedido.txtDataVenda.Text := FormatDateTime('dd/mm/yyyy', FService.mtPedidosdata.AsDateTime);
      LFramePedido.txtValorVenda.Text := FormatFloat('R$ ,0.00', FService.mtPedidostotal.AsFloat);
      LFramePedido.txtNomeCliente.Text := FService.mtPedidosnome_cliente.AsString;
      LFramePedido.Name := LFramePedido.ClassName + FService.mtPedidosid.AsString;
      LFramePedido.Parent := vsbPedidos;
      LFramePedido.Identify := FService.mtPedidosid.AsString;
      LFramePedido.OnDeletePedido := Self.OnDeletePedido;
      LFramePedido.OnEditPedido := Self.OnEditPedido;
      FService.mtPedidos.Next;
    end;
    retOffset.Position.Y := vsbPedidos.Content.ControlsCount * 130 + retOffset.Height;
  finally
    vsbPedidos.EndUpdate;
  end;
end;

destructor TFrmPedido.Destroy;
begin
  FService.Free;
  inherited;
end;

procedure TFrmPedido.DoAdicionarItem;
var
  LFrame: TFramePedidoItem;
begin
  LFrame := GetFrameProduto(FService.mtItensid_produto.AsString);
  LFrame.Align := TAlignLayout.Top;
  LFrame.Identify := FService.mtItensid.AsString;
  LFrame.IdProduto := FService.mtItensid_produto.AsString;
  LFrame.txtQuantidade.Text := FService.mtItensquantidade.AsString;
  LFrame.txtDescricao.Text := FService.mtItensnome_produto.AsString;
  LFrame.txtValorProduto.Text := FormatFloat('R$ ,0.00', FService.mtItenstotal.AsCurrency);
  LFrame.Parent := vsbProdutos;
end;

procedure TFrmPedido.DoAfterShow;
begin
  inherited;
  tabControlPedido.ActiveTab := tabConsulta;
  ListarPedidos;
end;

function TFrmPedido.GetFrameProduto(const AIdProduto: string): TFramePedidoItem;
var
  I: Integer;
begin
  for I := 0 to Pred(vsbProdutos.Content.ControlsCount) do
  begin
    if not vsbProdutos.Content.Controls[I].InheritsFrom(TFramePedidoItem) then
      Continue;
    if (TFramePedidoItem(vsbProdutos.Content.Controls[I]).IdProduto = AIdProduto) then
     Exit(TFramePedidoItem(vsbProdutos.Content.Controls[I]));
  end;
  Result := TFramePedidoItem.Create(vsbProdutos);
  Result.Name := Result.ClassName + vsbProdutos.Content.ControlsCount.ToString;
  Result.OnDeleteItem := Self.OnDeleteItem;
  Result.OnEditItem := Self.OnEditItem;
end;

procedure TFrmPedido.ListarPedidos;
begin
  TAguarde.Aguardar(
    procedure
    begin
      FService.ListarPedidosUsuario;
      TThread.Synchronize(TThread.Current,
        procedure
        begin
          DesignPedidos
        end);
    end);
end;

procedure TFrmPedido.NovaVenda;
var
  I: Integer;
begin
  for I := Pred(vsbProdutos.Content.ControlsCount) downto 0 do
    vsbProdutos.Content.Controls.Items[I].DisposeOf;
  btnAdicionarProduto.Visible := False;
  btnConfirmar.Visible := False;
  txtNomeCliente.Text := 'Nenhum cliente selecionado';
  txtTotalVenda.Text := 'R$ 0,00';
  FService.NovaVenda;
  FEhInclusao := True;
  tabControlPedido.Next();
end;

procedure TFrmPedido.OnDeleteItem(ASender: TObject);
begin
  if not ASender.InheritsFrom(TFramePedidoItem) then
    Exit;
  FService.DeletarItem(TFramePedidoItem(ASender).Identify);
  TFramePedidoItem(ASender).DisposeOf;
  AtualizarTotal;
end;

procedure TFrmPedido.OnDeletePedido(ASender: TObject);
begin
  if not ASender.InheritsFrom(TFramePedido) then
    Exit;
  FService.DeletarPedido(TFramePedido(ASender).Identify);
  TFramePedido(ASender).DisposeOf;
  lytNenhumaVenda.Visible := FService.mtPedidos.IsEmpty;
  vsbPedidos.Visible := not FService.mtPedidos.IsEmpty;
end;

procedure TFrmPedido.OnEditItem(ASender: TObject);
begin
  if not ASender.InheritsFrom(TFramePedidoItem) then
    Exit;
  FService.AlterarQuantidadeItem(TFramePedidoItem(ASender).txtQuantidade.Text,
    TFramePedidoItem(ASender).Identify);
  AtualizarTotal;
end;

procedure TFrmPedido.OnEditPedido(ASender: TObject);
var
  I: Integer;
begin
  if not ASender.InheritsFrom(TFramePedido) then
    Exit;
  FService.CarregarPedido(TFramePedido(ASender).Identify);
  txtNomeCliente.Text := FService.mtCadastronome_cliente.AsString;
  vsbProdutos.BeginUpdate;
  try
    for I := Pred(vsbProdutos.Content.ControlsCount) downto 0 do
      vsbProdutos.Content.Controls.Items[I].DisposeOf;
    FService.mtItens.First;
    while not FService.mtItens.Eof do
    begin
      DoAdicionarItem;
      FService.mtItens.Next;
    end;
  finally
    vsbProdutos.EndUpdate;
  end;
  btnAdicionarProduto.Visible := True;
  btnConfirmar.Visible := True;
  FEhInclusao := False;
  AtualizarTotal;
  tabControlPedido.Next();
end;

procedure TFrmPedido.OnSelectClient(const ADataSet: TDataSet);
begin
  FService.InicializarVenda(ADataSet.FieldByName('id').AsString);
  txtNomeCliente.Text := ADataSet.FieldByName('nome').AsString;
  btnAdicionarProduto.Visible := True;
  btnConfirmar.Visible := True;
end;

procedure TFrmPedido.OnSelectProduto(const ADataSet: TDataSet);
begin
  FService.AdicionarProduto(ADataSet);
  vsbProdutos.BeginUpdate;
  try
    DoAdicionarItem;
  finally
    vsbProdutos.EndUpdate;
  end;
  AtualizarTotal;
end;

end.
