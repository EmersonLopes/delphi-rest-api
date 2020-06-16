unit uProdutoDAO;

interface

uses System.SysUtils, FireDAC.Comp.Client, REST.Json, uConexaoController,
     System.Generics.Collections, uProdutoModel, uConexao;

type
  TProdutoDAO = class
    private
      FConexao: TConexao;
      function getUltimoProduto: TProdutoModel;
      function getUltimoProdutoImagem: TProdutoImagemModel;
    public
      constructor Create;
      function getProdutos : TObjectList<TProdutoModel>; overload;
      function getProdutos(pCodCategoria : Integer) : TObjectList<TProdutoModel>;overload;
      function updateProduto(pProduto : TProdutoModel) : TProdutoModel;
      function updateImagem(pImagem : TProdutoImagemModel) : TProdutoImagemModel;
  end;

implementation

{ TProdutoDAO }

constructor TProdutoDAO.Create;
begin
  FConexao:= TConexaoController.getInstantce().Conexao;
end;

function TProdutoDAO.getProdutos: TObjectList<TProdutoModel>;
var
  wl_Qry,
  wl_QryImgs: TFDQuery;
  wl_Lista: TObjectList<TProdutoModel>;
  wl_Produto: TProdutoModel;
  wl_Sql: string;
  wlImgs : TImagens;
  wlImagem : TProdutoImagemModel;
begin
  wl_Qry:= FConexao.getQuery;
  wl_QryImgs := FConexao.getQuery;
  try
    wl_Sql:= 'SELECT ID_PRODUTO, DESC_PROD, VALOR, DETALHES, ID_CATEGORIA ' +
             'FROM PRODUTO '+
             'ORDER BY ID_PRODUTO';


    wl_Lista:= TObjectList<TProdutoModel>.Create;
    wl_Qry.SQL.Text := wl_Sql;
    wl_Qry.Open;
    if wl_Qry.IsEmpty then
    begin
      {
      wl_Produto:= TProdutoModel.Create;
      wl_Produto.codProduto:= 0;
      wl_Produto.descProduto:= '';
      wl_Produto.valor:= 0;
      wl_Produto.detalhes := '';
      wl_Produto.codCategoria:= 0;
      wl_Lista.Add(wl_Produto);
      }
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
        wl_Produto.codCategoria:= wl_Qry.FieldByName('ID_CATEGORIA').AsInteger;
        wlImgs := nil;
        wl_Sql:= 'SELECT ID_PRODUTO_IMAGEM, ID_PRODUTO, DESC_IMAGEM, IMAGEM, URL ' +
                 '  FROM PRODUTO_IMAGEM WHERE ID_PRODUTO = '+ IntToStr(wl_Produto.codProduto);
        wl_QryImgs.SQL.Text := wl_Sql;
        wl_QryImgs.Open;

        if not wl_QryImgs.IsEmpty then
          SetLength(wlImgs, wl_QryImgs.RecordCount);

        wl_QryImgs.First;
        while not wl_QryImgs.Eof do
        begin
          wlImagem := TProdutoImagemModel.Create;
          wlImagem.codProdutoImagem := wl_QryImgs.FieldByName('ID_PRODUTO_IMAGEM').AsInteger;
          wlImagem.codProduto := wl_QryImgs.FieldByName('ID_PRODUTO').AsInteger;
          wlImagem.descImagem := wl_QryImgs.FieldByName('DESC_IMAGEM').AsString;
          wlImagem.imagem := wl_QryImgs.FieldByName('IMAGEM').AsString;
          wlImagem.url := wl_QryImgs.FieldByName('URL').AsString;
          wlImgs[wl_QryImgs.RecNo-1] := wlImagem;
          wl_QryImgs.Next;
        end;
        wl_Produto.imagens := wlImgs;

        wl_Lista.Add(wl_Produto);
        wl_Qry.Next;
      end;
    end;
    Result:= wl_Lista;
  finally
    wl_Qry.Free;
    wl_QryImgs.Free;
  end;

end;

