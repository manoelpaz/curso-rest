inherited ServicesCliente: TServicesCliente
  inherited qrySearch: TFDQuery
    SQL.Strings = (
      'select c.id, c.nome, c.status'
      '  from cliente c'
      ' where 1 = 1')
    object qrySearchid: TLargeintField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object qrySearchnome: TWideStringField
      FieldName = 'nome'
      Origin = 'nome'
      Size = 60
    end
    object qrySearchstatus: TSmallintField
      FieldName = 'status'
      Origin = 'status'
    end
  end
  inherited qryRecordCount: TFDQuery
    SQL.Strings = (
      'select count(c.id)'
      '  from cliente c'
      ' where 1 = 1')
  end
  inherited qryCRUD: TFDQuery
    SQL.Strings = (
      'select c.id, c.nome, c.status'
      '  from cliente c')
    object qryCRUDid: TLargeintField
      AutoGenerateValue = arAutoInc
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      ReadOnly = True
    end
    object qryCRUDnome: TWideStringField
      FieldName = 'nome'
      Origin = 'nome'
      Size = 60
    end
    object qryCRUDstatus: TSmallintField
      FieldName = 'status'
      Origin = 'status'
    end
  end
end
