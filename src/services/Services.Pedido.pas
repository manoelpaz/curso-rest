unit Services.Pedido;

interface

uses
  System.SysUtils, System.Classes, Providers.Queries, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.PG, FireDAC.Phys.PGDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, System.Generics.Collections;

type
  TServicesPedido = class(TProvidersQueries)
    qrySearchid: TLargeintField;
    qrySearchid_cliente: TLargeintField;
    qrySearchid_usuario: TLargeintField;
    qrySearchdata: TSQLTimeStampField;
    qryCRUDid: TLargeintField;
    qryCRUDid_cliente: TLargeintField;
    qryCRUDid_usuario: TLargeintField;
    qryCRUDdata: TSQLTimeStampField;
    qrySearchnome_cliente: TWideStringField;
    qryCRUDnome_cliente: TWideStringField;
    procedure qryCRUDAfterInsert(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    function Select(const AParams: TDictionary<string, string>): TFDQuery; override;
    function Select(const AId: string): TFDQuery; override;
  end;

var
  ServicesPedido: TServicesPedido;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TServicesPedido }

function TServicesPedido.Select(
  const AParams: TDictionary<string, string>): TFDQuery;
begin
  if AParams.ContainsKey('id') then begin
    qrySearch.SQL.Add('and p.id = :id');
    qrySearch.ParamByName('id').AsLargeInt := AParams.Items['id'].ToInt64;
    qryRecordCount.SQL.Add('and p.id = :id');
    qryRecordCount.ParamByName('id').AsLargeInt := AParams.Items['id'].ToInt64;
  end;

  if AParams.ContainsKey('cliente') then begin
    qrySearch.SQL.Add('and id_cliente = :cliente');
    qrySearch.ParamByName('cliente').AsLargeInt := AParams.Items['cliente'].ToInt64;
    qryRecordCount.SQL.Add('and id_cliente = :cliente');
    qryRecordCount.ParamByName('cliente').AsLargeInt := AParams.Items['cliente'].ToInt64;
  end;

  if AParams.ContainsKey('nomeCliente') then begin
    qrySearch.SQL.Add('and lower(c.nome) like :nome');
    qrySearch.ParamByName('nome').AsString := '%' + AParams.Items['nomeCliente'].ToLower + '%';
    qryRecordCount.SQL.Add('and lower(c.nome) like :nome');
    qryRecordCount.ParamByName('nome').AsString := '%' + AParams.Items['nomeCliente'].ToLower + '%';
  end;

  if AParams.ContainsKey('usuario') then begin
    qrySearch.SQL.Add('and id_usuario = :usuario');
    qrySearch.ParamByName('usuario').AsLargeInt := AParams.Items['usuario'].ToInt64;
    qryRecordCount.SQL.Add('and id_usuario = :usuario');
    qryRecordCount.ParamByName('usuario').AsLargeInt := AParams.Items['usuario'].ToInt64;
  end;

  if AParams.ContainsKey('dia') then begin
    qrySearch.SQL.Add('and TO_CHAR(p.data, ''DD'') = :dia');
    qrySearch.ParamByName('dia').AsString := AParams.Items['dia'];
    qryRecordCount.SQL.Add('and TO_CHAR(p.data, ''DD'') = :dia');
    qryRecordCount.ParamByName('dia').AsString := AParams.Items['dia'];
  end;

  if AParams.ContainsKey('mes') then begin
    qrySearch.SQL.Add('and TO_CHAR(p.data, ''MM'') = :mes');
    qrySearch.ParamByName('mes').AsString := AParams.Items['mes'];
    qryRecordCount.SQL.Add('and TO_CHAR(p.data, ''MM'') = :mes');
    qryRecordCount.ParamByName('mes').AsString := AParams.Items['mes'];
  end;

  if AParams.ContainsKey('ano') then begin
    qrySearch.SQL.Add('and TO_CHAR(p.data, ''YYYY'') = :ano');
    qrySearch.ParamByName('ano').AsString := AParams.Items['ano'];
    qryRecordCount.SQL.Add('and TO_CHAR(p.data, ''YYYY'') = :ano');
    qryRecordCount.ParamByName('ano').AsString := AParams.Items['ano'];
  end;

  qrySearch.SQL.Add('order by p.id');

  Result := inherited Select(AParams);
end;

procedure TServicesPedido.qryCRUDAfterInsert(DataSet: TDataSet);
begin
  inherited;
  qryCRUDdata.AsDateTime := Now;
end;

function TServicesPedido.Select(const AId: string): TFDQuery;
begin
  qryCRUD.SQL.Add('where p.id = :id');
  qryCRUD.ParamByName('id').AsLargeInt := AId.ToInt64;
  qryCRUD.Open();
  Result := qryCRUD;
end;

end.
