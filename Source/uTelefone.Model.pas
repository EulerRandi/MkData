unit uTelefone.Model;

interface

type

  TTelefoneClass = class
  private
    fDDD: string;
    fCodigo: Integer;
    fCodigoCliente: Integer;
    fTelefone: string;
    procedure SetCodigo(const Value: Integer);
    procedure SetCodigoCliente(const Value: Integer);
    procedure SetDDD(const Value: string);
    procedure SetTelefone(const Value: string);
  public
    property Codigo: Integer read fCodigo write SetCodigo;
    property CodigoCliente: Integer read fCodigoCliente write SetCodigoCliente;
    property DDD: string read fDDD write SetDDD;
    property Telefone: string read fTelefone write SetTelefone;

    procedure Clear;
  end;

implementation

uses System.SysUtils;

{ TTelefoneClass }

procedure TTelefoneClass.Clear;
begin
  Self.Codigo := 0;
  Self.CodigoCliente := 0;
  Self.DDD := EmptyStr;
  Self.Telefone := EmptyStr;
end;

procedure TTelefoneClass.SetCodigo(const Value: Integer);
begin
  Self.fCodigo := Value;
end;

procedure TTelefoneClass.SetCodigoCliente(const Value: Integer);
begin
  Self.fCodigoCliente := Value;
end;

procedure TTelefoneClass.SetDDD(const Value: string);
begin
  Self.fDDD := Value;
end;

procedure TTelefoneClass.SetTelefone(const Value: string);
begin
  Self.fTelefone := Value;
end;

end.
