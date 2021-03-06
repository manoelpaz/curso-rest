unit Controllers.Produto;

interface

procedure Registry;

implementation

uses System.JSON, Data.DB, Horse, DataSet.Serialize, Services.Produto;

procedure GetProdutos(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LReturn: TJSONObject;
  LService: TServicesProduto;
begin
  LService := TServicesProduto.Create;
  try
    LReturn := TJSONObject.Create;
    LReturn.AddPair('data', LService.Select(Req.Query).ToJSONArray());
    LReturn.AddPair('records', TJSONNumber.Create(LService.Select));
    Res.Send(LReturn);
  finally
    LService.Free;
  end;
end;

procedure GetProduto(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LIdProduto: string;
  LService: TServicesProduto;
begin
  LService := TServicesProduto.Create;
  try
    LIdProduto := Req.Params['id'];

    if LService.Select(LIdProduto).IsEmpty then
      raise EHorseException.Create(THTTPStatus.NotFound, 'Produto n?o cadastrado');

    Res.Send(LService.qryCRUD.ToJSONObject());
  finally
    LService.Free;
  end;
end;

procedure PostProduto(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LProduto: TJSONObject;
  LService: TServicesProduto;
begin
  LService := TServicesProduto.Create;
  try
    LProduto := Req.Body<TJSONObject>;
    if LService.Insert(LProduto) then
      Res.Send(LService.qryCRUD.ToJSONObject()).Status(THTTPStatus.Created);
  finally
    LService.Free;
  end;
end;

procedure PutProduto(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LIdProduto: string;
  LProduto: TJSONObject;
  LService: TServicesProduto;
begin
  LService := TServicesProduto.Create;
  try
    LIdProduto := Req.Params['id'];

    if LService.Select(LIdProduto).IsEmpty then
      raise EHorseException.Create(THTTPStatus.NotFound, 'Produto n?o cadastrado');

    LProduto := Req.Body<TJSONObject>;

    if LService.Update(LProduto) then
      Res.Status(THTTPStatus.NoContent);
  finally
    LService.Free;
  end;
end;

procedure DeleteProduto(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LIdProduto: string;
  LService: TServicesProduto;
begin
  LService := TServicesProduto.Create;
  try
    LIdProduto := Req.Params['id'];

    if LService.Select(LIdProduto).IsEmpty then
      raise EHorseException.Create(THTTPStatus.NotFound, 'Produto n?o cadastrado');

    if LService.Delete then
      Res.Status(THTTPStatus.NoContent);
  finally
    LService.Free;
  end;
end;

procedure Registry;
begin
  THorse.Get('/produtos', GetProdutos);
  THorse.Get('/produtos/:id', GetProduto);
  THorse.Post('/produtos', PostProduto);
  THorse.Put('/produtos/:id', PutProduto);
  THorse.Delete('/produtos/:id', DeleteProduto);
end;

end.
