VERSION 5.00
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Begin VB.Form Tela_FichaEstoque 
   AutoRedraw      =   -1  'True
   BorderStyle     =   4  'Fixed ToolWindow
   Caption         =   "Fichas de Estoque"
   ClientHeight    =   2670
   ClientLeft      =   30
   ClientTop       =   270
   ClientWidth     =   4335
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2670
   ScaleWidth      =   4335
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton BT_Cancelar 
      Caption         =   "&Voltar"
      Height          =   852
      Left            =   3480
      Picture         =   "Tela_FichaEstoque.frx":0000
      Style           =   1  'Graphical
      TabIndex        =   14
      ToolTipText     =   "Volta � edi��o da nota fiscal."
      Top             =   1560
      Width           =   732
   End
   Begin VB.Frame FR_1 
      Caption         =   "Pe�a:"
      Height          =   1332
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   4332
      Begin VB.CommandButton BT_AssitenteFigura 
         Caption         =   "Assistente &Figura"
         Height          =   972
         Left            =   3360
         Picture         =   "Tela_FichaEstoque.frx":0442
         Style           =   1  'Graphical
         TabIndex        =   5
         ToolTipText     =   "Assistente de Figuras de Estoque"
         Top             =   240
         Width           =   852
      End
      Begin VB.CommandButton BT_Procurar 
         Caption         =   "Pr&ocurar �tem"
         Height          =   972
         Left            =   2400
         Picture         =   "Tela_FichaEstoque.frx":074C
         Style           =   1  'Graphical
         TabIndex        =   4
         ToolTipText     =   "Procura este �tem no estoque"
         Top             =   240
         Width           =   852
      End
      Begin VB.ComboBox CB_Material 
         Height          =   288
         Left            =   840
         TabIndex        =   3
         ToolTipText     =   "Selecione um material"
         Top             =   960
         Width           =   1452
      End
      Begin VB.ComboBox CB_Bitola 
         Height          =   288
         Left            =   840
         TabIndex        =   2
         ToolTipText     =   "Sselecione uma bitola"
         Top             =   600
         Width           =   1452
      End
      Begin VB.ComboBox CB_Figura 
         Height          =   288
         Left            =   840
         Sorted          =   -1  'True
         TabIndex        =   1
         ToolTipText     =   "Selecione uma figura"
         Top             =   240
         Width           =   1452
      End
      Begin VB.Label LB_Material 
         AutoSize        =   -1  'True
         Caption         =   "Material:"
         Height          =   192
         Left            =   120
         TabIndex        =   8
         Top             =   960
         Width           =   612
      End
      Begin VB.Label LB_Bitola 
         AutoSize        =   -1  'True
         Caption         =   "Bitola:"
         Height          =   192
         Left            =   120
         TabIndex        =   7
         Top             =   600
         Width           =   444
      End
      Begin VB.Label LB_Figura 
         AutoSize        =   -1  'True
         Caption         =   "Figura:"
         Height          =   192
         Left            =   120
         TabIndex        =   6
         Top             =   240
         Width           =   492
      End
   End
   Begin VB.Frame FR_2 
      Caption         =   "Consultar por:"
      Height          =   1332
      Left            =   0
      TabIndex        =   9
      Top             =   1320
      Width           =   3372
      Begin VB.OptionButton RB_NF 
         Caption         =   "Por N.F.:"
         Height          =   252
         Left            =   120
         TabIndex        =   12
         Top             =   960
         Width           =   1332
      End
      Begin VB.OptionButton RB_Data 
         Caption         =   "Data - Desde:"
         Height          =   252
         Left            =   120
         TabIndex        =   11
         Top             =   600
         Width           =   1332
      End
      Begin VB.OptionButton RB_Todas 
         Caption         =   "Todas"
         Height          =   252
         Left            =   120
         TabIndex        =   10
         Top             =   240
         Width           =   1332
      End
      Begin MSMask.MaskEdBox TXT_NF 
         Height          =   252
         Left            =   1440
         TabIndex        =   15
         Top             =   960
         Width           =   972
         _ExtentX        =   1720
         _ExtentY        =   450
         _Version        =   393216
         Format          =   "dd/mm/99"
         PromptChar      =   "_"
      End
      Begin MSMask.MaskEdBox TXT_Data 
         Height          =   252
         Left            =   1440
         TabIndex        =   13
         Top             =   600
         Width           =   972
         _ExtentX        =   1720
         _ExtentY        =   450
         _Version        =   393216
         BackColor       =   -2147483633
         AllowPrompt     =   -1  'True
         AutoTab         =   -1  'True
         MaxLength       =   10
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Format          =   "dd/mm/yyyy"
         Mask            =   "99/99/9999"
         PromptChar      =   "_"
      End
   End
