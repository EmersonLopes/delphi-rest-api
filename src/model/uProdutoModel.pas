unit uProdutoModel;

interface

uses System.SysUtils, FireDAC.Comp.Client, System.Json, REST.Json,
     System.Generics.Collections;

type
  TProdutoModel = class
    private
    FcodProduto: Integer;
    FdescProduto : String;
    Fvalor : Double;
    procedure SetcodProduto(const Value: Integer);
    procedure SetdescProduto(const Value: String);
    procedure Setvalor(const Value: Double);

    public
      //Atributos
      property codProduto: Integer read FcodProduto write SetcodProduto;
      property descProduto: String read FdescProduto write SetdescProduto;
      property valor: Double read Fvalor write Setvalor;
  end;

implementation

{ TProdutoModel }

uses uProdutoDAO, uJSONUtil;

procedure TProdutoModel.SetcodProduto(const Value: Integer);
begin
  FcodProduto := Value;
end;


procedure TProdutoModel.SetdescProduto(const Value: String);
begin
  FdescProduto := Value;
end;


procedure TProdutoModel.Setvalor(const Value: Double);
begin
  Fvalor := Value;
end;

end.
