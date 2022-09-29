unit Services.Perfil;

interface

uses
  System.SysUtils, System.Classes, Services.Base, Providers.Request;

type
  TServicePerfil = class(TServiceBase)
  private
    { Private declarations }
  public
    { Public declarations }
    function DownloadFoto: TMemoryStream;
    procedure UploadFoto(const AFoto: TMemoryStream);
  end;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

function TServicePerfil.DownloadFoto: TMemoryStream;
var
  LResponse: IResponse;
begin
  Result := TMemoryStream.Create;
  LResponse := TRequest.New
    .BaseURL('http://localhost:9000')
    .Resource('usuarios/' + Session.User.Id.ToString + '/foto')
    .ContentType('application/octet-stream')
    .Get;
  if (LResponse.StatusCode = 200) then
  begin
    if (Length(LResponse.RawBytes) > 0) then
    begin
      Result.WriteBuffer(LResponse.RawBytes[0], Length(LResponse.RawBytes));
      Result.Position := 0;
    end;
  end;
end;

procedure TServicePerfil.UploadFoto(const AFoto: TMemoryStream);
var
  LResponse: IResponse;
begin
  LResponse := TRequest.New
    .BaseURL('http://localhost:9000')
    .Resource('usuarios/' + Session.User.Id.ToString + '/foto')
    .ContentType('application/octet-stream')
    .AddBody(AFoto, False)
    .Post;
  if (LResponse.StatusCode <> 204) then
    raise Exception.Create(LResponse.Content);
end;

end.
