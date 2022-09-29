unit Views.Menu;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, Providers.Frames.Base.View, FMX.Layouts,
  FMX.Objects, FMX.Controls.Presentation, Views.Home, FMX.MultiView, Views.Perfil, Views.Pedido;

type
  TFrmMenu = class(TFrameBaseView)
    retHeader: TRectangle;
    btnMenu: TButton;
    imgMenu: TPath;
    lytActiveForm: TLayout;
    MultiView: TMultiView;
    retContentMultiView: TRectangle;
    btnHome: TButton;
    imgHome: TPath;
    lblHome: TLabel;
    btnLogout: TButton;
    imgLogout: TPath;
    lblLogout: TLabel;
    btnPedido: TButton;
    imgPedido: TPath;
    lblPedido: TLabel;
    btnPerfil: TButton;
    imgPerfil: TPath;
    lblPerfil: TLabel;
    lineSeparator: TLine;
    procedure btnHomeClick(Sender: TObject);
    procedure btnPerfilClick(Sender: TObject);
    procedure btnPedidoClick(Sender: TObject);
    procedure btnLogoutClick(Sender: TObject);
  private
    FActiveFrame: TFrameBaseView;
    procedure ChangeFrame<T: TFrameBaseView>;
    procedure GoHome;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

implementation

{$R *.fmx}

{ TFrmMenu }

procedure TFrmMenu.ChangeFrame<T>;
begin
  if (FActiveFrame <> nil) then
  begin
    lytActiveForm.RemoveObject(FActiveFrame);
    FActiveFrame.DisposeOf;
  end;
  FActiveFrame := T.Create(lytActiveForm);
  FActiveFrame.Align := TAlignLayout.Contents;
  lytActiveForm.AddObject(FActiveFrame);
  FActiveFrame.DoAfterShow;
  if MultiView.IsShowed then
    MultiView.HideMaster;
end;

procedure TFrmMenu.btnHomeClick(Sender: TObject);
begin
  inherited;
  ChangeFrame<TFrmHome>;
end;

procedure TFrmMenu.btnLogoutClick(Sender: TObject);
begin
  inherited;
  Self.DisposeOf;
end;

procedure TFrmMenu.btnPedidoClick(Sender: TObject);
begin
  inherited;
  ChangeFrame<TFrmPedido>;
end;

procedure TFrmMenu.btnPerfilClick(Sender: TObject);
begin
  inherited;
  ChangeFrame<TFrmPerfil>;
end;

constructor TFrmMenu.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FActiveFrame := nil;
  GoHome;
end;

destructor TFrmMenu.Destroy;
begin
  if (FActiveFrame <> nil) then
  begin
    lytActiveForm.RemoveObject(FActiveFrame);
    FActiveFrame.DisposeOf;
  end;
  inherited;
end;

procedure TFrmMenu.GoHome;
begin
  ChangeFrame<TFrmHome>;
end;

end.
