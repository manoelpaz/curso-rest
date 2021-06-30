unit Controllers.Pedido.Item;

interface

procedure Registry;

implementation

uses System.JSON, Data.DB, Horse, DataSet.Serialize, Services.Pedido.Item;

procedure GetItens(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LIdPedido: string;
  LReturn: TJSONObject;
  LService: TServicesPedidoItem;
begin
  LService := TServicesPedidoItem.Create;
  try
    LIdPedido := Req.Params['id_pedido'];
    LReturn := TJSONObject.Create;
    LReturn.AddPair('data', LService.Select(Req.Query, LIdPedido).ToJSONArray());
    LReturn.AddPair('records', TJSONNumber.Create(LService.Select));
    Res.Send(LReturn);
  finally
    LService.Free;
  end;
end;

procedure GetItem(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LIdPedido,
  LIdItem: string;
  LService: TServicesPedidoItem;
begin
  LService := TServicesPedidoItem.Create;
  try
    LIdPedido := Req.Params['id_pedido'];
    LIdItem := Req.Params['id_item'];

    if LService.Select(LIdPedido, LIdItem).IsEmpty then
      raise EHorseException.Create(THTTPStatus.NotFound, 'Item n�o cadastrado');

    Res.Send(LService.qryCRUD.ToJSONObject());
  finally
    LService.Free;
  end;
end;

procedure PostItem(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LIdPedido: string;
  LItem: TJSONObject;
  LService: TServicesPedidoItem;
begin
  LService := TServicesPedidoItem.Create;
  try
    LItem := Req.Body<TJSONObject>;
    LIdPedido := Req.Params['id_pedido'];
    LItem.RemovePair('idPedido').Free;
    LItem.AddPair('idPedido', TJSONNumber.Create(LIdPedido));

    if LService.Insert(LItem) then
      Res.Send(LService.qryCRUD.ToJSONObject()).Status(THTTPStatus.Created);
  finally
    LService.Free;
  end;
end;

procedure PutItem(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LIdPedido,
  LIdItem: string;
  LItem: TJSONObject;
  LService: TServicesPedidoItem;
begin
  LService := TServicesPedidoItem.Create;
  try
    LIdPedido := Req.Params['id_pedido'];
    LIdItem := Req.Params['id_item'];

    if LService.Select(LIdPedido, LIdItem).IsEmpty then
      raise EHorseException.Create(THTTPStatus.NotFound, 'Item n�o cadastrado');

    LItem := Req.Body<TJSONObject>;
    LItem.RemovePair('idPedido').Free;

    if LService.Update(LItem) then
      Res.Status(THTTPStatus.NoContent);
  finally
    LService.Free;
  end;
end;

procedure DeleteItem(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LIdPedido,
  LIdItem: string;
  LService: TServicesPedidoItem;
begin
  LService := TServicesPedidoItem.Create;
  try
    LIdPedido := Req.Params['id_pedido'];
    LIdItem := Req.Params['id_item'];

    if LService.Select(LIdPedido, LIdItem).IsEmpty then
      raise EHorseException.Create(THTTPStatus.NotFound, 'Item n�o cadastrado');

    if LService.Delete then
      Res.Status(THTTPStatus.NoContent);
  finally
    LService.Free;
  end;
end;

procedure Registry;
begin
  THorse.Get('/pedidos/:id_pedido/itens', GetItens);
  THorse.Get('/pedidos/:id_pedido/itens/:id_item', GetItem);
  THorse.Post('/pedidos/:id_pedido/itens', PostItem);
  THorse.Put('/pedidos/:id_pedido/itens/:id_item', PutItem);
  THorse.Delete('/pedidos/:id_pedido/itens/:id_item', DeleteItem);
end;

end.
