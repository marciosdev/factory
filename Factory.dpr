program Factory;

uses
  Vcl.Forms,
  uFormBasic in 'Source\common\uFormBasic.pas' {frmBasic},
  uFormMain in 'Source\uFormMain.pas' {frmMain},
  FCT.Connection in 'Source\common\class\FCT.Connection.pas',
  FCT.Setting in 'Source\common\class\FCT.Setting.pas',
  FCT.Security in 'Source\common\class\FCT.Security.pas',
  FCT.Constant in 'Source\common\class\FCT.Constant.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
