unit uFrmCadCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls, System.StrUtils, Vcl.Mask,
  Vcl.Buttons, REST.Types, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, uCliente.Model, uCliente.Core;

type
  TFrmCadCliente = class(TForm)
    GrbDadosBasicos: TGroupBox;
    GrbTelefone: TGroupBox;
    PnlAction: TPanel;
    LblCodigo: TLabel;
    LblNome: TLabel;
    LblCPF: TLabel;
    LblRG: TLabel;
    LblDataCadastro: TLabel;
    LblDDD: TLabel;
    LblTelefone: TLabel;
    EdtNome: TEdit;
    EdtRG: TEdit;
    EdtDataCadastro: TDateTimePicker;
    ChkAtivo: TCheckBox;
    EdtDDD: TEdit;
    EdtTelefone: TEdit;
    LtvTelefone: TListView;
    EdtCodigo: TEdit;
    LblTipoPessoa: TLabel;
    CmbTipoPessoa: TComboBox;
    EdtCPF: TMaskEdit;
    GrbEndereco: TGroupBox;
    LblCEP: TLabel;
    LblLogradouro: TLabel;
    Label12: TLabel;
    LblComplemento: TLabel;
    LblBairro: TLabel;
    LblCidade: TLabel;
    Lbl: TLabel;
    Label17: TLabel;
    EdtCEP: TMaskEdit;
    BtnPesquisarCEP: TButton;
    EdtLogradouro: TEdit;
    EdtNumero: TEdit;
    EdtComplemento: TEdit;
    EdtBairro: TEdit;
    EdtCidade: TEdit;
    EdtPais: TEdit;
    LtvEndereco: TListView;
    BtnAdicionarCEP: TButton;
    BtnRemoverCEP: TButton;
    BtnAdicionarTelefone: TButton;
    BtnRemoverTelefone: TButton;
    EdtEstado: TEdit;
    BtnGravar: TButton;
    BtnCancelar: TButton;
    procedure CmbTipoPessoaChange(Sender: TObject);
    procedure BtnPesquisarCEPClick(Sender: TObject);
    procedure BtnAdicionarTelefoneClick(Sender: TObject);
    procedure BtnRemoverTelefoneClick(Sender: TObject);
    procedure BtnAdicionarCEPClick(Sender: TObject);
    procedure BtnGravarClick(Sender: TObject);
    procedure BtnRemoverCEPClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
  private
    { Private declarations }
    fCliente: TCliente;
  protected
    procedure LoadDataScreen;
    procedure LoadScreenData;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; aIDCliente: Integer); overload; virtual;
  end;

implementation

{$R *.dfm}

uses ViaCEP.Core, ViaCEP.Intf, ViaCEP.Model, System.Math, uDm, uTelefone.Model,
  uEndereco.Model;

{ TFrmCadCliente }

procedure TFrmCadCliente.BtnAdicionarCEPClick(Sender: TObject);
var
  vItem: TListItem;
begin
  vItem := Self.LtvEndereco.Items.Add;
  vItem.Caption := Self.EdtCEP.Text;
  vItem.SubItems.Add(Self.EdtLogradouro.Text);
  vItem.SubItems.Add(Self.EdtNumero.Text);
  vItem.SubItems.Add(Self.EdtComplemento.Text);
  vItem.SubItems.Add(Self.EdtBairro.Text);
  vItem.SubItems.Add(Self.EdtCidade.Text);
  vItem.SubItems.Add(Self.EdtEstado.Text);
  vItem.SubItems.Add(Self.EdtPais.Text);
end;

procedure TFrmCadCliente.BtnAdicionarTelefoneClick(Sender: TObject);
var
  vItem: TListItem;
begin
  if Trim(Self.EdtDDD.Text) = EmptyStr then
  begin
    Application.MessageBox('Favor preencher o campo DDD.', 'Dados não preenchido', MB_OK+MB_ICONASTERISK+MB_DEFBUTTON1);
    Self.EdtDDD.SetFocus;
  end
  else
  if Trim(Self.EdtTelefone.Text) = EmptyStr then
  begin
    Application.MessageBox('Favor preencher o campo Telefone.', 'Dados não preenchido', MB_OK+MB_ICONASTERISK+MB_DEFBUTTON1);
    Self.EdtTelefone.SetFocus;
  end
  else
  begin
    vItem := Self.LtvTelefone.Items.Add;
    vItem.Caption := Self.EdtDDD.Text;
    vItem.SubItems.Text := Self.EdtTelefone.Text;

    Self.EdtDDD.Clear;
    Self.EdtTelefone.Clear;
  end;
end;

procedure TFrmCadCliente.BtnCancelarClick(Sender: TObject);
begin
  Self.ModalResult := mrCancel;
  Self.CloseModal;
