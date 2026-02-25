unit StoryWindow;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBCtrls,
  models, VariableWindow;

type

  { TChapterForm }

  TChapterForm = class(TForm)
    CancelBtn: TButton;
    Label4: TLabel;
    VariableList: TListBox;
    SaveBtn: TButton;
    DBChapter: TDBEdit;
    DBNotes: TDBMemo;
    DBProject: TDBText;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure FormShow(Sender: TObject);
    procedure VariableListDblClick(Sender: TObject);
  private

  public

  end;

var
  ChapterForm: TChapterForm;

implementation

{$R *.lfm}

{ TChapterForm }

procedure TChapterForm.FormShow(Sender: TObject);
begin
  VariableList.Clear;
  with Database.VarsDB do
  begin
    First;
    if EOF then
      Exit;
    repeat
      if FieldValues['Chapter'] = Database.StoryDB.FieldValues['Chapter'] then
        VariableList.Items.Add(IntToStr(FieldValues['VariableID']));
      Next;
    until EOF;
  end;
end;

procedure TChapterForm.VariableListDblClick(Sender: TObject);
begin
  with Database.VarsDB do
  begin
    if Locate('VariableID', StrToInt(VariableList.GetSelectedText), []) then
    begin
      Edit;
      if VariableForm.ShowModal = mrOK then
        Post
      else
        Cancel;
    end;
  end;
end;

end.

