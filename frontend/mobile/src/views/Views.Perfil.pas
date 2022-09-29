unit Views.Perfil;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, Providers.Frames.Base.View, FMX.Layouts,
  FMX.Objects, FMX.Controls.Presentation, Providers.Request, Services.Perfil, FMX.MultiView;

type
  TFrmPerfil = class(TFrameBaseView)
    retContent: TRectangle;
    lytHeader: TLayout;
    lytUsuario: TLayout;
    lytTelefone: TLayout;
    lblUsuario: TLabel;
    txtUsuario: TLabel;
    txtTelefone: TLabel;
    lblTelefone: TLabel;
    imgPerfil: TCircle;
    txtSexo: TLabel;
    txtNome: TLabel;
    btnTrocarFoto: TButton;
    imgMenu: TPath;
    MultiView: TMultiView;
    retContentMultiView: TRectangle;
    btnGaleria: TButton;
    imgGaleria: TPath;
    lblGaleria: TLabel;
    btnCamera: TButton;
    imgCamera: TPath;
    lblCamera: TLabel;
    OpenDialog: TOpenDialog;
    procedure btnGaleriaClick(Sender: TObject);
  private
    FService: TServicePerfil;
    procedure CarregarFotoUsuario;
    procedure OnChangeProfileImage(const ABitmap: TBitmap);
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation

{$R *.fmx}

{ TFrmPerfil }

procedure TFrmPerfil.btnGaleriaClick(Sender: TObject);
begin
  inherited;
{$IFDEF MSWINDOWS}
  if OpenDialog.Execute then
    OnChangeProfileImage(TBitmap.CreateFromFile(OpenDialog.FileName));
{$ENDIF}
end;

procedure TFrmPerfil.CarregarFotoUsuario;
var
  LFoto: TMemoryStream;
begin
  LFoto := FService.DownloadFoto;
  try
    if (LFoto.Size > 0) then
      imgPerfil.Fill.Bitmap.Bitmap.LoadFromStream(LFoto);
  finally
    LFoto.Free;
  end;
end;

constructor TFrmPerfil.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FService := TServicePerfil.Create(Self);
  txtNome.Text := Session.User.Nome;
  txtSexo.Text := Session.User.GetSexoAsString;
  txtUsuario.Text := Session.User.Login;
  txtTelefone.Text := Session.User.Telefone;
  MultiView.Height := 100;
  CarregarFotoUsuario;
end;

procedure TFrmPerfil.OnChangeProfileImage(const ABitmap: TBitmap);
var
  LFoto: TMemoryStream;
begin
  LFoto := TMemoryStream.Create;
  try
    ABitmap.SaveToStream(LFoto);
    LFoto.Position := 0;
    if (LFoto.Size > 0) then
      imgPerfil.Fill.Bitmap.Bitmap.LoadFromStream(LFoto);
    LFoto.Position := 0;
    FService.UploadFoto(LFoto);
  finally
    LFoto.Free;
  end;
  MultiView.HideMaster;
end;

end.
