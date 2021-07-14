<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="viewClientes.aspx.cs" Inherits="TesteTempus.viewClientes" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link rel="stylesheet" href="Content/bootstrap.css"/>
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/bs/dt-1.10.25/datatables.min.css"/>
 
</head>
<body style="background-color:lightcyan">
    <style>
        .badge{
            display:inline;
            color:white;
            border-radius:.25rem;
            vertical-align:baseline;
            text-align:center;
        }
        .classea{
            background-color:red;
        }
        .classeb{
            background-color:gold;
        }
        .classec{
            background-color:green;
        }
        .card{
            display:block;
            min-height:90px;
            width:100%;
            border-radius:2px;
            margin-bottom:15px;
        }
    </style>
    <script src="https://code.jquery.com/jquery-1.10.0.min.js"></script>
    <script src="Scripts/bootstrap.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/v/bs/dt-1.10.25/datatables.min.js"></script>
    <div class="container" style="background-color:white;padding-top:3rem;padding-bottom:3rem">
        <form id="form1" runat="server">
            <div style="padding-bottom:1rem">
                <asp:DropDownList runat="server" ID="ddlRange" AutoPostBack="true" CssClass="form-control" style="width:10%">
                    <asp:ListItem Value="Hoje">Hoje</asp:ListItem>
                    <asp:ListItem Value="Semana">Semana</asp:ListItem>
                    <asp:ListItem Value="Mes" Selected="True">Mês</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="row">
                <div class="col-md-3">
                    <div class="card" style="background-color:lightgrey">
                        <div style="padding-left:2rem;padding-right:2rem;padding-top:5px">
                            <span style="display:block">Clientes classe A</span>
                            <span style="display:block;font-weight:bold;font-size:x-large;color:red"><asp:Label runat="server" ID="cliA" Text=""></asp:Label></span>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card" style="background-color:lightgrey">
                        <div style="padding-left:2rem;padding-right:2rem;padding-top:5px">
                            <span style="display:block">Clientes classe B</span>
                            <span style="display:block;font-weight:bold;font-size:x-large;color:gold"><asp:Label runat="server" ID="cliB" Text=""></asp:Label></span>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card" style="background-color:lightgrey">
                        <div style="padding-left:2rem;padding-right:2rem;padding-top:5px">
                            <span style="display:block">Clientes classe C</span>
                            <span style="display:block;font-weight:bold;font-size:x-large;color:green"><asp:Label runat="server" ID="cliC" Text=""></asp:Label></span>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card" style="background-color:lightgrey">
                        <div style="padding-left:2rem;padding-right:2rem;padding-top:5px">
                            <span style="display:block;font-size:inherit">Clientes +18 com renda acima da média</span>
                            <span style="display:block;font-weight:bold;font-size:x-large;color:blue"><asp:Label runat="server" ID="rendaplus" Text=""></asp:Label></span>
                        </div>
                    </div>
                </div>
            </div>
            <div>
                <h2 style="font-weight:bold">Todos os clientes</h2>
                <asp:Repeater runat="server" ID="rptClientes" EnableViewState="true" OnItemDataBound="rptClientes_ItemDataBound">
                    <HeaderTemplate>
                        <table class="table table-hover table-striped table-responsive table-bordered" id="tbCliente" style="width:100%">
                            <thead>
                                <tr>
                                    <th style="display:none">ID Cliente</th>
                                    <th style="text-align:center">Nome</th>
                                    <th style="text-align:center">Renda</th>
                                </tr>
                            </thead>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td style="display:none">
                                <asp:Label runat="server" style="display:none" ID="lblIdCliente" Text='<%# Eval("ID_Cliente")%>'></asp:Label>
                            </td>
                            <td style="text-align:center">
                                <asp:Label runat="server" ID="lblNome" Text='<%# Eval("Nome")%>'></asp:Label>
                            </td>
                            <td style="text-align:center">
                                <div>
                                    <asp:HiddenField runat="server" ID="hidRenda" Value='<%# Eval("RendaFull")%>'/>
                                    <asp:Label runat="server" ID="lblRenda" Text='<%# Eval("Renda")%>'></asp:Label>
                                </div>
                            </td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>
            </div>
            <a class="btn btn-info" href="index.aspx">Voltar</a>
        </form>
    </div>
    <script>
        $(document).ready(function () {
            $('#tbCliente').dataTable({

                searching: true,
                "lengthChange": false,
                "scrollX": true,
                "scrollY": true,

                "dom": '<"card card-default"<"card-heading "<"row"<"col-sm-6 "l><"col-sm-6 text-right"f>>>t<"card-footer"<"row"<"col-md-6"i>>>>',
            })
        });
    </script>
</body>
</html>
