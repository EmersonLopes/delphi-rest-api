unit uUsuarioController;

interface

uses System.SysUtils, FireDAC.Comp.Client, System.Json, System.Classes,
     uJSONUtil, uUsuarioDAO, uUsuarioModel, System.Generics.Collections;

type
  TUsuarioController = class(TComponent)
    private
      FUsuarioDAO: TUsuarioDAO;
    public
      constructor Create(pOwner: TComponent); override;
      destructor Destroy; override;

      function getUsuarios : TJSONArray;
      function Login(pLogin, pSenha : string) : TJSONObject;
  end;

implementation

{ TUsuarioController }

constructor TUsuarioController.Create(pOwner: TComponent);
begin
  inherited;
  FUsuarioDAO:= TUsuarioDAO.Create;
end;

destructor TUsuarioController.Destroy;
begin
  FreeAndNil(FUsuarioDAO);
  inherited;
end;

function TUsuarioController.getUsuarios: TJSONArray;
var
  wl_UsuarioDAO: TUsuarioDAO;
  wl_Lista: TObjectList<TUsuarioModel>;
begin
  wl_UsuarioDAO := TUsuarioDAO.Create;
  try
    wl_Lista:= wl_UsuarioDAO.getUsuarios;
    Result := TJSONUtil.ObjetoListaParaJson<TUsuarioModel>(wl_Lista);
  finally
    wl_UsuarioDAO.Free;
    wl_Lista.Free;
  end;
end;

function TUsuarioController.Login(pLogin, pSenha: string): TJSONObject;
var
  wl_UsuarioDAO: TUsuarioDAO;
  wl_ok: Boolean;
  wlJson : TJSONObject;
begin
  wl_UsuarioDAO := TUsuarioDAO.Create;
  wlJson := TJSONObject.Create;
  try
    wl_ok := wl_UsuarioDAO.Login(pLogin, pSenha);
    wlJson.AddPair(TJSONPair.Create('status',TJSONBool.Create(wl_ok)));
    Result := wlJson;
  finally
    wl_UsuarioDAO.Free;
  end;
end;

end.
