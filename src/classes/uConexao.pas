unit uConexao;

interface

uses FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
     FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async,
     FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.UI.Intf,
     FireDAC.Stan.Pool, Data.DB, System.SysUtils, FireDAC.VCLUI.Wait, Forms, IniFiles,
     FireDAC.Stan.Def, FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef,
     FireDAC.Moni.Base, FireDAC.Moni.FlatFile, FireDAC.Phys.MSSQLDef,
     FireDAC.Phys.MSSQL,FireDAC.Phys.ODBCBase;
type
  TConexao = class
  private
    FConn: TFDConnection;
    procedure ConfigurarConexao;
  public
    constructor Create;
    destructor Destroy; Override;

    function getProxCod(pTabela: string): string;

    function getQuery: TFDQuery;
    function getConexao: TFDConnection;
    procedure iniTrans;
    procedure gravaTrans;
    procedure desfazTrans;

  end;

implementation

{ TConexao }

uses uFrmPrincipal;

procedure TConexao.ConfigurarConexao;
var
  wl_DataBase, wl_Host, wl_User, wl_Pass: String;
begin
  //FConn.Close;
  FConn.Params.Clear;
  FConn.LoginPrompt := False;

  if FrmPrincipal.mtSettingstipoConexao.AsString = 'Firebird' then //FIREBIRD
  begin
    FConn.Params.DriverID := 'FB';
    FConn.Params.Values['Server'] := FrmPrincipal.mtSettingshost.AsString;
    FConn.Params.Database := FrmPrincipal.mtSettingsdatabase.AsString;
    FConn.Params.UserName := FrmPrincipal.mtSettingsuser.AsString;
    FConn.Params.Password := FrmPrincipal.mtSettingspassword.AsString;
  end
  else
  begin// SQL SERVER
    FConn.Params.Clear;
    FConn.Params.Add('Server='+FrmPrincipal.mtSettingshost.AsString);
    FConn.Params.Add('Database='+FrmPrincipal.mtSettingsdatabase.AsString);
    FConn.Params.Add('User_Name='+FrmPrincipal.mtSettingsuser.AsString);
    FConn.Params.Add('Password='+FrmPrincipal.mtSettingspassword.AsString);
    FConn.Params.Add('ExtendedMetadata=True');
    FConn.Params.Add('MonitorBy=FlatFile');
    FConn.Params.Add('DriverID=MSSQL');
  end;
end;

constructor TConexao.Create;
begin
  FConn:= TFDConnection.Create(nil);
  Self.ConfigurarConexao;
end;

procedure TConexao.desfazTrans;
begin
  if FConn.InTransaction then
    FConn.Rollback;
end;

destructor TConexao.Destroy;
begin
  FreeAndNil(FConn);
  inherited;
end;

function TConexao.getConexao: TFDConnection;
begin
  Result:= FConn;
end;

function TConexao.getProxCod(pTabela: string): string;
var
  wl_Qry: TFDQuery;
  wl_Cmd: string;
begin
  wl_Qry:= TFDQuery.Create(nil);
  wl_Qry.Connection := FConn;
  try
    wl_Cmd:= 'Exec IncContador '+UpperCase(pTabela);
    wl_Qry.Open(wl_Cmd);
    Result:= wl_Qry.FieldByName('Contador').AsString;
  finally
    wl_Qry.Free;
  end;
end;

function TConexao.getQuery: TFDQuery;
var
  wl_Qry: TFDQuery;
begin
  wl_Qry:= TFDQuery.Create(nil);
  wl_Qry.Connection := FConn;
  Result:= wl_Qry;
end;


procedure TConexao.gravaTrans;
begin
  if FConn.InTransaction then
    FConn.Commit
end;

procedure TConexao.iniTrans;
begin
  FConn.StartTransaction;
end;




end.
