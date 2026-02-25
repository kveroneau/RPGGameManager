unit models;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, dbf, DB;

type

  { TDatabase }

  TDatabase = class(TDataModule)
    TasksDS: TDataSource;
    TasksDB: TDbf;
    VarStateDS: TDataSource;
    VarStateDB: TDbf;
    VarsDS: TDataSource;
    VarsDB: TDbf;
    StoryDS: TDataSource;
    StoryDB: TDbf;
    ProjectDS: TDataSource;
    ProjectDB: TDbf;
  private

  public

  end;

var
  Database: TDatabase;

implementation

{$R *.lfm}

end.

