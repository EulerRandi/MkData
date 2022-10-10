unit uEndereco.Model;

interface

type

  TEnderecoClass = class
  private
    fLogradouro: string;
    fBairro: string;
    fUF: string;
    fCodigo: Integer;
    fCEP: string;
    fNumero: Integer;
    fComplemento: string;
    fCodigoCliente: Integer;
    fCidade: string;
    fPais: string;
    procedure SetBairro(const Value: string);
    procedure SetCEP(const Value: string);
    procedure SetCidade(const Value: string);
    procedure SetCodigo(const Value: Integer);
    procedure SetCodigoCliente(const Value: Integer);
    procedure SetComplemento(const Value: string);
    procedure SetLogradouro(const Value: string);
    procedure SetNumero(const Value: Integer);
    procedure SetPais(const Value: string);
    procedure SetUF(const Value: string);
  public
    property Codigo: Integer read fCodigo write SetCodigo;
    property CodigoCliente: Integer read fCodigoCliente write SetCodigoCliente;
    property CEP: string read fCEP write SetCEP;
    property Logradouro: string read fLogradouro write SetLogradouro;
    property Numero: Integer read fNumero write SetNumero;
    property Complemento: string read fComplemento write SetComplemento;
    property Bairro: string read fBairro write SetBairro;
    property Cidade: string read fCidade write SetCidade;
    property UF: string read fUF write SetUF;
    property Pais: string read fPais write SetPais;

    procedure Clear;
  end;

implementation

uses System.SysUtils;

{ TEnderecoClass }

procedure TEnderecoClass.Clear;
begin
  Self.Codigo := 0;
  Self.CodigoCliente := 0;
  Self.CEP := EmptyStr;
  Self.Logradouro := EmptyStr;
  Self.Numero := 0;
  Self.Complemento := EmptyStr;
  Self.Bairro := EmptyStr;
  Self.Cidade := EmptyStr;
  Self.UF := EmptyStr;
  Self.Pais := EmptyStr;
end;

procedure TEnderecoClass.SetBairro(const Value: string);
begin
  Self.fBairro := Value;
end;

procedure TEnderecoClass.SetCEP(const Value: string);
begin
  Self.fCEP := Value;
end;

procedure TEnderecoClass.SetCidade(const Value: string);
begin
  Self.fCidade := Value;
end;

procedure TEnderecoClass.SetCodigo(const Value: Integer);
begin
  Self.fCodigo := Value;
end;

procedure TEnderecoClass.SetCodigoCliente(const Value: Integer);
begin
  Self.fCodigoCliente := Value;
end;

procedure TEnderecoClass.SetComplemento(const Value: string);
begin
  Self.fComplemento := Value;
end;

procedure TEnderecoClass.SetLogradouro(const Value: string);
begin
  Self.fLogradouro := Value;
end;

procedure TEnderecoClass.SetNumero(const Value: Integer);
begin
  Self.fNumero := Value;
end;

procedure TEnderecoClass.SetPais(const Value: string);
begin
  Self.fPais := Value;
end;

procedure TEnderecoClass.SetUF(const Value: string);
begin
  Self.fUF := Value;
end;

end.
