inherited ServicesUsuario: TServicesUsuario
  inherited qrySearch: TFDQuery
    SQL.Strings = (
      
        'select u.id, u.nome, u.login, u.status, u.telefone, u.sexo, u.fo' +
        'to'
      '  from usuario u'
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
    object qrySearchlogin: TWideStringField
      FieldName = 'login'
      Origin = '"login"'
      Size = 30
    end
    object qrySearchstatus: TSmallintField
      FieldName = 'status'
      Origin = 'status'
    end
    object qrySearchtelefone: TWideStringField
      FieldName = 'telefone'
      Origin = 'telefone'
    end
    object qrySearchsexo: TSmallintField
      FieldName = 'sexo'
      Origin = 'sexo'
    end
    object qrySearchfoto: TBlobField
      FieldName = 'foto'
      Origin = 'foto'
    end
  end
  inherited qryRecordCount: TFDQuery
    SQL.Strings = (
      'select count(u.id)'
      '  from usuario u'
      ' where 1 = 1')
  end
  inherited qryCRUD: TFDQuery
    SQL.Strings = (
      
        'select u.id, u.nome, u.login, u.senha, u.status, u.telefone, u.s' +
        'exo, u.foto'
      '  from usuario u')
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
    object qryCRUDlogin: TWideStringField
      FieldName = 'login'
      Origin = '"login"'
      Size = 30
    end
    object qryCRUDsenha: TWideStringField
      FieldName = 'senha'
      Origin = 'senha'
      Size = 256
    end
    object qryCRUDstatus: TSmallintField
      FieldName = 'status'
      Origin = 'status'
    end
    object qryCRUDtelefone: TWideStringField
      FieldName = 'telefone'
      Origin = 'telefone'
    end
    object qryCRUDsexo: TSmallintField
      FieldName = 'sexo'
      Origin = 'sexo'
    end
    object qryCRUDfoto: TBlobField
      FieldName = 'foto'
      Origin = 'foto'
    end
  end
end
