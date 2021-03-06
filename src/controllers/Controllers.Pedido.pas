unit Controllers.Pedido;

interface

procedure Registry;

implementation

uses System.JSON, Data.DB, Horse, DataSet.Serialize, Services.Pedido;

procedure GetPedidos(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LReturn: TJSONObject;
  LService: TServicesPedido;
begin
  LService := TServicesPedido.Create;
  try
    LReturn := TJSONObject.Create;
    LReturn.AddPair('data', LService.Select(Req.Query).ToJSONArray());
    LReturn.AddPair('records', TJSONNumber.Create(LService.Select));
    Res.Send(LReturn);
  finally
    LService.Free;
  end;
end;

procedure GetPedido(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LIdPedido: string;
  LService: TServicesPedido;
begin
  LService := TServicesPedido.Create;
  try
    LIdPedido := Req.Params['id'];

    if LService.Select(LIdPedido).IsEmpty then
      raise EHorseException.Create(THTTPStatus.NotFound, 'Pedido n?o cadastrado');

    Res.Send(LService.qryCRUD.ToJSONObject());
  finally
    LService.Free;
  end;
end;

procedure PostPedido(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LPedido: TJSONObject;
  LService: TServicesPedido;
begin
  LService := TServicesPedido.Create;
  try
    LPedido := Req.Body<TJSONObject>;
    if LService.Insert(LPedido) then
      Res.Send(LService.qryCRUD.ToJSONObject()).Status(THTTPStatus.Created);
  finally
    LService.Free;
  end;
end;

procedure PutPedido(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LIdPedido: string;
  LPedido: TJSONObject;
  LService: TServicesPedido;
begin
  LService := TServicesPedido.Create;
  try
    LIdPedido := Req.Params['id']; // Params.Items['id'];

    if LService.Select(LIdPedido).IsEmpty then
      raise EHorseException.Create(THTTPStatus.NotFound, 'Pedido n?o cadastrado');

    LPedido := Req.Body<TJSONObject>;

    if LService.Update(LPedido) then
      Res.Status(THTTPStatus.NoContent);
  finally
    LService.Free;
  end;
end;

procedure DeletePedido(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LIdPedido: string;
  LService: TServicesPedido;
begin
  LService := TServicesPedido.Create;
  try
    LIdPedido := Req.Params['id']; // Params.Items['id'];

    if LService.Select(LIdPedido).IsEmpty then
      raise EHorseException.Create(THTTPStatus.NotFound, 'Pedido n?o cadastrado');

    if LService.Delete then
      Res.Status(THTTPStatus.NoContent);
  finally
    LService.Free;
  end;
end;

procedure Registry;
begin
  THorse.Get('/pedidos', GetPedidos);
  THorse.Get('/pedidos/:id', GetPedido);
  THorse.Post('/pedidos', PostPedido);
  THorse.Put('/pedidos/:id', PutPedido);
  THorse.Delete('/pedidos/:id', DeletePedido);
end;

end.
