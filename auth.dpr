program auth;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  Horse,
  Horse.Jhonson,
  Horse.HandleException,
  Horse.JWT,
  System.SysUtils,
  Controllers_Auth in 'src\controllers\Controllers_Auth.pas',
  Providers_Connection in 'src\providers\Providers_Connection.pas' {ProvidersConnection: TDataModule},
  Services_Auth in 'src\services\Services_Auth.pas' {ServicesAuth: TDataModule};

begin
  THorse
    .Use(Jhonson())
    .Use(HandleException)
    .Use(HorseJWT('curso-rest-horse', THorseJWTConfig.New.SkipRoutes(['login'])));

  Controllers_Auth.Registry;

  THorse.Listen(8000);
end.
