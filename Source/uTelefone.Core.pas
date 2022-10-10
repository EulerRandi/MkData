unit uTelefone.Core;

interface

uses System.Classes, uTelefone.Model, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, FireDAC.Comp.UI, Data.DB,
  FireDAC.Comp.Client;

type
  TTelefone = class(TTelefoneClass)
  private
    fConnection: TFDConnection;
  public
    constructor Create(aConnection: TFDConnection);
    destructor Destroy; override;

    property Codigo;
    property CodigoCliente;
    property DDD;
    property Telefone;

    class procedure Load(aQry: TFDQuery; aCodigoCliente: Integer; aList: TList);
    class function Insert(aQry: TFDQuery; aTelefone: TTelefoneClass): Boolean;
    function DeleteAllClient(const aCodigoCliente: Integer): Boolean;
  end;

implementation

{ TTelefone }

constructor TTelefone.Create(aConnection: TFDConnection);
begin
  Self.fConnection := aConnection;
end;

function TTelefone.DeleteAllClient(const aCodigoCliente: Integer): Boolean;
const
 cSQL = 'Delete from telefone '+
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

destructor TTelefone.Destroy;
begin

  inherited;
end;

class function TTelefone.Insert(aQry: TFDQuery; aTelefone: TTelefoneClass): Boolean;
const
  cSQL = 'insert into telefone ( idCliente, ddd, telefone) '+
                       'values ( :pIdCliente, :pDDD, :pTelefone)';

  cMax = 'SELECT Max(id) from telefone';

var
  vQry: TFDQuery;
begin
  try
    aQry.SQL.Text := cSQL;
    aQry.ParamByName('pIdCliente').AsInteger := aTelefone.CodigoCliente;
    aQry.ParamByName('pDDD').AsString := aTelefone.DDD;
    aQry.ParamByName('pTelefone').AsString := aTelefone.Telefone;
    aQry.ExecSQL;

    aQry.Open(cMax);
    aTelefone.Codigo :=  aQry.Fields[0].AsInteger;

    Result := True;
  except
    Result := False;
  end;
end;

class procedure TTelefone.Load(aQry: TFDQuery; aCodigoCliente: Integer; aList: TList);
const
  cSQL = 'select * from telefone where idCliente = :pIdCliente';
var
  vTelefone: TTelefone;
begin
  aQry.SQL.Text := cSQL;
  aQry.ParamByName('pIdCliente').AsInteger := aCodigoCliente;
  aQry.Open;

  aList.Clear;

  while not aQry.Eof do
  begin
    vTelefone := TTelefone.Create( TFDConnection( aQry.Connection ) );
    vTelefone.Codigo := aQry.FieldByName('id').AsInteger;
    vTelefone.CodigoCliente := aQry.FieldByName('idCliente').AsInteger;
    vTelefone.DDD := aQry.FieldByName('ddd').AsString;
    vTelefone.Telefone := aQry.FieldByName('telefone').AsString;

    aList.Add( vTelefone );
    aQry.Next;
  end;
end;

end.
