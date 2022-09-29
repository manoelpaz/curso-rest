program Desktop;

uses
  Vcl.Forms,
  Views.Login in 'src\views\Views.Login.pas' {FrmLogin},
  Services.Login in 'src\services\Services.Login.pas' {ServiceLogin: TDataModule},
  Views.Base in 'src\views\Views.Base.pas' {FrmBase},
  Services.Base in 'src\services\Services.Base.pas' {ServiceBase: TDataModule},
  Services.Base.Cadastro in 'src\services\Services.Base.Cadastro.pas' {ServiceBaseCadastro: TDataModule},
  Providers.Session in 'src\providers\Providers.Session.pas',
  Providers.Models.Token in 'src\providers\models\Providers.Models.Token.pas',
  Services.Clientes in 'src\services\Services.Clientes.pas' {ServiceClientes: TDataModule},
  Views.Principal in 'src\views\Views.Principal.pas' {FrmPrincipal},
  Views.Home in 'src\views\Views.Home.pas' {FrmHome},
  Services.Produtos in 'src\services\Services.Produtos.pas' {ServiceProdutos: TDataModule},
  Views.Base.Cadastro in 'src\views\Views.Base.Cadastro.pas' {FrmBaseCadastro},
  Views.Clientes in 'src\views\Views.Clientes.pas' {FrmClientes},
  Views.Produtos in 'src\views\Views.Produtos.pas' {FrmProdutos},
  Views.Usuarios in 'src\views\Views.Usuarios.pas' {FrmUsuarios},
  Providers.Request.Intf in 'src\providers\request\Providers.Request.Intf.pas',
  Providers.Request in 'src\providers\request\Providers.Request.pas',
  Services.Usuarios in 'src\services\Services.Usuarios.pas' {ServiceUsuarios: TDataModule};

{$R *.res}

var
  FrmPrincipal: TFrmPrincipal;

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;
end.
