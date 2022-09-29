unit Services.Login;

interface

uses
  System.SysUtils, System.Classes, Services.Base, Providers.Request, System.JSON, Providers.Session,
  System.Generics.Collections;

type
  TServiceLogin = class(TServiceBase)
  private
    procedure CarregarDadosUsuario(const AUsername: string);
  public
    procedure Login(const AUsername, APassword: string);
  end;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

{ TServiceLogin }

procedure TServiceLogin.CarregarDadosUsuario(const AUsername: string);
var
  LUser: TJSONObject;
  LResponse: IResponse;
begin
  LResponse := TRequest.New
    .BaseURL('http://localhost:9000')
    .Resource('usuarios')
    .AddParam('login', AUsername)
    .Get;

  if (LResponse.StatusCode <> 200) then
    raise Exception.Create(LResponse.JSONValue.GetValue<string>('error'));

  LUser := TJSONObject(LResponse.JSONValue.GetValue<TJSONArray>('data').Items[0]);
  TSession.GetInstance.User.Id := LUser.GetValue<Integer>('id');
  TSession.GetInstance.User.Nome := LUser.GetValue<string>('nome');
  TSession.GetInstance.User.Login := LUser.GetValue<string>('login');
  TSession.GetInstance.User.Telefone := LUser.GetValue<string>('telefone');
  TSession.GetInstance.User.Sexo := LUser.GetValue<Integer>('sexo');
end;

procedure TServiceLogin.Login(const AUsername, APassword: string);
var
  LUsuario: TJSONObject;
  LResponse: IResponse;
begin
  if AUsername.Trim.IsEmpty or APassword.Trim.IsEmpty then
    raise Exception.Create('Informe o usuário e a senha!');

  LUsuario := TJSONObject.Create;
  LUsuario.AddPair('username', AUsername);
  LUsuario.AddPair('password', APassword);

  LResponse := TRequest.New
    .BaseURL('http://localhost:8000')
    .Resource('login')
    .AddBody(LUsuario)
    .Post;

  if (LResponse.StatusCode <> 200) then
    raise Exception.Create(LResponse.JSONValue.GetValue<string>('error'));

  TSession.GetInstance.Token.Access := LResponse.JSONValue.GetValue<string>('access');
  TSession.GetInstance.Token.Refresh := LResponse.JSONValue.GetValue<string>('refresh');
  CarregarDadosUsuario(AUsername);
end;

end.
