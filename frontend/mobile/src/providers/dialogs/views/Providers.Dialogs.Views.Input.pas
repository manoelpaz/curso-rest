unit Providers.Dialogs.Views.Input;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, Providers.Frames.Base.View, FMX.Layouts,
  FMX.Objects, FMX.Controls.Presentation, FMX.Edit, FMXLabelEdit, Providers.CallBack;

type
  TFrmDialogsInput = class(TFrameBaseView)
    retContent: TRectangle;
    retMessage: TRectangle;
    edtInput: TLabelEdit;
    btnOK: TButton;
    btnCancelar: TButton;
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
  private
    FCallBack: TCallBackInput;
  public
    property CallBack: TCallBackInput read FCallBack write FCallBack;
  end;

implementation

{$R *.fmx}

procedure TFrmDialogsInput.btnCancelarClick(Sender: TObject);
begin
  inherited;
  Self.Visible := False;
  Self.Owner.RemoveComponent(Self);
  Self.DisposeOf;
end;

procedure TFrmDialogsInput.btnOKClick(Sender: TObject);
begin
  inherited;
  Self.Visible := False;
  if Assigned(FCallBack) then
    FCallBack(edtInput.Text);
  Self.Owner.RemoveComponent(Self);
  Self.DisposeOf;
end;

end.
