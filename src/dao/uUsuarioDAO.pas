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
      function Login(pUsuario, pSenha: string): Boolean;
  end;

implementation

{ TUsuarioDAO }

constructor TUsuarioDAO.Create;
begin
  FConexao:= TConexaoController.getInstantce().Conexao;
end;

function TUsuarioDAO.Login(pUsuario, pSenha: string): Boolean;
var
  wl_Qry: TFDQuery;
  wl_Lista: TObjectList<TUsuarioModel>;
  wl_ok : Boolean;
  wl_Login: TUsuarioModel;
  wl_Sql: string;
begin
  wl_Qry:= FConexao.getQuery;
  try
    wl_Sql:= 'Select ID_USUARIO, LOGIN_USUARIO ' +
             '  from USUARIO' +
             ' where UPPER(LOGIN_USUARIO) = '+UpperCase(QuotedStr(pUsuario))+
             '   and SENHA_USUARIO = '+QuotedStr(pSenha)+
             '   and ATIVO = 1';
    //wl_Lista:= TObjectList<TUsuarioModel>.Create;
    wl_Qry.Open(wl_Sql);
    if wl_Qry.IsEmpty then
    begin
      wl_Login:= TUsuarioModel.Create;
      wl_Login.codUsuario:= 0;
      wl_Login.loginUsuario:= pUsuario;
      //wl_Lista.Add(wl_Login);
      wl_ok := false;
    end
      else
    begin
      wl_ok := True;
      {
      wl_Qry.First;
      while not wl_qry.Eof do
      begin
        wl_Login:= TUsuarioModel.Create;
        wl_Login.codUsuario:= wl_Qry.FieldByName('codUsuario').AsInteger;
        wl_Login.loginUsuario:= wl_Qry.FieldByName('loginUsuario').AsString;
        wl_Lista.Add(wl_Login);
        wl_Qry.Next;
      end;
      }
    end;
    Result:= wl_ok;
  finally
    wl_Qry.Free;
  end;

end;

function TUsuarioDAO.getUsuarios: TObjectList<TUsuarioModel>;
var
  wl_Qry: TFDQuery;
  wl_Lista: TObjectList<TUsuarioModel>;
  wl_Login: TUsuarioModel;
  wl_Sql: string;
begin
  wl_Sql:= 'Select ID_USUARIO, LOGIN_USUARIO ' +
           '  from USUARIO';

  wl_Qry:= FConexao.getQuery;
  try
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
        wl_Login.loginUsuario:= wl_Qry.FieldByName('LOGIN_USUARIO').AsString;
        wl_Lista.Add(wl_Login);
        wl_Qry.Next;
      end;
    end;
    Result:= wl_Lista;
  finally
    wl_Qry.Free;
  end;

end;

end.
