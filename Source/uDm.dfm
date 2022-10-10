object DM: TDM
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 307
  Width = 232
  object Connection: TFDConnection
    Params.Strings = (
      'User_Name=Euler'
      'Password=ErcTech@520'
      'Server=localhost'
      'UseSSL=True'
      'Database=teste'
      'DriverID=MySQL')
    LoginPrompt = False
    Left = 80
    Top = 48
  end
  object MySQLDriverLink: TFDPhysMySQLDriverLink
    Left = 80
    Top = 104
  end
  object WaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 80
    Top = 160
  end
end