End
Attribute VB_Name = "Tela_FichaEstoque"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
' ****************** VARI�VEIS DLL's ****************
Dim DLL_BD As Scvbd.Classe_Scvbd
Dim DLL_CARGA As Scvcarr.Classe_Scvcarr
Public DLL_FUNCS As Scvfunc.Classe_Scvfunc
Dim DLL_ASFIG As Assfig.Classe_Assfig

' ****************** DECLARA��ES ****************
Const NOMEAPLIC As String = "Consulta � Fichas de Estoque"
Dim RespMsg
Dim I As Integer
Private Sub BT_AssitenteFigura_Click()
    On Error GoTo ERRO_SISCOVAL
    CB_Figura.Text = DLL_ASFIG.AssistenteFigura(App.ProductName, "Assfig", App.LegalCopyright)
    CB_Figura.SetFocus
ERRO_SISCOVAL: If Err Then If DLL_FUNCS.MensagemErro(DLL_FUNCS.PegaUsuario, DLL_FUNCS.PegaNomeComputador, Err.Number, Err.Description, Err.Source, NOMEAPLIC, Err.HelpFile, Err.HelpContext) = True Then Resume Next
End Sub
Private Sub BT_Cancelar_Click()
    On Error GoTo ERRO_SISCOVAL
    Unload Tela_FichaEstoque
ERRO_SISCOVAL: If Err Then If DLL_FUNCS.MensagemErro(DLL_FUNCS.PegaUsuario, DLL_FUNCS.PegaNomeComputador, Err.Number, Err.Description, Err.Source, NOMEAPLIC, Err.HelpFile, Err.HelpContext) = True Then Resume Next
End Sub
Private Sub BT_Procurar_Click()
    On Error GoTo ERRO_SISCOVAL
    If CB_Figura.Text = "" Then
        RespMsg = MsgBox("N�o foi selecionado uma figura para procura.", vbOKOnly, NOMEAPLIC)
        CB_Figura.SetFocus
        Exit Sub
    ElseIf CB_Bitola.Text = "" Then
        RespMsg = MsgBox("N�o foi selecionado uma bitola para procura.", vbOKOnly, NOMEAPLIC)
        CB_Bitola.SetFocus
        Exit Sub
    ElseIf CB_Material.Text = "" Then
        RespMsg = MsgBox("N�o foi selecionado um material para procura.", vbOKOnly, NOMEAPLIC)
        CB_Material.SetFocus
        Exit Sub
    ElseIf RB_Data.Value = True And TXT_Data.Text = "__/__/____" Then
        RespMsg = MsgBox("N�o foi selecionada uma data para procura.", vbOKOnly, NOMEAPLIC)
        TXT_Data.SetFocus
        Exit Sub
    ElseIf RB_NF.Value = True And TXT_NF.Text = "" Then
        RespMsg = MsgBox("N�o foi selecionado um n�mero de nota fiscal para procura.", vbOKOnly, NOMEAPLIC)
        TXT_NF.SetFocus
        Exit Sub
    End If
    'Procura pela ficha da Figura
    DLL_BD.BDSIS_TBEST.Seek "=", CB_Figura.Text, CB_Bitola.Text, CB_Material.Text
    If DLL_BD.BDSIS_TBEST.NoMatch Then
        RespMsg = MsgBox("Ocorreu algum problema na procura da ficha da figura.", vbOKOnly, NOMEAPLIC)
        Exit Sub
    Else
        Dim NovaConsulta As Tela_Ficha
        Set NovaConsulta = New Tela_Ficha
        NovaConsulta.Show vbModal
        
    End If
