unit Views.Usuarios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Views.Base.Cadastro, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.WinXPanels, Services.Usuarios, Vcl.DBCtrls, Vcl.Mask;

type
  TFrmUsuarios = class(TFrmBaseCadastro)
    lblPesquisaCodigo: TLabel;
    lblPesquisaNome: TLabel;
    edtPesquisaCodigo: TEdit;
    edtPesquisaNome: TEdit;
    lblCodigo: TLabel;
    lblNome: TLabel;
    edtCodigo: TDBEdit;
    edtNome: TDBEdit;
    ckbStatus: TDBCheckBox;
    lblLogin: TLabel;
    edtLogin: TDBEdit;
    edtSenha: TDBEdit;
    lblSenha: TLabel;
    edtTelefone: TDBEdit;
    lblTelefone: TLabel;
    lblSexo: TLabel;
    btnAlterarFotoPerfil: TButton;
    btnLimparFotoPerfil: TButton;
    OpenDialog: TOpenDialog;
    pnlImage: TPanel;
    imgPerfil: TImage;
    cmbSexo: TDBComboBox;
    procedure dsCadastroStateChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnAlterarFotoPerfilClick(Sender: TObject);
    procedure btnLimparFotoPerfilClick(Sender: TObject);
  private
    function GetStreamFotoUsuario: TMemoryStream;
    procedure CarregarFotoUsuario;
  protected
    procedure DoBeforeList; override;
  end;

implementation

uses JPEG;

{$R *.dfm}

procedure TFrmUsuarios.btnAlterarFotoPerfilClick(Sender: TObject);
begin
  inherited;
  if OpenDialog.Execute then
    imgPerfil.Picture.LoadFromFile(OpenDialog.FileName);
end;

procedure TFrmUsuarios.btnConfirmarClick(Sender: TObject);
begin
  if (dsCadastro.DataSet.State in dsEditModes) then
    TServiceUsuarios(FService).mtCadastrosexo.AsInteger := cmbSexo.ItemIndex;
  inherited;
  TServiceUsuarios(FService).SalvarFotoUsuario(GetStreamFotoUsuario);
end;

procedure TFrmUsuarios.btnLimparFotoPerfilClick(Sender: TObject);
begin
  inherited;
  imgPerfil.Picture := nil;
end;

procedure TFrmUsuarios.CarregarFotoUsuario;
var
  LFoto: TMemoryStream;
  LJPEGImage: TJPEGImage;
begin
  LFoto := TServiceUsuarios(FService).DownloadFotoUsuario;
  try
    if (LFoto.Size = 0) then
    begin
      imgPerfil.Picture := nil;
      Exit;
    end;
    LJPEGImage := TJPEGImage.Create;
    try
      LJPEGImage.LoadFromStream(LFoto);
      imgPerfil.Picture.Assign(LJPEGImage);
    finally
      LJPEGImage.Free;
    end;
  finally
    LFoto.Free;
  end;
end;

procedure TFrmUsuarios.DoBeforeList;
begin
  inherited;
  FService.Request
    .ClearParams
    .AddParam('id', edtPesquisaCodigo.Text)
    .AddParam('nome', edtPesquisaNome.Text);
end;

procedure TFrmUsuarios.dsCadastroStateChange(Sender: TObject);
begin
  inherited;
  if (dsCadastro.DataSet.State in dsEditModes) then
  begin
    if (dsCadastro.DataSet.State = dsInsert) then
      imgPerfil.Picture := nil
    else
      CarregarFotoUsuario;
    edtNome.SetFocus;
  end;
end;

procedure TFrmUsuarios.FormCreate(Sender: TObject);
begin
  inherited;
  FService := TServiceUsuarios.Create(Self);
end;

procedure TFrmUsuarios.FormShow(Sender: TObject);
begin
  inherited;
  edtPesquisaCodigo.SetFocus;
end;

function TFrmUsuarios.GetStreamFotoUsuario: TMemoryStream;
begin
  Result := TMemoryStream.Create;
  imgPerfil.Picture.SaveToStream(Result);
end;

end.