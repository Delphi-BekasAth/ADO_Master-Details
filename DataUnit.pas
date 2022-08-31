unit DataUnit;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.Win.ADODB;

type
  TDataModule1 = class(TDataModule)
    ADOConnection1: TADOConnection;
    ADOConnection2: TADOConnection;

    ADOQuery1: TADOQuery;
    ADOQuery2: TADOQuery;
    ADOQuery3: TADOQuery;
    ADOQuery4: TADOQuery;

    DataSource1: TDataSource;
    ADOQuery5: TADOQuery;
    ADOQuery6: TADOQuery;

    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule1: TDataModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDataModule1.DataModuleCreate(Sender: TObject);
begin

  //SETUP ADOCONNECTION2 & ADOQUERY CODE ONLY
  ADOConnection2.Create(DataModule1);
  ADOQuery3.Create(DataModule1);
  ADOQuery4.Create(DataModule1);

  ADOConnection2.ConnectionString := 'Provider=SQLNCLI11.1;Integrated Security=SSPI;Persist Security Info=False;User ID="";Initial Catalog=DelphiTestDb;Data Source="";Use Procedure for Prepare=1;Auto Translate=True;Packet Size=4096;Workstation '+'ID=PC-SOFT2;Initial File Name="";Use Encryption for Data=False;Tag with column collation when possible=False;MARS Connection=False;DataTypeCompatibility=0;Trust Server Certificate=False;Application Intent=READWRITE;';
  ADOConnection2.LoginPrompt := false;
  ADOConnection2.Connected := true;
  ADOConnection2.Open();

  ADOQuery3.Connection := ADOConnection2;
  ADOQuery3.SQL.Add('select CODE,COST from CUSORDER');
  ADOQuery3.Active := true;

  ADOQuery4.Connection := ADOConnection2;
  ADOQuery4.SQL.Add('select * from CUSORDER where CUSID = :ID');
  ADOQuery4.Active := true;


end;

end.