ERRO_SISCOVAL: If Err Then If DLL_FUNCS.MensagemErro(DLL_FUNCS.PegaUsuario, DLL_FUNCS.PegaNomeComputador, Err.Number, Err.Description, Err.Source, NOMEAPLIC, Err.HelpFile, Err.HelpContext) = True Then Resume Next
End Sub
Private Sub CB_Bitola_GotFocus()
    On Error GoTo ERRO_SISCOVAL
    If CB_Figura.Text = "" Then
        RespMsg = MsgBox("Selecione primeiro uma figura.", vbOKOnly, NOMEAPLIC)
        CB_Figura.SetFocus
    End If
    CB_Bitola.SelLength = Len(CB_Bitola.Text)
ERRO_SISCOVAL: If Err Then If DLL_FUNCS.MensagemErro(DLL_FUNCS.PegaUsuario, DLL_FUNCS.PegaNomeComputador, Err.Number, Err.Description, Err.Source, NOMEAPLIC, Err.HelpFile, Err.HelpContext) = True Then Resume Next
End Sub
Private Sub CB_Bitola_KeyPress(KeyAscii As Integer)
    On Error GoTo ERRO_SISCOVAL
    If KeyAscii = 13 And CB_Bitola.Text <> "" Then CB_Material.SetFocus
ERRO_SISCOVAL: If Err Then If DLL_FUNCS.MensagemErro(DLL_FUNCS.PegaUsuario, DLL_FUNCS.PegaNomeComputador, Err.Number, Err.Description, Err.Source, NOMEAPLIC, Err.HelpFile, Err.HelpContext) = True Then Resume Next
End Sub
Private Sub CB_Bitola_LostFocus()
    On Error GoTo ERRO_SISCOVAL
    CB_Bitola.Text = UCase(CB_Bitola.Text)
    If CB_Bitola.Text <> "" Then
        For I = 0 To CB_Bitola.ListCount - 1
            If CB_Bitola.Text = CB_Bitola.List(I) Then
                Exit For
            ElseIf CB_Bitola.Text <> CB_Bitola.List(I) And I = CB_Bitola.ListCount - 1 Then
                RespMsg = MsgBox("Essa bitola digitada n�o existe - consulte esta lista.", vbOKOnly, NOMEAPLIC)
                CB_Bitola.SetFocus
                Exit Sub
            End If
        Next I
    End If
ERRO_SISCOVAL: If Err Then If DLL_FUNCS.MensagemErro(DLL_FUNCS.PegaUsuario, DLL_FUNCS.PegaNomeComputador, Err.Number, Err.Description, Err.Source, NOMEAPLIC, Err.HelpFile, Err.HelpContext) = True Then Resume Next
End Sub
Private Sub CB_Figura_GotFocus()
    On Error GoTo ERRO_SISCOVAL
    CB_Figura.SelLength = Len(CB_Figura.Text)
    Dim X As String
    X = CB_Figura.Text
    CB_Material.Text = ""
    CB_Bitola.Text = ""
    BT_Procurar.Enabled = False
    CB_Bitola.Clear
    CB_Material.Clear
    CB_Figura.Text = X
ERRO_SISCOVAL: If Err Then If DLL_FUNCS.MensagemErro(DLL_FUNCS.PegaUsuario, DLL_FUNCS.PegaNomeComputador, Err.Number, Err.Description, Err.Source, NOMEAPLIC, Err.HelpFile, Err.HelpContext) = True Then Resume Next
End Sub
Private Sub CB_Figura_KeyPress(KeyAscii As Integer)
    On Error GoTo ERRO_SISCOVAL
    If KeyAscii = 13 And CB_Figura.Text <> "" Then CB_Bitola.SetFocus
