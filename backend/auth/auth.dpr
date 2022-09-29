program auth;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Horse,
  Horse.Jhonson,
  Horse.HandleException,
  Providers.Connection in 'src\providers\Providers.Connection.pas' {ProvidersConnection: TDataModule},
  Controllers.Auth in 'src\controllers\Controllers.Auth.pas',
  Services.Auth in 'src\services\Services.Auth.pas' {ServiceAuth: TDataModule};

begin
  THorse
    .Use(Jhonson())
    .Use(HandleException);

  Controllers.Auth.Registry;

  THorse.Listen(8000);
end.