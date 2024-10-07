object dmPedido: TdmPedido
  OldCreateOrder = True
  OnCreate = DataModuleCreate
  Height = 337
  Width = 534
  object FDConnection: TFDConnection
    Params.Strings = (
      'Database=wk_teste'
      'User_Name=root'
      'Password=MasterKey@43'
      'Server=localhost'
      'DriverID=MySQL')
    LoginPrompt = False
    Left = 133
    Top = 86
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = 'C:\DelphiProjetos\WK_TESTE\build\libmysql.dll'
    Left = 136
    Top = 152
  end
end
