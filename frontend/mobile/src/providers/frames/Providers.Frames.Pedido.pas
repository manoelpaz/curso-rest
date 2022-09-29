unit Providers.Frames.Pedido;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, Providers.Frames.Base, FMX.Controls.Presentation,
  FMX.Objects, FMX.Layouts;

type
  TFramePedido = class(TFrameBase)
    retDadosPedidos: TRectangle;
    retDadosCliente: TRectangle;
    retDadosValores: TRectangle;
    imgLogo: TPath;
    lytVenda: TLayout;
    lblNumero: TLabel;
    txtNumero: TLabel;
    btnEditar: TButton;
    imgEditar: TPath;
    btnExcluir: TButton;
    imgExcluir: TPath;
    Layout1: TLayout;
    Path1: TPath;
    txtNomeCliente: TLabel;
    Layout2: TLayout;
    Path2: TPath;
    txtDataVenda: TLabel;
    Layout3: TLayout;
    Path3: TPath;
    txtValorVenda: TLabel;
    lineSeparator: TLine;
    procedure btnExcluirClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
  private
    FOnDeletePedido: TNotifyEvent;
    FIdentify: string;
    FOnEditPedido: TNotifyEvent;
  public
    property Identify: string read FIdentify write FIdentify;
    property OnDeletePedido: TNotifyEvent read FOnDeletePedido write FOnDeletePedido;
    property OnEditPedido: TNotifyEvent read FOnEditPedido write FOnEditPedido;
  end;

implementation

{$R *.fmx}

procedure TFramePedido.btnEditarClick(Sender: TObject);
begin
  inherited;
  if Assigned(FOnEditPedido) then
    FOnEditPedido(Self);
end;

procedure TFramePedido.btnExcluirClick(Sender: TObject);
begin
  inherited;
  if Assigned(FOnDeletePedido) then
    FOnDeletePedido(Self);
end;

end.
