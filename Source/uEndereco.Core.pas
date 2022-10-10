unit uEndereco.Core;

interface

uses System.Classes, uEndereco.Model, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, FireDAC.Comp.UI, Data.DB,
  FireDAC.Comp.Client;

type
  TEndereco = class(TEnderecoClass)
  private
    fConnection: TFDConnection;
  public
    constructor Create(aConnection: TFDConnection);
    destructor Destroy; override;

    property Codigo;
    property CodigoCliente;
    property CEP;
    property Logradouro;
    property Numero;
    property Complemento;
    property Bairro;
    property Cidade;
    property UF;
    property Pais;

    class procedure Load(aQry: TFDQuery; aCodigoCliente: Integer; aList: TList);
    class function Insert(aQry: TFDQuery; aEndereco: TEnderecoClass): Boolean;
    function DeleteAllClient(const aCodigoCliente: Integer): Boolean;
  end;

implementation

{ TEndereco }

constructor TEndereco.Create(aConnection: TFDConnection);
begin
  Self.fConnection := aConnection;
end;

function TEndereco.DeleteAllClient(const aCodigoCliente: Integer): Boolean;
const
 cSQL = 'Delete from endereco '+
        'where idCliente = :pIdCliente';
var
  vQry: TFDQuery;
begin
  try
    vQry := TFDQuery.Create( nil );
    try
      vQry.Connection := Self.fConnection;
      vQry.SQL.Text := cSQL;
      vQry.ParamByName('pIdCliente').AsInteger := aCodigoCliente;
      vQry.ExecSQL;

      Result := True;
    finally
      vQry.Free;
    end;
  except
    Result := False;
  end;
end;

destructor TEndereco.Destroy;
begin

  inherited;
end;

class function TEndereco.Insert(aQry: TFDQuery; aEndereco: TEnderecoClass): Boolean;
const
  cSQL = 'insert into endereco ( idCliente, cep, logradouro, numero, complemento, bairro, cidade, uf, pais) '+
                       'values ( :pIdCliente, :pCep, :pLogradouro, :pNumero, :pComplemento, :pBairro, :pCidade, :pUf, :pPais)';

  cMax = 'SELECT Max(id) from endereco';

begin
  try
    aQry.SQL.Text := cSQL;
    aQry.ParamByName('pIdCliente').AsInteger := aEndereco.CodigoCliente;
    aQry.ParamByName('pCep').AsString := aEndereco.CEP;
    aQry.ParamByName('pLogradouro').AsString := aEndereco.Logradouro;
    aQry.ParamByName('pNumero').AsInteger := aEndereco.Numero;
    aQry.ParamByName('pComplemento').AsString := aEndereco.Complemento;
    aQry.ParamByName('pBairro').AsString := aEndereco.Bairro;
    aQry.ParamByName('pCidade').AsString := aEndereco.Cidade;
    aQry.ParamByName('pUf').AsString := aEndereco.UF;
    aQry.ParamByName('pPais').AsString := aEndereco.Pais;
    aQry.ExecSQL;

    aQry.Open(cMax);
    aEndereco.Codigo :=  aQry.Fields[0].AsInteger;

    Result := True;
  except
    Result := False;
  end;
end;

class procedure TEndereco.Load(aQry: TFDQuery; aCodigoCliente: Integer; aList: TList);
const
  cSQL = 'select * from endereco where idCliente = :pIdCliente';
var
  vEndereco: TEndereco;
begin
  aQry.SQL.Text := cSQL;
  aQry.ParamByName('pIdCliente').AsInteger := aCodigoCliente;
  aQry.Open;

  aList.Clear;

  while not aQry.Eof do
  begin
    vEndereco := TEndereco.Create( TFDConnection( aQry.Connection ) );
    vEndereco.Codigo := aQry.FieldByName('id').AsInteger;
    vEndereco.CodigoCliente := aQry.FieldByName('idCliente').AsInteger;
    vEndereco.CEP := aQry.FieldByName('Cep').AsString;
    vEndereco.Logradouro := aQry.FieldByName('logradouro').AsString;
    vEndereco.Numero := aQry.FieldByName('numero').AsInteger;
    vEndereco.Complemento := aQry.FieldByName('complemento').AsString;
    vEndereco.Bairro := aQry.FieldByName('bairro').AsString;
    vEndereco.Cidade := aQry.FieldByName('cidade').AsString;
    vEndereco.UF := aQry.FieldByName('uf').AsString;
    vEndereco.Pais := aQry.FieldByName('pais').AsString;

    aList.Add( vEndereco );
    aQry.Next;
  end;
end;

end.