end;

procedure TFrmCadCliente.BtnGravarClick(Sender: TObject);
begin
  Self.LoadDataScreen;

  if Trim( Self.fCliente.CpfCnpj ) = EmptyStr then
  begin
    if Self.fCliente.TipoPessoa = 0 then
    begin
      Application.MessageBox('Favor preencher o campo CPF.', 'Dados não preenchido', MB_OK+MB_ICONASTERISK+MB_DEFBUTTON1);
    end
    else
    begin
      Application.MessageBox('Favor preencher o campo CNPJ.', 'Dados não preenchido', MB_OK+MB_ICONASTERISK+MB_DEFBUTTON1);
    end;
    Self.EdtCPF.SetFocus;
  end;


  if Self.fCliente.Codigo = 0 then
  begin
    if Self.fCliente.Insert(Self.fCliente) then
    begin
      Self.ModalResult := mrOk;
      Self.CloseModal;
    end;
  end
  else
  begin
    if Self.fCliente.Update(Self.fCliente) then
    begin
      Self.ModalResult := mrOk;
      Self.CloseModal;
    end;
  end;

end;

procedure TFrmCadCliente.BtnPesquisarCEPClick(Sender: TObject);
var
  iCEP: IViaCEP;
  vCEP: TViaCEPClass;
  vStrCEP: string;
begin
  vStrCEP := StringReplace(Self.EdtCEP.Text, '-', '', [rfReplaceAll, rfIgnoreCase]);
  iCEP := TViaCEP.Create;
  if iCEP.Validate(vStrCEP) then
  begin
    vCEP := iCEP.Get(vStrCEP);

    if Assigned(vCEP) then
    begin
      try
        Self.EdtCEP.Text := vCEP.CEP;
        Self.EdtLogradouro.Text := vCEP.Logradouro;
        Self.EdtNumero.Clear;
        Self.edtComplemento.Text := vCEP.Complemento;
        Self.EdtBairro.Text := vCEP.Bairro;
        Self.EdtCidade.Text := vCEP.Localidade;
        Self.EdtEstado.Text := vCEP.UF;
        Self.EdtPais.Text := 'Brasil';
      finally
        vCEP.Free;
      end;
    end
    else
    begin
      Self.EdtCEP.Clear;
      Self.EdtLogradouro.Clear;
      Self.EdtNumero.Clear;
      Self.edtComplemento.Clear;
      Self.EdtBairro.Clear;
      Self.EdtCidade.Clear;
      Self.EdtEstado.Clear;
      Self.EdtPais.Clear;
    end;
  end
  else
  begin
    Self.EdtCEP.SetFocus;
    Application.MessageBox('Favor verificar o CEP digitado', 'CEP Inválido', MB_OK+MB_ICONASTERISK+MB_DEFBUTTON1);
  end;
end;

procedure TFrmCadCliente.BtnRemoverCEPClick(Sender: TObject);
begin
  Self.LtvEndereco.Items.Item[ Self.LtvEndereco.ItemIndex ].Delete;
end;

procedure TFrmCadCliente.BtnRemoverTelefoneClick(Sender: TObject);
begin
  Self.LtvTelefone.Items.Item[ Self.LtvTelefone.ItemIndex ].Delete;
end;

procedure TFrmCadCliente.CmbTipoPessoaChange(Sender: TObject);
begin
  Self.LblNome.Caption := IfThen( Self.CmbTipoPessoa.ItemIndex = 0, 'Nome', 'Razão Social' );
  Self.LblCPF.Caption := IfThen( Self.CmbTipoPessoa.ItemIndex = 0, 'CPF', 'CNPJ' );
  Self.EdtCPF.EditMask := IfThen( Self.CmbTipoPessoa.ItemIndex = 0, '000.000.000-00;1;_', '00.000.000/0000-00;1;_' );
  Self.LblRG.Caption := IfThen( Self.CmbTipoPessoa.ItemIndex = 0, 'R.G.', 'Insc. Estad.' );
end;

constructor TFrmCadCliente.Create(AOwner: TComponent; aIDCliente: Integer);
begin
  inherited Create( AOwner );

  Self.fCliente := TCliente.Create(DM.Connection);
  Self.fCliente.Load( aIDCliente );

  if Self.fCliente.Codigo = 0 then
  begin
    Self.Caption := 'Cadastro de Cliente - Inclusão';
  end
  else
  begin
    Self.Caption := 'Cadastro de Cliente - Alteração';
  end;

  Self.LoadScreenData;
end;

procedure TFrmCadCliente.LoadDataScreen;
var
  I, X: Integer;
  vTelefone: TTelefoneClass;
  vEndereco: TEnderecoClass;
