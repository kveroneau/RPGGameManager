unit VariableWindow;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBCtrls,
  DBGrids, models, VarStateWindow, ProjectWindow;

type

  { TVariableForm }

  TVariableForm = class(TForm)
    DBVarStates: TDBGrid;
    NewStateBtn: TButton;
    CancelBtn: TButton;
    Label6: TLabel;
    SaveBtn: TButton;
    DBChapter: TDBEdit;
    DBDesc: TDBMemo;
    DBTitle: TDBEdit;
    DBProject: TDBText;
    DBGameVar: TDBText;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure DBVarStatesDblClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure NewStateBtnClick(Sender: TObject);
  private

  public

  end;

var
  VariableForm: TVariableForm;

implementation

{$R *.lfm}

{ TVariableForm }

procedure TVariableForm.FormShow(Sender: TObject);
begin
  with Database.VarStateDB do
  begin
    Filtered:=False;
    Filter:='ProjectID='+IntToStr(ProjectForm.ProjectID)+' AND VariableID='+IntToStr(Database.VarsDB.FieldValues['VariableID']);
    Filtered:=True;
  end;
end;

procedure TVariableForm.DBVarStatesDblClick(Sender: TObject);
begin
  with Database.VarStateDB do
  begin
    Edit;
    if VarStateForm.ShowModal = mrOK then
      Post
    else
      Cancel;
  end;
end;

procedure TVariableForm.FormResize(Sender: TObject);
begin
  DBVarStates.Width:=ClientWidth-DBVarStates.Left;
end;

procedure TVariableForm.NewStateBtnClick(Sender: TObject);
begin
  with Database.VarStateDB do
  begin
    Append;
    FieldValues['ProjectID']:=ProjectForm.ProjectID;
    FieldValues['VariableID']:=Database.VarsDB.FieldValues['VariableID'];
    if VarStateForm.ShowModal = mrOK then
      Post
    else
      Cancel;
  end;
end;

end.

