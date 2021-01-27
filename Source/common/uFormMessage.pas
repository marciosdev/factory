unit uFormMessage;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFormBasic, System.ImageList,
  Vcl.ImgList, cxImageList, cxGraphics,
  System.Actions, Vcl.ActnList, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore,
  dxSkinsDefaultPainters, cxImage, cxTextEdit, cxMemo, dxGDIPlusClasses,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Imaging.pngimage;

type
  TypeMessage = (tmWarning, tmError, tmInformation, tmQuestion, tmFactory);
  TypeButton = (tbYes, tbNo, tbOK, tbCancel);

  TfrmMessage = class(TfrmBasic)
    ActionList: TActionList;
    cxImageList: TcxImageList;
    cxImage: TcxImage;
    cxMemo: TcxMemo;
    actYes: TAction;
    actNo: TAction;
    actCancel: TAction;
    btnYes: TButton;
    btnNo: TButton;
    btnCancel: TButton;
    SpeedButton: TSpeedButton;
    actPrinScreen: TAction;
    actOpenImage: TAction;
    actOK: TAction;
    Bevel1: TBevel;
    procedure actYesExecute(Sender: TObject);
    procedure actNoExecute(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure actOKExecute(Sender: TObject);
    procedure actPrinScreenExecute(Sender: TObject);
    procedure actOpenImageExecute(Sender: TObject);
  private
    FoTypeMessage: TypeMessage;
    FbShowCancel: Boolean;
    function LoadImageNameFromResource: string;
    function ShowInternalMessage(const pTypeMessage: TMsgDlgType;
      const psMessage: string; const pbShowCancel: boolean = False): integer;
    procedure SetTypeMessage(const poTypeMEssage: TMsgDlgType; const
      pbShowCancel: Boolean);
    procedure SetImage;
    procedure SetTitle;
    procedure SetMessage(const psMessage: string);
    procedure SetButton;
    procedure HideButtons;
    procedure RestoreButtonActions;
  public
    class function ShowError(const psMensagem: string): integer;
    class procedure ShowErrorDefault(const psMessage: string = '');
    class function ShowQuestion(const psMensagem: string; const pbShowCancel:
      boolean = False): integer;
    class function ShowAtention(const psMensagem: string): Integer;
    class function ShowInformation(const psMensagem: string): Integer;
    class function ShowFactory(const psMensagem: string): Integer;
  end;

var
  frmMessage: TfrmMessage;

implementation

{$R *.dfm}

{ TfrmMessage }

procedure TfrmMessage.actCancelExecute(Sender: TObject);
begin
  inherited;
  Close;
  ModalResult := mrCancel;
end;

procedure TfrmMessage.actNoExecute(Sender: TObject);
begin
  inherited;
  Close;
  ModalResult := mrNo;
end;

procedure TfrmMessage.actOKExecute(Sender: TObject);
begin
  inherited;
  Close;
  ModalResult := mrOk;
end;

procedure TfrmMessage.actOpenImageExecute(Sender: TObject);
begin
  inherited;
//
end;

procedure TfrmMessage.actPrinScreenExecute(Sender: TObject);
begin
  inherited;
//
end;

procedure TfrmMessage.actYesExecute(Sender: TObject);
begin
  inherited;
  Close;
  ModalResult := mrYes;
end;

procedure TfrmMessage.HideButtons;
begin
  btnYes.Hide;
  btnNo.Hide;
  btnCancel.Hide;
  SpeedButton.Hide;
end;

function TfrmMessage.LoadImageNameFromResource:
  string;
begin
  case FoTypeMessage of
    tmWarning: Result := 'tmWarning';
    tmError: Result := 'tmError';
    tmInformation: Result := 'tmInformation';
    tmQuestion: Result := 'tmQuestion';
  else
    Result := 'tmFactory';
  end;
end;

procedure TfrmMessage.RestoreButtonActions;
begin
  btnYes.Action := actYes;
  btnNo.Action := actNo;
  btnCancel.Action := actCancel;
end;

procedure TfrmMessage.SetButton;
begin
  RestoreButtonActions;
  HideButtons;

  case FoTypeMessage of
    tmError:
      begin
        btnCancel.Action := actOK;
        btnCancel.Show;
        btnCancel.Default := True;
        SpeedButton.Show;
      end;
    tmWarning,
      tmInformation,
      tmFactory:
      begin
        btnCancel.Action := actOK;
        btnCancel.Show;
        btnCancel.Default := True;
      end
  else
    begin
      btnYes.Show;
      btnNo.Show;
      btnNo.Default := True;
      btnCancel.Show;

      if not FbShowCancel then
      begin
        btnYes.Hide;
        btnNo.Action := actYes;
        btnNo.Default := False;
        btnCancel.Action := actNo;
        btnCancel.Default := True;
      end;
    end;
  end;
end;

procedure TfrmMessage.SetImage;
var
  sResourceName: string;
  oPngImage: TPngImage;
begin
  oPngImage := TPngImage.Create;

  try
    sResourceName := LoadImageNameFromResource;

    try
      oPngImage.LoadFromResourceName(HInstance, sResourceName);
      cxImage.Picture.Graphic := oPngImage;
    except
      //
    end;

  finally
    oPngImage.Free;
  end;
end;

procedure TfrmMessage.SetMessage(const psMessage: string);
begin
  cxMemo.Lines.Clear;
  cxMemo.Lines.Text := psMessage;
end;

procedure TfrmMessage.SetTitle;
begin
  case FoTypeMessage of
    tmWarning: Caption := 'Atenção';
    tmError: Caption := 'Erro';
    tmInformation: Caption := 'Informação';
    tmQuestion: Caption := 'Pergunta'
  else
    Caption := 'Factory';
  end;
end;

procedure TfrmMessage.SetTypeMessage(const poTypeMessage: TMsgDlgType; const
  pbShowCancel: Boolean);
begin
  case poTypeMessage of
    TMsgDlgType.mtWarning: FoTypeMessage := tmWarning;
    TMsgDlgType.mtError: FoTypeMessage := tmError;
    TMsgDlgType.mtInformation: FoTypeMessage := tmInformation;
    TMsgDlgType.mtConfirmation: FoTypeMessage := tmQuestion
  else
    FoTypeMessage := tmFactory;
  end;
  FbShowCancel := pbShowCancel;
end;

class function TfrmMessage.ShowAtention(const psMensagem: string): Integer;
begin
  Result := frmMessage.ShowInternalMessage(mtWarning, psMensagem);
end;

class function TfrmMessage.ShowError(const psMensagem: string): integer;
begin
  Result := frmMessage.ShowInternalMessage(mtError, psMensagem);
end;

class procedure TfrmMessage.ShowErrorDefault(const psMessage: string);
begin
  frmMessage.ShowInternalMessage(mtError, psMessage);
end;

class function TfrmMessage.ShowFactory(const psMensagem: string): Integer;
begin
  Result := frmMessage.ShowInternalMessage(mtCustom, psMensagem);
end;

class function TfrmMessage.ShowInformation(const psMensagem: string): Integer;
begin
  Result := frmMessage.ShowInternalMessage(mtInformation, psMensagem);
end;

function TfrmMessage.ShowInternalMessage(const pTypeMessage: TMsgDlgType; const
  psMessage: string;
  const pbShowCancel: boolean): integer;
begin
  try
    if not Assigned(frmMessage) then
      frmMessage := TfrmMessage.Create(Application);

    frmMessage.SetTypeMessage(pTypeMessage, pbShowCancel);
    frmMessage.SetImage;
    frmMessage.SetTitle;
    frmMessage.SetButton;
    frmMessage.SetMessage(psMessage);
    frmMessage.ShowModal;
    Result := frmMessage.ModalResult;
  finally
    FreeAndNil(frmMessage);
  end;
end;

class function TfrmMessage.ShowQuestion(const psMensagem: string; const
  pbShowCancel: boolean): integer;
begin
  Result := frmMessage.ShowInternalMessage(mtConfirmation, psMensagem,
    pbShowCancel);
end;

end.

