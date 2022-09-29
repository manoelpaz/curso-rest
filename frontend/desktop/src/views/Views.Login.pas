unit Views.Login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls,
//  dxGDIPlusClasses,
  Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Services.Login, Views.Base;

type
  TFrmLogin = class(TFrmBase)
    pnlBackground: TPanel;
    imgLogo: TImage;
    lblUsuario: TLabel;
    edtUsuario: TEdit;
    edtSenha: TEdit;
    lblSenha: TLabel;
    btnEntrar: TButton;
    btnCancelar: TButton;
    procedure btnEntrarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FService: TServiceLogin;
  end;

implementation

//uses Providers.Session;

{$R *.dfm}

procedure TFrmLogin.btnEntrarClick(Sender: TObject);
begin
  FService.Login(edtUsuario.Text, edtSenha.Text);
  Close;
  ModalResult := mrOk;
end;

procedure TFrmLogin.FormCreate(Sender: TObject);
begin
  FService := TServiceLogin.Create(Self);
end;

procedure TFrmLogin.FormDestroy(Sender: TObject);
begin
  FService.Free;
end;

end.
