unit FCT.Security;

///  Factory ERP
///  Date: 01-26-2020
///  Author: Marcio Silva
///  Git: github.com/marciosdev
///  Mail: marciosdev@icloud.com

interface

uses
  System.SysUtils;

type
  TFCTSecurity = class
  public
    function Encrypt(const psValue: string): string;
    function Decrypt(const psValue: string): string;
  end;

implementation

{ TFCTSecurity }

function TFCTSecurity.Decrypt(const psValue: string): string;
begin
  Result := Encrypt(psValue);
end;

function TFCTSecurity.Encrypt(const psValue: string): string;
var
  ASymbol: array[0..4] of string;
  I: Integer;
begin
  ASymbol[1] :=
    'ABCDEFGHIJLMNOPQRSTUVXZYWK ~!@#$%^&*()';

  ASymbol[2] :=
    'ÂÀ©Øû×ƒçêùÿ5Üø£úñÑªº¿®¬¼ëèïÙýÄÅÉæÆôöò»Á';

  ASymbol[3] := 'abcdefghijlmnopqrstuvxzywk1234567890';

  ASymbol[4] := 'áâäàåíóÇüé¾¶§÷ÎÏ-+ÌÓß¸°¨·¹³²Õµþîì¡«½';

  for I := 1 to Length(Trim(psValue)) do
  begin
    if pos(copy(psValue, I, 1), ASymbol[1]) > 0 then
      Result := Result + copy(ASymbol[2],
        pos(copy(psValue, I, 1), ASymbol[1]), 1)

    else if pos(copy(psValue, I, 1), ASymbol[2]) > 0 then
      Result := Result + copy(ASymbol[1],
        pos(copy(psValue, I, 1), ASymbol[2]), 1)

    else if pos(copy(psValue, I, 1), ASymbol[3]) > 0 then
      Result := Result + copy(ASymbol[4],
        pos(copy(psValue, I, 1), ASymbol[3]), 1)

    else if pos(copy(psValue, I, 1), ASymbol[4]) > 0 then
      Result := Result + copy(ASymbol[3],
        pos(copy(psValue, I, 1), ASymbol[4]), 1);
  end;
end;

end.