ERRO_SISCOVAL: If Err Then If DLL_FUNCS.MensagemErro(DLL_FUNCS.PegaUsuario, DLL_FUNCS.PegaNomeComputador, Err.Number, Err.Description, Err.Source, NOMEAPLIC, Err.HelpFile, Err.HelpContext) = True Then Resume Next
End Sub
Private Sub CB_Figura_LostFocus()
    On Error GoTo ERRO_SISCOVAL
    If CB_Figura.Text = "" Then Exit Sub
    CB_Figura.Text = UCase(CB_Figura.Text)
    For I = 0 To CB_Figura.ListCount - 1
        If CB_Figura.Text = CB_Figura.List(I) Then
            Exit For
        ElseIf CB_Figura.Text <> CB_Figura.List(I) And I = CB_Figura.ListCount - 1 Then
            RespMsg = MsgBox("Essa figura digitada n�o existe - consulte esta lista.", vbOKOnly, NOMEAPLIC)
            CB_Figura.SetFocus
            Exit Sub
        End If
    Next I
    'procura figura
    DLL_BD.BDSIS_TBEFG.Seek "=", CB_Figura.Text
    If DLL_BD.BDSIS_TBEFG.NoMatch Then
        RespMsg = MsgBox("Ocorreu algum erro durante a procura do �ndice da figura.", vbOKOnly, NOMEAPLIC)
        Exit Sub
    End If
    Dim cProc As String
    cProc = DLL_BD.BDSIS_TBEFG_CPIFG.Value
    'procura indice de figura
    DLL_BD.BDSIS_TBEID.Seek "=", cProc
    If DLL_BD.BDSIS_TBEID.NoMatch Then
        RespMsg = MsgBox("Ocorreu algum erro durante a procura da figura.", vbOKOnly, NOMEAPLIC)
        Exit Sub
    End If
    CB_Bitola.Clear
    CB_Material.Clear
    Dim cA As String
    'Montando lista de bitolas
    cA = ""
    For I = 1 To Len(DLL_BD.BDSIS_TBEID_CPGMA.Value)
        If Mid(DLL_BD.BDSIS_TBEID_CPGMA.Value, I, 1) <> ";" Then
            cA = cA & Mid(DLL_BD.BDSIS_TBEID_CPGMA.Value, I, 1)
        ElseIf Mid(DLL_BD.BDSIS_TBEID_CPGMA.Value, I, 1) = ";" Then
            CB_Material.AddItem (DLL_FUNCS.ProcuraGrupo(cA))
            cA = ""
        End If
    Next I
    CB_Material.AddItem (DLL_FUNCS.ProcuraGrupo(cA))
    'Montando lista de materiais
    cA = ""
    For I = 1 To Len(DLL_BD.BDSIS_TBEID_CPGBI.Value)
        If Mid(DLL_BD.BDSIS_TBEID_CPGBI.Value, I, 1) <> ";" Then
            cA = cA & Mid(DLL_BD.BDSIS_TBEID_CPGBI.Value, I, 1)
        ElseIf Mid(DLL_BD.BDSIS_TBEID_CPGBI.Value, I, 1) = ";" Then
            CB_Bitola.AddItem (DLL_FUNCS.ProcuraGrupo(cA))
            cA = ""
        End If
    Next I
    CB_Bitola.AddItem (DLL_FUNCS.ProcuraGrupo(cA))
    'seleciona material A-105
    CB_Material.ListIndex = 0
ERRO_SISCOVAL: If Err Then If DLL_FUNCS.MensagemErro(DLL_FUNCS.PegaUsuario, DLL_FUNCS.PegaNomeComputador, Err.Number, Err.Description, Err.Source, NOMEAPLIC, Err.HelpFile, Err.HelpContext) = True Then Resume Next
End Sub
Private Sub CB_Material_Change()
    On Error GoTo ERRO_SISCOVAL
    If CB_Material.Text = "" Then
        BT_Procurar.Enabled = False
    Else
        BT_Procurar.Enabled = True
    End If
    CB_Material.SelLength = Len(CB_Material.Text)
