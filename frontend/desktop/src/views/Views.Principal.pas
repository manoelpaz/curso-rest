unit Views.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
//  dxGDIPlusClasses,
  Vcl.WinXCtrls, System.ImageList, Vcl.ImgList,
  System.Actions, Vcl.ActnList, Vcl.CategoryButtons, Views.Clientes, Views.Home,
  Views.Produtos,
  Views.Usuarios,
  Vcl.Imaging.pngimage;

type
  TFrmPrincipal = class(TForm)
    pnlToolBar: TPanel;
    imgMenu: TImage;
    lblTitle: TLabel;
    pnlContent: TPanel;
    SplitView: TSplitView;
    ImageList: TImageList;
    ActionList: TActionList;
    actHome: TAction;
    actClientes: TAction;
    actProdutos: TAction;
    actUsuarios: TAction;
    CategoryButtons: TCategoryButtons;
    procedure FormCreate(Sender: TObject);
    procedure imgMenuClick(Sender: TObject);
    procedure actHomeExecute(Sender: TObject);
    procedure actClientesExecute(Sender: TObject);
    procedure actProdutosExecute(Sender: TObject);
    procedure actUsuariosExecute(Sender: TObject);
  private
    FActiveForm: TForm;
    procedure Login;
    procedure ShowForm(const AFormClass: TComponentClass; var AForm);
  end;

implementation

uses Views.Login;

{$R *.dfm}

procedure TFrmPrincipal.actClientesExecute(Sender: TObject);
var
  LForm: TFrmClientes;
begin
  ShowForm(TFrmClientes, LForm);
end;

procedure TFrmPrincipal.actHomeExecute(Sender: TObject);
var
  LForm: TFrmHome;
begin
  ShowForm(TFrmHome, LForm);
end;

procedure TFrmPrincipal.actProdutosExecute(Sender: TObject);
var
  LForm: TFrmProdutos;
begin
  ShowForm(TFrmProdutos, LForm);
end;

procedure TFrmPrincipal.actUsuariosExecute(Sender: TObject);
var
  LForm: TFrmUsuarios;
begin
  ShowForm(TFrmUsuarios, LForm);
end;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
begin
  Login;
end;

procedure TFrmPrincipal.imgMenuClick(Sender: TObject);
begin
  if SplitView.Opened then
  begin
    SplitView.Close;
    CategoryButtons.ButtonOptions := CategoryButtons.ButtonOptions - [boShowCaptions];
  end
  else
  begin
    SplitView.Open;
    CategoryButtons.ButtonOptions := CategoryButtons.ButtonOptions + [boShowCaptions];
  end;
end;

procedure TFrmPrincipal.Login;
var
  LForm: TFrmLogin;
begin
  LForm := TFrmLogin.Create(Self);
  try
    if LForm.ShowModal <> mrOk then
      Application.Terminate;
  finally
    LForm.Free;
  end;
end;

procedure TFrmPrincipal.ShowForm(const AFormClass: TComponentClass; var AForm);
begin
  if Assigned(FActiveForm) then
    FActiveForm.Close;
  Application.CreateForm(AFormClass, AForm);
  TForm(AForm).Parent := pnlContent;
  TForm(AForm).Align := TAlign.alClient;
  TForm(AForm).WindowState := TWindowState.wsMaximized;
  TForm(AForm).Show;
  FActiveForm := TForm(AForm);
end;

end.