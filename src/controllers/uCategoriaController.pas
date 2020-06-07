unit uCategoriaController;

interface

uses System.SysUtils, FireDAC.Comp.Client, System.Json, System.Classes,
     uJSONUtil, uCategoriaDAO, uCategoriaModel, System.Generics.Collections;

type
  TCategoriaController = class(TComponent)
    private
      FCategoriaDAO: TCategoriaDAO;
    public
      constructor Create(pOwner: TComponent); override;
      destructor Destroy; override;

      function getCategorias : TJSONArray;
      function updateCategorias(pCategoria : TJSONObject): TJSONObject;

  end;

implementation

uses
  REST.Json;

{ TCategoriaController }

constructor TCategoriaController.Create(pOwner: TComponent);
begin
  inherited;
  FCategoriaDAO:= TCategoriaDAO.Create;
end;

destructor TCategoriaController.Destroy;
begin
  FreeAndNil(FCategoriaDAO);
  inherited;
end;

function TCategoriaController.getCategorias: TJSONArray;
var
  wl_Lista: TObjectList<TCategoriaModel>;
begin
  try
    wl_Lista:= FCategoriaDAO.getCategorias;
    Result := TJSONUtil.ObjetoListaParaJson<TCategoriaModel>(wl_Lista);
  finally
    //wl_Lista.Free;
  end;
end;

function TCategoriaController.updateCategorias(pCategoria : TJSONObject): TJSONObject;
var
  wlCategoria : TCategoriaModel;
begin
  wlCategoria := TJson.JsonToObject<TCategoriaModel>(pCategoria);
  try
    wlCategoria := FCategoriaDAO.updateCategoria(wlCategoria);
    Result := TJson.ObjectToJsonObject(wlCategoria);
  finally
    wlCategoria.Free;
  end;
end;

end.
