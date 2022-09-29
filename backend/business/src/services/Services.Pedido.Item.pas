unit Services.Pedido.Item;

interface

uses
  System.SysUtils, System.Classes, Providers.Queries, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.PG, FireDAC.Phys.PGDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, System.JSON, System.Generics.Collections;

type
  TServicesPedidoItem = class(TProvidersQueries)
    qrySearchid: TLargeintField;
    qrySearchid_produto: TLargeintField;
    qrySearchquantidade: TFMTBCDField;
    qrySearchvalor: TFMTBCDField;
    qryCRUDid: TLargeintField;
    qryCRUDid_pedido: TLargeintField;
    qryCRUDid_produto: TLargeintField;
    qryCRUDquantidade: TFMTBCDField;
    qryCRUDvalor: TFMTBCDField;
    qrySearchnome_produto: TWideStringField;
    qryCRUDnome_produto: TWideStringField;
  private
    { Private declarations }
  public
    { Public declarations }
    function Insert(const AJson: TJSONObject): Boolean; override;
    function Select(const AParams: TDictionary<string, string>;
      const AIdPedido: string): TFDQuery; overload;
    function Select(const AParams: TDictionary<string, string>): TFDQuery; override;
    function Select(const AIdPedido, AIdItem: string): TFDQuery; overload;
//    function Update(const AJson: TJSONObject): Boolean; override;
  end;

var
  ServicesPedidoItem: TServicesPedidoItem;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TServicesPedidoItem }

function TServicesPedidoItem.Insert(const AJson: TJSONObject): Boolean;
begin
  Result := inherited Insert(AJson);
  qryCRUDid_pedido.Visible := False;
end;

function TServicesPedidoItem.Select(
  const AParams: TDictionary<string, string>): TFDQuery;
begin
  if AParams.ContainsKey('id') then begin
    qrySearch.SQL.Add('and id = :id');
    qrySearch.ParamByName('id').AsLargeInt := AParams.Items['id'].ToInt64;
    qryRecordCount.SQL.Add('and id = :id');
    qryRecordCount.ParamByName('id').AsLargeInt := AParams.Items['id'].ToInt64;
  end;

  if AParams.ContainsKey('pedido') then begin
    qrySearch.SQL.Add('and id_pedido = :pedido');
    qrySearch.ParamByName('pedido').AsLargeInt := AParams.Items['pedido'].ToInt64;
    qryRecordCount.SQL.Add('and id_pedido = :pedido');
    qryRecordCount.ParamByName('pedido').AsLargeInt := AParams.Items['pedido'].ToInt64;
  end;

  if AParams.ContainsKey('produto') then begin
    qrySearch.SQL.Add('and id_produto = :produto');
    qrySearch.ParamByName('produto').AsLargeInt := AParams.Items['produto'].ToInt64;
    qryRecordCount.SQL.Add('and id_produto = :produto');
    qryRecordCount.ParamByName('produto').AsLargeInt := AParams.Items['produto'].ToInt64;
  end;

//  if AParams.ContainsKey('nome') then begin
//    qrySearch.SQL.Add('and lower(nome) like :nome');
//    qrySearch.ParamByName('nome').AsString := '%' + AParams.Items['nome'].ToLower + '%';
//    qryRecordCount.SQL.Add('and lower(nome) like :nome');
//    qryRecordCount.ParamByName('nome').AsString := '%' + AParams.Items['nome'].ToLower + '%';
//  end;

  qrySearch.SQL.Add('order by id');

  Result := inherited Select(AParams);
end;

function TServicesPedidoItem.Select(const AParams: TDictionary<string, string>;
  const AIdPedido: string): TFDQuery;
begin
  qrySearch.ParamByName('id_pedido').AsLargeInt := AIdPedido.ToInt64;
  qryRecordCount.ParamByName('id_pedido').AsLargeInt := AIdPedido.ToInt64;
  Result := Select(AParams);
end;

function TServicesPedidoItem.Select(const AIdPedido, AIdItem: string): TFDQuery;
begin
  qryCRUDid_pedido.Visible := False;
  qryCRUD.SQL.Add('where i.id = :id_item');
  qryCRUD.SQL.Add('  and i.id_pedido = :id_pedido');
  qryCRUD.ParamByName('id_item').AsLargeInt := AIdItem.ToInt64;
  qryCRUD.ParamByName('id_pedido').AsLargeInt := AIdPedido.ToInt64;
  qryCRUD.Open();
  Result := qryCRUD;
end;

end.
