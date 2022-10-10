unit ViaCEP.Core;

interface

uses IdHTTP, IdSSLOpenSSL, ViaCEP.Intf, ViaCEP.Model;

type
  TViaCEP = class(TInterfacedObject, IViaCEP)
  private
    FIdHTTP: TIdHTTP;
    FIdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL;
    function Get(const ACep: string): TViaCEPClass;
    function Validate(const ACep: string): Boolean;
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TViaCEP }

uses System.Classes, REST.Json, System.SysUtils;

constructor TViaCEP.Create;
begin
  Self.FIdHTTP := TIdHTTP.Create;
  Self.FIdSSLIOHandlerSocketOpenSSL := TIdSSLIOHandlerSocketOpenSSL.Create;
  Self.FIdHTTP.IOHandler := FIdSSLIOHandlerSocketOpenSSL;
  Self.FIdSSLIOHandlerSocketOpenSSL.SSLOptions.SSLVersions := [sslvTLSv1, sslvTLSv1_1, sslvTLSv1_2];
end;

function TViaCEP.Get(const ACep: string): TViaCEPClass;
const
  URL = 'https://viacep.com.br/ws/%s/json';
  INVALID_CEP = '{'#$A'  "erro": true'#$A'}';
var
  LResponse: TStringStream;
begin
  Result := nil;
  LResponse := TStringStream.Create;
  try
    Self.FIdHTTP.Get(Format(URL, [ACep.Trim]), LResponse);
    if (FIdHTTP.ResponseCode = 200) and (not (LResponse.DataString).Equals(INVALID_CEP)) then
    begin
      Result := TJson.JsonToObject<TViaCEPClass>(UTF8ToString(PAnsiChar(AnsiString(LResponse.DataString))));
    end;
  finally
    LResponse.Free;
  end;
end;

function TViaCEP.Validate(const ACep: string): Boolean;
const
  INVALID_CHARACTER = -1;
begin
  Result := True;
  if ACep.Trim.Length <> 8 then
  begin
    Exit(False);
  end;

  if StrToIntDef(ACep, INVALID_CHARACTER) = INVALID_CHARACTER then
  begin
    Exit(False);
  end;
end;

destructor TViaCEP.Destroy;
begin
  Self.FIdSSLIOHandlerSocketOpenSSL.Free;
  Self.FIdHTTP.Free;

  inherited;
end;

end.
