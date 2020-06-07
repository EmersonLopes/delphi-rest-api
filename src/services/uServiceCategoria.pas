unit uServiceCategoria;

interface

uses System.SysUtils, System.Classes, Datasnap.DSServer, Datasnap.DSAuth,
  System.JSON, uRotinasDB, uCategoriaController;

type
{$METHODINFO ON}
  TServiceCategoria = class(TComponent)
  private
    { Private declarations }
    FCategoriaController: TCategoriaController;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetCategorias : TJSONArray;
    function updateCategorias(pCategoria : TJSONObject) : TJSONObject;

  end;
{$METHODINFO OFF}

implementation

{ TServiceCategoria }




constructor TServiceCategoria.Create(AOwner: TComponent);
begin
  inherited;
  FCategoriaController:= TCategoriaController.Create(nil);
end;

destructor TServiceCategoria.Destroy;
begin
  FreeAndNil(FCategoriaController);
  inherited;
end;

function TServiceCategoria.GetCategorias: TJSONArray;
begin
  Result := FCategoriaController.getCategorias;
end;

function TServiceCategoria.updateCategorias(pCategoria : TJSONObject): TJSONObject;
begin
  result := FCategoriaController.updateCategorias(pCategoria);
end;

end.
