object DmConexao: TDmConexao
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 150
  Width = 215
  object ConexaoBD: TFDConnection
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
  object mtSettings: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 116
    Top = 30
    object mtSettingscontext: TStringField
      FieldName = 'context'
      Size = 100
    end
    object mtSettingsport: TIntegerField
      FieldName = 'port'
    end
    object mtSettingshost: TStringField
      FieldName = 'host'
      Size = 200
    end
    object mtSettingsdatabase: TStringField
      FieldName = 'database'
      Size = 100
    end
    object mtSettingsuser: TStringField
      FieldName = 'user'
      Size = 100
    end
    object mtSettingspassword: TStringField
      FieldName = 'password'
      Size = 100
    end
  end
end
