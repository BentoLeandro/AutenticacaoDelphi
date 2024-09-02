unit Controllers_Auth;

interface

procedure Registry;

implementation

uses Horse, Horse.JWT, System.JSON, Services_Auth, JOSE.Core.JWT, JOSE.Core.Builder,
     System.SysUtils, System.DateUtils;

function GetToken(const AIdUsuario: string; const AExpiration: TDateTime): string;
var
  LJWT : TJWT;
begin
  LJWT := TJWT.Create;
  try
    LJWT.Claims.IssuedAt := Now;
    LJWT.Claims.Expiration := AExpiration;
    LJWT.Claims.Subject := AIdUsuario;

    Result := TJOSE.SHA256CompactToken('curso-rest-horse', LJWT);
  finally
    LJWT.Free;
  end;

end;

procedure EfetuarLogin(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LConteudo, LToken : TJSONObject;
  LUsuario, LSenha : string;
  LService  : TServicesAuth;
begin
  LConteudo := Req.Body<TJSONObject>;
  if not LConteudo.TryGetValue<string>('username', LUsuario) then
    raise EHorseException.New.Status(THTTPStatus.BadRequest).Error('Usuário não Informado!');

  if not LConteudo.TryGetValue<string>('password', LSenha) then
    raise EHorseException.New.Status(THTTPStatus.BadRequest).Error('Senha não Informada!');

  LService := TServicesAuth.Create(nil);
  try
    if not LService.PermitirAcesso(LUsuario, LSenha) then
      raise EHorseException.New.Status(THTTPStatus.Unauthorized).Error('Usuário não Autorizado!');

    //Token de Acesso com duração de 1 hora
    //Token de atualização com duração de 1 mês
    //Nas funções IncHour e IncMonth não é necessario adicionar o valor 1 pq já é default
    LToken := TJSONObject.Create;
    LToken.AddPair('access', GetToken(LService.qryLoginid.AsString, IncHour(Now)));
    LToken.AddPair('refresh', GetToken(LService.qryLoginid.AsString, IncMonth(Now)));

    Res.Send(LToken);
  finally
    LService.Free;
  end;

end;

procedure RenovarToken(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LSub : string;
  LToken : TJSONObject;
begin
  LSub := Req.Session<TJSONObject>.GetValue('sub').Value;
  try
    LToken := TJSONObject.Create;
    LToken.AddPair('access', GetToken(LSub, IncHour(Now)));

    Res.Send(LToken);
  finally
  end;

end;

procedure Registry;
begin
  THorse.Post('/login', EfetuarLogin);
  THorse.Get('/refresh', RenovarToken);
end;

end.
