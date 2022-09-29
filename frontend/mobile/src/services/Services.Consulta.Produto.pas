unit Services.Consulta.Produto;

interface

uses
  System.SysUtils, System.Classes, Services.Base, Providers.Request, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TServiceConsultaProduto = class(TServiceBase)
    mtProdutos: TFDMemTable;
    mtProdutosid: TLargeintField;
    mtProdutosnome: TWideStringField;
    mtProdutosvalor: TFMTBCDField;
    mtProdutosstatus: TIntegerField;
    mtProdutosestoque: TFMTBCDField;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ListarProdutos(const ADescricao: string);
  end;

implementation

uses DataSet.Serialize, System.JSON;

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

{ TServiceConsultaProduto }

procedure TServiceConsultaProduto.ListarProdutos(const ADescricao: string);
var
  LResponse: IResponse;
begin
  if not mtProdutos.Active then
    mtProdutos.Open;
  mtProdutos.EmptyDataSet;
  LResponse := TRequest.New
    .BaseURL('http://localhost:9000')
    .Resource('produtos')
    .AddParam('nome', ADescricao)
    .Get;
  if LResponse.StatusCode <> 200 then
    raise Exception.Create(LResponse.Content);
  mtProdutos.LoadFromJSON(LResponse.JSONValue.GetValue<TJSONArray>('data'), False);
end;

end.
