program WK_PedidoVenda;

uses
  Vcl.Forms,
  uPedidoVenda in 'uPedidoVenda.pas' {frmPedido},
  uDMPedido in 'uDMPedido.pas' {dmPedido: TDataModule},
  uProduto in 'uProduto.pas',
  uProdutoDAO in 'uProdutoDAO.pas',
  uCliente in 'uCliente.pas',
  uClienteDAO in 'uClienteDAO.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPedido, frmPedido);
  Application.CreateForm(TdmPedido, dmPedido);
  Application.Run;
end.
