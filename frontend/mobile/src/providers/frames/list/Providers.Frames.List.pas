unit Providers.Frames.List;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, Providers.Frames.Base, FMX.Objects,
  FMX.Controls.Presentation, Providers.CallBack;

type
  TFrameList = class(TFrameBase)
    retContent: TRectangle;
    btnListItem: TButton;
    lblDescricao: TLabel;
    lineSeparator: TLine;
    procedure btnListItemClick(Sender: TObject);
  private
    FIdentify: string;
    FCallBack: TCallBackIdentify;
  public
    property Identify: string read FIdentify write FIdentify;
    property CallBack: TCallBackIdentify read FCallBack write FCallBack;
  end;

implementation

{$R *.fmx}

procedure TFrameList.btnListItemClick(Sender: TObject);
begin
  inherited;
  if Assigned(FCallBack) then
    FCallBack(FIdentify);
end;

end.
