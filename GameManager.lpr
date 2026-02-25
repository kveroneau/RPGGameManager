program GameManager;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, ProjectWindow, models, NewProjectWindow, GameWindow, StoryWindow,
  VariableWindow, VarStateWindow, TasksWindow, TaskEditWindow;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Title:='RPG Game Manager';
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TGameManagerForm, GameManagerForm);
  Application.CreateForm(TProjectForm, ProjectForm);
  Application.CreateForm(TDatabase, Database);
  Application.CreateForm(TNewGameForm, NewGameForm);
  Application.CreateForm(TChapterForm, ChapterForm);
  Application.CreateForm(TVariableForm, VariableForm);
  Application.CreateForm(TVarStateForm, VarStateForm);
  Application.CreateForm(TTasksForm, TasksForm);
  Application.CreateForm(TTaskEditForm, TaskEditForm);
  Application.Run;
end.

