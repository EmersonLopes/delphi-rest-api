unit uDmConexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MSSQL,
  FireDAC.Phys.MSSQLDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef;

type
  TDmConexao = class(TDataModule)
    ConexaoBD_: TFDConnection;
    mtSettings: TFDMemTable;
    mtSettingscontext: TStringField;
    mtSettingsport: TIntegerField;
    mtSettingshost: TStringField;
    mtSettingsdatabase: TStringField;
    mtSettingsuser: TStringField;
    mtSettingspassword: TStringField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ConectarBD;
  end;

var
  DmConexao: TDmConexao;

implementation

uses
  Vcl.Forms;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDmConexao }

procedure TDmConexao.ConectarBD;
begin
  if not mtSettings.Active then
    Exit;
  {
  if ConexaoBD.Connected then
    Exit
  else
  begin
    try
      ConexaoBD.Close;
      ConexaoBD.Params.Clear;

      ConexaoBD.Params.DriverID := 'FB';
      ConexaoBD.Params.Values['Server'] := mtSettingshost.AsString;
      ConexaoBD.Params.Database := mtSettingsdatabase.AsString;;
      ConexaoBD.Params.UserName := mtSettingsuser.AsString;
      ConexaoBD.Params.Password := mtSettingspassword.AsString;

      ConexaoBD.Open;
    except
      on E: Exception do
      begin
        Abort;
      end;
    end;

  end;
  }
end;

procedure TDmConexao.DataModuleCreate(Sender: TObject);
begin
  if FileExists(ExtractFilePath(Application.ExeName)+'settings.json') then
    mtSettings.LoadFromFile(ExtractFilePath(Application.ExeName)+'settings.json',TFDStorageFormat.sfJSON);

  ConectarBD;
end;

end.
