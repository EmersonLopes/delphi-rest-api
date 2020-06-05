unit uProdutoController;

interface

uses System.SysUtils, FireDAC.Comp.Client, System.Json, System.Classes,
     uJSONUtil, uProdutoDAO, uProdutoModel, System.Generics.Collections;

type
  TProdutoController = class(TComponent)
    private
      FProdutoDAO: TProdutoDAO;
    public
      constructor Create(pOwner: TComponent); override;
      destructor Destroy; override;

      function getProdutos : TJSONArray;
      function updateProdutos(pProduto : TJSONObject): TJSONObject;
      function updateImagem(pImagem : TJSONObject): TJSONObject;

  end;

implementation

uses
  REST.Json;

{ TProdutoController }

constructor TProdutoController.Create(pOwner: TComponent);
begin
  inherited;
  FProdutoDAO:= TProdutoDAO.Create;
end;

destructor TProdutoController.Destroy;
begin
  FreeAndNil(FProdutoDAO);
  inherited;
end;

function TProdutoController.getProdutos: TJSONArray;
var
  //wl_ProdutoDAO: TProdutoDAO;
  wl_Lista: TObjectList<TProdutoModel>;
begin
  //wl_ProdutoDAO := TProdutoDAO.Create;
  try
    wl_Lista:= FProdutoDAO.getProdutos;
    Result := TJSONUtil.ObjetoListaParaJson<TProdutoModel>(wl_Lista);
  finally
    //wl_ProdutoDAO.Free;
  end;
end;

function TProdutoController.updateImagem(pImagem: TJSONObject): TJSONObject;
var
  wlImagem : TProdutoImagemModel;
begin
  wlImagem := TJson.JsonToObject<TProdutoImagemModel>(pImagem);
  try
    wlImagem := FProdutoDAO.updateImagem(wlImagem);
    Result := TJson.ObjectToJsonObject(wlImagem);
  finally
    wlImagem.Free;
  end;
end;

function TProdutoController.updateProdutos(pProduto : TJSONObject): TJSONObject;
var
  wlProduto : TProdutoModel;
begin
  wlProduto := TJson.JsonToObject<TProdutoModel>(pProduto);
  try
    wlProduto := FProdutoDAO.updateProduto(wlProduto);
    Result := TJson.ObjectToJsonObject(wlProduto);
  finally
    wlProduto.Free;
  end;
end;

end.
