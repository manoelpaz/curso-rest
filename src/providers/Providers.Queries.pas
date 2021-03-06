unit Providers.Queries;

interface

uses
  System.SysUtils, System.Classes, Providers.Connection, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.PG, FireDAC.Phys.PGDef, FireDAC.ConsoleUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet,
  System.JSON, System.Generics.Collections, FireDAC.VCLUI.Wait;

type
  TProvidersQueries = class(TProvidersConnection)
    qrySearch: TFDQuery;
    qryRecordCount: TFDQuery;
    qryCRUD: TFDQuery;
    qryRecordCountCOUNT: TLargeintField;
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create; reintroduce;
    function Insert(const AJson: TJSONObject): Boolean; virtual;
    function Update(const AJson: TJSONObject): Boolean; virtual;
    function Delete: Boolean; virtual;
    function Select(const AParams: TDictionary<string, string>): TFDQuery; overload; virtual;
    function Select(const AId: string): TFDQuery; overload; virtual;
    function Select: Int64; overload; virtual;
  end;

var
  ProvidersQueries: TProvidersQueries;

implementation

uses DataSet.Serialize;

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TProvidersQueries }

constructor TProvidersQueries.Create;
begin
  inherited Create(nil);
end;

function TProvidersQueries.Delete: Boolean;
begin
  qryCRUD.Delete;
  Result := qryCRUD.ApplyUpdates(0) = 0;
end;

function TProvidersQueries.Insert(const AJson: TJSONObject): Boolean;
begin
  qryCRUD.SQL.Add('where 1 <> 1');
  qryCRUD.Open();
  qryCRUD.LoadFromJSON(AJson, False);
  Result := qryCRUD.ApplyUpdates(0) = 0;
end;

function TProvidersQueries.Select: Int64;
begin
  qryRecordCount.Open();
  Result := qryRecordCountCOUNT.AsLargeInt;
end;

function TProvidersQueries.Select(const AId: string): TFDQuery;
begin
  qryCRUD.SQL.Add('where id = :id');
  qryCRUD.ParamByName('id').AsLargeInt := AId.ToInt64;
  qryCRUD.Open();
  Result := qryCRUD;
end;

function TProvidersQueries.Select(
  const AParams: TDictionary<string, string>): TFDQuery;
begin
  if AParams.ContainsKey('limit') then begin
    qrySearch.FetchOptions.RecsMax := StrToIntDef(AParams.Items['limit'], 50);
    qrySearch.FetchOptions.RowsetSize := StrToIntDef(AParams.Items['limit'], 50);
  end;

  if AParams.ContainsKey('offset') then
    qrySearch.FetchOptions.RecsSkip := StrToIntDef(AParams.Items['offset'], 0);

  qrySearch.Open();
  Result := qrySearch;
end;

function TProvidersQueries.Update(const AJson: TJSONObject): Boolean;
begin
  qryCRUD.MergeFromJSONObject(AJson, False);
  Result := qryCRUD.ApplyUpdates(0) = 0;
end;

end.
