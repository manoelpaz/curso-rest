unit Services.Usuario;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.PG, FireDAC.Phys.PGDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, System.Generics.Collections, Providers.Queries;

type
  TServicesUsuario = class(TProvidersQueries)
    qrySearchid: TLargeintField;
    qrySearchnome: TWideStringField;
    qrySearchlogin: TWideStringField;
    qrySearchstatus: TSmallintField;
    qrySearchtelefone: TWideStringField;
    qrySearchsexo: TSmallintField;
    qrySearchfoto: TBlobField;
    qryCRUDid: TLargeintField;
    qryCRUDnome: TWideStringField;
    qryCRUDlogin: TWideStringField;
    qryCRUDsenha: TWideStringField;
    qryCRUDstatus: TSmallintField;
    qryCRUDtelefone: TWideStringField;
    qryCRUDsexo: TSmallintField;
    qryCRUDfoto: TBlobField;
  private
    { Private declarations }
  public
    { Public declarations }
    function Select(const AParams: TDictionary<string, string>): TFDQuery; override;
  end;

var
  ServicesUsuario: TServicesUsuario;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TServicesUsuario }

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

  qrySearch.SQL.Add('order by id');

  Result := inherited Select(AParams);
end;

end.
