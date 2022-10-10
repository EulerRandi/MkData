unit uFrmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ToolWin, Vcl.ActnMan,
  Vcl.ActnCtrls, Vcl.Buttons, Vcl.ExtCtrls;

type
  TFrmPrincipal = class(TForm)
    MainMenu: TMainMenu;
    MnuCadastro: TMenuItem;
    MnuCadastroClientes: TMenuItem;
    PnlButtons: TPanel;
    BtnClientes: TSpeedButton;
    procedure MnuCadastroClientesClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

uses
  uFrmCadClienteBrowse;

{$R *.dfm}

procedure TFrmPrincipal.MnuCadastroClientesClick(Sender: TObject);
var
  vFrm: TFrmCadClienteBrowse;
begin
  vFrm := TFrmCadClienteBrowse.Create( Self );
  try
    vFrm.Showmodal;
  finally
    vFrm.Free;
  end;
end;

end.
