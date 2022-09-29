unit Services.Usuario;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.PG, FireDAC.Phys.PGDef, FireDAC.ConsoleUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, System.JSON, System.Generics.Collections, Providers.Queries,
  FireDAC.VCLUI.Wait;

type
  TServicesUsuario = class(TProvidersQueries)
    qrySearchid: TLargeintField;
    qrySearchnome: TWideStringField;
    qrySearchlogin: TWideStringField;
    qrySearchstatus: TSmallintField;
    qrySearchtelefone: TWideStringField;
    qrySearchsexo: TSmallintField;
    qryCRUDid: TLargeintField;
    qryCRUDnome: TWideStringField;
    qryCRUDlogin: TWideStringField;
    qryCRUDsenha: TWideStringField;
    qryCRUDstatus: TSmallintField;
    qryCRUDtelefone: TWideStringField;
    qryCRUDsexo: TSmallintField;
    qryCRUDfoto: TBlobField;
    procedure qryCRUDBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    function Insert(const AJson: TJSONObject): Boolean; override;
    function InsertFoto(const AFoto: TStream): Boolean;
    function Select(const AParams: TDictionary<string, string>): TFDQuery; override;
    function Select(const AId: string): TFDQuery; override;
    function SelectFoto: TStream;
    function Update(const AJson: TJSONObject): Boolean; override;

  end;

var
  ServicesUsuario: TServicesUsuario;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TServicesUsuario }

uses BCrypt;

function TServicesUsuario.Select(
  const AParams: TDictionary<string, string>): TFDQuery;
begin
  if AParams.ContainsKey('id') then begin
    qrySearch.SQL.Add('and id = :id');
    qrySearch.ParamByName('id').AsLargeInt := AParams.Items['id'].ToInt64;
    qryRecordCount.SQL.Add('and id = :id');
    qryRecordCount.ParamByName('id').AsLargeInt := AParams.Items['id'].ToInt64;
  end;

  if AParams.ContainsKey('nome') then begin
    qrySearch.SQL.Add('and lower(nome) like :nome');
    qrySearch.ParamByName('nome').AsString := '%' + AParams.Items['nome'].ToLower + '%';
    qryRecordCount.SQL.Add('and lower(nome) like :nome');
    qryRecordCount.ParamByName('nome').AsString := '%' + AParams.Items['nome'].ToLower + '%';
  end;

  if AParams.ContainsKey('login') then begin
    qrySearch.SQL.Add('and login = :login');
    qrySearch.ParamByName('login').AsString := AParams.Items['login'].ToLower;
    qryRecordCount.SQL.Add('and login = :login');
    qryRecordCount.ParamByName('login').AsString := AParams.Items['login'].ToLower;
  end;

  if AParams.ContainsKey('status') then begin
    qrySearch.SQL.Add('and status = :status');
    qrySearch.ParamByName('status').AsSmallInt := AParams.Items['status'].ToInteger();
    qryRecordCount.SQL.Add('and status = :status');
    qryRecordCount.ParamByName('status').AsSmallInt := AParams.Items['status'].ToInteger;
  end;

  if AParams.ContainsKey('sexo') then begin
    qrySearch.SQL.Add('and sexo = :sexo');
    qrySearch.ParamByName('sexo').AsSmallInt := AParams.Items['sexo'].ToInteger();
    qryRecordCount.SQL.Add('and sexo = :sexo');
    qryRecordCount.ParamByName('sexo').AsSmallInt := AParams.Items['sexo'].ToInteger;
  end;

  qrySearch.SQL.Add('order by u.id');

  Result := inherited Select(AParams);
end;

function TServicesUsuario.Insert(const AJson: TJSONObject): Boolean;
begin
  Result := inherited Insert(AJson);
  qryCRUDsenha.Visible := False;
end;

function TServicesUsuario.InsertFoto(const AFoto: TStream): Boolean;
begin
  qryCRUD.Edit;
  qryCRUDfoto.LoadFromStream(AFoto);
  qryCRUD.Post;
  Result := qryCRUD.ApplyUpdates(0) = 0;
end;

procedure TServicesUsuario.qryCRUDBeforePost(DataSet: TDataSet);
begin
  inherited;

  if (qryCRUDsenha.OldValue <> qryCRUDsenha.NewValue) and
     (not qryCRUDsenha.AsString.Trim.IsEmpty) then
    qryCRUDsenha.AsString := TBCrypt.GenerateHash(qryCRUDsenha.AsString);
end;

function TServicesUsuario.Select(const AId: string): TFDQuery;
begin
  Result := inherited Select(AId);
  qryCRUDsenha.Visible := False;
end;

function TServicesUsuario.SelectFoto: TStream;
begin
  Result := nil;

  if qryCRUDfoto.IsNull then
    Exit;

  Result := TMemoryStream.Create;
  qryCRUDfoto.SaveToStream(Result);
end;

function TServicesUsuario.Update(const AJson: TJSONObject): Boolean;
begin
  qryCRUDsenha.Visible := True;
  Result := inherited Update(AJson);
end;

end.
