program Mobile;

uses
  System.StartUpCopy,
  FMX.Forms,
  Views.Principal in 'src\views\Views.Principal.pas' {FrmPrincipal},
  Providers.Session in 'src\providers\Providers.Session.pas',
  Providers.Models.Token in 'src\providers\models\Providers.Models.Token.pas',
  Providers.Request.Intf in 'src\providers\request\Providers.Request.Intf.pas',
  Providers.Request in 'src\providers\request\Providers.Request.pas',
  Providers.Frames.Base in 'src\providers\frames\Providers.Frames.Base.pas' {FrameBase: TFrame},
  Providers.Frames.Base.View in 'src\providers\frames\Providers.Frames.Base.View.pas' {FrameBaseView: TFrame},
  Views.Login in 'src\views\Views.Login.pas' {FrmLogin: TFrame},
  Services.Base in 'src\services\Services.Base.pas' {ServiceBase: TDataModule},
  Services.Login in 'src\services\Services.Login.pas' {ServiceLogin: TDataModule},
  Views.Menu in 'src\views\Views.Menu.pas' {FrmMenu: TFrame},
  Views.Home in 'src\views\Views.Home.pas' {FrmHome: TFrame},
  Views.Perfil in 'src\views\Views.Perfil.pas' {FrmPerfil: TFrame},
  Providers.Models.User in 'src\providers\models\Providers.Models.User.pas',
  Services.Perfil in 'src\services\Services.Perfil.pas' {ServicePerfil: TDataModule},
  Views.Pedido in 'src\views\Views.Pedido.pas' {FrmPedido: TFrame},
  Services.Pedido in 'src\services\Services.Pedido.pas' {ServicePedido: TDataModule},
  Providers.Frames.Pedido in 'src\providers\frames\Providers.Frames.Pedido.pas' {FramePedido: TFrame},
  Providers.Aguarde in 'src\providers\aguarde\Providers.Aguarde.pas',
  Providers.Aguarde.Frame in 'src\providers\aguarde\Providers.Aguarde.Frame.pas' {FrameAguarde: TFrame},
  Views.Consulta.Cliente in 'src\views\Views.Consulta.Cliente.pas' {FrmConsultaCliente: TFrame},
  Services.Consulta.Cliente in 'src\services\Services.Consulta.Cliente.pas' {ServiceConsultaCliente: TDataModule},
  Providers.Frames.List in 'src\providers\frames\list\Providers.Frames.List.pas' {FrameList: TFrame},
  Providers.CallBack in 'src\providers\callback\Providers.CallBack.pas',
  Views.Consulta.Produto in 'src\views\Views.Consulta.Produto.pas' {FrmConsultaProduto: TFrame},
  Services.Consulta.Produto in 'src\services\Services.Consulta.Produto.pas' {ServiceConsultaProduto: TDataModule},
  Providers.Frames.List.Produto in 'src\providers\frames\list\Providers.Frames.List.Produto.pas' {FrameListProduto: TFrame},
  Providers.Frames.Pedido.Item in 'src\providers\frames\Providers.Frames.Pedido.Item.pas' {FramePedidoItem: TFrame},
  Providers.Dialogs.Error in 'src\providers\dialogs\Providers.Dialogs.Error.pas',
  Providers.Dialogs.Input in 'src\providers\dialogs\Providers.Dialogs.Input.pas',
  Providers.Dialogs.Views.Error in 'src\providers\dialogs\views\Providers.Dialogs.Views.Error.pas' {FrmDialogError: TFrame},
  Providers.Dialogs.Views.Input in 'src\providers\dialogs\views\Providers.Dialogs.Views.Input.pas' {FrmDialogsInput: TFrame};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;
end.
