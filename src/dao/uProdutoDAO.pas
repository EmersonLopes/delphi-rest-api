unit uProdutoDAO;

interface

uses System.SysUtils, FireDAC.Comp.Client, REST.Json, uConexaoController,
     System.Generics.Collections, uProdutoModel, uConexao;

type
  TProdutoDAO = class
    private
      FConexao: TConexao;
      function getUltimo: TProdutoModel;
    public
      constructor Create;
      function getProdutos : TObjectList<TProdutoModel>;
      function updateProduto(pProduto : TProdutoModel) : TProdutoModel;
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
  wl_Qry:= FConexao.getQuery;
  try
    wl_Sql:= 'SELECT ID_PRODUTO, DESC_PROD, VALOR, DETALHES ' +
             '  FROM PRODUTO';


    wl_Lista:= TObjectList<TProdutoModel>.Create;
    wl_Qry.Open(wl_Sql);
    if wl_Qry.IsEmpty then
    begin
      wl_Produto:= TProdutoModel.Create;
      wl_Produto.codProduto:= 0;
      wl_Produto.descProduto:= '';
      wl_Produto.valor:= 0;
      wl_Produto.detalhes := '';
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
        wl_Produto.detalhes:= wl_Qry.FieldByName('DETALHES').AsString;
        wl_Lista.Add(wl_Produto);
        wl_Qry.Next;
      end;
    end;
    Result:= wl_Lista;
  finally
    wl_Qry.Free;
  end;

end;

function TProdutoDAO.getUltimo: TProdutoModel;
var
  wl_Qry: TFDQuery;
  wl_Lista: TObjectList<TProdutoModel>;
  wl_Produto: TProdutoModel;
  wl_Sql: string;
begin
  wl_Qry:= FConexao.getQuery;
  try
    wl_Sql:= 'SELECT ID_PRODUTO, DESC_PROD, VALOR, DETALHES ' +
             'FROM PRODUTO '+
             'WHERE ID_PRODUTO = (SELECT MAX(ID_PRODUTO) FROM PRODUTO)';

    wl_Qry.Open(wl_Sql);
    if wl_Qry.IsEmpty then
    begin
      wl_Produto:= TProdutoModel.Create;
      wl_Produto.codProduto:= 0;
      wl_Produto.descProduto:= '';
      wl_Produto.valor:= 0;
      wl_Produto.detalhes := '';
      wl_Lista.Add(wl_Produto);
    end
      else
    begin
      wl_Produto:= TProdutoModel.Create;
      wl_Produto.codProduto:= wl_Qry.FieldByName('ID_PRODUTO').AsInteger;
      wl_Produto.descProduto:= wl_Qry.FieldByName('DESC_PROD').AsString;
      wl_Produto.valor:= wl_Qry.FieldByName('VALOR').AsFloat;
      wl_Produto.detalhes:= wl_Qry.FieldByName('DETALHES').AsString;
    end;
    Result:= wl_Produto;
  finally
    wl_Qry.Free;
  end;
end;

function TProdutoDAO.updateProduto(pProduto : TProdutoModel): TProdutoModel;
var
  wl_Qry: TFDQuery;
  wlI : Integer;
  wl_Produto: TProdutoModel;
  wl_Sql: string;
begin
  wl_Qry:= FConexao.getQuery;
  try
    try
      wl_Sql:= 'INSERT INTO PRODUTO (DESC_PROD, VALOR, DETALHES) ' +
               'VALUES(:DESC_PROD, :VALOR, :DETALHES)';


      wlI = wl_Qry.ExecSQL(
      wl_Sql,[

      pProduto.descProduto,
      pProduto.valor,
      pProduto.detalhes ]
      );

      if wlI > 0 then
        Result:= getUltimo
      else
        raise Exception.Create('Nothin inserted.');
    except on E: Exception do
      begin
        pProduto.codProduto:= 0;
        pProduto.descProduto:= '';
        pProduto.valor:= 0;
        pProduto.detalhes := '';
        result := pProduto;
      end;
    end;
  finally
    wl_Qry.Free;
  end;
end;

end.