begin
  Self.fCliente.Nome := Self.EdtNome.Text;
  Self.fCliente.TipoPessoa := Self.CmbTipoPessoa.ItemIndex;
  Self.fCliente.CpfCnpj := Self.EdtCPF.Text;
  Self.fCliente.RgIe := Self.EdtRG.Text;
  Self.fCliente.DataCadastro := Self.EdtDataCadastro.Date;
  Self.fCliente.Ativo := IfThen( Self.ChkAtivo.Checked, 1, 0 );

  {$REGION ' Telefone '}
  for I := Self.fCliente.ListaTelefone.Count - 1 downto 0 do
  begin
    Self.fCliente.DelTelefone( Self.fCliente.ListaTelefone.Items[ I ] );
  end;

  for I := 0 to Self.LtvTelefone.Items.Count - 1 do
  begin
    vTelefone := TTelefoneClass.Create;
    vTelefone.DDD := Self.LtvTelefone.Items[ I ].Caption;
    vTelefone.Telefone := Self.LtvTelefone.Items[ I ].SubItems[ 0 ];

    Self.fCliente.ListaTelefone.add( vTelefone );
  end;
  {$ENDREGION}

  {$REGION ' Endereço '}
  for I := Self.fCliente.ListaEndereco.Count - 1 downto 0 do
  begin
    Self.fCliente.DelEndereco( Self.fCliente.ListaEndereco.Items[ I ] );
  end;

  for I := 0 to Self.LtvEndereco.Items.Count - 1 do
  begin
    vEndereco := TEnderecoClass.Create;
    vEndereco.CEP := Self.LtvEndereco.Items[ I ].Caption;
    vEndereco.Logradouro := Self.LtvEndereco.Items[ I ].SubItems[ 0 ];
    vEndereco.Numero := StrToInt( Self.LtvEndereco.Items[ I ].SubItems[ 1 ] );
    vEndereco.Complemento := Self.LtvEndereco.Items[ I ].SubItems[ 2 ];
    vEndereco.Bairro := Self.LtvEndereco.Items[ I ].SubItems[ 3 ];
    vEndereco.Cidade := Self.LtvEndereco.Items[ I ].SubItems[ 4 ];
    vEndereco.UF := Self.LtvEndereco.Items[ I ].SubItems[ 5 ];
    vEndereco.Pais := Self.LtvEndereco.Items[ I ].SubItems[ 6 ];

    Self.fCliente.ListaEndereco.add( vEndereco );
  end;
  {$ENDREGION}
end;

procedure TFrmCadCliente.LoadScreenData;
var
  I: Integer;
  vItem: TListItem;
begin
  Self.EdtCodigo.Text := FormatFloat('000000', Self.fCliente.Codigo);
  Self.EdtNome.Text := Self.fCliente.Nome;
  Self.CmbTipoPessoa.ItemIndex := Self.fCliente.TipoPessoa;
  Self.EdtCPF.Text := Self.fCliente.CpfCnpj;
  Self.EdtRG.Text := Self.fCliente.RgIe;
  Self.EdtDataCadastro.Date := Self.fCliente.DataCadastro;
  Self.ChkAtivo.Checked := Self.fCliente.Ativo = 1;

  for I := 0 to Self.fCliente.ListaTelefone.Count - 1 do
  begin
    vItem := Self.LtvTelefone.Items.Add;
    vItem.Caption := TTelefoneClass( Self.fCliente.ListaTelefone[ I ] ).DDD;
    vItem.SubItems.Text := TTelefoneClass( Self.fCliente.ListaTelefone[ I ] ).Telefone;
  end;

  for I := 0 to Self.fCliente.ListaEndereco.Count - 1 do
  begin
    vItem := Self.LtvEndereco.Items.Add;
    vItem.Caption := TEnderecoClass( Self.fCliente.ListaEndereco[ I ] ).CEP;
    vItem.SubItems.Add( TEnderecoClass( Self.fCliente.ListaEndereco[ I ] ).Logradouro );
    vItem.SubItems.Add( IntToStr( TEnderecoClass( Self.fCliente.ListaEndereco[ I ] ).Numero ) );
    vItem.SubItems.Add( TEnderecoClass( Self.fCliente.ListaEndereco[ I ] ).Complemento );
    vItem.SubItems.Add( TEnderecoClass( Self.fCliente.ListaEndereco[ I ] ).Bairro );
    vItem.SubItems.Add( TEnderecoClass( Self.fCliente.ListaEndereco[ I ] ).Cidade );
    vItem.SubItems.Add( TEnderecoClass( Self.fCliente.ListaEndereco[ I ] ).UF );
    vItem.SubItems.Add( TEnderecoClass( Self.fCliente.ListaEndereco[ I ] ).Pais );
  end;
end;

end.
