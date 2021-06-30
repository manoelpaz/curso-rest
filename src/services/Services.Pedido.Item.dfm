inherited ServicesPedidoItem: TServicesPedidoItem
  inherited qrySearch: TFDQuery
    SQL.Strings = (
      
        'select i.id, i.id_produto, i.valor, i.quantidade, p.nome as nome' +
        '_produto'
      '  from pedido_item i'
      ' inner join produto p on p.id = i.id_produto'
      ' where i.id_pedido = :id_pedido'
      '')
    ParamData = <
      item
        Name = 'ID_PEDIDO'
        ParamType = ptInput
      end>
    object qrySearchid: TLargeintField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object qrySearchid_produto: TLargeintField
      FieldName = 'id_produto'
      Origin = 'id_produto'
    end
    object qrySearchvalor: TFMTBCDField
      FieldName = 'valor'
      Origin = 'valor'
      Precision = 20
      Size = 4
    end
    object qrySearchquantidade: TFMTBCDField
      FieldName = 'quantidade'
      Origin = 'quantidade'
      Precision = 20
      Size = 4
    end
    object qrySearchnome_produto: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'nome_produto'
      Origin = 'nome_produto'
      Size = 60
    end
  end
  inherited qryRecordCount: TFDQuery
    SQL.Strings = (
      'select count(i.id)'
      '  from pedido_item i'
      ' inner join produto p on p.id = i.id_produto'
      ' where i.id_pedido = :id_pedido')
    ParamData = <
      item
        Name = 'ID_PEDIDO'
        ParamType = ptInput
      end>
  end
  inherited qryCRUD: TFDQuery
    SQL.Strings = (
      
        'select i.id, i.id_pedido, i.id_produto, i.valor, i.quantidade, p' +
        '.nome as nome_produto'
      '  from pedido_item i'
      ' inner join produto p on p.id = i.id_produto')
    object qryCRUDid: TLargeintField
      AutoGenerateValue = arAutoInc
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      ReadOnly = True
    end
    object qryCRUDid_pedido: TLargeintField
      FieldName = 'id_pedido'
      Origin = 'id_pedido'
    end
    object qryCRUDid_produto: TLargeintField
      FieldName = 'id_produto'
      Origin = 'id_produto'
    end
    object qryCRUDvalor: TFMTBCDField
      FieldName = 'valor'
      Origin = 'valor'
      Precision = 20
      Size = 4
    end
    object qryCRUDquantidade: TFMTBCDField
      FieldName = 'quantidade'
      Origin = 'quantidade'
      Precision = 20
      Size = 4
    end
    object qryCRUDnome_produto: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'nome_produto'
      Origin = 'nome_produto'
      Size = 60
    end
  end
end
