unit uFormMain;

///  Factory ERP
///  Date: 01-26-2020
///  Author: Marcio Silva
///  Git: github.com/marciosdev
///  Mail: marciosdev@icloud.com

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFormBasic, Vcl.Menus, Vcl.PlatformDefaultStyleActnCtrls, System.Actions,
  Vcl.ActnList, Vcl.ActnMan, FCT.Connection, Uni, Vcl.StdCtrls;

type
  TfrmMain = class(TfrmBasic)
    ActionManager: TActionManager;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses
  uFormMessage;

{$R *.dfm}

procedure TfrmMain.Button1Click(Sender: TObject);
begin
  inherited;
  frmMessage.ShowInformation('hahaahah');
end;

end.
