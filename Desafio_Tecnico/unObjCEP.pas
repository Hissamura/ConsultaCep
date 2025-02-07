unit unObjCEP;

interface

uses
  FireDAC.DApt, FireDAC.VCLUI.Wait, System.UITypes, FireDAC.Stan.Param,
  System.SysUtils, FireDAC.Comp.Client, FireDAC.Stan.Def, FireDAC.Stan.Async,
  FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.UI.Intf, System.Classes;

type
  TObjCEP = class
  private
    FConexao: TFDConnection;
  public

    function CEPExiste(ACEP: string): Boolean;
    function CarregaCEP(ACEP: string): TStringList;
    procedure InserirCEP(ACEP, ALogradouro, AComplemento, ABairro, ALocalidade, AUF: string);
    procedure AtualizarCEP(ACEP, ALogradouro, AComplemento, ABairro, ALocalidade, AUF: string);
    procedure CriarBancoSQLite;

    constructor Create;
    destructor Destroy; override;

  end;

implementation

constructor TObjCEP.Create;
begin
  FConexao := TFDConnection.Create(nil);
  FConexao.Params.DriverID := 'SQLite';
  FConexao.Params.Database := 'bancodedados.db';
  FConexao.LoginPrompt := False;
  FConexao.Connected := True;
end;

destructor TObjCEP.Destroy;
begin
  FConexao.Free;
  inherited;
end;

function TObjCEP.CarregaCEP(ACEP: string): TStringList;
var
  vloQuery: TFDQuery;
begin
  Result := TStringList.Create;

  vloQuery := TFDQuery.Create(nil);

  try
    vloQuery.Connection := FConexao;
    vloQuery.SQL.Text := 'SELECT * FROM CEPS WHERE CEP = :CEP';
    vloQuery.ParamByName('CEP').AsString := ACEP;
    vloQuery.Open;

    Result.Add(vloQuery.FieldByname('cep').AsString);
    Result.Add(vloQuery.FieldByname('logradouro').AsString);
    Result.Add(vloQuery.FieldByname('complemento').AsString);
    Result.Add(vloQuery.FieldByname('bairro').AsString);
    Result.Add(vloQuery.FieldByname('localidade').AsString);
    Result.Add(vloQuery.FieldByname('uf').AsString);

  finally
    vloQuery.Free;
  end;
end;

function TObjCEP.CEPExiste(ACEP: string): Boolean;
var
  vloQuery: TFDQuery;
begin
  vloQuery := TFDQuery.Create(nil);
  try
    vloQuery.Connection := FConexao;
    vloQuery.SQL.Text := 'SELECT COUNT(*) FROM CEPS WHERE CEP = :CEP';
    vloQuery.ParamByName('CEP').AsString := ACEP;
    vloQuery.Open;
    Result := vloQuery.Fields[0].AsInteger > 0;
  finally
    vloQuery.Free;
  end;
end;

procedure TObjCEP.InserirCEP(ACEP, ALogradouro, AComplemento, ABairro, ALocalidade, AUF: string);
var
  vloQuery: TFDQuery;
begin
  vloQuery := TFDQuery.Create(nil);
  try
    vloQuery.Connection := FConexao;
    vloQuery.SQL.Text :=
      'INSERT INTO CEPS (CEP, LOGRADOURO, COMPLEMENTO, BAIRRO, LOCALIDADE, UF) ' +
      'VALUES (:CEP, :LOGRADOURO, :COMPLEMENTO, :BAIRRO, :LOCALIDADE, :UF)';
    vloQuery.ParamByName('CEP').AsString := ACEP;
    vloQuery.ParamByName('LOGRADOURO').AsString := ALogradouro;
    vloQuery.ParamByName('COMPLEMENTO').AsString := AComplemento;
    vloQuery.ParamByName('BAIRRO').AsString := ABairro;
    vloQuery.ParamByName('LOCALIDADE').AsString := ALocalidade;
    vloQuery.ParamByName('UF').AsString := AUF;
    vloQuery.ExecSQL;
  finally
    vloQuery.Free;
  end;
end;

procedure TObjCEP.AtualizarCEP(ACEP, ALogradouro, AComplemento, ABairro, ALocalidade, AUF: string);
var
  vloQuery: TFDQuery;
begin
  vloQuery := TFDQuery.Create(nil);
  try
    vloQuery.Connection := FConexao;
    vloQuery.SQL.Text :=
      'UPDATE CEPS SET LOGRADOURO = :LOGRADOURO, COMPLEMENTO = :COMPLEMENTO, ' +
      'BAIRRO = :BAIRRO, LOCALIDADE = :LOCALIDADE, UF = :UF WHERE CEP = :CEP';
    vloQuery.ParamByName('CEP').AsString := ACEP;
    vloQuery.ParamByName('LOGRADOURO').AsString := ALogradouro;
    vloQuery.ParamByName('COMPLEMENTO').AsString := AComplemento;
    vloQuery.ParamByName('BAIRRO').AsString := ABairro;
    vloQuery.ParamByName('LOCALIDADE').AsString := ALocalidade;
    vloQuery.ParamByName('UF').AsString := AUF;
    vloQuery.ExecSQL;
  finally
    vloQuery.Free;
  end;
end;

procedure TObjCEP.CriarBancoSQLite;
var
  vloConsulta: TFDQuery;
begin
  vloConsulta := TFDQuery.Create(nil);
  try
    // Criar tabela se não existir
    vloConsulta.Connection := FConexao;
    vloConsulta.SQL.Text :=
      'CREATE TABLE IF NOT EXISTS CEPS (' +
      'ID INTEGER PRIMARY KEY AUTOINCREMENT, ' +
      'CEP TEXT NOT NULL, ' +
      'LOGRADOURO TEXT, ' +
      'COMPLEMENTO TEXT, ' +
      'BAIRRO TEXT, ' +
      'LOCALIDADE TEXT, ' +
      'UF TEXT);';
    vloConsulta.ExecSQL;
  finally
    vloConsulta.Free;
  end;
end;

end.
