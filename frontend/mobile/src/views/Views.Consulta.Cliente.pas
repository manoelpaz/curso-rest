unit Views.Consulta.Cliente;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, Data.DB,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, Providers.Frames.Base.View, FMX.Layouts,
  FMX.Objects, FMX.Controls.Presentation, FMX.Edit, FMX.Effects, Services.Consulta.Cliente, Providers.Aguarde,
  Providers.Frames.List, System.Generics.Collections, Providers.CallBack;

type
  TFrmConsultaCliente = class(TFrameBaseView)
    retHeader: TRectangle;
    btnVoltar: TButton;
    imgVoltar: TPath;
    btnBuscar: TButton;
    imgBuscar: TPath;
    edtPesquisa: TEdit;
    ShadowEffect: TShadowEffect;
    retContent: TRectangle;
    lytBuscaVazia: TLayout;
    txtBuscaVazia: TLabel;
    imgBuscaVazia: TPath;
    vsbClientes: TVertScrollBox;
    procedure btnBuscarClick(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
  private
    { Private declarations }
    FService: TServiceConsultaCliente;
    FListaFrames: TObjectList<TFrameList>;
    FCallBack: TCallBackDataSet;
    procedure DesignClientes;
    procedure OnSelectClient(const AValue: string);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    property CallBack: TCallBackDataSet read FCallBack write FCallBack;
    destructor Destroy; override;
  end;

implementation

{$R *.fmx}

{ TFrmConsultaCliente }

procedure TFrmConsultaCliente.btnBuscarClick(Sender: TObject);
begin
  inherited;
  TAguarde.Aguardar(
    procedure
    begin
      FService.ListarClientes(edtPesquisa.Text);
      TThread.Synchronize(TThread.Current,
        procedure
        begin
          DesignClientes;
        end);
    end);
end;

procedure TFrmConsultaCliente.btnVoltarClick(Sender: TObject);
begin
  inherited;
  Self.Owner.RemoveComponent(Self);
  Self.DisposeOf;
end;

constructor TFrmConsultaCliente.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FService := TServiceConsultaCliente.Create(Self);
  FListaFrames := TObjectList<TFrameList>.Create;
end;

procedure TFrmConsultaCliente.DesignClientes;
var
  LFrame: TFrameList;
begin
  lytBuscaVazia.Visible := FService.mtClientes.IsEmpty;
  vsbClientes.Visible := not FService.mtClientes.IsEmpty;
  if lytBuscaVazia.Visible then
    Exit;
  vsbClientes.BeginUpdate;
  try
    FListaFrames.Clear;
    FService.mtClientes.First;
    while not FService.mtClientes.Eof do
    begin
      LFrame := TFrameList.Create(vsbClientes);
      LFrame.Align := TAlignLayout.Top;
      LFrame.Identify := FService.mtClientesid.AsString;
      LFrame.lblDescricao.Text := FService.mtClientesnome.AsString;
      LFrame.Name := LFrame.ClassName + vsbClientes.Content.ControlsCount.ToString;
      LFrame.Parent := vsbClientes;
      LFrame.CallBack := Self.OnSelectClient;
      FListaFrames.Add(LFrame);
      FService.mtClientes.Next;
    end;
  finally
    vsbClientes.EndUpdate;
  end;
end;

destructor TFrmConsultaCliente.Destroy;
begin
  FService.Free;
  FListaFrames.Free;
  inherited;
end;

procedure TFrmConsultaCliente.OnSelectClient(const AValue: string);
begin
  FService.mtClientes.Locate('id', AValue);
  if Assigned(FCallBack) then
    FCallBack(FService.mtClientes);
  Self.Owner.RemoveComponent(Self);
  Self.DisposeOf;
end;

end.
