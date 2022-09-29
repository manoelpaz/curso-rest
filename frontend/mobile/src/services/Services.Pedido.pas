unit Services.Pedido;

interface

uses
  System.SysUtils, System.Classes, Services.Base, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Providers.Request;

type
  TServicePedido = class(TServiceBase)
    mtPedidos: TFDMemTable;
    mtPedidosid: TLargeintField;
    mtPedidosid_cliente: TLargeintField;
    mtPedidosdata: TSQLTimeStampField;
    mtPedidosnome_cliente: TWideStringField;
    mtPedidosid_usuario: TLargeintField;
    mtPedidostotal: TFMTBCDField;
    mtCadastro: TFDMemTable;
    mtItens: TFDMemTable;
    mtCadastroid: TLargeintField;
    mtCadastroid_cliente: TLargeintField;
    mtCadastrodata: TSQLTimeStampField;
    mtCadastronome_cliente: TWideStringField;
    mtCadastroid_usuario: TLargeintField;
    mtCadastrototal: TFMTBCDField;
    mtItensid: TLargeintField;
    mtItensid_produto: TLargeintField;
    mtItensid_pedido: TLargeintField;
    mtItensvalor: TFMTBCDField;
    mtItensquantidade: TFMTBCDField;
    mtItensnome_produto: TWideStringField;
    mtItenstotal: TCurrencyField;
    procedure DataModuleCreate(Sender: TObject);
    procedure mtItensBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
    procedure AtualizarTotal;
    procedure CarregarItensPedido(const AId: string);
  public
    procedure ListarPedidosUsuario;
    procedure InicializarVenda(const AIdCliente: string);
    procedure AdicionarProduto(const ADataSet: TDataSet);
    procedure DeletarItem(const AId: string);
    procedure DeletarPedido(const AId: string);
    procedure AlterarQuantidadeItem(const AQuantidade, AId: string);
    procedure CarregarPedido(const AId: string);
    procedure NovaVenda;
  end;

implementation

uses DataSet.Serialize, System.JSON;

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TServicePedido.AdicionarProduto(const ADataSet: TDataSet);
var
  LRequest: IRequest;
  LResponse: IResponse;
begin
  if mtItens.Locate('id_produto', ADataSet.FieldByName('id').AsString) then
    mtItens.Edit
  else
    mtItens.Append;
  mtItensid_pedido.AsLargeInt := mtCadastroid.AsLargeInt;
  mtItensid_produto.AsLargeInt := ADataSet.FieldByName('id').AsLargeInt;
  mtItensvalor.AsCurrency := ADataSet.FieldByName('valor').AsCurrency;
  mtItensquantidade.AsInteger := mtItensquantidade.AsInteger + 1;
  mtItensnome_produto.AsString := ADataSet.FieldByName('nome').AsString;
  mtItens.Post;
  LRequest := TRequest.New
    .BaseURL('http://localhost:9000')
    .Resource('pedidos/' + mtCadastroid.AsString + '/itens')
    .AddBody(mtItens.ToJSONObject);
  if (mtItensid.AsLargeInt > 0) then
  begin
    LResponse := LRequest.ResourceSuffix(mtItensid.AsString).Put;
    if (LResponse.StatusCode <> 204) then
      raise Exception.Create(LResponse.Content);
  end
  else
  begin
    LResponse := LRequest.Post;
    if (LResponse.StatusCode <> 201) then
      raise Exception.Create(LResponse.Content);
    mtItens.MergeFromJSONObject(TJSONObject(LResponse.JSONValue), False);
  end;
  AtualizarTotal;
end;

procedure TServicePedido.AlterarQuantidadeItem(const AQuantidade, AId: string);
var
  LResponse: IResponse;
begin
  if not mtItens.Locate('id', AId) then
    Exit;
  mtItens.Edit;
  mtItensquantidade.AsInteger := AQuantidade.ToInteger;
  mtItens.Post;
  LResponse := TRequest.New
    .BaseURL('http://localhost:9000')
    .Resource('pedidos/' + mtCadastroid.AsString + '/itens')
    .ResourceSuffix(AId)
    .AddBody(mtItens.ToJSONObject)
    .Put;
  if (LResponse.StatusCode <> 204) then
    raise Exception.Create(LResponse.Content);
  AtualizarTotal;
end;

procedure TServicePedido.AtualizarTotal;
var
  LId: Int64;
begin
  LId := mtItensid.AsLargeInt;
  try
    mtCadastro.Edit;
    mtCadastrototal.AsCurrency := 0.00;
    mtItens.First;
    while not mtItens.Eof do
    begin
      mtCadastrototal.AsCurrency := mtCadastrototal.AsCurrency + mtItenstotal.AsCurrency;
      mtItens.Next;
    end;
    mtCadastro.Post;
  finally
    mtItens.Locate('id', LId);
  end;
