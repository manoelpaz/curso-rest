inherited ServiceClientes: TServiceClientes
  inherited mtPesquisa: TFDMemTable
    object mtPesquisaid: TIntegerField
      FieldName = 'id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object mtPesquisanome: TStringField
      FieldName = 'nome'
      Size = 500
    end
    object mtPesquisastatus: TIntegerField
      Alignment = taLeftJustify
      FieldName = 'status'
      OnGetText = mtPesquisastatusGetText
    end
  end
  inherited mtCadastro: TFDMemTable
    AfterInsert = mtCadastroAfterInsert
    object mtCadastroid: TLargeintField
      AutoGenerateValue = arAutoInc
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object mtCadastronome: TWideStringField
      FieldName = 'nome'
      Origin = 'nome'
      Size = 60
    end
    object mtCadastrostatus: TSmallintField
      FieldName = 'status'
      Origin = 'status'
    end
  end
end
