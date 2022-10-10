program Teste;

uses
  Vcl.Forms,
  Winapi.Windows,
  uFrmPrincipal in 'uFrmPrincipal.pas' {FrmPrincipal},
  uFrmCadClienteBrowse in 'Source\uFrmCadClienteBrowse.pas' {FrmCadClienteBrowse},
  uDm in 'Source\uDm.pas' {Dm: TDataModule},
  uClass.Connection in 'Source\uClass.Connection.pas',
  uFrmConfigDB in 'Source\uFrmConfigDB.pas' {FrmConfigDB},
  uFuncoes in 'Source\uFuncoes.pas',
  uFrmCadCliente in 'Source\uFrmCadCliente.pas' {FrmCadCliente},
  ViaCEP.Core in 'Source\ViaCEP.Core.pas',
  ViaCEP.Intf in 'Source\ViaCEP.Intf.pas',
  ViaCEP.Model in 'Source\ViaCEP.Model.pas',
  uCliente.Core in 'Source\uCliente.Core.pas',
  uCliente.Model in 'Source\uCliente.Model.pas',
  uEndereco.Model in 'Source\uEndereco.Model.pas',
  uEndereco.Core in 'Source\uEndereco.Core.pas',
  uTelefone.Model in 'Source\uTelefone.Model.pas',
  uTelefone.Core in 'Source\uTelefone.Core.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDM, DM);
  if DM.ConfigDB.ConnectDataBase then
  begin
    Application.CreateForm(TFrmPrincipal, FrmPrincipal);
    Application.Run;
  end
  else
  begin
    Application.MessageBox(pChar('Não foi possível conectar ao banco de dados.' + sLineBreak +
                                 sLineBreak +
                                 'Erro encontrado:' + sLineBreak +
                                 DM.ConfigDB.ErrorMsg
                                ),
                           'Erro ao conectar ao banco de dados',
                           MB_OK+MB_DEFBUTTON1+MB_ICONASTERISK);
    Application.CreateForm(TFrmConfigDB, FrmConfigDB);
    Application.Run;
  end;
  Application.Run;
end.
