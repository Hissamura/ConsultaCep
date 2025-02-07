program DesafioTec;

uses
  Vcl.Forms,
  unConsultaCEP in 'unConsultaCEP.pas' {frmConsultaCEP},
  unObjCEP in 'unObjCEP.pas',
  unObjViaCEP in 'unObjViaCEP.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmConsultaCEP, frmConsultaCEP);
  Application.Run;
end.
