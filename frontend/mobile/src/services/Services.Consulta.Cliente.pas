unit Services.Consulta.Cliente;

interface

uses
  System.SysUtils, System.Classes, Services.Base, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Providers.Request;

type
  TServiceConsultaCliente = class(TServiceBase)
    mtClientes: TFDMemTable;
    mtClientesid: TLargeintField;
    mtClientesnome: TWideStringField;
    mtClientesstatus: TIntegerField;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ListarClientes(const ANome: string);
  end;

implementation

uses DataSet.Serialize, System.JSON;

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

{ TServiceConsultaCliente }

procedure TServiceConsultaCliente.ListarClientes(const ANome: string);
var
  LResponse: IResponse;
begin
  if not mtClientes.Active then
    mtClientes.Open;
  mtClientes.EmptyDataSet;
  LResponse := TRequest.New
    .BaseURL('http://localhost:9000')
    .Resource('clientes')
    .AddParam('nome', ANome)
    .Get;
  if LResponse.StatusCode <> 200 then
    raise Exception.Create(LResponse.Content);
  mtClientes.LoadFromJSON(LResponse.JSONValue.GetValue<TJSONArray>('data'), False);
end;

end.
