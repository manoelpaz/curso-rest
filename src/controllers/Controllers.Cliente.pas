unit Controllers.Cliente;

interface

procedure Registry;

implementation

uses System.JSON, Data.DB, Horse, DataSet.Serialize, Services.Cliente;

procedure GetClientes(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LReturn: TJSONObject;
  LService: TServicesCliente;
begin
  LService := TServicesCliente.Create;
  try
    LReturn := TJSONObject.Create;
    LReturn.AddPair('data', LService.Select(Req.Query).ToJSONArray());
    LReturn.AddPair('records', TJSONNumber.Create(LService.Select));
    Res.Send(LReturn);
  finally
    LService.Free;
  end;
end;

procedure GetCliente(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LIdCliente: string;
  LService: TServicesCliente;
begin
  LService := TServicesCliente.Create;
  try
    LIdCliente := Req.Params['id'];

    if LService.Select(LIdCliente).IsEmpty then
      raise EHorseException.Create(THTTPStatus.NotFound, 'Cliente n?o cadastrado');

    Res.Send(LService.qryCRUD.ToJSONObject());
  finally
    LService.Free;
  end;
end;

procedure PostCliente(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LCliente: TJSONObject;
  LService: TServicesCliente;
begin
  LService := TServicesCliente.Create;
  try
    LCliente := Req.Body<TJSONObject>;

    if LService.Insert(LCliente) then
      Res.Send(LService.qryCRUD.ToJSONObject()).Status(THTTPStatus.Created);
  finally
    LService.Free;
  end;
end;

procedure PutCliente(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LIdCliente: string;
  LCliente: TJSONObject;
  LService: TServicesCliente;
begin
  LService := TServicesCliente.Create;
  try
    LIdCliente := Req.Params['id'];

    if LService.Select(LIdCliente).IsEmpty then
      raise EHorseException.Create(THTTPStatus.NotFound, 'Cliente n?o cadastrado');

    LCliente := Req.Body<TJSONObject>;

    if LService.Update(LCliente) then
      Res.Status(THTTPStatus.NoContent);
  finally
    LService.Free;
  end;
end;

procedure DeleteCliente(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LIdCliente: string;
  LService: TServicesCliente;
begin
  LService := TServicesCliente.Create;
  try
    LIdCliente := Req.Params['id'];

    if LService.Select(LIdCliente).IsEmpty then
      raise EHorseException.Create(THTTPStatus.NotFound, 'Cliente n?o cadastrado');

    if LService.Delete then
      Res.Status(THTTPStatus.NoContent);
  finally
    LService.Free;
  end;
end;

procedure Registry;
begin
  THorse.Get('/clientes', GetClientes);
  THorse.Get('/clientes/:id', GetCliente);
  THorse.Post('/clientes', PostCliente);
  THorse.Put('/clientes/:id', PutCliente);
  THorse.Delete('/clientes/:id', DeleteCliente);
end;

end.
