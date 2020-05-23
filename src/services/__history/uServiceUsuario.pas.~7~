unit uServiceUsuario;

interface

uses System.SysUtils, System.Classes, Datasnap.DSServer, Datasnap.DSAuth,
  System.JSON, uRotinasDB, Usuario;

type
{$METHODINFO ON}
  TServiceUsuario = class(TComponent)
  private
    { Private declarations }
  public
    { Public declarations }
    function GetUsuarios : TJSONArray;
    function Login(pLoginUsuario, pSenha: String) : TJSONObject;
  end;
{$METHODINFO OFF}

implementation

{ TServiceUsuario }



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
