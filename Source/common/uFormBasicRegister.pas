unit uFormBasicRegister;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFormBasic, System.ImageList,
  Vcl.ImgList, cxImageList, cxGraphics,
  System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls, Data.DB, DBAccess,
  Uni, MemDS;

type
  TfrmBasicRegister = class(TfrmBasic)
    ActionList: TActionList;
    cxImageList: TcxImageList;
    actNew: TAction;
    actSave: TAction;
    actRefresh: TAction;
    actUndo: TAction;
    btnNew: TButton;
    Bevel: TBevel;
    btnSave: TButton;
    btnUndo: TButton;
    btnRefreash: TButton;
    qyRegister: TUniQuery;
    dsRegister: TUniDataSource;
    procedure FormCreate(Sender: TObject);
  private
    FsTable: string;
    FnKey: Integer;
    procedure SetConnection;
    procedure New;
    function Save: boolean;
    procedure Undo;
    procedure Refreash;
    function TestRequiredFieldsFilled: boolean;
    function TestValidation: Boolean; virtual;
  public
    property Table: string read FsTable write FsTable;
    property Key: Integer read FnKey write FnKey;
  end;

var
  frmBasicRegister: TfrmBasicRegister;

implementation

uses
  FCT.Connection, uFormMessage;

{$R *.dfm}

{ TfrmBasicRegister }

procedure TfrmBasicRegister.FormCreate(Sender: TObject);
begin
  inherited;
  SetConnection;
end;

procedure TfrmBasicRegister.New;
begin
  qyRegister.ReadOnly := False;
  qyRegister.Cancel;

  try
    qyRegister.Open;
    qyRegister.Append;
  except
    on E: exception do
    begin
      TfrmMessage.ShowError('Ocorreu um erro ao iniciar novo registro. Mensagem: ' + E.Message);
      Abort;
    end;
  end;
end;

procedure TfrmBasicRegister.Refreash;
begin
  if not qyRegister.Active then
    Exit;


end;

function TfrmBasicRegister.Save: boolean;
begin
  if not TestRequiredFieldsFilled then
    Exit;

  if not TestValidation then
    Exit;

  if qyRegister.State in dsEditModes then
    qyRegister.Post;

  try
    qyRegister.ApplyUpdates;
  except
    on E: Exception do
      Abort;
  end;

end;

procedure TfrmBasicRegister.SetConnection;
var
  I: integer;
begin
  for I := 0 to Self.ComponentCount - 1 do
    if (Self.Components[I]).ClassNameIs('TUniQuery') then
      (Self.Components[I] as TUniQuery).Connection :=
        TFCTConnection.GetConnection;
end;

function TfrmBasicRegister.TestRequiredFieldsFilled: boolean;
var
  nI: Integer;
  slRequiredFields: TStringList;
begin
  slRequiredFields := TStringList.Create;

  try
    if qyRegister.State in dsEditModes then
      qyRegister.UpdateRecord;
  except
    on E: Exception do
    begin
      Abort;
    end;
  end;

  try
    for nI := 0 to qyRegister.FieldDefList.Count - 1 do
    begin
      if ((qyRegister.Fields[nI].Required) and (Trim(qyRegister.Fields[nI].AsString) = EmptyStr)) then
        slRequiredFields.Add(qyRegister.FieldByName(qyRegister.Fields[nI].FieldName).DisplayLabel);
    end;

    Result := (slRequiredFields.Count = 0);

    if (not Result) then
      TfrmMessage.ShowInformation('Por favor preencha o(s) campo(s) obrigatório(s) abaixo: ' +
        sLineBreak + sLineBreak + slRequiredFields.CommaText);

  finally
    FreeAndNil(slRequiredFields);
  end;
end;

function TfrmBasicRegister.TestValidation: Boolean;
begin
  Result := True;
end;

procedure TfrmBasicRegister.Undo;
begin
  qyRegister.Cancel;
end;

end.

