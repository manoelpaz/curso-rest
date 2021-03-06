unit Services.Produto;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.PG, FireDAC.Phys.PGDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, System.Generics.Collections, Providers.Queries;

type
  TServicesProduto = class(TProvidersQueries)
    qrySearchid: TLargeintField;
    qrySearchnome: TWideStringField;
    qrySearchvalor: TFMTBCDField;
    qrySearchstatus: TSmallintField;
    qrySearchestoque: TFMTBCDField;
    qryCRUDid: TLargeintField;
    qryCRUDnome: TWideStringField;
    qryCRUDvalor: TFMTBCDField;
    qryCRUDstatus: TSmallintField;
    qryCRUDestoque: TFMTBCDField;
  private
    { Private declarations }
  public
    { Public declarations }
    function Select(const AParams: TDictionary<string, string>): TFDQuery; override;
  end;

var
  ServicesProduto: TServicesProduto;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TServicesProduto }

function TServicesProduto.Select(
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
    qryRecordCount.ParamByName('status').AsSmallInt := AParams.Items['status'].ToInteger();
  end;

  qrySearch.SQL.Add('order by id');

  Result := inherited Select(AParams);
end;

end.
