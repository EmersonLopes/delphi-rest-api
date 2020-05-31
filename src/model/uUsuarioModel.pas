unit uUsuarioModel;

interface

uses System.SysUtils, FireDAC.Comp.Client, System.Json, REST.Json,
     System.Generics.Collections;

type
  TUsuarioModel = class
    private
    FcodUsuario: Integer;
    FloginUsuario: string;
    procedure SetcodUsuario(const Value: Integer);
    procedure SetloginUsuario(const Value: string);

    public
      //Atributos
      property codUsuario: Integer read FcodUsuario write SetcodUsuario;
      property loginUsuario: string read FloginUsuario write SetloginUsuario;
  end;

implementation

{ TUsuarioModel }

procedure TUsuarioModel.SetcodUsuario(const Value: Integer);
begin
  FcodUsuario := Value;
end;

procedure TUsuarioModel.SetloginUsuario(const Value: string);
begin
  FloginUsuario := Value;
end;

end.
