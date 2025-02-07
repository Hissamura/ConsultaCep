unit unObjViaCEP;

interface

uses
  System.SysUtils, System.Classes, System.JSON, Xml.XMLDoc, Xml.XMLIntf,
  System.Net.HttpClient, System.Net.HttpClientComponent;

type
  TFormatoRetorno = (frJSON, frXML);
  TObjViaCEP = class
  private
    FHTTPClient: TNetHTTPClient;
    function ParseJSON(const AJSON: string): TStringList;
    function ParseXML(const AXML: string): TStringList;
  public
    constructor Create;
    destructor Destroy; override;
    function ConsultarCEP(const ACep: string; AFormato: TFormatoRetorno): TStringList;
    function ConsultarViaCEP(const ACep: string; AFormato: TFormatoRetorno): string;
  end;

implementation

{ TObjViaCEP }

constructor TObjViaCEP.Create;
begin
  FHTTPClient := TNetHTTPClient.Create(nil);
end;

destructor TObjViaCEP.Destroy;
begin
  FHTTPClient.Free;
  inherited;
end;

function TObjViaCEP.ConsultarViaCEP(const ACep: string; AFormato: TFormatoRetorno): string;
var
  vlsURL: string;
  vloResponse: IHTTPResponse;
begin
  if AFormato = frJSON then
    vlsURL := Format('https://viacep.com.br/ws/%s/json/', [ACep])
  else
    vlsURL := Format('https://viacep.com.br/ws/%s/xml/', [ACep]);
  vloResponse := FHTTPClient.Get(vlsURL);
  Result := vloResponse.ContentAsString();
end;

function TObjViaCEP.ParseJSON(const AJSON: string): TStringList;
var
  vloJSONObject: TJSONObject;
begin
  Result := TStringList.Create;
  vloJSONObject := TJSONObject.ParseJSONValue(AJSON) as TJSONObject;
  try
    if Assigned(vloJSONObject) then
    begin
      Result.Add(vloJSONObject.GetValue<string>('cep'));
      Result.Add(vloJSONObject.GetValue<string>('logradouro'));
      Result.Add(vloJSONObject.GetValue<string>('complemento'));
      Result.Add(vloJSONObject.GetValue<string>('bairro'));
      Result.Add(vloJSONObject.GetValue<string>('localidade'));
      Result.Add(vloJSONObject.GetValue<string>('uf'));
    end;
  finally
    vloJSONObject.Free;
  end;
end;

function TObjViaCEP.ParseXML(const AXML: string): TStringList;
var
  vloXMLDocument: IXMLDocument;
  vloNode: IXMLNode;
begin
  Result := TStringList.Create;
  vloXMLDocument := LoadXMLData(AXML);
  vloNode := vloXMLDocument.DocumentElement;
  if Assigned(vloNode) then
  begin
    Result.Add(vloNode.ChildNodes['cep'].Text);
    Result.Add(vloNode.ChildNodes['logradouro'].Text);
    Result.Add(vloNode.ChildNodes['complemento'].Text);
    Result.Add(vloNode.ChildNodes['bairro'].Text);
    Result.Add(vloNode.ChildNodes['localidade'].Text);
    Result.Add(vloNode.ChildNodes['uf'].Text);
  end;
end;

function TObjViaCEP.ConsultarCEP(const ACep: string; AFormato: TFormatoRetorno): TStringList;
var
  vlsRetornoAPI: string;
begin
  vlsRetornoAPI := ConsultarViaCEP(ACep, AFormato);

  if pos('erro', vlsRetornoAPI) > 0 then
  begin
    Result := TStringList.Create;
    Result.Add('erro');
    exit;
  end;

  if AFormato = frJSON then
    Result := ParseJSON(vlsRetornoAPI)
  else
    Result := ParseXML(vlsRetornoAPI);
end;

end.
