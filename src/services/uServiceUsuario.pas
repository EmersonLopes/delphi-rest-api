unit uServiceUsuario;

interface

uses System.SysUtils, System.Classes, Datasnap.DSServer, Datasnap.DSAuth,
  System.JSON, uRotinasDB, Usuario, uUsuarioController;

type
{$METHODINFO ON}
  TServiceUsuario = class(TComponent)
  private
    { Private declarations }
  public
    { Public declarations }
    function GetUsuarios : TJSONArray;
    function GetUsuarios2 : TJSONArray;
    function Login(pLoginUsuario, pSenha: String) : TJSONObject;
  end;
{$METHODINFO OFF}

implementation

{ TServiceUsuario }



function TServiceUsuario.GetUsuarios2: TJSONArray;
var
  wl_UsuarioController: TUsuarioController;
begin
  wl_UsuarioController:= TUsuarioController.Create(nil);
  try
    Result := wl_UsuarioController.getUsuarios;
  finally
    wl_UsuarioController.Free;
  end;
end;

function TServiceUsuario.Login(pLoginUsuario, pSenha: String): TJSONObject;
begin
  Result := DataSetToJSON_Object(TUsuario.Login(pLoginUsuario, pSenha));
end;

{ TServiceUsuario }

function TServiceUsuario.GetUsuarios: TJSONArray;
begin
  result := DataSetToJSON(TUsuario.GetUsuarios);
end;

end.
