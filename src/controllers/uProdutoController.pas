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
  end;

implementation

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

end.
