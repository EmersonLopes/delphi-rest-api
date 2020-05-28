unit uServiceProduto;

interface

uses System.SysUtils, System.Classes, Datasnap.DSServer, Datasnap.DSAuth,
  System.JSON, uRotinasDB, uProdutoController;

type
{$METHODINFO ON}
  TServiceProduto = class(TComponent)
  private
    { Private declarations }
  public
    { Public declarations }
    function GetProdutos : TJSONArray;        
  end;
{$METHODINFO OFF}

implementation

{ TServiceProduto }



function TServiceProduto.GetProdutos: TJSONArray;
var
  wl_ProdutoController: TProdutoController;
begin
  wl_ProdutoController:= TProdutoController.Create(nil);
  try
    Result := wl_ProdutoController.getProdutos;
  finally
    wl_ProdutoController.Free;
  end;
end;

end.
