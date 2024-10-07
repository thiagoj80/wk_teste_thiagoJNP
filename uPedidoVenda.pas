unit uPedidoVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Data.DB, Datasnap.DBClient, Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.Mask,
  Vcl.DBCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, uDMPedido, Datasnap.Provider, uProdutoDAO, uProduto, uCliente, uClienteDAO;

type
  TfrmPedido = class(TForm)
    pnlPrincipal: TPanel;
    pnlItens: TPanel;
    DBGrid1: TDBGrid;
    Panel4: TPanel;
    Label5: TLabel;
    cb_Produto: TComboBox;
    Panel3: TPanel;
    btnGravar: TBitBtn;
    Panel5: TPanel;
    Label1: TLabel;
    edtPedido: TEdit;
    btnNovo: TBitBtn;
    btnSair: TBitBtn;
    pnlDados: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    dtpEmissao: TDateTimePicker;
    cb_Cliente: TComboBox;
    Bevel1: TBevel;
    btnIncluirItem: TBitBtn;
    Bevel2: TBevel;
    edtQtde: TEdit;
    Label6: TLabel;
    btnCancelar: TBitBtn;
    cdsPedido: TClientDataSet;
    cdsPedidoItens: TClientDataSet;
    dtsPedidoItens: TDataSource;
    dtsPedido: TDataSource;
    cdsPedidoItensItemId: TIntegerField;
    cdsPedidoItensCodProduto: TStringField;
    cdsPedidoItensDescProduto: TStringField;
    cdsPedidoItensQuantidade: TIntegerField;
    cdsPedidoItensValorUnitario: TFloatField;
    cdsPedidoItensValorTotal: TFloatField;
    cdsPedidoItensPedidoId: TIntegerField;
    cdsPedidoPedidoId: TIntegerField;
    cdsPedidoDataEmissao: TDateTimeField;
    cdsPedidoCodCliente: TIntegerField;
    cdsPedidoValorTotal: TFloatField;
    edtCodCliente: TDBEdit;
    DBEdit2: TDBEdit;
    FDQuery1: TFDQuery;
    Label7: TLabel;
    Label8: TLabel;
    procedure btnSairClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure SomenteNumero(Sender: TObject; var Key: Char);
    procedure FormResize(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtPedidoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnGravarClick(Sender: TObject);
    procedure edtQtdeKeyPress(Sender: TObject; var Key: Char);
    procedure btnIncluirItemClick(Sender: TObject);
    procedure cb_ProdutoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cb_ProdutoSelect(Sender: TObject);
    procedure cdsPedidoBeforePost(DataSet: TDataSet);
    procedure cb_ClienteSelect(Sender: TObject);
    procedure DBGrid1ColExit(Sender: TObject);
    procedure edtCodClienteExit(Sender: TObject);
    procedure cb_ClienteKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    FValUnit : Double;
    iPedido : Integer;
    procedure HabilitaBotoes;
    procedure MostraComponentes;
    procedure BuscaPedido(Pedido: Integer);
    function GetDescricao(const Table, Descricao: string; const ID: Integer): String;
    procedure RecalcularTotalPedido;
    procedure InserirPedido;
    procedure InserirItensPedido;
  public
    { Public declarations }
  end;

var
  frmPedido: TfrmPedido;

implementation

{$R *.dfm}

procedure TfrmPedido.btnCancelarClick(Sender: TObject);
begin
   cdsPedido.Cancel;
   edtPedido.Text := '';
   cdsPedido.cancel;
   cdsPedidoItens.cancel;
   cdsPedido.Close;
   cdsPedidoItens.Close;
   cb_Cliente.Text := '';
   cb_Produto.Text := '';
   MostraComponentes;
   HabilitaBotoes;
end;

procedure TfrmPedido.btnGravarClick(Sender: TObject);
begin
   if Vcl.Dialogs.MessageDlg('Confirma a gravação do pedido?',
                               mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes then
   begin
     try
       InserirPedido;
       InserirItensPedido;
       Vcl.Dialogs.MessageDlg('Pedido gravado com sucesso!', mtInformation, [mbOk], 0, mbOk);
     except
       on e: Exception do
       begin
          Vcl.Dialogs.MessageDlg('Erro ao gravar o pedido: ' + e.Message, mtError, [mbOk], 0, mbOk);
       end;
     end;
     HabilitaBotoes;
   end;
end;

procedure TfrmPedido.btnIncluirItemClick(Sender: TObject);
var
   nTotal : Double;
   iQtde : Integer;
begin
   if (Trim(cb_Produto.Text)='') or (StrToIntDef(Copy(Trim(cb_Produto.Text),1,8),0)=0) then
   begin
      Vcl.Dialogs.MessageDlg('Informe um produto válido.', mtInformation, [mbOk], 0, mbOk);
      cb_Produto.SetFocus;
      Exit;
   end;

   iQtde := StrToIntDef(edtQtde.Text,0);
   if iQtde=0 then
   begin
      Vcl.Dialogs.MessageDlg('Informe a quantidade.', mtInformation, [mbOk], 0, mbOk);
      if edtQtde.CanFocus then
         edtQtde.SetFocus;
      exit;
   end;

   nTotal := iQtde * FValUnit;
   cdsPedidoItens.Append;
   cdsPedidoItensItemId.AsInteger := cdsPedidoItens.RecordCount + 1;
   cdsPedidoItensCodProduto.AsString := Copy(cb_Produto.Text,1,8);
   cdsPedidoItensdescproduto.AsString := cb_produto.Text;
   cdsPedidoItensquantidade.AsInteger :=  iQtde;
   cdsPedidoItensvalorunitario.AsFloat := FValUnit;
   cdsPedidoItensvalortotal.AsFloat := nTotal;
   RecalcularTotalPedido;
end;


procedure TfrmPedido.btnNovoClick(Sender: TObject);
begin
   edtPedido.Text := '';
   dtpEmissao.Date := now;
   cdsPedido.CreateDataSet;
   cdsPedidoItens.CreateDataSet;
   cdsPedido.Insert;
   MostraComponentes;
   HabilitaBotoes;
end;

procedure TfrmPedido.btnSairClick(Sender: TObject);
begin
   Close;
end;

procedure TfrmPedido.BuscaPedido(Pedido: Integer);
begin
//   OpenDataSet(Pedido);
   if cdsPedido.IsEmpty then
   begin
      Vcl.Dialogs.MessageDlg('Pedido não encontrado.', mtInformation, [mbOk], 0, mbOk);
      cdsPedido.Close;
      cdsPedidoItens.Close;
   end
   else
      dtpEmissao.Date  := cdsPedidoDATAEMISSAO.AsDateTime;
   MostraComponentes;
   HabilitaBotoes;
end;

procedure TfrmPedido.cb_ClienteKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  ClienteDAO: TClienteDAO;
  Cliente : TCliente;
  ListaCliente : TList;
  i: Integer;
  sDesc : string;
begin
  sDesc := cb_Cliente.Text;
  cb_Cliente.Items.Clear;
  ClienteDAO := TClienteDAO.Create(dmPedido.FDConnection);
  try
    ListaCliente := ClienteDAO.BuscarClientesPorDescricao(sDesc);
    try
      for i := 0 to ListaCliente.Count - 1 do
      begin
        Cliente := TCliente(ListaCliente[i]);
        cb_Cliente.Items.AddObject(Format('%.8d',[Cliente.Codigo])+' - '+Cliente.Descricao, Cliente);
      end;
    finally
      ListaCliente.Free;
    end;
  finally
    ClienteDAO.Free;
  end;
  cb_Cliente.DroppedDown := (cb_Cliente.Items.Count > 0);
  cb_Cliente.Text := sDesc;
  cb_Cliente.SelStart := Length(cb_Cliente.Text);

end;

procedure TfrmPedido.cb_ClienteSelect(Sender: TObject);
begin
  edtCodCliente.Text := Copy(cb_Cliente.Text,1,8);
  MostraComponentes;
end;

procedure TfrmPedido.cb_ProdutoKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  ProdutoDAO: TProdutoDAO;
  Produto : TProduto;
  ListaProduto : TList;
  i: Integer;
  sDesc : string;
begin
  sDesc := cb_Produto.Text;
  cb_Produto.Items.Clear;
  ProdutoDAO := TProdutoDAO.Create(dmPedido.FDConnection);
  try
    ListaProduto := ProdutoDAO.BuscarProdutosPorDescricao(sDesc);
    try
      for i := 0 to ListaProduto.Count - 1 do
      begin
        Produto := TProduto(ListaProduto[i]);
        cb_Produto.Items.AddObject(Format('%.8d',[Produto.Codigo])+' - '+Produto.Descricao, Produto);
      end;
    finally
      ListaProduto.Free;
    end;
  finally
    ProdutoDAO.Free;
  end;
  cb_Produto.DroppedDown := (cb_Produto.Items.Count > 0);
  cb_Produto.Text := sDesc;
  cb_Produto.SelStart := Length(cb_produto.Text);
end;

procedure TfrmPedido.cb_ProdutoSelect(Sender: TObject);
var
  Produto: TProduto;
begin
  if cb_produto.ItemIndex <> -1 then
  begin
    Produto := TProduto(cb_produto.Items.Objects[cb_produto.ItemIndex]);
    FValUnit := Produto.Preco_venda;
  end;end;

procedure TfrmPedido.cdsPedidoBeforePost(DataSet: TDataSet);
begin
   cdsPedidodataemissao.AsDateTime := dtpEmissao.Date;
end;

procedure TfrmPedido.edtCodClienteExit(Sender: TObject);
begin
   if Trim(edtCodCliente.Text)<>'' then
      cb_Cliente.Text := GetDescricao('TAB_CLIENTE','NOME',StrToIntDef(edtCodCliente.Text,0));

   MostraComponentes;

end;

procedure TfrmPedido.DBGrid1ColExit(Sender: TObject);
var
  Quantidade, ValorUnitario, ValorTotal: Double;
begin
  if (cdsPedidoItens.State in [dsEdit, dsInsert]) then
  begin
    Quantidade := cdsPedidoItens.FieldByName('Quantidade').AsFloat;
    ValorUnitario := cdsPedidoItens.FieldByName('ValorUnitario').AsFloat;
    ValorTotal := Quantidade * ValorUnitario;

    cdsPedidoItens.Edit;
    cdsPedidoItens.FieldByName('ValorTotal').AsFloat := ValorTotal;
    cdsPedidoItens.Post;

    RecalcularTotalPedido;
  end;
end;

procedure TfrmPedido.RecalcularTotalPedido;
var
  TotalPedido: Double;
begin
  TotalPedido := 0;

  cdsPedidoItens.First;
  while not cdsPedidoItens.Eof do
  begin
    TotalPedido := TotalPedido + cdsPedidoItens.FieldByName('ValorTotal').AsFloat;
    cdsPedidoItens.Next;
  end;

  cdsPedido.Edit;
  cdsPedido.FieldByName('ValorTotal').AsFloat := TotalPedido;
  cdsPedido.Post;
end;

procedure TfrmPedido.edtQtdeKeyPress(Sender: TObject; var Key: Char);
begin
   if not (Key in ['0'..'9', ',', '.', #13]) then
    Key := #0;
end;

procedure TfrmPedido.edtPedidoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if (key = 13) then
      BuscaPedido(StrToIntDef(edtPedido.Text,0));
end;

procedure TfrmPedido.FormCreate(Sender: TObject);
begin
   MostraComponentes;
   HabilitaBotoes;
end;

procedure TfrmPedido.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if Key = VK_RETURN then
       perform(WM_NEXTDLGCTL,0,0);
end;

procedure TfrmPedido.FormResize(Sender: TObject);
var
  iPosLeft : Integer;
begin
  iPosLeft := frmPedido.Width - ((frmPedido.Width + pnlPrincipal.Width) div 2) ;
  pnlPrincipal.Left := iPosLeft;
end;

function TfrmPedido.GetDescricao(const Table, Descricao: string; const ID: Integer): String;
var
  qry : TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  try
    qry.Connection := dmPedido.FDConnection;
    try
      qry.SQL.Text := Format('SELECT %s FROM %s WHERE codigo = :ID', [Descricao, Table]);
      qry.ParamByName('ID').AsInteger := ID;
      qry.Open;
      if qry.IsEmpty then
         Result := ''
      else
         Result := qry.FieldByName(Descricao).AsString;
    except
      on e: Exception do
      begin
         Vcl.Dialogs.MessageDlg('Erro na busca da descrição: ' + e.Message, mtError, [mbOk], 0, mbOk);
      end;
    end;
  finally
    qry.Free;
  end;
end;

procedure TfrmPedido.HabilitaBotoes;
begin
   btnNovo.Enabled := not cdsPedido.Active or (cdsPedido.State = dsBrowse);
   btnCancelar.Enabled := (cdsPedido.State in [dsInsert, dsEdit]);
   btnSair.Enabled := not cdsPedido.Active or (cdsPedido.State = dsBrowse);
   btnGravar.Enabled := (cdsPedido.State in [dsInsert, dsEdit]);
   edtPedido.Enabled :=  btnNovo.Enabled;
end;

procedure TfrmPedido.MostraComponentes;
begin
   pnlDados.Visible := not cdsPedido.IsEmpty or (cdsPedido.State in [dsInsert]);
   pnlItens.Visible := (Trim(cb_Cliente.Text)<>'');
   HabilitaBotoes;
end;

procedure TfrmPedido.SomenteNumero(Sender: TObject; var Key: Char);
begin
   if not (Key in ['0'..'9', #13]) then
    Key := #0;
end;

procedure TfrmPedido.InserirPedido;
var
  SQLInsertPedido: String;
begin
  SQLInsertPedido := 'INSERT INTO Pedido (DataEmissao, CodCliente, ValorTotal) ' +
                     'VALUES (:DataEmissao, :CodCliente, :ValorTotal)';

  FDQuery1.SQL.Text := SQLInsertPedido;
  FDQuery1.Params.ParamByName('DataEmissao').AsDateTime := cdsPedido.FieldByName('DataEmissao').AsDateTime;
  FDQuery1.Params.ParamByName('CodCliente').AsInteger := cdsPedido.FieldByName('CodCliente').AsInteger;
  FDQuery1.Params.ParamByName('ValorTotal').AsFloat := cdsPedido.FieldByName('ValorTotal').AsFloat;
  FDQuery1.ExecSQL;

  // Obter o ID do pedido inserido
  cdsPedido.Edit;
  cdsPedido.FieldByName('PedidoId').AsInteger := dmPedido.FDConnection.GetLastAutoGenValue('PedidoId');
  cdsPedido.Post;
  edtPedido.Text := IntToStr(cdsPedido.FieldByName('PedidoId').AsInteger);
end;

procedure TfrmPedido.InserirItensPedido;
var
  SQLInsertItens: String;
begin
  SQLInsertItens := 'INSERT INTO PedidoItens (PedidoId, ItemId, CodProduto, DescProduto, Quantidade, ValorUnitario, ValorTotal) ' +
                    'VALUES (:PedidoId, :ItemId, :CodProduto, :DescProduto, :Quantidade, :ValorUnitario, :ValorTotal)';

  cdsPedidoItens.First;
  while not cdsPedidoItens.Eof do
  begin
    FDQuery1.SQL.Text := SQLInsertItens;
    FDQuery1.Params.ParamByName('PedidoId').AsInteger := cdsPedido.FieldByName('PedidoId').AsInteger;
    FDQuery1.Params.ParamByName('ItemId').AsInteger := cdsPedidoItens.FieldByName('ItemId').AsInteger;
    FDQuery1.Params.ParamByName('CodProduto').AsString := cdsPedidoItens.FieldByName('CodProduto').AsString;
    FDQuery1.Params.ParamByName('DescProduto').AsString := cdsPedidoItens.FieldByName('DescProduto').AsString;
    FDQuery1.Params.ParamByName('Quantidade').AsInteger := cdsPedidoItens.FieldByName('Quantidade').AsInteger;
    FDQuery1.Params.ParamByName('ValorUnitario').AsFloat := cdsPedidoItens.FieldByName('ValorUnitario').AsFloat;
    FDQuery1.Params.ParamByName('ValorTotal').AsFloat := cdsPedidoItens.FieldByName('ValorTotal').AsFloat;
    FDQuery1.ExecSQL;

    cdsPedidoItens.Next;
  end;
end;
end.
