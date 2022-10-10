unit uCliente.Core;

interface

uses System.Classes, uCliente.Model, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, FireDAC.Comp.UI, Data.DB,
  FireDAC.Comp.Client, uTelefone.Model, uEndereco.Model;

type
  TCliente = class(TClienteClass)
  private
    fConnection: TFDConnection;
    fListTelefone: TList;
    fListEndereco: TList;

    procedure _AdicionarTelefone( const aCliente: TClienteClass; aQry: TFDQuery );
    procedure _AdicionarEndereco( const aCliente: TClienteClass; aQry: TFDQuery );

  public
    constructor Create(aConnection: TFDConnection);
    destructor Destroy; override;

    property ListaTelefone: TList read fListTelefone write fListTelefone;
    property ListaEndereco: TList read fListEndereco write fListEndereco;
    property Codigo;
    property Nome;
    property TipoPessoa;
    property CpfCnpj;
    property RgIe;
    property DataCadastro;
    property Ativo;


    function Load(const aCodigo: Integer): Boolean;
    function Insert(const aCliente: TClienteClass): Boolean;
    function Update(const aCliente: TClienteClass): Boolean;
    function Delete(const aCliente: TClienteClass): Boolean;

    function AddTelefone( aTelefone: TTelefoneClass ): Boolean;
    function DelTelefone( aTelefone: TTelefoneClass ): Boolean;
    function AddEndereco( aEndereco: TEnderecoClass ): Boolean;
    function DelEndereco( aEndereco: TEnderecoClass ): Boolean;
  end;

implementation

{ TCliente }

uses uEndereco.Core, uTelefone.Core, Vcl.Forms, Winapi.Windows;

function TCliente.AddEndereco(aEndereco: TEnderecoClass): Boolean;
begin
  if Assigned( Self.fListEndereco ) then
  begin
    Self.fListEndereco.Add( aEndereco );
  end;
end;

function TCliente.AddTelefone(aTelefone: TTelefoneClass): Boolean;
begin
  if Assigned( Self.fListTelefone ) then
  begin
    Self.fListTelefone.Add( aTelefone );
  end;
end;

constructor TCliente.Create(aConnection: TFDConnection);
begin
  Self.fConnection := aConnection;

  Self.fListTelefone := TList.Create;
  Self.fListEndereco := TList.Create;
end;

function TCliente.DelEndereco(aEndereco: TEnderecoClass): Boolean;
begin
  if Assigned( Self.fListEndereco ) then
  begin
    Self.fListEndereco.Delete( Self.fListEndereco.IndexOf( aEndereco ) );
  end;
end;

function TCliente.Delete(const aCliente: TClienteClass): Boolean;
const
 cSQL = 'Delete from cliente '+
        'where id = :pId';
var
  vQry: TFDQuery;
begin
  try
    vQry := TFDQuery.Create( nil );
    try
      vQry.Connection := Self.fConnection;
      vQry.SQL.Text := cSQL;
      vQry.ParamByName('pId').AsInteger := aCliente.Codigo;
      vQry.ExecSQL;

      Result := True;
    finally
      vQry.Free;
    end;
  except
    Result := False;
  end;
end;

function TCliente.DelTelefone(aTelefone: TTelefoneClass): Boolean;
begin
  if Assigned( Self.fListTelefone ) then
  begin
    Self.fListTelefone.Delete( Self.fListTelefone.IndexOf( aTelefone ) );
  end;
end;

destructor TCliente.Destroy;
var
  I: Integer;
begin
  for I := Self.fListTelefone.Count - 1 downto 0 do
  begin
    TTelefoneClass(Self.fListTelefone.Items[ I ]).Free;
    Self.fListTelefone.Delete( I );
  end;

  Self.fListTelefone.Free;

  for I := Self.fListEndereco.Count - 1 downto 0 do
  begin
    TEnderecoClass(Self.fListEndereco.Items[ I ]).Free;
    Self.fListEndereco.Delete( I );
  end;

  Self.fListEndereco.Free;

  inherited;
end;

function TCliente.Insert(const aCliente: TClienteClass): Boolean;
const
  cSQLSelect = 'select 1 from cliente where cpfCnpj = :pCpfCnpj';

  cSQLInsert = 'INSERT INTO cliente ( nome, tipoPessoa, cpfCnpj, rgIe, dataCadastro, ativo ) '+
                      'VALUES ( :pNome, :pTipoPessoa, :pCpfCnpj, :RgIe, :pDataCadastro, :pAtivo ) ';

  cMax = 'SELECT Max(id) from cliente';

var
  vQry: TFDQuery;
begin
  try
    vQry := TFDQuery.Create( nil );
    try
      vQry.Connection := Self.fConnection;
      vQry.SQL.Text := cSQLSelect;
      vQry.ParamByName('pCpfCnpj').AsString := aCliente.CpfCnpj;
      vQry.Open;

      if vQry.isEmpty then
      begin
        vQry.SQL.Text := cSQLInsert;
        vQry.ParamByName('pNome').AsString := aCliente.Nome;
        vQry.ParamByName('pTipoPessoa').AsInteger := aCliente.TipoPessoa;
        vQry.ParamByName('pCpfCnpj').AsString := aCliente.CpfCnpj;
        vQry.ParamByName('RgIe').AsString := aCliente.RgIe;
        vQry.ParamByName('pDataCadastro').AsDate := aCliente.DataCadastro;
        vQry.ParamByName('pAtivo').AsInteger := aCliente.Ativo;
        vQry.ExecSQL;

        vQry.Open(cMax);
        aCliente.Codigo :=  vQry.Fields[0].AsInteger;

        Self._AdicionarTelefone( aCliente, vQry );
        Self._AdicionarEndereco( aCliente, vQry );

        Result := True;
      end
      else
      begin
        Application.MessageBox('CPF/CNPJ já cadastrado.', 'Atenção', MB_OK+MB_ICONASTERISK+MB_DEFBUTTON1);

        Result := False;
      end;
    finally
      vQry.Free;
    end;
  except
    Result := False;
  end;
