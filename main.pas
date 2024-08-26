unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Body, Physics;

type

  { TFormMain }

  TFormMain = class(TForm)
    MemoBodiesState: TMemo;
    TimerMemoUpdate: TTimer;
    TimerMassUpdate: TTimer;
    TimerPhysics: TTimer;

    procedure FormCreate(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormPaint(Sender: TObject);
    procedure TimerMemoUpdateTimer(Sender: TObject);
    procedure TimerMassUpdateTimer(Sender: TObject);
    procedure TimerPhysicsTimer(Sender: TObject);
  private
    Bodies: array of TBody;
    CreationMass: single;
    CreationPos: TPoint;

    procedure AddBody(Body: TBody);
  public

  end;

const
  MassGrowthRate = 0.1;
  InitialCreationMass = 5;

var
  FormMain: TFormMain;

implementation

{$R *.lfm}

{ TFormMain }
procedure TFormMain.FormCreate(Sender: TObject);
begin
  FormMain.Left := (Screen.Width - ClientWidth) div 2;
  FormMain.Top := (Screen.Height - ClientHeight) div 2;

  MemoBodiesState.Height := ClientHeight;
  MemoBodiesState.Width := 180;

  //  саттелиты и крипоколонии
  AddBody(TBody.Create(ClientWidth div 2 - 50, ClientHeight div 2, 0, -2, 0, 0, 10));
  AddBody(TBody.Create(ClientWidth div 2 + 50, ClientHeight div 2, 0, 2, 0, 0, 10));
  //  ОР_БИТА
  AddBody(TBody.Create(ClientWidth div 2, ClientHeight div 2, 0, 0, 0, 0, 10));
end;

procedure TFormMain.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  CreationPos := ScreenToClient(Mouse.CursorPos);
  CreationMass := InitialCreationMass;
  TimerMassUpdate.Enabled := True;
end;

procedure TFormMain.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  CreationSize: integer;
begin
  CreationSize := MassToSize(CreationMass);
  AddBody(TBody.Create(CreationPos.X - CreationSize div 2, CreationPos.Y -
    CreationSize div 2, 0, 0, 0, 0, CreationSize));

  CreationMass := 0;
  TimerMassUpdate.Enabled := False;
end;

procedure TFormMain.FormPaint(Sender: TObject);
var
  I: integer;
  X, Y, Size: integer;
  CreationX, CreationY, CreationSize: integer;
begin
  Canvas.Brush.Color := clBlack;
  Canvas.FillRect(0, 0, ClientWidth, ClientHeight);

  Canvas.Brush.Color := clWhite;
  Canvas.Pen.Style := psClear;

  for I := Low(Bodies) to High(Bodies) do
  begin
    X := Trunc(Bodies[I].X);
    Y := Trunc(Bodies[I].Y);
    Size := MassToSize(Bodies[I].M);
    Canvas.Ellipse(X, Y, X + Size, Y + Size);
  end;

  if CreationMass <> 0 then
  begin
    CreationSize := MassToSize(CreationMass);
    CreationX := Trunc(CreationPos.X);
    CreationY := Trunc(CreationPos.Y);
    Canvas.Ellipse(CreationX - CreationSize div 2, CreationY -
      CreationSize div 2, CreationX + CreationSize div 2,
      CreationY + CreationSize div 2);
  end;

end;

procedure TFormMain.TimerMemoUpdateTimer(Sender: TObject);
var
  I: Integer;
  BodyText: string;
begin
  MemoBodiesState.Lines.Clear;
  MemoBodiesState.Lines.Add('Bodies:');
  for I := Low(Bodies) to High(Bodies) do
  begin
    BodyText := Format('%d. X=%.3f; Y=%.3f;', [i, Bodies[i].X, Bodies[i].Y]);
    MemoBodiesState.Lines.Add(BodyText);
  end;
end;

procedure TFormMain.TimerMassUpdateTimer(Sender: TObject);
begin
  CreationMass := CreationMass + MassGrowthRate;
end;

procedure TFormMain.TimerPhysicsTimer(Sender: TObject);
var
  I, J: integer;
  Fx, Fy: single;
begin
  for I := Low(Bodies) to High(Bodies) do
  begin
    Fx := 0;
    Fy := 0;
    for J := Low(Bodies) to High(Bodies) do
    begin
      if I = J then Continue;
      Fx := Fx + CalcGravityForce(Bodies[I], Bodies[J]).X;
      Fy := Fy + CalcGravityForce(Bodies[I], Bodies[J]).Y;
    end;
    Bodies[I].Fx := Fx;
    Bodies[I].Fy := Fy;

    Bodies[I].UpdateState;
  end;

  Invalidate;
end;

procedure TFormMain.AddBody(Body: TBody);
begin
  SetLength(Bodies, Length(Bodies) + 1);
  Bodies[High(Bodies)] := Body;
end;

end.
