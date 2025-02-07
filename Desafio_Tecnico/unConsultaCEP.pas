unit unConsultaCEP;

interface

uses
  System.SysUtils, FireDAC.Comp.Client, FireDAC.Stan.Def, FireDAC.Stan.Async,
  FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.UI.Intf,
  Winapi.Windows, Winapi.Messages, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, unObjViaCep,
  Vcl.ExtCtrls, unObjCEP;

type
  TfrmConsultaCEP = class(TForm)
    btnCarregar: TBitBtn;
    edtCEP: TEdit;
    rgTipoResult: TRadioGroup;
    btnSalvar: TBitBtn;
    Panel1: TPanel;
    mmoResultRaw: TMemo;
    edtRua: TEdit;
    edtComplemento: TEdit;
    edtBairro: TEdit;
    edtCidade: TEdit;
    edtEstado: TEdit;
    lblCEP: TLabel;
    lblRua: TLabel;
    lblComplemento: TLabel;
    lblBairro: TLabel;
    lblCidade: TLabel;
    lblEstado: TLabel;
    procedure btnCarregarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSalvarClick(Sender: TObject);
  private
    FObjViaCEP: TObjViaCEP;
    FObjCEP : TObjCEP;
    FDadosCEP: TStringList;
    procedure CarregaCEPWS(ACEP : string);
    procedure CarregaCEPBD(ACEP : string);
  public

  end;
var
  frmConsultaCEP: TfrmConsultaCEP;

implementation

{$R *.dfm}


procedure TfrmConsultaCEP.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FObjViaCEP.Free;
  FObjCEP.Free;
end;

procedure TfrmConsultaCEP.FormCreate(Sender: TObject);
begin
  FObjViaCEP := TObjViaCEP.Create;

  FObjCEP := TObjCEP.Create;

  FObjCEP.CriarBancoSQLite;
end;

procedure TfrmConsultaCEP.CarregaCEPBD(ACEP : string);
begin
  mmoResultRaw.Clear;

  FDadosCEP := FObjCEP.CarregaCEP(ACEP);

  edtRua.Text := FDadosCEP.Strings[1];
  edtComplemento.Text := FDadosCEP.Strings[2];
  edtBairro.Text := FDadosCEP.Strings[3];
  edtCidade.Text := FDadosCEP.Strings[4];
  edtEstado.Text := FDadosCEP.Strings[5];

end;

procedure TfrmConsultaCEP.CarregaCEPWS(ACEP : string);
var
  vlsDadosCEPRaw : string;
  vloFormato: TFormatoRetorno;
begin
  mmoResultRaw.Clear;

  if rgTipoResult.ItemIndex = 0 then
    vloFormato := frJSON
  else
    vloFormato := frXML;

  FDadosCEP := FObjViaCEP.ConsultarCEP(ACEP, vloFormato);
  vlsDadosCEPRaw := FObjViaCEP.ConsultarViaCEP(ACEP, vloFormato);

  if FDadosCEP.Strings[0] <> 'erro' then
  begin

    edtRua.Text := FDadosCEP.Strings[1];
    edtComplemento.Text := FDadosCEP.Strings[2];
    edtBairro.Text := FDadosCEP.Strings[3];
    edtCidade.Text := FDadosCEP.Strings[4];
    edtEstado.Text := FDadosCEP.Strings[5];

    mmoResultRaw.Lines.Add(vlsDadosCEPRaw);
  end
  else
    ShowMessage('CEP não encontrado.');
end;

procedure TfrmConsultaCEP.btnCarregarClick(Sender: TObject);
var
  vloTaskDialog: TTaskDialog;
  vloBtnWebService, vloBtnBancoDados: TTaskDialogBaseButtonItem;
begin
  if edtCEP.Text = '' then
  begin
    ShowMessage('Digite um CEP para buscar.');
    Exit;
  end;

  if not(FObjCEP.CEPExiste(edtCEP.Text)) then
  begin
    CarregaCEPWS(edtCEP.Text);
  end
  else
  begin

    vloTaskDialog := TTaskDialog.Create(nil);

    try
      vloTaskDialog.Text := 'Deseja carregar as informações do Web Service ou do Banco de Dados?';

      vloTaskDialog.CommonButtons := []; // Remove botões padrão
      // Criando botão para Web Service
      vloBtnWebService := vloTaskDialog.Buttons.Add;
      vloBtnWebService.Caption := 'Web Service';
      vloBtnWebService.ModalResult := 100;
      // Criando botão para Banco de Dados
      vloBtnBancoDados := vloTaskDialog.Buttons.Add;
      vloBtnBancoDados.Caption := 'Banco de Dados';
      vloBtnBancoDados.ModalResult := 101;
      if vloTaskDialog.Execute then
      begin
        if vloTaskDialog.ModalResult = 100 then
          CarregaCEPWS(edtCEP.Text)
        else if vloTaskDialog.ModalResult = 101 then
          CarregaCEPBD(edtCEP.Text);
      end;
    finally
      vloTaskDialog.Free;
    end;

  end;

end;

procedure TfrmConsultaCEP.btnSalvarClick(Sender: TObject);
var
  vlsCEP, vlsLogradouro, vlsComplemento, vlsBairro, vlsLocalidade, vlsUF: string;
begin
  if FDadosCEP.Count = 0 then
  begin
    ShowMessage('Nenhum dado para salvar.');
    Exit;
  end;

  vlsCEP := edtCEP.text;
  vlsLogradouro := edtRua.Text;
  vlsComplemento := edtComplemento.Text;
  vlsBairro := edtBairro.Text;
  vlsLocalidade := edtCidade.Text;
  vlsUF := edtEstado.Text;

  // Verifica se já existe o CEP no banco
  if FObjCEP.CEPExiste(vlsCEP) then
  begin
    if MessageDlg('CEP já existe. Deseja atualizar os dados?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      FObjCEP.AtualizarCEP(vlsCEP, vlsLogradouro, vlsComplemento, vlsBairro, vlsLocalidade, vlsUF);
  end
  else
    FObjCEP.InserirCEP(vlsCEP, vlsLogradouro, vlsComplemento, vlsBairro, vlsLocalidade, vlsUF);

  ShowMessage('Dados salvos com sucesso!');
end;

end.

