unit FCT.Connection;

interface

uses
  System.SysUtils, System.Variants, System.Classes, System.Win.Registry,
  Uni, PostgreSQLUniProvider, FCT.Setting;

type
  TFCTConnection = class
    private
      FoSetting: TFCTSetting;
      FoConnect: TUniConnection;
      procedure AfterConnect;
    public
    constructor Create; override;
    destructor Destroy; override;
  end;

implementation

{ TFCTConnection }

constructor TFCTConnection.Create;
begin
  inherited;
  FoSetting := TFCTSetting.Create;
end;

destructor TFCTConnection.Destroy;
begin
  if Assigned(FoSetting) then
    FreeAndNil(FoSetting);
  inherited;
end;

procedure TFCTConnection.AfterConnect;
begin

end;

end.
