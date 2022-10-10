unit uCliente.Model;

interface

uses System.Classes;

type
  TClienteClass = class
  private
    fTipoPessoa: Integer;
    fCodigo: Integer;
    fCpfCnpj: string;
    fRgIe: string;
    fDataCadastro: TDateTime;
    fNome: string;
    fAtivo: Integer;

    procedure SetCodigo(const Value: Integer);
    procedure SetCpfCnpj(const Value: string);
    procedure SetDataCadastro(const Value: TDateTime);
    procedure SetNome(const Value: string);
    procedure SetRgIe(const Value: string);
    procedure SetTipoPessoa(const Value: Integer);
    procedure SetAtivo(const Value: Integer);
  public
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;

    property Codigo: Integer read fCodigo write SetCodigo;
    property Nome: string read fNome write SetNome;
    property TipoPessoa: Integer read fTipoPessoa write SetTipoPessoa;
    property CpfCnpj: string read fCpfCnpj write SetCpfCnpj;
    property RgIe: string read fRgIe write SetRgIe;
    property DataCadastro: TDateTime read fDataCadastro write SetDataCadastro;
    property Ativo: Integer read fAtivo write SetAtivo;


    procedure Clear;
  end;

implementation

uses System.SysUtils;

{ TClienteClass }

procedure TClienteClass.Clear;
begin
  Self.Codigo := 0;
  Self.Nome := EmptyStr;
  Self.TipoPessoa := 0;
  Self.CpfCnpj := EmptyStr;
  Self.RgIe := EmptyStr;
  Self.DataCadastro := Now;
  Self.Ativo := 1;
end;

constructor TClienteClass.Create(AOwner: TComponent);
begin
end;

destructor TClienteClass.Destroy;
begin
end;

procedure TClienteClass.SetAtivo(const Value: Integer);
begin
  Self.fAtivo := Value;
end;

procedure TClienteClass.SetCodigo(const Value: Integer);
begin
  Self.fCodigo := Value;
end;

procedure TClienteClass.SetCpfCnpj(const Value: string);
begin
  Self.fCpfCnpj := Value;
end;

procedure TClienteClass.SetDataCadastro(const Value: TDateTime);
begin
  Self.fDataCadastro := Value;
end;

procedure TClienteClass.SetNome(const Value: string);
begin
  Self.fNome := Value;
end;

procedure TClienteClass.SetRgIe(const Value: string);
begin
  Self.fRgIe := Value;
end;

procedure TClienteClass.SetTipoPessoa(const Value: Integer);
begin
  Self.fTipoPessoa := Value;
end;

end.
