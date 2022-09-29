unit Services.Login;

interface

uses
  System.SysUtils, System.Classes;

type
  TServiceLogin = class(TDataModule)
  public
    procedure Login(const AUsername, APassword: string);
  end;

implementation

uses
  System.JSON, Providers.Request, Providers.Session;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TServiceLogin }

procedure TServiceLogin.Login(const AUsername, APassword: string);
var
  LJSON: TJSONObject;
  LResponse: IResponse;
begin
  if AUsername.Trim.IsEmpty or APassword.Trim.IsEmpty then
    raise Exception.Create('Informe o usu�rio e senha!');

  LJSON := TJSONObject.Create;
  LJSON.AddPair('username', AUsername);
  LJSON.AddPair('password', APassword);

  LResponse := TRequest.New
    .BaseURL('http://localhost:8000')
    .Resource('login')
    .AddBody(LJSON)
    .Post;

  if (LResponse.StatusCode <> 200) then
    raise Exception.Create(LResponse.JSONValue.GetValue<string>('error'));

  TSession.GetInstance.Token.Access := LResponse.JSONValue.GetValue<string>('access');
  TSession.GetInstance.Token.Refresh := LResponse.JSONValue.GetValue<string>('refresh');
end;

end.
