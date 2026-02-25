unit VarStateWindow;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBCtrls;

type

  { TVarStateForm }

  TVarStateForm = class(TForm)
    CancelBtn: TButton;
    SaveBtn: TButton;
    DBInfo: TDBEdit;
    DBVarValue: TDBEdit;
    DBProject: TDBText;
    DBGameVar: TDBText;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
  private

  public

  end;

var
  VarStateForm: TVarStateForm;

implementation

{$R *.lfm}

end.

