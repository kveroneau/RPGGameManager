unit GameWindow;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, models,
  ProjectWindow, StoryWindow, VariableWindow, TasksWindow;

type

  { TGameManagerForm }

  TGameManagerForm = class(TForm)
    TasksBtn: TButton;
    VarBtn: TButton;
    GameVar: TEdit;
    Label1: TLabel;
    NewStoryBtn: TButton;
    StoryList: TListBox;
    procedure FormShow(Sender: TObject);
    procedure NewStoryBtnClick(Sender: TObject);
    procedure StoryListDblClick(Sender: TObject);
    procedure TasksBtnClick(Sender: TObject);
    procedure VarBtnClick(Sender: TObject);
  private
    procedure RefreshLists;
  public

  end;

var
  GameManagerForm: TGameManagerForm;

implementation

{$R *.lfm}

{ TGameManagerForm }

procedure TGameManagerForm.FormShow(Sender: TObject);
var
  r: TModalResult;
  projfilter: string;
begin
  r:=ProjectForm.ShowModal;
  if r <> mrOK then
    Close;
  Caption:=Caption+' :: '+ProjectForm.ProjectTitle;
  projfilter:='ProjectID='+IntToStr(ProjectForm.ProjectID);
  Database.StoryDB.Active:=True;
  Database.StoryDB.Filter:=projfilter;
  Database.StoryDB.Filtered:=True;
  Database.VarsDB.Active:=True;
  Database.VarsDB.Filter:=projfilter;
  Database.VarsDB.Filtered:=True;
  Database.VarStateDB.Active:=True;
  Database.VarStateDB.Filter:=projfilter;
  Database.VarStateDB.Filtered:=True;
  Database.TasksDB.Active:=True;
  Database.TasksDB.Filter:=projfilter;
  Database.TasksDB.Filtered:=True;
  RefreshLists;
end;

procedure TGameManagerForm.NewStoryBtnClick(Sender: TObject);
begin
  with Database.StoryDB do
  begin
    Append;
    FieldValues['ProjectID']:=ProjectForm.ProjectID;
    if ChapterForm.ShowModal = mrOK then
      Post
    else
      Cancel;
  end;
  RefreshLists;
end;

procedure TGameManagerForm.StoryListDblClick(Sender: TObject);
begin
  if Database.StoryDB.Locate('Chapter', StoryList.ItemIndex, []) then
  begin
    Database.StoryDB.Edit;
    if ChapterForm.ShowModal = mrOK then
      Database.StoryDB.Post
    else
      Database.StoryDB.Cancel;
  end;
end;

procedure TGameManagerForm.TasksBtnClick(Sender: TObject);
begin
  TasksForm.Show;
end;

procedure TGameManagerForm.VarBtnClick(Sender: TObject);
begin
  with Database.VarsDB do
  begin
    if not Locate('VariableID', StrToInt(GameVar.Text), []) then
    begin
      Append;
      FieldValues['ProjectID']:=ProjectForm.ProjectID;
      FieldValues['VariableID']:=StrToInt(GameVar.Text);
    end
    else
      Edit;
    if VariableForm.ShowModal = mrOK then
      Post
    else
      Cancel;
  end;
end;

procedure TGameManagerForm.RefreshLists;
begin
  StoryList.Clear;
  with Database.StoryDB do
  begin
    First;
    if EOF then
      Exit;
    repeat
      StoryList.Items.Add('Chapter '+IntToStr(FieldValues['Chapter']));
      Next;
    until EOF;
  end;
end;

end.

