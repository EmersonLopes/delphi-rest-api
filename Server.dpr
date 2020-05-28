program Server;
{$APPTYPE GUI}

{$R *.dres}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  uFrmPrincipal in 'src\forms\uFrmPrincipal.pas' {FrmPrincipal},
  ServerMethodsUnit1 in 'src\services\ServerMethodsUnit1.pas',
  ServerContainerUnit1 in 'src\forms\ServerContainerUnit1.pas' {ServerContainer1: TDataModule},
  WebModuleUnit1 in 'src\modules\WebModuleUnit1.pas' {WebModule1: TWebModule},
  Vcl.Themes,
  Vcl.Styles,
  uDialogs in 'src\classes\uDialogs.pas',
  uRotinaSis in 'src\classes\uRotinaSis.pas',
  uDmConexao in 'src\modules\uDmConexao.pas' {DmConexao: TDataModule},
  uServiceUsuario in 'src\services\uServiceUsuario.pas',
  uRotinasDB in 'src\classes\uRotinasDB.pas',
  Usuario in 'src\classes\Usuario.pas',
  uUsuarioController in 'src\controllers\uUsuarioController.pas',
  uUsuarioDAO in 'src\dao\uUsuarioDAO.pas',
  uUsuarioModel in 'src\model\uUsuarioModel.pas',
  uJSONUtil in 'src\utils\uJSONUtil.pas',
  uConexao in 'src\classes\uConexao.pas',
  uConexaoController in 'src\controllers\uConexaoController.pas',
  uServiceProduto in 'src\services\uServiceProduto.pas',
  uProdutoController in 'src\controllers\uProdutoController.pas',
  uProdutoModel in 'src\model\uProdutoModel.pas',
  uProdutoDAO in 'src\dao\uProdutoDAO.pas';

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  TStyleManager.TrySetStyle('Carbon');
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDmConexao, DmConexao);
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;
end.
