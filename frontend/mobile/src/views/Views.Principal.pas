unit Views.Principal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Controls.Presentation, FMX.Edit, FMX.StdCtrls, FMXLabelEdit,
  FMX.Layouts, Views.Login;

type
  TFrmPrincipal = class(TForm)
    StyleBook: TStyleBook;
    lytContent: TLayout;
    procedure FormActivate(Sender: TObject);
  private
    FActived: Boolean;
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.fmx}

procedure TFrmPrincipal.FormActivate(Sender: TObject);
var
  LFrmLogin: TFrmLogin;
begin
  if FActived then
    Exit;
  LFrmLogin := TFrmLogin.Create(lytContent);
  LFrmLogin.Align := TAlignLayout.Contents;
  lytContent.AddObject(LFrmLogin);
  FActived := True;
end;

end.
