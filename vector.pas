unit Vector;

{$mode ObjFPC}{$H+}

interface

type

  TVector2D = record
    X, Y: single;
  end;

function InitVector2D(X, Y: single): TVector2D;

implementation

function InitVector2D(X, Y: single): TVector2D;
begin
  Result.X := X;
  Result.Y := Y;
end;


end.
