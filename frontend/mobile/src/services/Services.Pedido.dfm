inherited ServicePedido: TServicePedido
  Width = 345
  PixelsPerInch = 96
  object mtPedidos: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 64
    Top = 56
    object mtPedidosid: TLargeintField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object mtPedidosid_cliente: TLargeintField
      FieldName = 'id_cliente'
      Origin = 'id_cliente'
    end
    object mtPedidosdata: TSQLTimeStampField
      FieldName = 'data'
      Origin = 'data'
    end
    object mtPedidosnome_cliente: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'nome_cliente'
      Origin = 'nome_cliente'
      Size = 60
    end
    object mtPedidosid_usuario: TLargeintField
      FieldName = 'id_usuario'
      Origin = 'id_usuario'
    end
    object mtPedidostotal: TFMTBCDField
      FieldName = 'total'
      Origin = 'total'
      Precision = 64
      Size = 0
    end
  end
  object mtCadastro: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 144
    Top = 56
    object mtCadastroid: TLargeintField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object mtCadastroid_cliente: TLargeintField
      FieldName = 'id_cliente'
      Origin = 'id_cliente'
    end
    object mtCadastrodata: TSQLTimeStampField
      FieldName = 'data'
      Origin = 'data'
    end
    object mtCadastronome_cliente: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'nome_cliente'
      Origin = 'nome_cliente'
      Size = 60
    end
    object mtCadastroid_usuario: TLargeintField
      FieldName = 'id_usuario'
      Origin = 'id_usuario'
    end
    object mtCadastrototal: TFMTBCDField
      AutoGenerateValue = arDefault
      FieldName = 'total'
      Origin = 'total'
      Precision = 64
      Size = 0
    end
  end
  object mtItens: TFDMemTable
    BeforePost = mtItensBeforePost
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 232
    Top = 56
    object mtItensid: TLargeintField
      AutoGenerateValue = arAutoInc
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object mtItensid_produto: TLargeintField
      FieldName = 'id_produto'
      Origin = 'id_produto'
    end
    object mtItensid_pedido: TLargeintField
      FieldName = 'id_pedido'
      Origin = 'id_pedido'
    end
    object mtItensvalor: TFMTBCDField
      FieldName = 'valor'
      Origin = 'valor'
      Precision = 20
      Size = 4
    end
    object mtItensquantidade: TFMTBCDField
      FieldName = 'quantidade'
      Origin = 'quantidade'
      Precision = 20
      Size = 4
    end
    object mtItensnome_produto: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'nome_produto'
      Origin = 'nome_produto'
      Size = 60
    end
    object mtItenstotal: TCurrencyField
      FieldKind = fkInternalCalc
      FieldName = 'total'
    end
  end
end
