unit TasksWindow;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, models,
  ProjectWindow, TaskEditWindow;

type

  { TTasksForm }

  TTasksForm = class(TForm)
    WorkingList: TListBox;
    TestingList: TListBox;
    DoneList: TListBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Next2Btn: TButton;
    Next3Btn: TButton;
    SetFilterBtn: TButton;
    TagFilter: TEdit;
    Label2: TLabel;
    NewTaskBtn: TButton;
    Next1Btn: TButton;
    Label1: TLabel;
    InitialList: TListBox;
    procedure DoneListDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure InitialListDblClick(Sender: TObject);
    procedure NewTaskBtnClick(Sender: TObject);
    procedure Next1BtnClick(Sender: TObject);
    procedure Next2BtnClick(Sender: TObject);
    procedure Next3BtnClick(Sender: TObject);
    procedure SetFilterBtnClick(Sender: TObject);
    procedure TestingListDblClick(Sender: TObject);
    procedure WorkingListDblClick(Sender: TObject);
  private
    projfilter: string;
    procedure RenderKanbanLists;
    function GetTask(lst: TListBox): Boolean;
    procedure OpenTask(lst: TListBox);
    procedure UpdateState(lst: TListBox; newstate: Integer);
  public

  end;

var
  TasksForm: TTasksForm;

implementation

{$R *.lfm}

{ TTasksForm }

procedure TTasksForm.FormShow(Sender: TObject);
begin
  RenderKanbanLists;
end;

procedure TTasksForm.DoneListDblClick(Sender: TObject);
begin
  OpenTask(DoneList);
end;

procedure TTasksForm.InitialListDblClick(Sender: TObject);
begin
  OpenTask(InitialList);
end;

procedure TTasksForm.NewTaskBtnClick(Sender: TObject);
begin
  with Database.TasksDB do
  begin
    Append;
    FieldValues['ProjectID']:=ProjectForm.ProjectID;
    FieldValues['Added']:=Now;
    FieldValues['State']:=0;
    if TaskEditForm.ShowModal = mrOK then
      Post
    else
      Cancel;
  end;
  RenderKanbanLists;
end;

procedure TTasksForm.Next1BtnClick(Sender: TObject);
begin
  UpdateState(InitialList, 1);
end;

procedure TTasksForm.Next2BtnClick(Sender: TObject);
begin
  UpdateState(WorkingList, 2);
end;

procedure TTasksForm.Next3BtnClick(Sender: TObject);
begin
  UpdateState(TestingList, 3);
end;

procedure TTasksForm.SetFilterBtnClick(Sender: TObject);
begin
  with Database.TasksDB do
  begin
    if TagFilter.Enabled then
    begin
      projfilter:=Filter;
      Filtered:=False;
      Filter:=projfilter+' AND TAG='+QuotedStr(TagFilter.Text);
      Filtered:=True;
      TagFilter.Enabled:=False;
    end
    else
    begin
      Filtered:=False;
      Filter:=projfilter;
      Filtered:=True;
      TagFilter.Text:='';
      TagFilter.Enabled:=True;
    end;
  end;
  RenderKanbanLists;
end;

procedure TTasksForm.TestingListDblClick(Sender: TObject);
begin
  OpenTask(TestingList);
end;

procedure TTasksForm.WorkingListDblClick(Sender: TObject);
begin
  OpenTask(WorkingList);
end;

procedure TTasksForm.RenderKanbanLists;
var
  st: Integer;
begin
  InitialList.Clear;
  WorkingList.Clear;
  TestingList.Clear;
  DoneList.Clear;
  with Database.TasksDB do
  begin
    First;
    if EOF then
      Exit;
    repeat
      st:=FieldValues['STATE'];
      case st of
        0: InitialList.Items.Add(FieldValues['TITLE']);
        1: WorkingList.Items.Add(FieldValues['TITLE']);
        2: TestingList.Items.Add(FieldValues['TITLE']);
        3: DoneList.Items.Add(FieldValues['TITLE']);
      end;
      Next;
    until EOF;
  end;
end;

function TTasksForm.GetTask(lst: TListBox): Boolean;
begin
  Result:=Database.TasksDB.Locate('Title', lst.GetSelectedText, []);
end;

procedure TTasksForm.OpenTask(lst: TListBox);
begin
  with Database.TasksDB do
  begin
    if not GetTask(lst) then
      Exit;
    Edit;
    if TaskEditForm.ShowModal = mrOK then
      Post
    else
      Cancel;
  end;
  RenderKanbanLists;
end;

procedure TTasksForm.UpdateState(lst: TListBox; newstate: Integer);
begin
  if not GetTask(lst) then
    Exit;
  with Database.TasksDB do
  begin
    Edit;
    FieldValues['State']:=newstate;
    Post;
  end;
  RenderKanbanLists;
end;

end.

