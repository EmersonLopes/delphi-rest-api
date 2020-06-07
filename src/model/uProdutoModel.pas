unit uProdutoModel;

interface

uses System.SysUtils, FireDAC.Comp.Client, System.Json, REST.Json,
     System.Generics.Collections;

type
  TProdutoImagemModel = class
    private
    FcodProdutoImagem: Integer;
    FcodProduto: Integer;
    FdescImagem : String;
    Furl : String;
    Fimagem : String;
    procedure SetcodProduto(const Value: Integer);
    procedure SetdescImagem(const Value: String);
    procedure SetFcodProdutoImagem(const Value: Integer);
    procedure Setimagem(const Value: String);
    procedure Seturl(const Value: String);
    public
      //Atributos
      property codProdutoImagem: Integer read FcodProdutoImagem write SetFcodProdutoImagem;
      property codProduto: Integer read FcodProduto write SetcodProduto;
      property imagem: String read Fimagem write Setimagem;
      property descImagem: String read FdescImagem write SetdescImagem;
      property url: String read Furl write Seturl;

  end;

type
  TImagens = array of TProdutoImagemModel;

type
  TProdutoModel = class
    private
    FcodProduto: Integer;
    FdescProduto : String;
    FcodCategoria: Integer;
    Fvalor : Double;
    Fdetalhes : String;
    Fimagens : TImagens;
    procedure SetcodProduto(const Value: Integer);
    procedure SetdescProduto(const Value: String);
    procedure Setvalor(const Value: Double);
    procedure Setdetalhes(const Value: String);
    procedure Setimagens(const Value: TImagens);
    procedure SetcodCategoria(const Value: Integer);

    public
      //Atributos
      property codProduto: Integer read FcodProduto write SetcodProduto;
      property descProduto: String read FdescProduto write SetdescProduto;
      property codCategoria: Integer read FcodCategoria write SetcodCategoria;
      property valor: Double read Fvalor write Setvalor;
      property detalhes: String read Fdetalhes write Setdetalhes;
      property imagens: TImagens read Fimagens write Setimagens;
  end;


implementation

{ TProdutoModel }

uses uProdutoDAO, uJSONUtil;

procedure TProdutoModel.SetcodCategoria(const Value: Integer);
begin
  FcodCategoria := Value;
end;

procedure TProdutoModel.SetcodProduto(const Value: Integer);
begin
  FcodProduto := Value;
end;


procedure TProdutoModel.SetdescProduto(const Value: String);
begin
  FdescProduto := Value;
end;


procedure TProdutoModel.Setdetalhes(const Value: String);
begin
  Fdetalhes := Value;
end;

procedure TProdutoModel.Setimagens(const Value: TImagens);
begin
  Fimagens := Value;
end;

procedure TProdutoModel.Setvalor(const Value: Double);
begin
  Fvalor := Value;
end;

{ TProdutoImagemModel }

procedure TProdutoImagemModel.SetcodProduto(const Value: Integer);
begin
  FcodProduto := Value;
end;

procedure TProdutoImagemModel.SetdescImagem(const Value: String);
begin
  FdescImagem := Value;
end;

procedure TProdutoImagemModel.SetFcodProdutoImagem(const Value: Integer);
begin
  FcodProdutoImagem := Value;
end;

procedure TProdutoImagemModel.Setimagem(const Value: String);
begin
  Fimagem := Value;
end;

procedure TProdutoImagemModel.Seturl(const Value: String);
begin
  Furl := Value;
end;

end.
