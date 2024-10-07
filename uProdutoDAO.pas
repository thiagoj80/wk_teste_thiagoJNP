unit uProdutoDAO;

interface

uses
  FireDAC.Comp.Client, System.Classes, uProduto;

type
  TProdutoDAO = class
  private
    FDConnection: TFDConnection;
  public
    constructor Create(pConnection: TFDConnection);
    function BuscarProdutosPorDescricao(pDescricao: string): TList;
  end;

implementation

uses
  System.SysUtils;

constructor TProdutoDAO.Create(pConnection: TFDConnection);
begin
  FDConnection := pConnection;
end;

function TProdutoDAO.BuscarProdutosPorDescricao(pDescricao: string): TList;
var
  qryProduto: TFDQuery;
  Produto: TProduto;
  ListaProdutos: TList;
  sBusca : string;
begin
  sBusca := '%'+UpperCase(StringReplace(pDescricao,' ','%',[rfReplaceAll]))+'%';
  ListaProdutos := TList.Create;
  qryProduto := TFDQuery.Create(nil);
  try
    qryProduto.Connection := FDConnection;
    qryProduto.SQL.Text := 'SELECT codigo, descricao, preco_venda FROM tab_produto WHERE CONCAT(LPAD(CODIGO,10,''0''),'' '',UPPER(DESCRICAO)) LIKE :Descricao';
    qryProduto.ParamByName('Descricao').AsString := sBusca;
    qryProduto.Open;

    while not qryProduto.Eof do
    begin
      Produto := TProduto.Create(qryProduto.FieldByName('codigo').AsInteger,
                                 qryProduto.FieldByName('descricao').AsString,
                                 qryProduto.FieldByName('preco_venda').AsFloat);
      ListaProdutos.Add(Produto);
      qryProduto.Next;
    end;
  finally
    qryProduto.Free;
  end;
  Result := ListaProdutos;
end;

end.
