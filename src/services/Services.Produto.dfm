inherited ServicesProduto: TServicesProduto
  inherited qrySearch: TFDQuery
    SQL.Strings = (
      'select p.id, p.nome, p.valor, p.status, p.estoque'
      '  from produto p'
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
    object qrySearchvalor: TFMTBCDField
      FieldName = 'valor'
      Origin = 'valor'
      Precision = 20
      Size = 4
    end
    object qrySearchstatus: TSmallintField
      FieldName = 'status'
      Origin = 'status'
    end
    object qrySearchestoque: TFMTBCDField
      FieldName = 'estoque'
      Origin = 'estoque'
      Precision = 20
      Size = 4
    end
  end
  inherited qryRecordCount: TFDQuery
    SQL.Strings = (
      'select count(p.id) '
      '  from produto p'
      ' where 1 = 1')
  end
  inherited qryCRUD: TFDQuery
    SQL.Strings = (
      'select p.id, p.nome, p.valor, p.status, p.estoque'
      '  from produto p ')
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
    object qryCRUDvalor: TFMTBCDField
      FieldName = 'valor'
      Origin = 'valor'
      Precision = 20
      Size = 4
    end
    object qryCRUDstatus: TSmallintField
      FieldName = 'status'
      Origin = 'status'
    end
    object qryCRUDestoque: TFMTBCDField
      FieldName = 'estoque'
      Origin = 'estoque'
      Precision = 20
      Size = 4
    end
  end
end
