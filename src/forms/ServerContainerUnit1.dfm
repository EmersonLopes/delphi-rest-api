object ServerContainer1: TServerContainer1
  OldCreateOrder = False
  Height = 271
  Width = 415
  object DSServer1: TDSServer
    Left = 96
    Top = 11
  end
  object DSServerClass1: TDSServerClass
    OnGetClass = DSServerClass1GetClass
    Server = DSServer1
    Left = 200
    Top = 11
  end
  object DSServerClassUsuario: TDSServerClass
    OnGetClass = DSServerClassUsuarioGetClass
    Server = DSServer1
    Left = 72
    Top = 83
  end
  object DSServerClassProduto: TDSServerClass
    OnGetClass = DSServerClassProdutoGetClass
    Server = DSServer1
    Left = 72
    Top = 139
  end
end
