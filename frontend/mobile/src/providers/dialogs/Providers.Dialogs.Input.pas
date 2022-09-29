unit Providers.Dialogs.Input;

interface

uses Providers.CallBack, Providers.Dialogs.Views.Input, FMX.Types, FMX.Forms;

type
  TDialogInput = class
  public
    class procedure Show(const APrompt, ADefaultText: string; const ACallBack: TCallBackInput);
  end;

implementation

class procedure TDialogInput.Show(const APrompt, ADefaultText: string; const ACallBack: TCallBackInput);
var
  LFrame: TFrmDialogsInput;
begin
  LFrame := TFrmDialogsInput.Create(Screen.ActiveForm);
  LFrame.CallBack := ACallBack;
  LFrame.edtInput.TextPrompt := APrompt;
  LFrame.edtInput.SetValue(ADefaultText);
  LFrame.Align := TAlignLayout.Client;
  LFrame.Parent := Screen.ActiveForm;
  LFrame.edtInput.Focus;
end;

end.
