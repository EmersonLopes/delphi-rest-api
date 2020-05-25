unit uConexaoController;

interface

uses uConexao,
     System.SysUtils;

type
  TConexaoController = class
  private
    FConexao: TConexao;
    class var FInstance: TConexaoController;
  public
    constructor Create;
    destructor Destroy; override;
    class function getInstantce: TConexaoController;

    property Conexao: TConexao read FConexao write FConexao;
  end;

implementation

{ TConexaoController }

constructor TConexaoController.Create;
begin
  FConexao := TConexao.Create;
end;

destructor TConexaoController.Destroy;
begin
  FreeAndNil(FConexao);
  inherited;
end;

class function TConexaoController.getInstantce: TConexaoController;
begin
  if not Assigned(Self.FInstance) then
    Self.FInstance := TConexaoController.Create();
  Result := Self.FInstance;
end;

end.
