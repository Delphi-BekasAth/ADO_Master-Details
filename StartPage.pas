unit StartPage;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids, DataUnit, Data.Win.ADODB;

type
  TForm1 = class(TForm)
    StringGrid1: TStringGrid;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Button3: TButton;
    Button4: TButton;
    Label3: TLabel;
    StringGrid2: TStringGrid;
    Edit1: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label5: TLabel;
    Button5: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FillMasterTable(query: TADOQuery);
    procedure Button5Click(Sender: TObject);
   // procedure Button7Click(Sender: TObject);
   // procedure Button6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  detail: boolean;
  deleteOrdId: integer;

implementation

{$R *.dfm}

procedure TForm1.FillMasterTable(query: TADOQuery);
var
  i,row: integer;

begin

    StringGrid1.RowCount := 1;

    with query do
    begin

      for i := 0 to query.Fields.Count - 1 do
      begin

        StringGrid1.Rows[0][i] := Fields[i].FieldName.ToUpper;

      end;

      query.First;

      while NOT query.eof do
      begin
        StringGrid1.ColCount := Fields.Count;
        row :=  StringGrid1.RowCount;
        StringGrid1.RowCount := row + 1;

        for i := 0 to Fields.Count - 1  do
          StringGrid1.rows[row][i] := Fields[i].AsString;

        query.Next;
      end;

    end;

    if StringGrid1.RowCount > 1 then
      StringGrid1.FixedRows:= 1;


end;

procedure TForm1.Button1Click(Sender: TObject);
begin


    detail := false;

    with DataModule1 do
    begin
      FillMastertable(ADOQuery1);
    end;


end;

procedure TForm1.Button2Click(Sender: TObject);
begin


    detail := true;

     with DataModule1 do
     begin
       FillMastertable(ADOQuery2);
     end;


end;

procedure TForm1.Button3Click(Sender: TObject);
var
  i,row: integer;
begin


    detail := false;

    with DataModule1 do
    begin

      ADOQuery3.SQL.Clear;
      ADOQuery3.SQL.Add('select CODE,COST from CUSORDER');
      ADOQuery3.Active:= true;

      FillMastertable(ADOQuery3);
    end;


end;

procedure TForm1.Button4Click(Sender: TObject);
var i,row: integer;

begin


    detail := false;

    with DataModule1 do
    begin

      ADOQuery3.SQL.Clear;
      ADOQuery3.SQL.Add('select * from CUSORDER');
      ADOQuery3.Active:= true;

      FillMasterTable(ADOQuery3);

    end;

end;

procedure TForm1.Button5Click(Sender: TObject);
var
  query: string;
  date: TDate;
  r: integer;
begin


    query := 'insert into CUSORDER (CODE, CUSID, DATE, COST) VALUES (:CODE, :CUSID, :DATE, :COST)';


    with Datamodule1 do
    begin

      try
        date := VarToDateTime(Edit5.Text);
        ADOQuery5.Close;
        ADOQuery5.SQL.Clear;
        ADOQuery5.SQL.Add(query);
        ADOQuery5.Parameters.ParamByName('CODE').value := Edit4.Text;
        ADOQuery5.Parameters.ParamByName('CUSID').value := Edit1.Text;
        ADOQuery5.Parameters.ParamByName('DATE').value := date;
        ADOQuery5.Parameters.ParamByName('COST').value := Edit3.Text;
        ADOQuery5.ExecSQL;
        ShowMessage('Success.');

      except

        ShowMessage('Error.');

      end;

      Close;

      Edit4.Clear;
      Edit5.Clear;
      Edit1.Clear;
      Edit3.Clear;

    end;


end;
{
procedure TForm1.Button6Click(Sender: TObject);
var
  ok: integer;
begin

  with DataModule1 do
  begin


      with ADOQuery6 do
          begin

            Close;
            SQL.Clear;
            SQL.Add('delete from CUSORDER where ID = :ID');
            Parameters.ParamByName('ID').value :=  deleteOrdId;
            ok := ExecSQL;

            if ok = 1 then
            begin
              ShowMessage('Order Deleted.');
              Button6.Enabled := false;
            end
            else
              ShowMessage('Error');

            Edit2.Clear;
            Edit6.Clear;

            Close;

          end;
        end;

end;      }
{
procedure TForm1.Button7Click(Sender: TObject);
var
  ordid,cusid: integer;
  code,cusname: string;
begin


    code := Edit2.Text;

    with Datamodule1 do
    begin

      ordid := 0;
      with ADOQuery6 do
      begin
        try
          Close;
          SQL.Clear;
          SQL.Add('select ID from CUSORDER where CODE = :CODE');
          Parameters.paramByName('CODE').value := code;
          Open;
          if not (ADOQuery6['ID'] = null) then
            ordid := ADOQuery6['ID'];

          Close;
          SQL.Clear;
          SQL.Add('select CUSID from CUSORDER where ID = :ID');
          Parameters.paramByName('ID').value := ordid;
          Open;
          cusid := ADOQuery6['CUSID'];

          Close;
          SQL.Clear;
          SQL.Add('select NAME from CUSTOMER where ID = :CUSID');
          Parameters.paramByName('CUSID').value := cusid;
          Open;
          cusname := ADOQuery6['NAME'];
          Edit6.Text := cusname;

          if not (cusid = NULL) then
            Button6.Enabled := true;

          deleteOrdId := ordid;

        except
          ShowMessage('Error');

        end;

        Close;

      end;


    end;

end;   }


procedure TForm1.FormCreate(Sender: TObject);
begin

      Stringgrid2.RowCount := 1;

          StringGrid2.Rows[0][0] := 'ID';
          StringGrid2.Rows[0][1] := 'CODE';
          StringGrid2.Rows[0][2] := 'CUSTID';
          StringGrid2.Rows[0][3] := 'DATE';
          StringGrid2.Rows[0][4] := 'COST';


end;

procedure TForm1.StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
  var
    id,row: integer;
begin
    if detail then
    begin
      StringGrid2.RowCount := 1;

      if(StringGrid1.Rows[0][0] = 'ID') then
      begin
        id := StrToint(StringGrid1.Rows[ARow][0]);

        with DataModule1 do
        begin
          with ADOQuery4 do
          begin
            Close;
            SQL.Clear;
            SQL.Add('select * from CUSORDER where CUSID = :ID');
            Parameters.ParamByName('ID').Value := id;
            Open;
            ADOQuery4.First;
          end;

          while NOT ADOQuery4.eof do
          begin

            row := Stringgrid2.RowCount;
            StringGrid2.RowCount := row + 1;

            StringGrid2.Rows[row][0] := ADOQuery4['ID'];
            StringGrid2.Rows[row][1] := ADOQuery4['CODE'];
            StringGrid2.Rows[row][2] := ADOQuery4['CUSID'];
            StringGrid2.Rows[row][3] := ADOQuery4['DATE'];
            StringGrid2.Rows[row][4] := ADOQuery4['COST'];

            ADOQuery4.Next;

          end;

        end;
      end;
    end;

end;

end.
