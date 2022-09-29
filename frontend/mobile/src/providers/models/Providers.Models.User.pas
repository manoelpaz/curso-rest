unit Providers.Models.User;

interface

type
  TUser = class
  private
    FId: Integer;
    FNome: string;
    FLogin: string;
    FTelefone: string;
    FSexo: Integer;
  public
    property Id: Integer read FId write FId;
    property Nome: string read FNome write FNome;
    property Login: string read FLogin write FLogin;
    property Telefone: string read FTelefone write FTelefone;
    property Sexo: Integer read FSexo write FSexo;
    function GetSexoAsString: string;
  end;

implementation

{ TUser }

function TUser.GetSexoAsString: string;
begin
  Result := 'Masculino';
  if (FSexo = 1) then
    Result := 'Feminino';
end;

end.
