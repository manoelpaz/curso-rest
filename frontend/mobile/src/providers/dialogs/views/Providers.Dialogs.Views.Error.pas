unit Providers.Dialogs.Views.Error;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, Providers.Frames.Base.View, FMX.Layouts,
  FMX.Objects, FMX.Controls.Presentation, FMX.Edit, FMXLabelEdit;

type
  TFrmDialogError = class(TFrameBaseView)
    retContent: TRectangle;
    retMessage: TRectangle;
    btnOK: TButton;
    retHeader: TRectangle;
    txtMensage: TText;
    Circle1: TCircle;
    imgError: TPath;
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

procedure TFrmDialogError.btnOKClick(Sender: TObject);
begin
  inherited;
  Self.Visible := False;
  Self.Owner.RemoveComponent(Self);
  Self.DisposeOf;
end;

end.
