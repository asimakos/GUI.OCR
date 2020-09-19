unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,
  Process,LazFileUtils,Unit2;

type

  { TForm1 }

  TForm1 = class(TForm)
    BitBtn1: TBitBtn;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    Memo1: TMemo;
    OpenDialog1: TOpenDialog;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    procedure BitBtn1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  AProcess: TProcess;
  filepath:String;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
var
execpath:String;
filename:String;
begin
  if RadioButton1.Checked=true then
  begin
    execpath:='./app/label';
  end
  else if RadioButton2.Checked=true  then
  begin
     execpath:='./app/text';
  end;
  filename:='./images/'+ExtractFileName(filepath);

  AProcess := TProcess.Create(nil);
  AProcess.Executable := execpath;
  AProcess.Parameters.Add(filename);
  AProcess.Options := AProcess.Options + [poWaitOnExit, poUsePipes];
  AProcess.Execute;
  Label1.Caption:='ΕΠΕΞΕΡΓΑΣΙΑ ...';
  Memo1.Lines.LoadFromStream(AProcess.Output);
  AProcess.Free;
  Label1.Caption:='ΕΠΙΤΥΧΗΣ ΟΛΟΚΛΗΡΩΣΗ !';
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
OpenDialog1.Execute;
if (OpenDialog1.Files.Count = 1) and (FileExistsUTF8(OpenDialog1.FileName)) then
begin
  filepath := OpenDialog1.FileName;
  Form2.Show;
  Form2.Image1.Picture.LoadFromFile(OpenDialog1.FileName);
end;

end;

end.

