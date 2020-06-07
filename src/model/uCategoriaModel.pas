unit uCategoriaModel;

interface

uses System.SysUtils, FireDAC.Comp.Client, System.Json, REST.Json,
     System.Generics.Collections;


type
  TCategoriaModel = class
    private
    FcodCategoria: Integer;
    FdescCategoria : String;
    Fimagem : String;
    Furl : String;
    procedure SetcodCategoria(const Value: Integer);
    procedure SetdescCategoria(const Value: String);
    procedure Setimagem(const Value: String);
    procedure Seturl(const Value: String);
    

    public
      //Atributos
      property codCategoria: Integer read FcodCategoria write SetcodCategoria;
      property descCategoria: String read FdescCategoria write SetdescCategoria;
      property imagem: String read Fimagem write Setimagem;
      property url: String read Furl write Seturl;
  end;


implementation

{ TCategoriaModel }

uses uCategoriaDAO, uJSONUtil;


{ TCategoriaModel }

procedure TCategoriaModel.SetcodCategoria(const Value: Integer);
begin
  FcodCategoria := Value;
end;

procedure TCategoriaModel.SetdescCategoria(const Value: String);
begin
  FdescCategoria := Value;
end;

procedure TCategoriaModel.Setimagem(const Value: String);
begin
  Fimagem := Value;
end;

procedure TCategoriaModel.Seturl(const Value: String);
begin
  Furl := Value;
end;

end.