end;

function TCliente.Load(const aCodigo: Integer): Boolean;
const
  cSQL = 'select * from cliente where id = :pId';
var
  vQry: TFDQuery;
begin
  try
    vQry := TFDQuery.Create( nil );
    try
      vQry.Connection := Self.fConnection;
      vQry.SQL.Text := cSQL;
      vQry.ParamByName('pId').AsInteger := aCodigo;
      vQry.Open;
      if not vQry.IsEmpty then
      begin
        Self.Codigo := vQry.FieldByName('id').AsInteger;
        Self.Nome := vQry.FieldByName('nome').AsString;
        Self.TipoPessoa := vQry.FieldByName('tipoPessoa').AsInteger;
        Self.CpfCnpj := vQry.FieldByName('cpfCnpj').AsString;
        Self.RgIe := vQry.FieldByName('rgIe').AsString;
        Self.DataCadastro := vQry.FieldByName('dataCadastro').AsDateTime;
        Self.Ativo := vQry.FieldByName('ativo').AsInteger;

        TTelefone.Load( vQry, Self.Codigo, Self.fListTelefone );
        TEndereco.Load( vQry, Self.Codigo, Self.fListEndereco );
      end
      else
      begin
        Self.Clear;
      end;

      Result := True;
    finally
      vQry.Free;
    end;
  except
    Result := False;
  end;
end;

function TCliente.Update(const aCliente: TClienteClass): Boolean;
const
 cSQL = 'update '+
        '  cliente '+
        'set '+
        '  nome = :pNome, '+
        '  tipoPessoa = :pTipoPessoa, '+
        '  cpfCnpj = :pCpfCnpj, '+
        '  rgIe = :pRgIe, '+
        '  dataCadastro = :pDataCadastro, '+
        '  ativo = :pativo '+
        'where id = :pId';
var
  vQry: TFDQuery;
begin
  try
    vQry := TFDQuery.Create( nil );
    try
      vQry.Connection := Self.fConnection;
      vQry.SQL.Text := cSQL;
      vQry.ParamByName('pNome').AsString := aCliente.Nome;
      vQry.ParamByName('pTipoPessoa').AsInteger := aCliente.TipoPessoa;
      vQry.ParamByName('pCpfCnpj').AsString := aCliente.CpfCnpj;
      vQry.ParamByName('pRgIe').AsString := aCliente.RgIe;
      vQry.ParamByName('pDataCadastro').AsDate := aCliente.DataCadastro;
      vQry.ParamByName('pAtivo').AsInteger := aCliente.Ativo;
      vQry.ParamByName('pId').AsInteger := aCliente.Codigo;
      vQry.ExecSQL;

      _AdicionarTelefone( Self, vQry );
      _AdicionarEndereco( Self, vQry );

      Result := True;
    finally
      vQry.Free;
    end;
  except
    Result := False;
  end;
end;

procedure TCliente._AdicionarEndereco( const aCliente: TClienteClass; aQry: TFDQuery );
var
  I: Integer;
  vEndereco: TEndereco;
begin
  vEndereco := TEndereco.Create( Self.fConnection );
  try
    vEndereco.DeleteAllClient( aCliente.Codigo );

    for I := Self.ListaEndereco.Count - 1 downto 0 do
    begin
      vEndereco.Clear;
      vEndereco.CodigoCliente := aCliente.Codigo;
      vEndereco.CEP := TEndereco(Self.ListaEndereco.Items[ I ]).CEP;
      vEndereco.Logradouro := TEndereco(Self.ListaEndereco.Items[ I ]).Logradouro;
      vEndereco.Numero := TEndereco(Self.ListaEndereco.Items[ I ]).Numero;
      vEndereco.Complemento := TEndereco(Self.ListaEndereco.Items[ I ]).Complemento;
      vEndereco.Bairro := TEndereco(Self.ListaEndereco.Items[ I ]).Bairro;
      vEndereco.Cidade := TEndereco(Self.ListaEndereco.Items[ I ]).Cidade;
      vEndereco.UF := TEndereco(Self.ListaEndereco.Items[ I ]).UF;
      vEndereco.Pais := TEndereco(Self.ListaEndereco.Items[ I ]).Pais;

      vEndereco.Insert( aQry, vEndereco );
    end;
  finally
    vEndereco.Free;
  end;
end;

procedure TCliente._AdicionarTelefone( const aCliente: TClienteClass; aQry: TFDQuery );
var
  I: Integer;
  vTelefone: TTelefone;
begin
  vTelefone := TTelefone.Create( Self.fConnection );
  try
    vTelefone.DeleteAllClient( aCliente.Codigo );

    for I := Self.ListaTelefone.Count - 1 downto 0 do
    begin
      vTelefone.Clear;
      vTelefone.CodigoCliente := aCliente.Codigo;
      vTelefone.DDD := TTelefone( Self.ListaTelefone.Items[ I ] ).DDD;
      vTelefone.Telefone := TTelefone(Self.ListaTelefone.Items[ I ] ).Telefone;

      TTelefone.Insert( aQry, vTelefone );
    end;
  finally
    vTelefone.Free;
  end;
end;

end.
