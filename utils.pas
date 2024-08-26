unit Utils;

{$mode ObjFPC}{$H+}

interface

uses SysUtils;

function Pow(Base, Power: single): single;

implementation

function Pow(Base, Power: Single): Single;
begin
  if Base = 0 then
  begin
    if Power <= 0 then
      raise Exception.Create('0 raised to a non-positive power is undefined');
    Result := 0;
  end
  else if Base = 1 then
  begin
    Result := 1;
  end
  else if Base = -1 then
  begin
    if Frac(Power) = 0 then
      Result := 1
    else
      Result := -1;
  end
  else
  begin
    if Base < 0 then
    begin
      if Frac(Power) <> 0 then
        raise Exception.Create('Negative base with fractional power is not supported');
    end;
    Result := Exp(Ln(Base) * Power);
  end;
end;

end.
