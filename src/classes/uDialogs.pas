unit uDialogs;

interface

uses
  Vcl.Forms, Winapi.Windows;

  procedure MsgInfo(pInfo: String);
  procedure MsgAviso(pAviso: String);
  procedure MsgErro(pErro: WideString);
  function Pergunta(pMsg:string):Boolean;


implementation

procedure MsgErro(pErro: WideString);
begin
  Application.MessageBox(PChar(pErro), PChar(Application.Title),MB_OK+MB_ICONWARNING);
end;

procedure MsgAviso(pAviso: String);
begin
  Application.MessageBox(PChar(pAviso), PChar(Application.Title),MB_OK+MB_ICONWARNING);
end;

procedure MsgInfo(pInfo: String);
begin
  Application.MessageBox(PChar(pInfo), PChar(Application.Title),MB_ICONINFORMATION);
end;

function Pergunta(pMsg:string):Boolean;
begin
  Result := False;

  if Application.MessageBox(PChar(pMsg), PChar(Application.Title),MB_ICONQUESTION+MB_YESNO) = ID_YES then
    Result := True;
end;

end.
