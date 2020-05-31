unit uRotinasDB;

interface

uses
  FireDAC.Comp.Client, Vcl.Forms, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, System.JSON, System.NetEncoding, System.Classes,
  Vcl.Graphics;

  function Base64FromBitmap(pBitmap: TBitmap): string;
  function BitmapFromBase64(const base64: string): TBitmap;
  function BytesStreamFromBase64(const base64: string): TBytesStream;

implementation

uses System.SysUtils;

function DataSetToJSON(oDataSet : TDataset) : TJSONArray;
Var
  JObject  : TJSONObject;
  i        : Integer;
  StreamIn: TStream;
  StreamOut : TStringStream;
begin
  Result   := TJSONArray.Create;
  try
    oDataSet.First;
    while Not(oDataSet.Eof) do
    begin
      JObject := TJSONObject.Create;
      for i := 0 to oDataSet.FieldCount-1 do
      begin
        if oDataSet.Fields[i].IsBlob then
        begin
          StreamIn := oDataSet.CreateBlobStream(oDataSet.Fields[i], bmRead);
          StreamOut := TStringStream.Create;
          TNetEncoding.Base64.Encode(StreamIn, StreamOut);
          StreamOut.Position := 0;
          JObject.AddPair(oDataSet.Fields[i].DisplayName, StreamOut.DataString);
        end
        else
        begin
          JObject.AddPair(

            oDataSet.Fields[i].FieldName.ToLower,
            TJSONString.Create(oDataSet.Fields[i].AsString)
          );
        end;

      end;

      Result.AddElement(JObject);
      oDataSet.Next;
    end;
  finally
    oDataSet.Free;
  end;

end;

function DataSetToJSON_Object(oDataSet : TDataset) : TJSONObject;
Var
  JObject  : TJSONObject;
  i        : Integer;
begin
  JObject := TJSONObject.Create;
  try
    if oDataSet.IsEmpty then
    begin
      JObject.AddPair('result','null');
      Result := JObject;
      Exit;
    end;


    oDataSet.First;
    while Not(oDataSet.Eof) do
    begin

      for i := 0 to oDataSet.FieldCount-1 do
        JObject.AddPair(oDataSet.Fields[i].FieldName.ToLower,TJSONString.Create(oDataSet.Fields[i].AsString));

      Result := JObject;
      oDataSet.Next;
    end;
  finally
    oDataSet.Free;
  end;

end;


function Base64FromBitmap(pBitmap: TBitmap): string;
var
  Input: TBytesStream;
  Output: TStringStream;
begin
  Input := TBytesStream.Create;
  try
    {
    pBitmap.SaveToStream(Input);
    Input.Position := 0;
    Output := TStringStream.Create('', TEncoding.ASCII);
    try
      Soap.EncdDecd.EncodeStream(Input, Output);
      Result := Output.DataString;
    finally
      Output.Free;
    end;
    }

  finally
    Input.Free;
  end;
end;

function BitmapFromBase64(const base64: string): TBitmap;
var
  Input: TStringStream;
  Output: TBytesStream;
begin
  Input := TStringStream.Create(base64, TEncoding.ASCII);
  try
    Output := TBytesStream.Create;
    try
      {
      Soap.EncdDecd.DecodeStream(Input, Output);
      Output.Position := 0;
      Result := TBitmap.Create;
      try
        Result.LoadFromStream(Output);
      except
        Result.Free;
        raise;
      end;
      }
    finally
      Output.Free;
    end;
  finally
    Input.Free;
  end;
end;

function BytesStreamFromBase64(const base64: string): TBytesStream;
var
  Input: TStringStream;
  Output: TBytesStream;
begin
  Input := TStringStream.Create(base64, TEncoding.ASCII);
  Output := TBytesStream.Create;
  try
    TNetEncoding.Base64.Decode(Input,Output);
    Output.Position := 0;

    Result := Output;
  finally
    Input.Free;
  end;
end;

end.
