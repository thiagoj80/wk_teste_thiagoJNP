unit uClienteDAO;

interface

uses
  FireDAC.Comp.Client, System.Classes, uCliente;

type
  TClienteDAO = class
  private
    FDConnection: TFDConnection;
  public
    constructor Create(pConnection: TFDConnection);
    function BuscarClientesPorDescricao(pDescricao: string): TList;
  end;

implementation

uses
  System.SysUtils;

constructor TClienteDAO.Create(pConnection: TFDConnection);
begin
  FDConnection := pConnection;
end;

function TClienteDAO.BuscarClientesPorDescricao(pDescricao: string): TList;
var
  qryCliente: TFDQuery;
  Cliente: TCliente;
  ListaClientes: TList;
  sBusca : string;
begin
  sBusca := '%'+UpperCase(StringReplace(pDescricao,' ','%',[rfReplaceAll]))+'%';
  ListaClientes := TList.Create;
  qryCliente := TFDQuery.Create(nil);
  try
    qryCliente.Connection := FDConnection;
    qryCliente.SQL.Text := 'SELECT codigo, nome FROM tab_Cliente WHERE CONCAT(LPAD(CODIGO,10,''0''),'' '',UPPER(nome)) LIKE :nome';
    qryCliente.ParamByName('nome').AsString := sBusca;
    qryCliente.Open;

    while not qryCliente.Eof do
    begin
      Cliente := TCliente.Create(qryCliente.FieldByName('codigo').AsInteger,
                                 qryCliente.FieldByName('nome').AsString);
      ListaClientes.Add(Cliente);
      qryCliente.Next;
    end;
  finally
    qryCliente.Free;
  end;
  Result := ListaClientes;
end;

end.
