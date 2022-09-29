unit Views.Login;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, Providers.Frames.Base.View, FMX.Layouts,
  FMX.Objects, FMX.Effects, FMX.Controls.Presentation, FMX.Edit, FMXLabelEdit, Services.Login, Views.Menu, Providers.Aguarde,
  Providers.Dialogs.Error;

type
  TFrmLogin = class(TFrameBaseView)
    retContent: TRectangle;
    retLogin: TRectangle;
    sdwLogin: TShadowEffect;
    lytLogo: TLayout;
    imgLogo: TPath;
    lytBemVindo: TLayout;
    lblBemVindo: TLabel;
    lytContentLogin: TLayout;
    edtUsuario: TLabelEdit;
    edtSenha: TLabelEdit;
    btnEntrar: TButton;
    lytFooter: TLayout;
    lblSolicitarAcesso: TLabel;
    lblRecuperarSenha: TLabel;
    procedure btnEntrarClick(Sender: TObject);
  private
    FService: TServiceLogin;
    procedure GoToMenu;
  public
    constructor Create(AOnwer: TComponent); override;
    destructor Destroy; override;
  end;

implementation

{$R *.fmx}

{ TFrmLogin }

procedure TFrmLogin.btnEntrarClick(Sender: TObject);
begin
  inherited;
  TAguarde.Aguardar(
    procedure
    begin
      try
        FService.Login(edtUsuario.Text, edtSenha.Text);
        TThread.Synchronize(TThread.Current,
          procedure
          begin
            edtUsuario.SetValue(EmptyStr);
            edtSenha.SetValue(EmptyStr);
            GoToMenu;
          end);
      except
        on E:Exception do
          TThread.Synchronize(TThread.Current,
            procedure
            begin
              TDialogError.Show(E.Message);
            end);
      end;
    end);
end;

constructor TFrmLogin.Create(AOnwer: TComponent);
begin
  inherited Create(AOnwer);
  FService := TServiceLogin.Create(Self);
end;

destructor TFrmLogin.Destroy;
begin
  FreeAndNil(FService);
  inherited;
end;

procedure TFrmLogin.GoToMenu;
var
  LFrmMenu: TFrmMenu;
begin
  LFrmMenu := TFrmMenu.Create(Self.Owner);
  LFrmMenu.Align := TAlignLayout.Contents;
  TLayout(Self.Owner).AddObject(LFrmMenu);
end;

end.
