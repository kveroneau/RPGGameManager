unit ProjectWindow;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, models,
  NewProjectWindow;

type

  { TProjectForm }

  TProjectForm = class(TForm)
    NewBtn: TButton;
    ProjectList: TListBox;
    procedure FormShow(Sender: TObject);
    procedure NewBtnClick(Sender: TObject);
    procedure ProjectListDblClick(Sender: TObject);
  private
    function GetProjectID: integer;
    function GetProjectTitle: string;
    procedure RefreshProjects;
  public
    property ProjectID: integer read GetProjectID;
    property ProjectTitle: string read GetProjectTitle;
  end;

var
  ProjectForm: TProjectForm;

implementation

{$R *.lfm}

{ TProjectForm }

procedure TProjectForm.ProjectListDblClick(Sender: TObject);
begin
  if Database.ProjectDB.Locate('TITLE', ProjectList.GetSelectedText, []) then
    ModalResult:=mrOK;
end;

function TProjectForm.GetProjectID: integer;
begin
  Result:=Database.ProjectDB.FieldValues['ID'];
end;

function TProjectForm.GetProjectTitle: string;
begin
  Result:=Database.ProjectDB.FieldValues['TITLE'];
end;

procedure TProjectForm.RefreshProjects;
begin
  ProjectList.Clear;
  with Database.ProjectDB do
  begin
    First;
    if EOF then
      Exit;
    repeat
      ProjectList.Items.Add(FieldValues['TITLE']);
      Next;
    until EOF;
  end;
end;

procedure TProjectForm.FormShow(Sender: TObject);
begin
  Database.ProjectDB.Active:=True;
  RefreshProjects;
end;

procedure TProjectForm.NewBtnClick(Sender: TObject);
var
  r: TModalResult;
begin
  with Database.ProjectDB do
  begin
    Append;
    FieldValues['ADDED']:=Now;
    r := NewGameForm.ShowModal;
    if r = mrOK then
      Post
    else
      Cancel;
  end;
  RefreshProjects;
end;

end.

