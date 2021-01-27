unit FCT.Connection;

///  Factory ERP
///  Date: 01-26-2020
///  Author: Marcio Silva
///  Git: github.com/marciosdev
///  Mail: marciosdev@icloud.com

interface

uses
  System.SysUtils, System.Variants, System.Classes, System.Win.Registry,
  Uni, PostgreSQLUniProvider, FCT.Setting;

type
  TFCTConnection = class
    private
      FoSetting: TFCTSetting;
      FoConnection: TUniConnection;
      class var FoFCTConnection: TFCTConnection;
      procedure DoBeforeConnect;
      procedure DoConnect;
      class procedure Free;
    public
      constructor Create; overload;
      class function GetConnection: TUniConnection;
  end;

implementation

{ TFCTConnection }

constructor TFCTConnection.Create;
begin
  inherited;
  FoSetting := TFCTSetting.Create;
end;

procedure TFCTConnection.DoBeforeConnect;
begin
  FoConnection.Server := FoSetting.GetPostgreServer;
  FoConnection.Port := FoSetting.GetPostgrePort;
  FoConnection.Username := FoSetting.GetPostgreUser;
  FoConnection.Password := FoSetting.GetPostgrePass;{oSeguranca.Decriptografar(oConfiguracao.GetSenhaPostgreSQL)};
  FoConnection.ProviderName := FoSetting.GetPostgreProvider;
  FoConnection.LoginPrompt := False;
end;

procedure TFCTConnection.DoConnect;
begin
  try
    FoConnection.Open;
  except
    on E: Exception do
    begin
      raise Exception.Create('Error Message');
      //TfrmMensagem.Erro(Format(sMSG_ERRO_CONECTAR_POSTGRE, [FoPostgreDB.Server, E.Message]));
    end;
  end;
end;

class procedure TFCTConnection.Free;
begin
  if not Assigned(FoFCTConnection) then
    Exit;

  if Assigned(FoFCTConnection.FoSetting) then
    FreeAndNil(FoFCTConnection.FoSetting);

  FoFCTConnection.FoConnection.Close;
  FreeAndNil(FoFCTConnection.FoConnection);
  FreeAndNil(FoFCTConnection);
end;

class function TFCTConnection.GetConnection: TUniConnection;
begin
  if not Assigned(FoFCTConnection) then
  begin
    FoFCTConnection := TFCTConnection.Create;
    FoFCTConnection.FoConnection := TUniConnection.Create(nil);
    FoFCTConnection.DoBeforeConnect;
    FoFCTConnection.DoConnect;
  end;
  Result := FoFCTConnection.FoConnection;
end;

initialization
finalization
  TFCTConnection.Free;


end.
