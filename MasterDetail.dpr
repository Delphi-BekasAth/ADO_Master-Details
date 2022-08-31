program MasterDetail;

uses
  Vcl.Forms,
  StartPage in 'StartPage.pas' {Form1},
  DataUnit in 'DataUnit.pas' {DataModule1: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.Run;
end.
