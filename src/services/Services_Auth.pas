unit Services_Auth;

interface

uses
  System.SysUtils, System.Classes, Providers_Connection, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.PG, FireDAC.Phys.PGDef, FireDAC.ConsoleUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TServicesAuth = class(TProvidersConnection)
    qryLogin: TFDQuery;
    qryLoginid: TLargeintField;
    qryLoginsenha: TWideStringField;
  private
    { Private declarations }
  public
    { Public declarations }
    function PermitirAcesso(const AUsuario, ASenha: string): Boolean;
  end;

var
  ServicesAuth: TServicesAuth;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TServicesAuth }

uses BCrypt;

function TServicesAuth.PermitirAcesso(const AUsuario, ASenha: string): Boolean;
begin
  qryLogin.ParamByName('plogin').AsString := AUsuario;
  qryLogin.Open();
  if qryLogin.IsEmpty then
    Exit(False);

  Result := TBCrypt.CompareHash(ASenha, qryLoginsenha.AsString);
end;

end.
