unit Controllers.Auth;

interface

procedure Registry;

implementation

uses
  System.SysUtils, System.DateUtils, System.JSON,
  Horse, JOSE.Core.JWT, JOSE.Core.Builder, Horse.JWT, Services.Auth;

const
  JWT_KEY = 'curso-rest-horse';

function GetToken(const AIdUsuario: string; const AExpiration: TDateTime): string;
var
  LJWT: TJWT;
begin
  LJWT := TJWT.Create;
  try
    LJWT.Claims.IssuedAt := Now;
    LJWT.Claims.Expiration := AExpiration;
    LJWT.Claims.Subject := AIdUsuario;
    Result := TJOSE.SHA256CompactToken(JWT_KEY, LJWT);
  finally
    LJWT.Free;
  end;
end;

procedure DoLogin(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LContent,
  LToken: TJSONObject;
  LUsuario,
  LSenha: string;
  LService: TServiceAuth;
begin
  LContent := Req.Body<TJSONObject>;

  if not LContent.TryGetValue<string>('username', LUsuario) then
    raise EHorseException.Create(THTTPStatus.BadRequest, 'Usu�rio n�o informado');

  if not LContent.TryGetValue<string>('password', LSenha) then
    raise EHorseException.Create(THTTPStatus.BadRequest, 'Senha n�o informada');

  LService := TServiceAuth.Create(nil);
  try
    if not LService.AllowAccess(LUsuario, LSenha) then
      raise EHorseException.Create(THTTPStatus.Unauthorized, 'Usu�rio n�o autorizado');

    LToken := TJSONObject.Create;
    LToken.AddPair('access', GetToken(LService.qryLoginid.AsString, IncMinute(Now)));
    LToken.AddPair('refresh', GetToken(LService.qryLoginid.AsString, IncMonth(Now)));
    Res.Send(LToken);
  finally
    LService.Free;
  end;
end;

procedure RenewToken(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LSub,
  LToken: string;
begin
  LSub := Req.Session<TJSONObject>.GetValue('sub').Value;
  LToken := GetToken(LSub, IncHour(Now));
  Res.Send(TJSONObject.Create(TJSONPair.Create('access', LToken)));
end;

procedure Registry;
begin
  THorse.Post('/login', DoLogin);
  THorse.Get('/refresh', HorseJWT(JWT_KEY), RenewToken);
end;

end.
