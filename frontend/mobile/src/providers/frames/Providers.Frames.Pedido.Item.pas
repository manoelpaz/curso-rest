unit Providers.Frames.Pedido.Item;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, Providers.Frames.Base, FMX.Objects,
  FMX.Controls.Presentation, Providers.Dialogs.Input;

type
  TFramePedidoItem = class(TFrameBase)
    retContent: TRectangle;
    lineSeparator: TLine;
    txtQuantidade: TLabel;
    txtDescricao: TLabel;
    txtValorProduto: TLabel;
    btnExcluir: TButton;
    imgExcluir: TPath;
    bnEditar: TButton;
    imgEditar: TPath;
    procedure btnExcluirClick(Sender: TObject);
    procedure bnEditarClick(Sender: TObject);
  private
    FIdentify: string;
    FIdProduto: string;
    FOnDeleteItem: TNotifyEvent;
    FOnEditItem: TNotifyEvent;
    { Private declarations }
  public
    { Public declarations }
    property Identify: string read FIdentify write FIdentify;
    property IdProduto: string read FIdProduto write FIdProduto;
    property OnDeleteItem: TNotifyEvent read FOnDeleteItem write FOnDeleteItem;
    property OnEditItem: TNotifyEvent read FOnEditItem write FOnEditItem;
  end;

implementation

{$R *.fmx}

procedure TFramePedidoItem.bnEditarClick(Sender: TObject);
begin
  inherited;
  TDialogInput.Show('Quantidade', txtQuantidade.Text,
    procedure(const AResponse: string)
    begin
      if AResponse.Trim.IsEmpty or (StrToIntDef(AResponse, 0) <= 0) then
        Exit;
      txtQuantidade.Text := AResponse;
      if Assigned(FOnEditItem) then
        FOnEditItem(Self);
    end);
end;

procedure TFramePedidoItem.btnExcluirClick(Sender: TObject);
begin
  inherited;
  if Assigned(FOnDeleteItem) then
    FOnDeleteItem(Self);
end;

end.
