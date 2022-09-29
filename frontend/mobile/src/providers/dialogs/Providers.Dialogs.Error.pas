unit Providers.Dialogs.Error;

interface

uses Providers.Dialogs.Views.Error, FMX.Forms, FMX.Types;

type
  TDialogError = class
  public
    class procedure Show(const AMessage: string);
  end;

implementation

class procedure TDialogError.Show(const AMessage: string);
var
  LFrame: TFrmDialogError;
begin
  LFrame := TFrmDialogError.Create(Screen.ActiveForm);
  LFrame.Align := TAlignLayout.Client;
  LFrame.Parent := Screen.ActiveForm;
  LFrame.txtMensage.Text := AMessage;
end;

end.
