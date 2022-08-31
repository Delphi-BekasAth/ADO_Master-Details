object DataModule1: TDataModule1
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 507
  Width = 694
  object ADOConnection1: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=SQLNCLI11.1;Integrated Security=SSPI;Persist Security I' +
      'nfo=False;User ID="";Initial Catalog=DelphiTestDb;Data Source=""' +
      ';Initial File Name="";Server SPN=""'
    LoginPrompt = False
    Provider = 'SQLNCLI11.1'
    Left = 16
    Top = 8
  end
  object ADOQuery1: TADOQuery
    Active = True
    Connection = ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select NAME, BALANCE from CUSTOMER')
    Left = 88
    Top = 8
  end
  object DataSource1: TDataSource
    DataSet = ADOQuery1
    Left = 224
    Top = 40
  end
  object ADOQuery2: TADOQuery
    Active = True
    Connection = ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from CUSTOMER')
    Left = 88
    Top = 56
  end
  object ADOConnection2: TADOConnection
    LoginPrompt = False
    Left = 16
    Top = 88
  end
  object ADOQuery3: TADOQuery
    Parameters = <>
    Left = 88
    Top = 128
  end
  object ADOQuery4: TADOQuery
    Parameters = <>
    Left = 88
    Top = 200
  end
  object ADOQuery5: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    SQL.Strings = (
      '')
    Left = 88
    Top = 272
  end
  object ADOQuery6: TADOQuery
    Connection = ADOConnection2
    Parameters = <>
    SQL.Strings = (
      'select * from CUSORDER')
    Left = 80
    Top = 344
  end
end
