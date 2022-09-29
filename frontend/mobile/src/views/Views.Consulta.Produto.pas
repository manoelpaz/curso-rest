unit Views.Consulta.Produto;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, Data.DB,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, Providers.Frames.Base.View, FMX.Layouts,
  FMX.Effects, FMX.Edit, FMX.Objects, FMX.Controls.Presentation, Services.Consulta.Produto,
  System.Generics.Collections, Providers.CallBack, Providers.Aguarde, Providers.Frames.List.Produto;

type
  TFrmConsultaProduto = class(TFrameBaseView)
    retContent: TRectangle;
    vsbProdutos: TVertScrollBox;
    lytBuscaVazia: TLayout;
    txtBuscaVazia: TLabel;
    imgBuscaVazia: TPath;
    retHeader: TRectangle;
    btnVoltar: TButton;
    imgVoltar: TPath;
    btnBuscar: TButton;
    imgBuscar: TPath;
    edtPesquisa: TEdit;
    ShadowEffect: TShadowEffect;
    procedure btnVoltarClick(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
  private
    { Private declarations }
    FService: TServiceConsultaProduto;
    FCallBack: TCallBackDataSet;
    FListaFrames: TObjectList<TFrameListProduto>;
    procedure DesignProdutos;
    procedure OnSelectProduto(const AValue: string);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    property CallBack: TCallBackDataSet read FCallBack write FCallBack;
    destructor Destroy; override;
  end;

implementation

{$R *.fmx}

procedure TFrmConsultaProduto.btnBuscarClick(Sender: TObject);
begin
  inherited;
  TAguarde.Aguardar(
    procedure
    begin
      FService.ListarProdutos(edtPesquisa.Text);
      TThread.Synchronize(TThread.Current,
        procedure
        begin
          DesignProdutos;
        end);
    end);
end;

procedure TFrmConsultaProduto.btnVoltarClick(Sender: TObject);
begin
  inherited;
  Self.Owner.RemoveComponent(Self);
  Self.DisposeOf;
end;

constructor TFrmConsultaProduto.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FService := TServiceConsultaProduto.Create(Self);
  FListaFrames := TObjectList<TFrameListProduto>.Create;
end;

procedure TFrmConsultaProduto.DesignProdutos;
var
  LFrame: TFrameListProduto;
begin
  lytBuscaVazia.Visible := FService.mtProdutos.IsEmpty;
  vsbProdutos.Visible := not FService.mtProdutos.IsEmpty;
  if lytBuscaVazia.Visible then
    Exit;
  vsbProdutos.BeginUpdate;
  try
    FListaFrames.Clear;
    FService.mtProdutos.First;
    while not FService.mtProdutos.Eof do
    begin
      LFrame := TFrameListProduto.Create(vsbProdutos);
      LFrame.Align := TAlignLayout.Top;
      LFrame.Identify := FService.mtProdutosid.AsString;
      LFrame.lblDescricao.Text := FService.mtProdutosnome.AsString;
      LFrame.txtEstoque.Text := 'Estoque: ' + FService.mtProdutosestoque.AsString;
      LFrame.txtValorProduto.Text := FormatFloat('R$ ,0.00', FService.mtProdutosvalor.AsCurrency);
      LFrame.Name := LFrame.ClassName + vsbProdutos.Content.ControlsCount.ToString;
      LFrame.Parent := vsbProdutos;
      LFrame.CallBack := Self.OnSelectProduto;
      FListaFrames.Add(LFrame);
      FService.mtProdutos.Next;
    end;
  finally
    vsbProdutos.EndUpdate;
  end;
end;

destructor TFrmConsultaProduto.Destroy;
begin
  FService.Free;
  FListaFrames.Free;
  inherited;
end;

procedure TFrmConsultaProduto.OnSelectProduto(const AValue: string);
begin
  FService.mtProdutos.Locate('id', AValue);
  if Assigned(FCallBack) then
    FCallBack(FService.mtProdutos);
  Self.Owner.RemoveComponent(Self);
  Self.DisposeOf;
end;

end.
