unit FCT.Setting;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  System.Win.Registry, Uni, PostgreSQLUniProvider;

type
  TFCTSetting = class
    private
      function GetSetting(const psKeyName: string): Variant;
    public
      function GetPostgreServer: string;
      function GetPostgrePort: integer;
      function GetPostgreUser: string;
      function GetPostgrePass: string;
      function GetPostgreProvider: string;
  end;

implementation

uses
  FCT.Constant;

{ TFCTSetting }

function TFCTSetting.GetPostgrePass: string;
begin
  Result := GetSetting(SETTING_POSTGRE_PASS);
end;

function TFCTSetting.GetPostgrePort: integer;
begin
  Result := GetSetting(SETTING_POSTGRE_PORT);
end;

function TFCTSetting.GetPostgreProvider: string;
begin
  Result := GetSetting(SETTING_POSTGRE_PROVIDER);
end;

function TFCTSetting.GetPostgreServer: string;
begin
  Result := GetSetting(SETTING_POSTGRE_SERVER);
end;

function TFCTSetting.GetPostgreUser: string;
begin
  Result := GetSetting(SETTING_POSTGRE_USER);
end;

function TFCTSetting.GetSetting(const psKeyName: string): Variant;
var
  oReg: TRegistry;
begin
  Result := EmptyStr;
  oReg := TRegistry.Create(KEY_WRITE or KEY_WOW64_64KEY);
  try
    oReg.Lazywrite := False;
    oReg.RootKey := HKEY_LOCAL_MACHINE;
    oReg.OpenKeyReadOnly(HKEY_FACTORY);

    try
      Result := oReg.ReadString(psKeyName);
    except
      Result := oReg.ReadInteger(psKeyName);
    end;

    oReg.CloseKey;
  finally
    FreeAndNil(oReg);
  end;
end;

end.