ERRO_SISCOVAL: If Err Then If DLL_FUNCS.MensagemErro(DLL_FUNCS.PegaUsuario, DLL_FUNCS.PegaNomeComputador, Err.Number, Err.Description, Err.Source, NOMEAPLIC, Err.HelpFile, Err.HelpContext) = True Then Resume Next
End Sub
Private Sub CB_Material_Click()
    On Error GoTo ERRO_SISCOVAL
    BT_Procurar.Enabled = True
ERRO_SISCOVAL: If Err Then If DLL_FUNCS.MensagemErro(DLL_FUNCS.PegaUsuario, DLL_FUNCS.PegaNomeComputador, Err.Number, Err.Description, Err.Source, NOMEAPLIC, Err.HelpFile, Err.HelpContext) = True Then Resume Next
End Sub
Private Sub CB_Material_GotFocus()
    On Error GoTo ERRO_SISCOVAL
    If CB_Figura.Text = "" Then
        RespMsg = MsgBox("Selecione primeiro uma figura.", vbOKOnly, NOMEAPLIC)
        CB_Figura.SetFocus
        Exit Sub
    ElseIf CB_Bitola.Text = "" Then
        RespMsg = MsgBox("Selecione primeiro uma bitola.", vbOKOnly, NOMEAPLIC)
        CB_Bitola.SetFocus
        Exit Sub
    End If
ERRO_SISCOVAL: If Err Then If DLL_FUNCS.MensagemErro(DLL_FUNCS.PegaUsuario, DLL_FUNCS.PegaNomeComputador, Err.Number, Err.Description, Err.Source, NOMEAPLIC, Err.HelpFile, Err.HelpContext) = True Then Resume Next
End Sub
Private Sub CB_Material_KeyPress(KeyAscii As Integer)
    On Error GoTo ERRO_SISCOVAL
    If KeyAscii = 13 And CB_Material.Text <> "" Then
        BT_Procurar.Enabled = True
        BT_Procurar.SetFocus
    End If
ERRO_SISCOVAL: If Err Then If DLL_FUNCS.MensagemErro(DLL_FUNCS.PegaUsuario, DLL_FUNCS.PegaNomeComputador, Err.Number, Err.Description, Err.Source, NOMEAPLIC, Err.HelpFile, Err.HelpContext) = True Then Resume Next
End Sub
Private Sub CB_Material_LostFocus()
    On Error GoTo ERRO_SISCOVAL
    CB_Material.Text = UCase(CB_Material.Text)
    If CB_Material.Text <> "" Then
        For I = 0 To CB_Material.ListCount - 1
            If CB_Material.Text = CB_Material.List(I) Then
                Exit For
            ElseIf CB_Material.Text <> CB_Material.List(I) And I = CB_Material.ListCount - 1 Then
                RespMsg = MsgBox("Esse material digitado n�o existe - consulte esta lista.", vbOKOnly, NOMEAPLIC)
                CB_Material.SetFocus
                Exit Sub
            End If
        Next I
    End If
