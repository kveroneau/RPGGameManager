unit TaskEditWindow;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBCtrls,
  models;

type

  { TTaskEditForm }

  TTaskEditForm = class(TForm)
    CancelBtn: TButton;
    SaveBtn: TButton;
    DBChapter: TDBEdit;
    DBAdded: TDBText;
    DBNotes: TDBMemo;
    DBTags: TDBEdit;
    DBTitle: TDBEdit;
    DBProject: TDBText;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
  private

  public

  end;

var
  TaskEditForm: TTaskEditForm;

implementation

{$R *.lfm}

end.

