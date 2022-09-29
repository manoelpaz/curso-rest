object ProvidersConnection: TProvidersConnection
  Height = 208
  Width = 194
  PixelsPerInch = 96
  object FDConnection: TFDConnection
    Params.Strings = (
      'ConnectionDef=Curso_Pooled')
    LoginPrompt = False
    Left = 80
    Top = 24
  end
  object FDPhysPgDriverLink: TFDPhysPgDriverLink
    VendorHome = 'D:\GitHub-Reposit'#243'rios\manoelpaz\curso-rest\backend\business'
    Left = 80
    Top = 112
  end
end
