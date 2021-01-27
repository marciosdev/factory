unit uFormBasicRegister;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFormBasic, System.ImageList, Vcl.ImgList, cxImageList, cxGraphics,
  System.Actions, Vcl.ActnList;

type
  TfrmBasicRegister = class(TfrmBasic)
    ActionList: TActionList;
    cxImageList: TcxImageList;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBasicRegister: TfrmBasicRegister;

implementation

{$R *.dfm}

end.
