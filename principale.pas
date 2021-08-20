unit principale;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.WinXCtrls,
  Vcl.StdCtrls, Vcl.BaseImageCollection, Vcl.ImageCollection, System.ImageList,
  Vcl.ImgList, Vcl.VirtualImageList, Vcl.VirtualImage, Vcl.Imaging.pngimage,
  Vcl.WinXPanels, WebView2, Winapi.ActiveX, Vcl.Edge, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, REST.Types, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, REST.Response.Adapter, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Langji.Wke.Webbrowser;

type
  TForm1 = class(TForm)
    SplitView1: TSplitView;
    VirtualImageList1: TVirtualImageList;
    ImageCollection1: TImageCollection;
    HeaderPanel: TPanel;
    MenuVirtualImage: TVirtualImage;
    Label1: TLabel;
    NavPanel: TPanel;
    Image5: TImage;
    ultimenews: TButton;
    Italia: TButton;
    Mondo: TButton;
    Affari: TButton;
    Tecnologia: TButton;
    CardPanel1: TCardPanel;
    Card1: TCard;
    Card2: TCard;
    Scienze: TButton;
    Button1: TButton;
    FDMemTable1: TFDMemTable;
    RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    RESTClient1: TRESTClient;
    ListBox1: TListBox;
    VirtualImage1: TVirtualImage;
    wb1: TWkeWebBrowser;
    procedure MenuVirtualImageClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure ultimenewsClick(Sender: TObject);
    procedure VirtualImage1Click(Sender: TObject);
    procedure ItaliaClick(Sender: TObject);
    procedure MondoClick(Sender: TObject);
    procedure AffariClick(Sender: TObject);
    procedure TecnologiaClick(Sender: TObject);
    procedure ScienzeClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure RESTRequest1HTTPProtocolError(Sender: TCustomRESTRequest);
  private
    { Private declarations }
    procedure scansionanotizie;
  public
    { Public declarations }
    procedure sceglinews(id: string);
  end;

var
  Form1: TForm1;
  parole: TArray<string>;
  scelta: string;

implementation

{$R *.dfm}
{$I servizijson.inc}

function StrdaArray(const testo: string;
  const ArrayOfString: TArray<String>): Boolean;
var
  parola: string;
begin
  for parola in ArrayOfString do
  begin
    if testo.Contains(parola) then
    begin
      Exit(True);
    end;
  end;
  result := False;
end;

procedure TForm1.AffariClick(Sender: TObject);
begin
  sceglinews(Af);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  sceglinews(Sp);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  parole := TArray<string>.Create('Covid', 'Green Pass', 'Coronavirus',
    'ricoveri', 'contagi', 'positivi', 'Vaccino', 'virologo', 'green pass',
    'vaccinarsi', 'vaccina', 'vaccini', 'Vaccini', 'Green pass');
//    wb1.BrowserExecutableFolder:='WebView2Loader_x64.dll';
end;

procedure TForm1.ItaliaClick(Sender: TObject);
begin
  sceglinews(It);
end;

procedure TForm1.ListBox1Click(Sender: TObject);
begin
  CardPanel1.ActiveCard := Card2;
  FDMemTable1.RecNo := ListBox1.ItemIndex + 1;
  wb1.LoadUrl(FDMemTable1.FieldByName('url').Value);
end;

procedure TForm1.MenuVirtualImageClick(Sender: TObject);
begin
  SplitView1.Opened := not SplitView1.Opened;
end;

procedure TForm1.MondoClick(Sender: TObject);
begin
  sceglinews(M);
end;

procedure TForm1.RESTRequest1HTTPProtocolError(Sender: TCustomRESTRequest);
begin
if (Sender.Response.StatusText='500') or (Sender.Response.StatusText='400')
then
ShowMessage('Errore lato server');
end;


procedure TForm1.scansionanotizie;
begin
  RESTClient1.BaseURL := scelta;
  try
    RESTRequest1.Execute;
  finally
    FDMemTable1.DisableControls;
    ListBox1.Items.Clear;
    FDMemTable1.First;
    with FDMemTable1 do
      for var x := 0 to RecordCount - 1 do
      begin
        if not StrdaArray(FieldByName('Title').Text, parole) then
        begin
          ListBox1.Items.Add(FDMemTable1.FieldByName('Title').AsString);
          Next;
        end
        else
        begin
          Delete;
        end;
      end
  end;
end;

procedure TForm1.sceglinews(id: string);
begin
  CardPanel1.ActiveCard := Card1;
  scelta := urlrss + id;
  scansionanotizie;
end;

procedure TForm1.ScienzeClick(Sender: TObject);
begin
  sceglinews(Sci);
end;

procedure TForm1.TecnologiaClick(Sender: TObject);
begin
  sceglinews(Tec);
end;

procedure TForm1.ultimenewsClick(Sender: TObject);
begin
  sceglinews(notizie);
end;

procedure TForm1.VirtualImage1Click(Sender: TObject);
begin
  CardPanel1.ActiveCard := Card1;
end;

end.
