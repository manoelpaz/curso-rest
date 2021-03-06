inherited ServicesPedido: TServicesPedido
  inherited qrySearch: TFDQuery
    SQL.Strings = (
      
        'select p.id, p.id_cliente, p.data, c.nome as nome_cliente, p.id_' +
        'usuario'
      '  from pedido p'
      ' inner join cliente c on c.id = p.id_cliente'
      ' where 1 = 1')
    object qrySearchid: TLargeintField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object qrySearchid_cliente: TLargeintField
      FieldName = 'id_cliente'
      Origin = 'id_cliente'
    end
    object qrySearchdata: TSQLTimeStampField
      FieldName = 'data'
      Origin = 'data'
    end
    object qrySearchnome_cliente: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'nome_cliente'
      Origin = 'nome_cliente'
      Size = 60
    end
    object qrySearchid_usuario: TLargeintField
      FieldName = 'id_usuario'
      Origin = 'id_usuario'
    end
  end
  inherited qryRecordCount: TFDQuery
    SQL.Strings = (
      'select count(p.id)'
      '  from pedido p'
      ' inner join cliente c on c.id = p.id_cliente'
      ' where 1 = 1')
  end
  inherited qryCRUD: TFDQuery
    AfterInsert = qryCRUDAfterInsert
    SQL.Strings = (
      
        'select p.id, p.id_cliente, p.data, c.nome as nome_cliente, p.id_' +
        'usuario'
      '  from pedido p'
      ' inner join cliente c on c.id = p.id_cliente')
    object qryCRUDid: TLargeintField
      AutoGenerateValue = arAutoInc
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      ReadOnly = True
    end
    object qryCRUDid_cliente: TLargeintField
      FieldName = 'id_cliente'
      Origin = 'id_cliente'
    end
    object qryCRUDdata: TSQLTimeStampField
      FieldName = 'data'
      Origin = 'data'
    end
    object qryCRUDnome_cliente: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'nome_cliente'
      Origin = 'nome_cliente'
      Size = 60
    end
    object qryCRUDid_usuario: TLargeintField
      FieldName = 'id_usuario'
      Origin = 'id_usuario'
    end
  end
end
