﻿  unit Unit1;

  interface

  uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.FileCtrl, Vcl.Grids,
  Vcl.ComCtrls, Data.DB, Vcl.DBGrids, UnitLog, Vcl.Menus, Winapi.OpenGL, Unit3DLog,
  Vcl.ExtCtrls;

  type
    TForm1 = class(TForm)
      ListBox1: TListBox;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Memo1: TMemo;
    ListView1: TListView;
    procedure ListBox1Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    private
      { Private declarations }
    public
      { Public declarations }
    end;

  var
    Form1: TForm1;
    derictoryPath: string;
    log : TLog;
  implementation

  {$R *.dfm}
    procedure TForm1.ListBox1Click(Sender: TObject);
    var
    path, s: string;

    begin
      if ListBox1.ItemIndex >=0  then
      begin
          path := derictoryPath+'\'+ ListBox1.Items.Strings[ListBox1.ItemIndex];
          log := TLog.Create(path);

          if Memo1.Lines.Count>0 then
          begin
             Memo1.Lines.Clear();
          end;
          for s in  log.GetProertyList do
          begin
             Memo1.Lines.Add(s);
             Create3DLog(log,Handle);
          end;

      end;
    end;

procedure TForm1.N1Click(Sender: TObject);
var
        sr: TSearchRec;
    begin
      SelectDirectory('Выбор папки', '',derictoryPath);

      if FindFirst(derictoryPath+'\*.lprf', faAnyFile, sr)=0  then  //ищем  файлы Word  в каталоге
      if ListBox1.Items.Count>0 then
      ListBox1.Items.Clear();

      repeat
          Listbox1.Items.Add(sr.Name); //выводим список в ListBox
      until FindNext(sr)<>0;

            FindClose(sr);
    end;

end.