ERRO_SISCOVAL: If Err Then If DLL_FUNCS.MensagemErro(DLL_FUNCS.PegaUsuario, DLL_FUNCS.PegaNomeComputador, Err.Number, Err.Description, Err.Source, NOMEAPLIC, Err.HelpFile, Err.HelpContext) = True Then Resume Next
End Sub
Private Sub Form_Load()
    On Error GoTo ERRO_SISCOVAL
    'Abre Classes DLL's
    Set DLL_BD = New Scvbd.Classe_Scvbd
    Set DLL_CARGA = New Scvcarr.Classe_Scvcarr
    Set DLL_FUNCS = New Scvfunc.Classe_Scvfunc
    Set DLL_ASFIG = New Assfig.Classe_Assfig
    
    DLL_CARGA.Exibe (True)
    DLL_CARGA.Max (11)
    DLL_CARGA.ResetaBP
    
    'Abre bancos de dados
    DLL_CARGA.CarregaTexto ("Abrindo banco de dados...")
    If DLL_BD.AbreBD(App.ProductName, "Scvbd", App.LegalCopyright) = False Then GoTo ERRO_ACESSO_BANCODADOS
    'Abrindo Tabelas
    DLL_CARGA.CarregaTexto ("Abrindo tabela Grupos...")
    If DLL_BD.AbreTabela_Grupos(App.ProductName, "Scvbd", App.LegalCopyright) = False Then GoTo ERRO_ACESSO_BANCODADOS
    DLL_CARGA.CarregaTexto ("Abrindo tabela Estoque...")
    If DLL_BD.AbreTabela_Estoque(App.ProductName, "Scvbd", App.LegalCopyright) = False Then GoTo ERRO_ACESSO_BANCODADOS
    DLL_CARGA.CarregaTexto ("Abrindo tabela Estoque - �ndice...")
    If DLL_BD.AbreTabela_EstoqueIndice(App.ProductName, "Scvbd", App.LegalCopyright) = False Then GoTo ERRO_ACESSO_BANCODADOS
    DLL_CARGA.CarregaTexto ("Abrindo tabela Estoque - Figuras...")
    If DLL_BD.AbreTabela_EstoqueFiguras(App.ProductName, "Scvbd", App.LegalCopyright) = False Then GoTo ERRO_ACESSO_BANCODADOS
    'Abre Campos
    DLL_CARGA.CarregaTexto ("Abrindo campos da tabela Grupos...")
    If DLL_BD.AbreCampos_Grupos(App.ProductName, "Scvbd", App.LegalCopyright) = False Then GoTo ERRO_ACESSO_BANCODADOS
    DLL_CARGA.CarregaTexto ("Abrindo campos da tabela Estoque...")
    If DLL_BD.AbreCampos_Estoque(App.ProductName, "Scvbd", App.LegalCopyright) = False Then GoTo ERRO_ACESSO_BANCODADOS
    DLL_CARGA.CarregaTexto ("Abrindo campos da tabela Estoque - �ndice...")
    If DLL_BD.AbreCampos_EstoqueIndice(App.ProductName, "Scvbd", App.LegalCopyright) = False Then GoTo ERRO_ACESSO_BANCODADOS
    DLL_CARGA.CarregaTexto ("Abrindo campos da tabela Estoque - Figuras...")
    If DLL_BD.AbreCampos_EstoqueFiguras(App.ProductName, "Scvbd", App.LegalCopyright) = False Then GoTo ERRO_ACESSO_BANCODADOS
    
    'Carrega lista de figuras
    CB_Figura.Clear
    DLL_CARGA.CarregaTexto ("Carregando lista de figuras...")
    If DLL_BD.BDSIS_TBEFG.RecordCount > 0 Then
        DLL_BD.BDSIS_TBEFG.MoveFirst
        While Not DLL_BD.BDSIS_TBEFG.EOF
            If DLL_BD.BDSIS_TBEFG_CPFIG.Value <> "" Then
                CB_Figura.AddItem (DLL_BD.BDSIS_TBEFG_CPFIG.Value)
            End If
            DLL_BD.BDSIS_TBEFG.MoveNext
        Wend
    End If
    
    TXT_Data.Text = "__/__/____"
    RB_Todas.Value = True
    DLL_FUNCS.RegistraEvento "Abrir Fichas de Estoque", ""
    DLL_CARGA.CarregaTexto ("Finalizando")
    DLL_CARGA.Exibe (False)
    Exit Sub
ERRO_ACESSO_BANCODADOS:
    RespMsg = MsgBox("Ocorreu algum erro durante o acesso ao banco de dados.", vbCritical + vbOKOnly, "Erro de abertura")
    DLL_CARGA.Exibe (False)
    Unload Tela_FichaEstoque
