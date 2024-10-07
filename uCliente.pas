unit uCliente;

interface

type
  TCliente = class(TObject)
  private
    FCodigo: Integer;
    FDescricao: string;
  public
    constructor Create(pCodigo: Integer; pDescricao: string);
    property Codigo: Integer read FCodigo;
    property Descricao: string read FDescricao;
  end;

implementation


{ TCliente }

constructor TCliente.Create(pCodigo: Integer; pDescricao: string);
begin
  FCodigo := pCodigo;
  FDescricao := pDescricao;
end;

end.
