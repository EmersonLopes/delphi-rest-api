unit uProdutoDAO;

interface

uses System.SysUtils, FireDAC.Comp.Client, REST.Json, uConexaoController,
     System.Generics.Collections, uProdutoModel, uConexao;

type
  TProdutoDAO = class
    private
      FConexao: TConexao;
    public
      constructor Create;
      function getProdutos : TObjectList<TProdutoModel>;      
  end;

implementation

{ TProdutoDAO }

constructor TProdutoDAO.Create;
begin
  FConexao:= TConexaoController.getInstantce().Conexao;
end;

function TProdutoDAO.getProdutos: TObjectList<TProdutoModel>;
var
  wl_Qry: TFDQuery;
  wl_Lista: TObjectList<TProdutoModel>;
  wl_Produto: TProdutoModel;
  wl_Sql: string;
begin
  wl_Sql:= 'SELECT ID_PRODUTO, DESC_PROD, VALOR ' +
           '  FROM PRODUTO';

  wl_Qry:= FConexao.getQuery;
  wl_Lista:= TObjectList<TProdutoModel>.Create;
  wl_Qry.Open(wl_Sql);
  if wl_Qry.IsEmpty then
  begin
    wl_Produto:= TProdutoModel.Create;
    wl_Produto.codProduto:= 0;
    wl_Produto.descProduto:= '';
    wl_Produto.valor:= 0;
    wl_Lista.Add(wl_Produto);
  end
    else
  begin
    wl_Qry.First;
    while not wl_qry.Eof do
    begin
      wl_Produto:= TProdutoModel.Create;
      wl_Produto.codProduto:= wl_Qry.FieldByName('ID_PRODUTO').AsInteger;
      wl_Produto.descProduto:= wl_Qry.FieldByName('DESC_PROD').AsString;
      wl_Produto.valor:= wl_Qry.FieldByName('VALOR').AsFloat;
      wl_Lista.Add(wl_Produto);
      wl_Qry.Next;
    end;
  end;
  Result:= wl_Lista;
end;

end.
