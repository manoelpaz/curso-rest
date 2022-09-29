unit Controllers.Usuario;

interface

procedure Registry;

implementation

uses System.JSON, Data.DB, System.Classes, Horse, DataSet.Serialize, Services.Usuario;

procedure GetUsuarios(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LReturn: TJSONObject;
  LService: TServicesUsuario;
begin
  LService := TServicesUsuario.Create;
  try
    LReturn := TJSONObject.Create;
    LReturn.AddPair('data', LService.Select(Req.Query).ToJSONArray());
    LReturn.AddPair('records', TJSONNumber.Create(LService.Select));
    Res.Send(LReturn);
  finally
    LService.Free;
  end;
end;

procedure GetUsuario(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LIdUsuario: string;
  LService: TServicesUsuario;
begin
  LService := TServicesUsuario.Create;
  try
    LIdUsuario := Req.Params['id'];

    if LService.Select(LIdUsuario).IsEmpty then
      raise EHorseException.Create(THTTPStatus.NotFound, 'Usu�rio n�o cadastrado');

    Res.Send(LService.qryCRUD.ToJSONObject());
  finally
    LService.Free;
  end;
end;

procedure PostUsuario(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LUsuario: TJSONObject;
  LService: TServicesUsuario;
begin
  LService := TServicesUsuario.Create;
  try
    LUsuario := Req.Body<TJSONObject>;

    if LService.Insert(LUsuario) then
      Res.Send(LService.qryCRUD.ToJSONObject()).Status(THTTPStatus.Created);
  finally
    LService.Free;
  end;
end;

procedure PutUsuario(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LIdUsuario: string;
  LUsuario: TJSONObject;
  LService: TServicesUsuario;
begin
  LService := TServicesUsuario.Create;
  try
    LIdUsuario := Req.Params['id'];

    if LService.Select(LIdUsuario).IsEmpty then
      raise EHorseException.Create(THTTPStatus.NotFound, 'Usu�rio n�o cadastrado');

    LUsuario := Req.Body<TJSONObject>;

    if LService.Update(LUsuario) then
      Res.Status(THTTPStatus.NoContent);
  finally
    LService.Free;
  end;
end;

procedure DeleteUsuario(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LIdUsuario: string;
  LService: TServicesUsuario;
begin
  LService := TServicesUsuario.Create;
  try
    LIdUsuario := Req.Params['id'];

    if LService.Select(LIdUsuario).IsEmpty then
      raise EHorseException.Create(THTTPStatus.NotFound, 'Usu�rio n�o cadastrado');

    if LService.Delete then
      Res.Status(THTTPStatus.NoContent);
  finally
    LService.Free;
  end;
end;

procedure PostFotoUsuario(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LFoto: TMemoryStream;
  LIdUsuario: string;
  LService: TServicesUsuario;
begin
  LService := TServicesUsuario.Create;
  try
    LIdUsuario := Req.Params['id'];

    if LService.Select(LIdUsuario).IsEmpty then
      raise EHorseException.Create(THTTPStatus.NotFound, 'Usu�rio n�o cadastrado');

    LFoto := Req.Body<TMemoryStream>;

    if not Assigned(LFoto) then
      raise EHorseException.Create(THTTPStatus.BadRequest, 'Foto inv�lida');

    if LService.InsertFoto(LFoto) then
      Res.Status(THTTPStatus.NoContent);
  finally
    LService.Free;
  end;
end;

procedure GetFotoUsuario(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LFoto: TStream;
  LIdUsuario: string;
  LService: TServicesUsuario;
begin
  LService := TServicesUsuario.Create;
  try
    LIdUsuario := Req.Params['id'];

    if LService.Select(LIdUsuario).IsEmpty then
      raise EHorseException.Create(THTTPStatus.NotFound, 'Usu�rio n�o cadastrado');

    LFoto := LService.SelectFoto;

    if not Assigned(LFoto) then
      raise EHorseException.Create(THTTPStatus.NotFound, 'Foto n�o cadastrada');

    Res.Send(LFoto);
  finally
    LService.Free;
  end;
end;

procedure Registry;
begin
  THorse.Get('/usuarios', GetUsuarios);
  THorse.Get('/usuarios/:id', GetUsuario);
  THorse.Post('/usuarios', PostUsuario);
  THorse.Put('/usuarios/:id', PutUsuario);
  THorse.Delete('/usuarios/:id', DeleteUsuario);
  THorse.Post('/usuarios/:id/foto', PostFotoUsuario);
  THorse.Get('/usuarios/:id/foto', GetFotoUsuario);
end;

end.