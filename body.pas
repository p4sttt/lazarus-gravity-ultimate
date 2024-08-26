unit Body;

{$mode ObjFPC}{$H+}

interface

uses
  Vector;

type
  TBody = class
  private
    FCoordinates: TVector2D;
    FVelocity: TVector2D;
    FForce: TVector2D;
    FMass: single;

    function GetX: single;
    function GetY: single;
    function GetVx: single;
    function GetVy: single;
    function GetFx: single;
    function GetFy: single;
    function GetM: single;

    procedure SetX(AX: single);
    procedure SetY(AY: single);
    procedure SetVx(AVx: single);
    procedure SetVy(AVy: single);
    procedure SetFx(AFx: single);
    procedure SetFy(AFy: single);
    procedure SetM(AM: single);

    procedure UpdateCoordinates;
    procedure UpdateVelocity;
    procedure UpdateForce;
  public
    constructor Create(AX, AY, AVx, AVy, AFx, AFy, AM: single);

    procedure UpdateState;

    property X: single read GetX write SetX;
    property Y: single read GetY write SetY;
    property Vx: single read GetVx write SetVx;
    property Vy: single read GetVy write SetVy;
    property Fx: single read GetFx write SetFx;
    property Fy: single read GetFy write SetFy;
    property M: single read GetM write SetM;

  end;

implementation

{ TBody }

function TBody.GetX: single;
begin
  Result := Self.FCoordinates.X;
end;

function TBody.GetY: single;
begin
  Result := Self.FCoordinates.Y;
end;

function TBody.GetVx: single;
begin
  Result := Self.FVelocity.X;
end;

function TBody.GetVy: single;
begin
  Result := Self.FVelocity.Y;
end;

function TBody.GetFx: single;
begin
  Result := Self.FForce.X;
end;

function TBody.GetFy: single;
begin
  Result := Self.FForce.Y;
end;

function TBody.GetM: single;
begin
  Result := Self.FMass;
end;

procedure TBody.SetX(AX: single);
begin
  Self.FCoordinates.X := AX;
end;

procedure TBody.SetY(AY: single);
begin
  Self.FCoordinates.Y := AY;
end;

procedure TBody.SetVx(AVx: single);
begin
  Self.FVelocity.X := AVx;
end;

procedure TBody.SetVy(AVy: single);
begin
  Self.FVelocity.Y := AVy;
end;

procedure TBody.SetFx(AFx: single);
begin
  Self.FForce.X := AFx;
end;

procedure TBody.SetFy(AFy: single);
begin
  Self.FForce.Y := AFy;
end;

procedure TBody.SetM(AM: single);
begin
  if AM > 0 then
    Self.FMass := AM
  else
    Self.FMass := 0;
end;

procedure TBody.UpdateCoordinates;
begin
  X := X + Vx + Fx / (2 * M);
  Y := Y + Vy + Fy / (2 * M);
end;

procedure TBody.UpdateVelocity;
begin
  Vx := Vx + Fx / M;
  Vy := Vy + Fy / M;
end;

procedure TBody.UpdateForce;
begin

end;

constructor TBody.Create(AX, AY, AVx, AVy, AFx, AFy, AM: single);
begin
  { TODO: Rewrite to setters }
  Self.X := AX;
  Self.Y := AY;
  Self.Vx := AVx;
  Self.Vy := AVy;
  Self.Fx := AFx;
  Self.Fy := AFy;
  Self.M := AM;
end;

procedure TBody.UpdateState;
begin
  Self.UpdateCoordinates;
  Self.UpdateVelocity;
  Self.UpdateForce;
end;

end.
