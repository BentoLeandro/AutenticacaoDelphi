inherited ServicesAuth: TServicesAuth
  inherited FDConnection: TFDConnection
    Connected = True
    Top = 80
  end
  object qryLogin: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'select u.id, u.senha'
      'from usuario u'
      'where u.login = :plogin and'
      #9'  u.status = 1')
    Left = 344
    Top = 80
    ParamData = <
      item
        Name = 'PLOGIN'
        DataType = ftString
        ParamType = ptInput
        Value = '0'
      end>
    object qryLoginid: TLargeintField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object qryLoginsenha: TWideStringField
      FieldName = 'senha'
      Origin = 'senha'
      Size = 256
    end
  end
end
