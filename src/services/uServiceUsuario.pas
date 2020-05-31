unit uServiceUsuario;

interface

uses System.SysUtils, System.Classes, Datasnap.DSServer, Datasnap.DSAuth,
  System.JSON, uRotinasDB, uUsuarioController;

type
{$METHODINFO ON}
  TServiceUsuario = class(TComponent)
  private
    { Private declarations }
    FUsuarioController: TUsuarioController;
    FJson : TJSONObject;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetUsuarios : TJSONArray;
    function Login(pLogin, pSenha : string) : TJSONObject;
  end;
{$METHODINFO OFF}

implementation

{ TServiceUsuario }


constructor TServiceUsuario.Create(AOwner: TComponent);
begin
  inherited;
  FUsuarioController:= TUsuarioController.Create(nil);
  FJson := TJSONObject.Create;
end;

destructor TServiceUsuario.Destroy;
begin
  FreeAndNil(FUsuarioController);
  FreeAndNil(FJson);
  inherited;
end;

function TServiceUsuario.GetUsuarios: TJSONArray;
begin
  Result := FUsuarioController.getUsuarios;
end;

function TServiceUsuario.Login(pLogin, pSenha : string): TJSONObject;
begin
  Result := FUsuarioController.Login(pLogin, pSenha);
end;

end.
