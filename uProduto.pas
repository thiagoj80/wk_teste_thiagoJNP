unit uProduto;

interface

type
  TProduto = class(TObject)
  private
    FCodigo: Integer;
    FDescricao: string;
    FPreco_Venda: Double;
  public
    constructor Create(pCodigo: Integer; pDescricao: string; pPreco_Venda: Double);
    property Codigo: Integer read FCodigo;
    property Descricao: string read FDescricao;
    property Preco_Venda: Double read FPreco_Venda;
  end;

implementation

constructor TProduto.Create(pCodigo: Integer; pDescricao: string; pPreco_venda: Double);
begin
  FCodigo := pCodigo;
  FDescricao := pDescricao;
  FPreco_Venda := pPreco_Venda;
end;

end.
