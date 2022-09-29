unit Services.Usuarios;

interface

uses
  System.SysUtils, System.Classes, Services.Base.Cadastro, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TServiceUsuarios = class(TServiceBaseCadastro)
    mtPesquisaid: TLargeintField;
    mtPesquisanome: TWideStringField;
    mtPesquisalogin: TWideStringField;
    mtPesquisastatus: TSmallintField;
    mtPesquisasexo: TSmallintField;
    mtPesquisatelefone: TWideStringField;
    mtCadastroid: TLargeintField;
    mtCadastronome: TWideStringField;
    mtCadastrologin: TWideStringField;
    mtCadastrosenha: TWideStringField;
    mtCadastrostatus: TSmallintField;
    mtCadastrosexo: TSmallintField;
    mtCadastrotelefone: TWideStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure mtCadastroAfterInsert(DataSet: TDataSet);
    procedure mtPesquisastatusGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure mtPesquisasexoGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure mtCadastrosexoGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure mtCadastrosexoSetText(Sender: TField; const Text: string);
  public
    function DownloadFotoUsuario: TMemoryStream;
    procedure SalvarFotoUsuario(const AFoto: TMemoryStream);
    procedure Salvar; override;
  end;

implementation

uses Providers.Request, Providers.Session;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TServiceUsuarios.DataModuleCreate(Sender: TObject);
begin
  inherited;
  Request.BaseURL('http://localhost:9000').Resource('usuarios');
end;

function TServiceUsuarios.DownloadFotoUsuario: TMemoryStream;
var
  LResponse: IResponse;
begin
  Result := TMemoryStream.Create;
  LResponse := TRequest.New
    .BaseURL('http://localhost:9000')
    .Resource('usuarios/' + mtPesquisaid.AsString + '/foto')
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

procedure TServiceUsuarios.mtCadastroAfterInsert(DataSet: TDataSet);
begin
  inherited;
  mtCadastrostatus.AsInteger := 1;
  mtCadastrosexo.AsInteger := 0;
end;

procedure TServiceUsuarios.mtCadastrosexoGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  Text := 'Masculino';

  if (Sender.AsInteger = 1) then
    Text := 'Feminino';
end;

procedure TServiceUsuarios.mtCadastrosexoSetText(Sender: TField;
  const Text: string);
begin
  inherited;
  Sender.AsInteger := 0;

  if Text = 'Feminino' then
    Sender.AsInteger := 1;
end;

procedure TServiceUsuarios.mtPesquisasexoGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  inherited;
  Text := 'Masculino';
  if (Sender.AsInteger = 1) then
    Text := 'Feminino';
end;

procedure TServiceUsuarios.mtPesquisastatusGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  inherited;
  Text := 'Ativo';
  if (Sender.AsInteger = 0) then
    Text := 'Inativo';
end;

procedure TServiceUsuarios.Salvar;
begin
  mtCadastrosenha.Visible := not mtCadastrosenha.AsString.Trim.IsEmpty;
  inherited;
end;

procedure TServiceUsuarios.SalvarFotoUsuario(const AFoto: TMemoryStream);
var
  LResponse: IResponse;
begin
  AFoto.Position := 0;
  LResponse := TRequest.New
    .BaseURL('http://localhost:9000')
    .Resource('usuarios/' + mtPesquisaid.AsString + '/foto')
    .AddBody(AFoto)
    .ContentType('application/octet-stream')
    .Post;
  if (LResponse.StatusCode <> 204) then
    raise Exception.Create(LResponse.Content);
end;

end.