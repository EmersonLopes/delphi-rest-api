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

      function getProdutos : TJSONArray;overload;
      function getProdutos(pDesc : string) : TJSONArray;overload;
      function getProdutos(pCodCategoria : Integer) : TJSONArray;overload;
      function getMaisVendidos: TJSONArray;
      function getPromocoes: TJSONArray;
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

function TProdutoController.getProdutos(pCodCategoria: Integer): TJSONArray;
var
  wl_Lista: TObjectList<TProdutoModel>;
begin
  try
    wl_Lista:= FProdutoDAO.getProdutos(pCodCategoria);
    Result := TJSONUtil.ObjetoListaParaJson<TProdutoModel>(wl_Lista);
  finally
    //wl_Lista.Free;
  end;
end;

function TProdutoController.getProdutos: TJSONArray;
var
  wl_Lista: TObjectList<TProdutoModel>;
begin
  try
    wl_Lista:= FProdutoDAO.getProdutos;
    Result := TJSONUtil.ObjetoListaParaJson<TProdutoModel>(wl_Lista);
  finally
    //wl_Lista.Free;
  end;
end;

function TProdutoController.getMaisVendidos: TJSONArray;
var
  wl_Lista: TObjectList<TProdutoModel>;
begin
  try
    wl_Lista:= FProdutoDAO.getMaisVendidos;
    Result := TJSONUtil.ObjetoListaParaJson<TProdutoModel>(wl_Lista);
  finally
    //wl_Lista.Free;
  end;
end;

function TProdutoController.getProdutos(pDesc: string): TJSONArray;
var
  wl_Lista: TObjectList<TProdutoModel>;
begin
  try
    if(pDesc.Length <3)then
    begin
      Result := TJSONArray.Create;
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('msg',TJSONString.Create('campo de pesquisa deve ser maior que 3 caracters.'))));
    end
    else
    begin
      wl_Lista:= FProdutoDAO.getProdutos(pDesc);
      Result := TJSONUtil.ObjetoListaParaJson<TProdutoModel>(wl_Lista);
    end;
  finally
    //wl_Lista.Free;
  end;
end;

function TProdutoController.getPromocoes: TJSONArray;
var
  wl_Lista: TObjectList<TProdutoModel>;
begin
  try
    wl_Lista:= FProdutoDAO.getPromocoes;
    Result := TJSONUtil.ObjetoListaParaJson<TProdutoModel>(wl_Lista);
  finally
    //wl_Lista.Free;
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
