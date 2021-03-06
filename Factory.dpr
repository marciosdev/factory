program Factory;

{$R *.dres}

uses
  Vcl.Forms,
  uFormBasic in 'Source\common\uFormBasic.pas' {frmBasic},
  uFormMain in 'Source\uFormMain.pas' {frmMain},
  FCT.Connection in 'Source\common\class\FCT.Connection.pas',
  FCT.Setting in 'Source\common\class\FCT.Setting.pas',
  FCT.Security in 'Source\common\class\FCT.Security.pas',
  FCT.Constant in 'Source\common\class\FCT.Constant.pas',
  uFormBasicRegister in 'Source\common\uFormBasicRegister.pas' {frmBasicRegister},
  uFormMessage in 'Source\common\uFormMessage.pas' {frmMessage};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
