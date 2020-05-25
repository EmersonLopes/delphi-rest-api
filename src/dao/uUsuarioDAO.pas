unit uUsuarioDAO;

interface

uses System.SysUtils, FireDAC.Comp.Client, REST.Json, uConexaoController,
     System.Generics.Collections, uUsuarioModel, uConexao;

type
  TUsuarioDAO = class
    private
      FConexao: TConexao;
    public
      constructor Create;
      function getUsuarios : TObjectList<TUsuarioModel>;
      function getLogin(pUsuario, pSenha: string): TObjectList<TUsuarioModel>;
  end;

implementation

{ TUsuarioDAO }

constructor TUsuarioDAO.Create;
begin
  FConexao:= TConexaoController.getInstantce().Conexao;
end;

function TUsuarioDAO.getLogin(pUsuario, pSenha: string): TObjectList<TUsuarioModel>;
var
  wl_Qry: TFDQuery;
  wl_Lista: TObjectList<TUsuarioModel>;
  wl_Login: TUsuarioModel;
  wl_Sql: string;
begin
  wl_Sql:= 'Select CodUsuario, LoginUsuario ' +
           '  from usuario' +
           ' where LoginUsuario = '+QuotedStr(pUsuario)+
           //'   and SenhaUsuario = '+QuotedStr(Encrypt(pSenha))+
           '   and ativo = 1';
  wl_Qry:= FConexao.getQuery;
  wl_Lista:= TObjectList<TUsuarioModel>.Create;
  wl_Qry.Open(wl_Sql);
  if wl_Qry.IsEmpty then
  begin
    wl_Login:= TUsuarioModel.Create;
    wl_Login.codUsuario:= 0;
    wl_Login.loginUsuario:= pUsuario;
    wl_Lista.Add(wl_Login);
  end
    else
  begin
    wl_Qry.First;
    while not wl_qry.Eof do
    begin
      wl_Login:= TUsuarioModel.Create;
      wl_Login.codUsuario:= wl_Qry.FieldByName('codUsuario').AsInteger;
      wl_Login.loginUsuario:= wl_Qry.FieldByName('loginUsuario').AsString;
      wl_Lista.Add(wl_Login);
      wl_Qry.Next;
    end;
  end;
  Result:= wl_Lista;
end;

function TUsuarioDAO.getUsuarios: TObjectList<TUsuarioModel>;
var
  wl_Qry: TFDQuery;
  wl_Lista: TObjectList<TUsuarioModel>;
  wl_Login: TUsuarioModel;
  wl_Sql: string;
begin
  wl_Sql:= 'Select ID_USUARIO, USUARIO ' +
           '  from usuario';

  wl_Qry:= FConexao.getQuery;
  wl_Lista:= TObjectList<TUsuarioModel>.Create;
  wl_Qry.Open(wl_Sql);
  if wl_Qry.IsEmpty then
  begin
    wl_Login:= TUsuarioModel.Create;
    wl_Login.codUsuario:= 0;
    wl_Login.loginUsuario:= '';
    wl_Lista.Add(wl_Login);
  end
    else
  begin
    wl_Qry.First;
    while not wl_qry.Eof do
    begin
      wl_Login:= TUsuarioModel.Create;
      wl_Login.codUsuario:= wl_Qry.FieldByName('ID_USUARIO').AsInteger;
      wl_Login.loginUsuario:= wl_Qry.FieldByName('USUARIO').AsString;
      wl_Lista.Add(wl_Login);
      wl_Qry.Next;
    end;
  end;
  Result:= wl_Lista;
end;

end.
