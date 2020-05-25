unit uUsuarioModel;

interface

uses System.SysUtils, FireDAC.Comp.Client, System.Json, REST.Json,
     System.Generics.Collections;

type
  TUsuarioModel = class
    private
    FcodUsuario: Integer;
    FloginUsuario: string;
    procedure SetcodUsuario(const Value: Integer);
    procedure SetloginUsuario(const Value: string);

    public
      //Metodos
      function getLogin(pUsuario, pSenha: string): TJsonArray;

      //Atributos
      property codUsuario: Integer read FcodUsuario write SetcodUsuario;
      property loginUsuario: string read FloginUsuario write SetloginUsuario;
  end;

implementation

{ TUsuarioModel }

uses uUsuarioDAO, uJSONUtil;

function TUsuarioModel.getLogin(pUsuario, pSenha: string): TJsonArray;
var
  wl_UsuarioDAO: TUsuarioDAO;
  wl_Lista: TObjectList<TUsuarioModel>;
begin
  wl_UsuarioDAO := TUsuarioDAO.Create;
  try
    wl_Lista:= wl_UsuarioDAO.getLogin(pUsuario, pSenha);
    Result := TJSONUtil.ObjetoListaParaJson<TUsuarioModel>(wl_Lista);
  finally
    wl_UsuarioDAO.Free;
  end;
end;

procedure TUsuarioModel.SetcodUsuario(const Value: Integer);
begin
  FcodUsuario := Value;
end;

procedure TUsuarioModel.SetloginUsuario(const Value: string);
begin
  FloginUsuario := Value;
end;

end.
