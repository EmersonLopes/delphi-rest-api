unit uCategoriaDAO;

interface

uses System.SysUtils, FireDAC.Comp.Client, REST.Json, uConexaoController,
     System.Generics.Collections, uCategoriaModel, uConexao;

type
  TCategoriaDAO = class
    private
      FConexao: TConexao;
      function getUltimoCategoria: TCategoriaModel;
    public
      constructor Create;
      function getCategorias : TObjectList<TCategoriaModel>;
      function updateCategoria(pCategoria : TCategoriaModel) : TCategoriaModel;
  end;

implementation

{ TCategoriaDAO }

constructor TCategoriaDAO.Create;
begin
  FConexao:= TConexaoController.getInstantce().Conexao;
end;

function TCategoriaDAO.getCategorias: TObjectList<TCategoriaModel>;
var
  wl_Qry: TFDQuery;
  wl_Lista: TObjectList<TCategoriaModel>;
  wl_Categoria: TCategoriaModel;
  wl_Sql: string;
begin
  wl_Qry:= FConexao.getQuery;
  try
    wl_Sql:= 'SELECT ID_CATEGORIA, DESC_CATEGORIA, IMAGEM, URL ' +
             'FROM CATEGORIA '+
             'ORDER BY ID_CATEGORIA';


    wl_Lista:= TObjectList<TCategoriaModel>.Create;
    wl_Qry.Open(wl_Sql);
    if wl_Qry.IsEmpty then
    begin
      wl_Categoria:= TCategoriaModel.Create;
      wl_Categoria.codCategoria:= 0;
      wl_Categoria.descCategoria:= '';
      wl_Categoria.imagem:= '';
      wl_Categoria.url := '';
      wl_Lista.Add(wl_Categoria);
    end
      else
    begin
      wl_Qry.First;
      while not wl_qry.Eof do
      begin
        wl_Categoria:= TCategoriaModel.Create;
        wl_Categoria.codCategoria:= wl_Qry.FieldByName('ID_CATEGORIA').AsInteger;
        wl_Categoria.descCategoria:= wl_Qry.FieldByName('DESC_CATEGORIA').AsString;
        wl_Categoria.imagem:= wl_Qry.FieldByName('IMAGEM').AsString;
        wl_Categoria.url:= wl_Qry.FieldByName('URL').AsString;

        wl_Lista.Add(wl_Categoria);
        wl_Qry.Next;
      end;
    end;
    Result:= wl_Lista;
  finally
    wl_Qry.Free;
  end;

end;

function TCategoriaDAO.getUltimoCategoria: TCategoriaModel;
var
  wl_Qry: TFDQuery;
  wl_Lista: TObjectList<TCategoriaModel>;
  wl_Categoria: TCategoriaModel;
  wl_Sql: string;
begin
  wl_Qry:= FConexao.getQuery;
  try
    wl_Sql:= 'SELECT ID_CATEGORIA, DESC_CATEGORIA, IMAGEM, URL ' +
             'FROM CATEGORIA '+
             'WHERE ID_CATEGORIA = (SELECT MAX(ID_CATEGORIA) FROM CATEGORIA) '+
             'ORDER BY ID_CATEGORIA';

    wl_Qry.Open(wl_Sql);
    if wl_Qry.IsEmpty then
    begin
      wl_Categoria:= TCategoriaModel.Create;
      wl_Categoria.codCategoria:= 0;
      wl_Categoria.descCategoria:= '';
      wl_Categoria.imagem:= '';
      wl_Categoria.url := '';
      wl_Lista.Add(wl_Categoria);
    end
      else
    begin
      wl_Categoria:= TCategoriaModel.Create;
      wl_Categoria.codCategoria:= wl_Qry.FieldByName('ID_CATEGORIA').AsInteger;
      wl_Categoria.descCategoria:= wl_Qry.FieldByName('DESC_CATEGORIA').AsString;
      wl_Categoria.imagem:= wl_Qry.FieldByName('IMAGEM').AsString;
      wl_Categoria.url:= wl_Qry.FieldByName('URL').AsString;
    end;
    Result:= wl_Categoria;
  finally
    wl_Qry.Free;
  end;
end;

function TCategoriaDAO.updateCategoria(pCategoria : TCategoriaModel): TCategoriaModel;
var
  wl_Qry: TFDQuery;
  wlI : Integer;
  wl_Categoria: TCategoriaModel;
  wl_Sql: string;
begin
  wl_Qry:= FConexao.getQuery;
  try
    try
      wl_Sql:= 'INSERT INTO CATEGORIA (DESC_CATEGORIA, IMAGEM, URL) ' +
               'VALUES(:DESC_CATEGORIA, :IMAGEM, :URL)';

      wlI := wl_Qry.ExecSQL(
      wl_Sql,[

      pCategoria.descCategoria,
      pCategoria.imagem,
      pCategoria.url ]
      );

      if wlI > 0 then
        Result:= getUltimoCategoria
      else
        raise Exception.Create('Nothing inserted.');
    except on E: Exception do
      begin
        pCategoria.codCategoria:= 0;
        pCategoria.descCategoria:= '';
        pCategoria.imagem:= '';
        pCategoria.url := '';
        result := pCategoria;
      end;
    end;
  finally
    wl_Qry.Free;
  end;
end;

end.