function TProdutoDAO.getUltimoProdutoImagem: TProdutoImagemModel;
var
  wl_Qry: TFDQuery;
  wl_ProdutoImagem: TProdutoImagemModel;
  wl_Sql: string;
begin
  wl_Qry:= FConexao.getQuery;
  try
    wl_Sql:= 'SELECT ID_PRODUTO_IMAGEM, ID_PRODUTO, IMAGEM, URL, DESC_IMAGEM ' +
             'FROM PRODUTO_IMAGEM '+
             'WHERE ID_PRODUTO_IMAGEM = (SELECT MAX(ID_PRODUTO_IMAGEM) FROM PRODUTO_IMAGEM)';

    wl_Qry.Open(wl_Sql);
    if wl_Qry.IsEmpty then
    begin
      wl_ProdutoImagem.codProdutoImagem := 0;
      wl_ProdutoImagem.codProduto := 0;
      wl_ProdutoImagem.imagem := '';
      wl_ProdutoImagem.url := '';
      wl_ProdutoImagem.descImagem := '';
    end
      else
    begin
      wl_ProdutoImagem:= TProdutoImagemModel.Create;
      wl_ProdutoImagem.codProdutoImagem := wl_Qry.FieldByName('ID_PRODUTO_IMAGEM').AsInteger;
      wl_ProdutoImagem.codProduto := wl_Qry.FieldByName('ID_PRODUTO').AsInteger;
      wl_ProdutoImagem.imagem := wl_Qry.FieldByName('IMAGEM').AsString;
      wl_ProdutoImagem.url := wl_Qry.FieldByName('URL').AsString;
      wl_ProdutoImagem.descImagem := wl_Qry.FieldByName('DESC_IMAGEM').AsString;
    end;
    Result:= wl_ProdutoImagem;
  finally
    wl_Qry.Free;
  end;
end;

function TProdutoDAO.getProdutos(
  pCodCategoria: Integer): TObjectList<TProdutoModel>;
var
  wl_Qry,
  wl_QryImgs: TFDQuery;
  wl_Lista: TObjectList<TProdutoModel>;
  wl_Produto: TProdutoModel;
  wl_Sql: string;
  wlImgs : TImagens;
  wlImagem : TProdutoImagemModel;
begin
  wl_Qry:= FConexao.getQuery;
  wl_QryImgs := FConexao.getQuery;
  try
    wl_Sql:= 'SELECT ID_PRODUTO, DESC_PROD, VALOR, DETALHES, ID_CATEGORIA ' +
             'FROM PRODUTO '+
             'WHERE ID_CATEGORIA = '+IntToStr(pCodCategoria)+
             ' ORDER BY ID_PRODUTO';


    wl_Lista:= TObjectList<TProdutoModel>.Create;
    wl_Qry.SQL.Text := wl_Sql;
    wl_Qry.Open;
    if wl_Qry.IsEmpty then
    begin
      {
      wl_Produto:= TProdutoModel.Create;
      wl_Produto.codProduto:= 0;
      wl_Produto.descProduto:= '';
      wl_Produto.valor:= 0;
      wl_Produto.detalhes := '';
      wl_Produto.codCategoria:= 0;
      wl_Lista.Add(wl_Produto);
      }
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
        wl_Produto.codCategoria:= wl_Qry.FieldByName('ID_CATEGORIA').AsInteger;
        wlImgs := nil;
        wl_Sql:= 'SELECT ID_PRODUTO_IMAGEM, ID_PRODUTO, DESC_IMAGEM, IMAGEM, URL ' +
                 '  FROM PRODUTO_IMAGEM WHERE ID_PRODUTO = '+ IntToStr(wl_Produto.codProduto);
        wl_QryImgs.SQL.Text := wl_Sql;
        wl_QryImgs.Open;

        if not wl_QryImgs.IsEmpty then
          SetLength(wlImgs, wl_QryImgs.RecordCount);

        wl_QryImgs.First;
        while not wl_QryImgs.Eof do
        begin
          wlImagem := TProdutoImagemModel.Create;
          wlImagem.codProdutoImagem := wl_QryImgs.FieldByName('ID_PRODUTO_IMAGEM').AsInteger;
          wlImagem.codProduto := wl_QryImgs.FieldByName('ID_PRODUTO').AsInteger;
          wlImagem.descImagem := wl_QryImgs.FieldByName('DESC_IMAGEM').AsString;
          wlImagem.imagem := wl_QryImgs.FieldByName('IMAGEM').AsString;
          wlImagem.url := wl_QryImgs.FieldByName('URL').AsString;
          wlImgs[wl_QryImgs.RecNo-1] := wlImagem;
          wl_QryImgs.Next;
        end;
        wl_Produto.imagens := wlImgs;

        wl_Lista.Add(wl_Produto);
        wl_Qry.Next;
      end;
    end;
    Result:= wl_Lista;
  finally
    wl_Qry.Free;
    wl_QryImgs.Free;
  end;
