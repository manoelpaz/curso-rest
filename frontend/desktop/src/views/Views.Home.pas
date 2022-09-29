unit Views.Home;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Views.Base, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls;

type
  TFrmHome = class(TFrmBase)
    Image: TImage;
  end;

implementation

{$R *.dfm}

end.
