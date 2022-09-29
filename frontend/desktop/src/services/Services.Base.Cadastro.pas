unit Services.Base.Cadastro;

interface

uses
  System.SysUtils, System.Classes, Services.Base, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Providers.Session;

type
  TServiceBaseCadastro = class(TServiceBase)
    mtPesquisa: TFDMemTable;
    mtCadastro: TFDMemTable;
    procedure DataModuleCreate(Sender: TObject);
  private
    FRecords: Integer;
    FPageLimit: Integer;
    FPage: Integer;
    FPages: Integer;
    function GetResourceSuffix: string;
  public
    property Records: Integer read FRecords write FRecords;
    property PageLimit: Integer read FPageLimit write FPageLimit;
    property Page: Integer read FPage write FPage;
    property Pages: Integer read FPages write FPages;
    procedure Alterar; virtual;
    procedure Excluir; virtual;
    procedure Incluir; virtual;
    procedure ListarRegistro; virtual;
    procedure Salvar; virtual;
  end;

implementation

uses Providers.Request, DataSet.Serialize, System.JSON;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TServiceBaseCadastro }

procedure TServiceBaseCadastro.Alterar;
var
  LResponse: IResponse;

begin
  if (not mtPesquisa.Active) or (mtPesquisa.IsEmpty) then
    raise Exception.Create('Selecione um registro para alterar');

  LResponse := Request.ResourceSuffix(GetResourceSuffix).Get;

  if (LResponse.StatusCode <> 200) then
    raise Exception.Create(LResponse.Content);

  if mtCadastro.Active then
    mtCadastro.EmptyDataSet;

  mtCadastro.LoadFromJSON(LResponse.Content);
  mtCadastro.Edit;
end;

procedure TServiceBaseCadastro.DataModuleCreate(Sender: TObject);
begin
  inherited;
  FRecords := 0;
  FPageLimit := 50;
  FPage := 1;
  FPages := 1;
end;

procedure TServiceBaseCadastro.Excluir;
var
  LResponse: IResponse;

begin
  if (not mtPesquisa.Active) or (mtPesquisa.IsEmpty) then
    raise Exception.Create('Selecione um registro para excluir');

  LResponse := Request.ResourceSuffix(GetResourceSuffix).Delete;

  if (LResponse.StatusCode <> 204) then
    raise Exception.Create(LResponse.Content);

  mtPesquisa.Delete;
end;

function TServiceBaseCadastro.GetResourceSuffix: string;
var
  LField: TField;
begin
  for LField in mtPesquisa.Fields do begin
    if (pfInKey in LField.ProviderFlags) then
      Exit(LField.AsString);
  end;
end;

procedure TServiceBaseCadastro.Incluir;
begin
  if not mtCadastro.Active then
    mtCadastro.Open;

  mtCadastro.Append;
end;

procedure TServiceBaseCadastro.ListarRegistro;
var
  LResponse: IResponse;

begin
  mtPesquisa.DisableControls;
  try
    LResponse := Request
      .ResourceSuffix(EmptyStr)
      .AddParam('limit', FPageLimit.ToString)
      .AddParam('offset', (Pred(FPage) * FPageLimit).ToString)
      .Get;

    if (LResponse.StatusCode <> 200) then
      raise Exception.Create(LResponse.Content);

    if mtPesquisa.Active then
      mtPesquisa.EmptyDataSet;

    mtPesquisa.LoadFromJSON(LResponse.JSONValue.GetValue<TJSONArray>('data'), False);
    FRecords := LResponse.JSONValue.GetValue<Integer>('records');
  finally
    mtPesquisa.EnableControls;
  end;
end;

procedure TServiceBaseCadastro.Salvar;
var
  LResponse: IResponse;

begin
  mtPesquisa.DisableControls;
  try
    Request.ClearBody.AddBody(mtCadastro.ToJSONObject);

    if (mtCadastro.State = dsEdit) then
      LResponse := Request.Put
    else
      LResponse := Request.ResourceSuffix(EmptyStr).Post;

    if not (LResponse.StatusCode in [201, 204]) then
      raise Exception.Create(LResponse.Content);

    if not mtPesquisa.Active then
      mtPesquisa.Open;

    if (mtCadastro.State = dsEdit) then
      mtPesquisa.MergeFromJSONObject(mtCadastro.ToJSONObject)
    else
      mtPesquisa.LoadFromJSON(LResponse.Content);

    mtCadastro.Cancel;
  finally
    mtPesquisa.EnableControls;
  end;
end;

end.
