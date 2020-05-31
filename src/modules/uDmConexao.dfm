object DmConexao: TDmConexao
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 180
  Width = 276
  object ConexaoBD_: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\Emerson\AppData\Roaming\HK-Software\IBExpert\M' +
        'YSTOCK.FDB'
      'User_Name=sysdba'
      'Password=masterkey'
      'Server=localhost'
      'DriverID=FB')
    LoginPrompt = False
    Left = 40
    Top = 24
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 112
    Top = 88
  end
end
