unit Services.Base;

interface

uses
  System.SysUtils, System.Classes, Providers.Session;

type
  TServiceBase = class(TDataModule)
  private
    { Private declarations }
  public
    { Public declarations }
    function Session: TSession;
  end;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

{ TServiceBase }

function TServiceBase.Session: TSession;
begin
  Result := TSession.GetInstance;
end;

end.