end;

procedure TServicePedido.CarregarItensPedido(const AId: string);
var
  LResponse: IResponse;
begin
  LResponse := TRequest.New
    .BaseURL('http://localhost:9000')
    .Resource('pedidos/' + Aid + '/itens')
    .Get;
  if (LResponse.StatusCode <> 200) then
    raise Exception.Create(LResponse.Content);

  if not mtItens.Active then
    mtItens.Open;
  mtItens.EmptyDataSet;
  mtItens.LoadFromJSON(LResponse.JSONValue.GetValue<TJSONArray>('data'), False);
end;

procedure TServicePedido.CarregarPedido(const AId: string);
var
  LResponse: IResponse;
begin
  LResponse := TRequest.New
    .BaseURL('http://localhost:9000')
    .Resource('pedidos')
    .ResourceSuffix(AId)
    .Get;
  if (LResponse.StatusCode <> 200) then
    raise Exception.Create(LResponse.Content);

  if not mtCadastro.Active then
    mtCadastro.Open;
  mtCadastro.EmptyDataSet;
  mtCadastro.LoadFromJSON(TJSONObject(LResponse.JSONValue), False);
  CarregarItensPedido(AId);
  AtualizarTotal;
end;

procedure TServicePedido.DataModuleCreate(Sender: TObject);
begin
  inherited;
  mtPedidos.Open;
end;

procedure TServicePedido.DeletarItem(const AId: string);
var
  LResponse: IResponse;
begin
  if not mtItens.Locate('id', AId) then
    raise Exception.Create('Item não localizado');
  LResponse := TRequest.New
    .BaseURL('http://localhost:9000')
    .Resource('pedidos/' + mtCadastroid.AsString + '/itens')
    .ResourceSuffix(AId)
    .Delete;
  if (LResponse.StatusCode <> 204) then
    raise Exception.Create(LResponse.Content);
  mtItens.Delete;
  AtualizarTotal;
end;

procedure TServicePedido.DeletarPedido(const AId: string);
var
  LResponse: IResponse;
begin
  if mtPedidos.Locate('id', AId) then
    mtPedidos.Delete;
  LResponse := TRequest.New
    .BaseURL('http://localhost:9000')
    .Resource('pedidos')
    .ResourceSuffix(AId)
    .Delete;
  if (LResponse.StatusCode <> 204) then
    raise Exception.Create(LResponse.Content);
end;

procedure TServicePedido.InicializarVenda(const AIdCliente: string);
var
  LRequest: IRequest;
  LResponse: IResponse;
begin
  if not mtCadastro.Active then
  begin
    mtCadastro.Open;
    mtCadastro.Append;
    mtCadastrodata.AsDateTime := Now;
    mtCadastroid_usuario.AsLargeInt := Session.User.Id;
    mtItens.Open;
  end
  else
    mtCadastro.Edit;
  mtCadastroid_cliente.AsString := AIdCliente;
  mtCadastro.Post;
  LRequest := TRequest.New
    .BaseURL('http://localhost:9000')
    .Resource('pedidos')
    .AddBody(mtCadastro.ToJSONObject);
  if (mtCadastroid.AsLargeInt > 0) then
  begin
    LResponse := LRequest.ResourceSuffix(mtCadastroid.AsString).Put;
    if (LResponse.StatusCode <> 204) then
      raise Exception.Create(LResponse.Content);
  end
  else
  begin
    LResponse := LRequest.Post;
    if (LResponse.StatusCode <> 201) then
      raise Exception.Create(LResponse.Content);
    mtCadastro.MergeFromJSONObject(TJSONObject(LResponse.JSONValue), False);
  end;
end;

procedure TServicePedido.ListarPedidosUsuario;
var
  LResponse: IResponse;
begin
  LResponse := TRequest.New
    .BaseURL('http://localhost:9000')
    .Resource('pedidos')
    .AddParam('usuario', Session.User.Id.ToString)
    .Get;
  if (LResponse.StatusCode <> 200) then
    raise Exception.Create(LResponse.Content);
  mtPedidos.EmptyDataSet;
  mtPedidos.LoadFromJSON(LResponse.JSONValue.GetValue<TJSONArray>('data'), False);
end;

procedure TServicePedido.mtItensBeforePost(DataSet: TDataSet);
begin
  inherited;
  mtItenstotal.AsCurrency := mtItensvalor.AsCurrency * mtItensquantidade.AsInteger;
end;

procedure TServicePedido.NovaVenda;
begin
  mtItens.Close;
  mtCadastro.Close;
end;

end.