ERRO_SISCOVAL: If Err Then If DLL_FUNCS.MensagemErro(DLL_FUNCS.PegaUsuario, DLL_FUNCS.PegaNomeComputador, Err.Number, Err.Description, Err.Source, NOMEAPLIC, Err.HelpFile, Err.HelpContext) = True Then Resume Next
End Sub
Private Sub Form_Unload(Cancel As Integer)
    On Error GoTo ERRO_SISCOVAL
    'Fecha tabelas
    If DLL_BD.FechaTabela_Grupos(App.ProductName, "Scvbd", App.LegalCopyright) = False Then Beep
    If DLL_BD.FechaTabela_Estoque(App.ProductName, "Scvbd", App.LegalCopyright) = False Then Beep
    If DLL_BD.FechaTabela_EstoqueIndice(App.ProductName, "Scvbd", App.LegalCopyright) = False Then Beep
    If DLL_BD.FechaTabela_EstoqueFiguras(App.ProductName, "Scvbd", App.LegalCopyright) = False Then Beep
    'Fecha banco de dados
    If DLL_BD.FechaBD(App.ProductName, "Scvbd", App.LegalCopyright) = False Then Beep
    'Fecha classes de DLL's
    Set DLL_BD = Nothing
    Set DLL_CARGA = Nothing
    Set DLL_FUNCS = Nothing
    Set DLL_ASFIG = Nothing
ERRO_SISCOVAL: If Err Then If DLL_FUNCS.MensagemErro(DLL_FUNCS.PegaUsuario, DLL_FUNCS.PegaNomeComputador, Err.Number, Err.Description, Err.Source, NOMEAPLIC, Err.HelpFile, Err.HelpContext) = True Then Resume Next
End Sub


' ********************** FUN�OES ***********************
Private Sub RB_Data_Click()
    On Error GoTo ERRO_SISCOVAL
    RB_Todas.Value = False
    RB_Data.Value = True
    RB_NF.Value = False
    TXT_Data.Enabled = True
    TXT_NF.Enabled = False
ERRO_SISCOVAL: If Err Then If DLL_FUNCS.MensagemErro(DLL_FUNCS.PegaUsuario, DLL_FUNCS.PegaNomeComputador, Err.Number, Err.Description, Err.Source, NOMEAPLIC, Err.HelpFile, Err.HelpContext) = True Then Resume Next
End Sub
Private Sub RB_NF_Click()
    On Error GoTo ERRO_SISCOVAL
    RB_Todas.Value = False
    RB_Data.Value = False
    RB_NF.Value = True
    TXT_Data.Enabled = False
    TXT_NF.Enabled = True
ERRO_SISCOVAL: If Err Then If DLL_FUNCS.MensagemErro(DLL_FUNCS.PegaUsuario, DLL_FUNCS.PegaNomeComputador, Err.Number, Err.Description, Err.Source, NOMEAPLIC, Err.HelpFile, Err.HelpContext) = True Then Resume Next
End Sub
Private Sub RB_Todas_Click()
    On Error GoTo ERRO_SISCOVAL
    RB_Todas.Value = True
    RB_Data.Value = False
    RB_NF.Value = False
    TXT_Data.Enabled = False
    TXT_NF.Enabled = False
ERRO_SISCOVAL: If Err Then If DLL_FUNCS.MensagemErro(DLL_FUNCS.PegaUsuario, DLL_FUNCS.PegaNomeComputador, Err.Number, Err.Description, Err.Source, NOMEAPLIC, Err.HelpFile, Err.HelpContext) = True Then Resume Next
End Sub
Private Sub TXT_Data_LostFocus()
    On Error GoTo ERRO_SISCOVAL
    TXT_Data.Text = Format(TXT_Data.Text, "dd/mm/yyyy")
ERRO_SISCOVAL: If Err Then If DLL_FUNCS.MensagemErro(DLL_FUNCS.PegaUsuario, DLL_FUNCS.PegaNomeComputador, Err.Number, Err.Description, Err.Source, NOMEAPLIC, Err.HelpFile, Err.HelpContext) = True Then Resume Next
End Sub
