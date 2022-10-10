unit uFrmCadClienteBrowse;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TFrmCadClienteBrowse = class(TForm)
    PnlFilter: TPanel;
    PnlAction: TPanel;
    PnlBackGround: TPanel;
    DBGClient: TDBGrid;
    LblTelefones: TLabel;
    DBGrid1: TDBGrid;
    LblEndereco: TLabel;
    DBGrid2: TDBGrid;
    BtnIncluir: TBitBtn;
    BtnAlterar: TBitBtn;
    BtnClose: TBitBtn;
    QryCliente: TFDQuery;
    DsCliente: TDataSource;
    QryClienteid: TFDAutoIncField;
    QryClientenome: TStringField;
    QryClientetipoPessoa: TIntegerField;
    QryClientecpfCnpj: TStringField;
    QryClientergIe: TStringField;
    QryClientedataCadastro: TDateField;
    QryClienteativo: TIntegerField;
    QryTelefone: TFDQuery;
    DsTelefone: TDataSource;
    QryEndereco: TFDQuery;
    DsEndereco: TDataSource;
    QryEnderecoid: TFDAutoIncField;
    QryEnderecoidCliente: TIntegerField;
    QryEnderecocep: TStringField;
    QryEnderecologradouro: TStringField;
    QryEndereconumero: TIntegerField;
    QryEnderecocomplemento: TStringField;
    QryEnderecobairro: TStringField;
    QryEnderecocidade: TStringField;
    QryEnderecouf: TStringField;
    QryEnderecopais: TStringField;
    QryTelefoneid: TFDAutoIncField;
    QryTelefoneidCliente: TIntegerField;
    QryTelefoneddd: TStringField;
    QryTelefonetelefone: TStringField;
    QryClienteCalcTipoPessoa: TStringField;
    QryClienteCalcAtivo: TStringField;
    GroupBox1: TGroupBox;
    LblFiltroNome: TLabel;
    EdtFiltroNome: TEdit;
    RdgFiltroAtivos: TRadioGroup;
    BtnExcluir: TButton;
    procedure BtnCloseClick(Sender: TObject);
    procedure BtnIncluirClick(Sender: TObject);
    procedure BtnAlterarClick(Sender: TObject);
    procedure QryClienteCalcFields(DataSet: TDataSet);
    procedure EdtFiltroNomeChange(Sender: TObject);
    procedure RdgFiltroAtivosClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
  private
    { Private declarations }
    procedure FiltrarRegistros;
  public
    { Public declarations }

    constructor Create(AOwner: TComponent); override;
  end;

implementation

uses
  uDm, uFrmCadCliente, uCliente.Core, uTelefone.Core, uEndereco.Core;

{$R *.dfm}

procedure TFrmCadClienteBrowse.BtnAlterarClick(Sender: TObject);
var
  vFrm: TFrmCadCliente;
  vBook: TBookmark;
begin
  vFrm := TFrmCadCliente.Create( Self, Self.QryCliente.FieldByName('id').AsInteger );
  try
    if vFrm.ShowModal = mrOk then
    begin
      vBook := Self.QryCliente.GetBookmark;
      Self.QryCliente.Close;
      Self.QryCliente.Open;
      Self.QryCliente.GotoBookmark(vBook);

      Self.QryTelefone.Close;
      Self.QryTelefone.Open;

      Self.QryEndereco.Close;
      Self.QryEndereco.Open;
    end;
  finally
    FreeAndNil( vFrm );
  end;
end;

procedure TFrmCadClienteBrowse.BtnCloseClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TFrmCadClienteBrowse.BtnExcluirClick(Sender: TObject);
var
  vCliente : TCliente;
begin
  if Application.MessageBox( Pchar('Deseja excluir o Cliente ' + sLineBreak + FormatFloat( '000000', Self.QryClienteid.AsInteger) + ' - ' + Self.QryClientenome.AsString ), 'Dados não preenchido', MB_YESNO+MB_ICONASTERISK+MB_DEFBUTTON2 ) = IDYES then
  begin
     vCliente := TCliente.Create( DM.Connection );
     vCliente.Load( QryClienteid.AsInteger );

     if vCliente.ListaTelefone.Count > 0 then
     begin
       TTelefone( vCliente.ListaTelefone[ 0 ] ).DeleteAllClient( vCliente.Codigo );
     end;

     if vCliente.ListaEndereco.Count > 0 then
     begin
       TEndereco( vCliente.ListaEndereco[ 0 ] ).DeleteAllClient( vCliente.Codigo );
     end;

     vCliente.Delete( vCliente );

  end;
end;

procedure TFrmCadClienteBrowse.BtnIncluirClick(Sender: TObject);
var
  vFrm: TFrmCadCliente;
  vBook: TBookmark;
begin
  vFrm := TFrmCadCliente.Create( Self, 0 );
  try
    if vFrm.ShowModal = mrOk then
    begin
      vBook := Self.QryCliente.GetBookmark;
      Self.QryCliente.Close;
      Self.QryCliente.Open;
      Self.QryCliente.GotoBookmark(vBook);

      Self.QryTelefone.Close;
      Self.QryTelefone.Open;

      Self.QryEndereco.Close;
      Self.QryEndereco.Open;
    end;
  finally
    FreeAndNil( vFrm );
  end;
end;

constructor TFrmCadClienteBrowse.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Self.QryCliente.Open;
  Self.QryTelefone.Open;
  Self.QryEndereco.Open;
end;

procedure TFrmCadClienteBrowse.EdtFiltroNomeChange(Sender: TObject);
begin
  Self.FiltrarRegistros;
end;

procedure TFrmCadClienteBrowse.FiltrarRegistros;
begin
  Self.QryCliente.Filtered := False;

  case Self.RdgFiltroAtivos.ItemIndex of
    0: begin
      Self.QryCliente.Filter := 'UPPER(nome) like ''%' + UpperCase( Trim( Self.EdtFiltroNome.Text ) )+'%''';
    end;

    1: begin
      Self.QryCliente.Filter := 'UPPER(nome) like ''%' + UpperCase( Trim( Self.EdtFiltroNome.Text ) )+'%'' and ativo = 1';
    end;

    2: begin
      Self.QryCliente.Filter := 'UPPER(nome) like ''%' + UpperCase( Trim( Self.EdtFiltroNome.Text ) )+'%'' and ativo = 0';
    end;
  end;

  Self.QryCliente.Filtered := True;
end;

procedure TFrmCadClienteBrowse.QryClienteCalcFields(DataSet: TDataSet);
begin
  {$REGION ' Calc Tipo Pessoa '}
  case Self.QryCliente.FieldByName('tipoPessoa').AsInteger of
    0: Self.QryClienteCalcTipoPessoa.AsString := 'Física';
    1: Self.QryClienteCalcTipoPessoa.AsString := 'Jurídica';
  end;
  {$ENDREGION}

  {$REGION ' Calc Ativo '}
  case Self.QryCliente.FieldByName('ativo').AsInteger of
    0: Self.QryClienteCalcAtivo.AsString := 'Não';
    1: Self.QryClienteCalcAtivo.AsString := 'Sim';
  end;
  {$ENDREGION}
end;

procedure TFrmCadClienteBrowse.RdgFiltroAtivosClick(Sender: TObject);
begin
  Self.FiltrarRegistros;
end;

end.
