unit Services.Clientes;

interface

uses
  System.SysUtils, System.Classes, Services.Base.Cadastro, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TServiceClientes = class(TServiceBaseCadastro)
    mtPesquisastatus: TIntegerField;
    mtPesquisanome: TStringField;
    mtPesquisaid: TIntegerField;
    mtCadastroid: TLargeintField;
    mtCadastronome: TWideStringField;
    mtCadastrostatus: TSmallintField;
    procedure DataModuleCreate(Sender: TObject);
    procedure mtPesquisastatusGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure mtCadastroAfterInsert(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TServiceClientes.DataModuleCreate(Sender: TObject);
begin
  inherited;
  Request.BaseURL('http://localhost:9000')
    .Resource('clientes');
end;

procedure TServiceClientes.mtCadastroAfterInsert(DataSet: TDataSet);
begin
  inherited;
  mtCadastrostatus.AsInteger := 1;
end;

procedure TServiceClientes.mtPesquisastatusGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  Text := 'Ativo';

  if (Sender.AsInteger = 0) then
    Text := 'Inativo';
end;

end.