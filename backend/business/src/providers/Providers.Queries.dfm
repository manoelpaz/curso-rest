inherited ProvidersQueries: TProvidersQueries
  OldCreateOrder = True
  Height = 196
  Width = 428
  inherited FDConnection: TFDConnection
    Connected = True
  end
  object qrySearch: TFDQuery
    CachedUpdates = True
    Connection = FDConnection
    Left = 352
    Top = 64
  end
  object qryRecordCount: TFDQuery
    CachedUpdates = True
    Connection = FDConnection
    Left = 272
    Top = 66
    object qryRecordCountCOUNT: TLargeintField
      FieldName = 'COUNT'
    end
  end
  object qryCRUD: TFDQuery
    CachedUpdates = True
    Connection = FDConnection
    Left = 192
    Top = 67
  end
end
