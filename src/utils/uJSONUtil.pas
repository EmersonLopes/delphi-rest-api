unit uJSONUtil;

interface

uses System.JSON, System.Generics.Collections, REST.Json, Data.DB,
     REST.Response.Adapter, System.SysUtils;

type
  TJSONUtil = class
    class function ObjetoListaParaJson<T: class>(pLista: TObjectList<T>; pNomeObjecto: String): TJSONObject; overload;
    class function ObjetoListaParaJson<T: class>(pLista: TObjectList<T>): TJSONArray; overload;
  public
    procedure JsonToDataSet(pDataSet: TDataSet; pJson: String);
  end;

implementation

{ TJSonUtil }

class function TJSONUtil.ObjetoListaParaJson<T>(pLista: TObjectList<T>; pNomeObjecto: String): TJSONObject;
var
  wl_Item: T;
  wl_Array: TJSONArray;
begin
  wl_Array := TJSONArray.Create;

  for wl_Item in pLista do
    wl_Array.AddElement(TJson.ObjectToJsonObject(wl_Item));

  Result := TJSONObject.Create;
  Result.AddPair(pNomeObjecto, wl_Array);
end;

procedure TJSONUtil.JsonToDataSet(pDataSet: TDataSet; pJson: String);
var
  JObj: TJSONArray;
  vConv: TCustomJSONDataSetAdapter;
begin
  if (pJSON = EmptyStr) then
    Exit;

  JObj := TJSONObject.ParseJSONValue(pJSON) as TJSONArray;
  vConv := TCustomJSONDataSetAdapter.Create(Nil);

  try
    vConv.Dataset := pDataset;
    vConv.UpdateDataSet(JObj);
  finally
    vConv.Free;
    JObj.Free;
  end;
end;

class function TJSONUtil.ObjetoListaParaJson<T>(pLista: TObjectList<T>): TJSONArray;
var
  wl_Item: T;
begin
  Result := TJSONArray.Create;

  for wl_Item in pLista do
    Result.AddElement(TJson.ObjectToJsonObject(wl_Item));
end;

end.
