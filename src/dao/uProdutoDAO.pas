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
  wl_Login: TProdutoModel;
  wl_Sql: string;
begin
  wl_Sql:= 'Select ID_Produto, Produto ' +
           '  from Produto';

  wl_Qry:= FConexao.getQuery;
  wl_Lista:= TObjectList<TProdutoModel>.Create;
  wl_Qry.Open(wl_Sql);
  if wl_Qry.IsEmpty then
  begin
    wl_Login:= TProdutoModel.Create;
    wl_Login.codProduto:= 0;
    wl_Login.descProduto:= '';
    wl_Lista.Add(wl_Login);
  end
    else
  begin
    wl_Qry.First;
    while not wl_qry.Eof do
    begin
      wl_Login:= TProdutoModel.Create;
      wl_Login.codProduto:= wl_Qry.FieldByName('ID_PRODUTO').AsInteger;
      wl_Login.descProduto:= wl_Qry.FieldByName('DESC_PRODUTO').AsString;
      wl_Lista.Add(wl_Login);
      wl_Qry.Next;
    end;
  end;
  Result:= wl_Lista;
end;

end.
