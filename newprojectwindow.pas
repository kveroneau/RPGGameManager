unit NewProjectWindow;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBCtrls;

type

  { TNewGameForm }

  TNewGameForm = class(TForm)
    CancelBtn: TButton;
    SaveBtn: TButton;
    DBEdit1: TDBEdit;
    DBMemo1: TDBMemo;
    Label1: TLabel;
    Label2: TLabel;
  private

  public

  end;

var
  NewGameForm: TNewGameForm;

implementation

{$R *.lfm}

end.

