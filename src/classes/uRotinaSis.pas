unit uRotinaSis;

interface

uses Windows, SysUtils, Forms, SQLExpr, DBClient, IniFiles,
     StdCtrls, ComCtrls, Messages, RichEdit,
     ShlObj, Dialogs, ExtCtrls, Controls,
     Classes, WinSock, IdBaseComponent, IdIPWatch,
     xmldom, XMLIntf, msxmldom, XMLDoc,
     Vcl.Buttons, System.Threading,
     Graphics, DBCtrls, DBGrids,
     Mask,  FireDAC.Comp.Client,
     FireDAC.Comp.DataSet, Vcl.Styles, Vcl.Themes,
     Data.DB;

  function NomeComputador : String;
  function GetIP: String;
  function getVersaoExe(pArquivo: String): String;


  function PegaDadosArqIni(p_NomArq, p_Secao, p_Chave, p_Default : String) : String;
  Procedure WriteIni(Pasta: String; IniFile: String; Secao: String; Chave: String;
  valor: string);
  function LeIni(Pasta: String; IniFile: String; Secao: String; Chave: String): String;
  function NomeMaquina: string;



implementation


function PegaDadosArqIni(p_NomArq, p_Secao, p_Chave, p_Default : String) : String;
var
  wl_ArqIni : TIniFile;
begin
  wl_ArqIni := TIniFile.Create(ExtractFilePath(Application.ExeName)+'\'+p_NomArq+'.INI');
  try
    Result := wl_ArqIni.ReadString(p_Secao, p_Chave, p_Default);
  finally
    wl_ArqIni.Free;
  end;
end;


function GetIP: String;
var
  wl_IPWatch: TIdIPWatch;
begin
  with TIdIPWatch.Create(Nil) do
  begin
    Result := LocalIP;
    Free;
  end;
end;

function getVersaoExe(pArquivo: String): String;
const
  Key: array[1..9] of string =('CompanyName', 'FileDescription','FileVersion','InternalName',
                               'LegalCopyright','OriginalFilename', 'ProductName','ProductVersion',
                               'Comments');
  KeyBr: array [1..9] of string = ('Empresa','Descricao','Versao do Arquivo','Nome Interno',
                                   'Copyright','Nome Original do Arquivo', 'Produto','Versao do Produto',
                                   'Comentarios');
var
  Dummy : Cardinal;
  BufferSize, Len : Integer;
  Buffer : PChar;
  LoCharSet, HiCharSet : Word;
  Translate, Return : Pointer;
  StrFileInfo : string;
begin
  Result := '** ERRO **';
  { Obtemos o tamanho em bytes do "version  information" }
  BufferSize := GetFileVersionInfoSize(PWideChar(pArquivo), Dummy);
  if BufferSize <> 0 then
  begin
    GetMem(Buffer, Succ(BufferSize));
    try
      if GetFileVersionInfo(PChar(pArquivo), 0, BufferSize, Buffer) then
        { Executamos a funcao "VerQueryValue" e conseguimos informacoes sobre o idioma/character-set }
        if VerQueryValue(Buffer, '\VarFileInfo\Translation', Translate, UINT(Len)) then
        begin
          LoCharSet := LoWord(Longint(Translate^));
          HiCharSet := HiWord(Longint(Translate^));
          { Montamos a string de pesquisa }
          StrFileInfo := Format('\StringFileInfo\0%x0%x\FileVersion',[LoCharSet, HiCharSet, Key[3]]);
          { Adicionamos cada key pré-definido }
          if VerQueryValue(Buffer,PChar(StrFileInfo), Return, UINT(Len)) then
            Result := PChar(Return);
        end;
    finally
      FreeMem(Buffer, Succ(BufferSize));
    end;
  end;
end;

function NomeComputador : String;
var
  WnomeComputador: Array[0..30]of Char;
  size:Cardinal;
begin
 {Variável de iniciação }
 size:= 30;
 {Retorna o nome do computador }
 if GetComputerName(Wnomecomputador,size) then
   Result := strpas(WnomeComputador)
 else
   Result := '';
end;

Procedure WriteIni(Pasta: String; IniFile: String; Secao: String; Chave: String;
  valor: string);
var
  wrkIni: TIniFile;
begin
  wrkIni := TIniFile.Create(Pasta + IniFile + '.ini');
  try
    wrkIni.WriteString(Secao, Chave, valor);
  Finally
    wrkIni.Free;
  end;
end;

function LeIni(Pasta: String; IniFile: String; Secao: String; Chave: String): String; // ler um arquivo ini
var
  wrkIni: TIniFile;
begin
  wrkIni := TIniFile.Create(Pasta + IniFile + '.ini');
  try
    result := wrkIni.ReadString(Secao, Chave, '');
  Finally
    wrkIni.Free;
  end;
end;


function NomeMaquina: string;
var
  lpBuffer: PChar;
  nSize: DWord;
const
  Buff_Size = MAX_COMPUTERNAME_LENGTH + 1;
begin
  nSize := Buff_Size;
  lpBuffer := StrAlloc(Buff_Size);
  GetComputerName(lpBuffer, nSize);
  result := String(lpBuffer);
  StrDispose(lpBuffer);
end;

end.
