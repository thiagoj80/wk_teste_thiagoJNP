unit uDMPedido;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL, Vcl.Dialogs,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, IniFiles;

type
  TdmPedido = class(TDataModule)
    FDConnection: TFDConnection;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ConectarBanco;
  end;

var
  dmPedido: TdmPedido;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}


{ TdmPedido }

procedure TdmPedido.ConectarBanco;
var
  Ini: TIniFile;
  Server, Database, Username, Password: string;
  Port: Integer;
begin
  Ini := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'config.ini');
  try
    Server := Ini.ReadString('wk_teste', 'Server', 'localhost');
    Database := Ini.ReadString('wk_teste', 'Database', 'wk_teste');
    Username := Ini.ReadString('wk_teste', 'Username', 'root');
    Password := Ini.ReadString('wk_teste', 'Password', 'Masterkey@43');
    Port := Ini.ReadInteger('wk_teste', 'Port', 3306);

    FDConnection.Params.Clear;
    FDConnection.Params.Add('DriverID=MySQL');
    FDConnection.Params.Add('Server=' + Server);
    FDConnection.Params.Add('Database=' + Database);
    FDConnection.Params.Add('User_Name=' + Username);
    FDConnection.Params.Add('Password=' + Password);
    FDConnection.Params.Add('Port=' + IntToStr(Port));

    // Tenta conectar
    try
      FDConnection.Connected := True;
      Vcl.Dialogs.MessageDlg('Conexão bem sucedida.' , mtInformation, [mbOk], 0, mbOk);
    except
      on E: Exception do
        Vcl.Dialogs.MessageDlg('Erro ao conectar: ' + e.Message, mtError, [mbOk], 0, mbOk);
    end;

  finally
    Ini.Free;
  end;
end;

procedure TdmPedido.DataModuleCreate(Sender: TObject);
begin
   ConectarBanco;
end;

end.