end;

function TProdutoDAO.getUltimoProduto: TProdutoModel;
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

function TProdutoDAO.updateImagem(pImagem: TProdutoImagemModel): TProdutoImagemModel;
var

  wl_Qry: TFDQuery;
  wlI : Integer;
  wl_Produto: TProdutoModel;
  wl_Sql: string;
begin
  wl_Qry:= FConexao.getQuery;
  try
    try
      wl_Sql:= 'INSERT INTO PRODUTO_IMAGEM (ID_PRODUTO, IMAGEM, URL, DESC_IMAGEM) ' +
               'VALUES(:ID_PRODUTO, :IMAGEM, :URL, :DESC_IMAGEM)';


      wlI := wl_Qry.ExecSQL(
      wl_Sql,[

      pImagem.codProduto,
      pImagem.imagem,
      pImagem.url,
      pImagem.descImagem ]
      );

      if wlI > 0 then
        Result:= getUltimoProdutoImagem
      else
        raise Exception.Create('Nothing inserted.');
    except on E: Exception do
      begin
        pImagem.codProdutoImagem := 0;
        pImagem.codProduto := 0;
        pImagem.imagem := '';
        pImagem.url := '';
        pImagem.descImagem := '';
      end;
    end;
  finally
    wl_Qry.Free;
  end;
end;

function TProdutoDAO.updateProduto(pProduto : TProdutoModel): TProdutoModel;
var
  wl_Qry: TFDQuery;
  wlI,
  I : Integer;
  wl_Produto: TProdutoModel;
  wl_Sql: string;
begin
  wl_Qry:= FConexao.getQuery;
  try
    FConexao.iniTrans;
    try
      wl_Sql:= 'INSERT INTO PRODUTO (DESC_PROD, ID_CATEGORIA, VALOR, DETALHES) ' +
               'VALUES(:DESC_PROD, :ID_CATEGORIA, :VALOR, :DETALHES)';


      wlI := wl_Qry.ExecSQL(
      wl_Sql,[

      pProduto.descProduto,
      pProduto.codCategoria,
      pProduto.valor,
      pProduto.detalhes ]
      );

      if wlI <= 0 then
      begin
        FConexao.desfazTrans;
        raise Exception.Create('Nothing inserted.');
      end;

      wl_Produto := getUltimoProduto;
      for I := 0 to Length(pProduto.imagens) - 1 do
      begin
        wl_Sql:= 'INSERT INTO PRODUTO_IMAGEM (ID_PRODUTO, IMAGEM, URL, DESC_IMAGEM) ' +
                 'VALUES(:ID_PRODUTO, :IMAGEM, :URL, :DESC_IMAGEM)';


        wlI := wl_Qry.ExecSQL(
        wl_Sql,[

        wl_Produto.codProduto,
        pProduto.imagens[i].imagem,
        pProduto.imagens[i].url,
        pProduto.imagens[i].descImagem ]
        );
      end;


      Result:= wl_Produto;


      FConexao.gravaTrans;
    except on E: Exception do
      begin
        FConexao.desfazTrans;
        pProduto.codProduto:= 0;
        pProduto.descProduto:= '';
        pProduto.codCategoria:= 0;
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
