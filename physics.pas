unit Physics;

{$mode ObjFPC}{$H+}

interface

uses
  Math, Body;

type
  TVector2D = record
    X, Y: single;
  end;

const
  G = 10;

function CalcGravityForce(Body1, Body2: TBody): TVector2D;
function CalcRadius(Body1, Body2: TBody): TVector2D;
function MassToSize(Mass: single): Integer;

implementation

function CalcGravityForce(Body1, Body2: TBody): TVector2D;
var
  R: TVector2D;
  Distance: single;
begin
  R := CalcRadius(Body1, Body2);
  Distance := Power(Power(R.X, 2) + Power(R.Y, 2), 0.5);
  Result.X := -(G * Body1.M * Body2.M * R.X) / Power(Distance, 3);
  Result.Y := -(G * Body1.M * Body2.M * R.Y) / Power(Distance, 3);
end;

function CalcRadius(Body1, Body2: TBody): TVector2D;
begin
  Result.X := Body1.X - Body2.X;
  Result.Y := Body1.Y - Body2.Y;
end;

function MassToSize(Mass: single): Integer;
begin
  Result := Trunc(Mass);
end;

end.
