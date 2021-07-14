<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="TesteTempus.index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link rel="stylesheet" href="Content/bootstrap.css"/>
</head>
<body style="background-color:lightcyan">
    <script src="https://code.jquery.com/jquery-1.10.0.min.js"></script>
    <script src="https://rawgit.com/RobinHerbots/Inputmask/3.x/dist/jquery.inputmask.bundle.js"></script>
    <script src="Scripts/bootstrap.js"></script>
    <div class="container">
        <form id="form1" runat="server" class="well form-horizontal" style="background-color:lightblue">
            <fieldset>
                <legend><center><h2>Cadastro de cliente</h2></center></legend>

                <div class="form-group">
                    <label class="col-md-4 control-label">Nome completo</label>  
                    <div class="col-md-4 inputGroupContainer">
                        <div class="input-group">
                            <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                            <input type="text" class="form-control" maxlength="150" required="required" id="txtNome" runat="server" placeholder="Nome"/>
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-md-4 control-label">CPF</label>  
                    <div class="col-md-4 inputGroupContainer">
                        <div class="input-group">
                            <span class="input-group-addon"><i class="glyphicon glyphicon-asterisk"></i></span>
                            <input type="text" class="form-control" id="txtCpf" maxlength="14" placeholder="CPF" runat="server" onkeyup="cpfCheck(this)" required="required"/>
                        </div>
                        <span id="cpfResponse" runat="server"></span>
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-md-4 control-label">Data de nascimento</label>  
                    <div class="col-md-4 inputGroupContainer">
                        <div class="input-group">
                            <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                            <input type="date" class="form-control" required="required" runat="server" id="dataNasc"/>
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-md-4 control-label">Renda</label>  
                    <div class="col-md-4 inputGroupContainer">
                        <div class="input-group">
                            <span class="input-group-addon"><i class="glyphicon glyphicon-usd"></i></span>
                            <input type="number" class="form-control" min="0" runat="server" step="0.01" id="numRenda"/>
                        </div>
                    </div>
                </div>
                
                <div style="text-align:center"> 
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Cadastrar" ID="btnCadCliente" OnClick="btnCadCliente_Click"/>
                </div>
                
            </fieldset>
        </form>
        <div class="well" style="text-align:center;background-color:lightblue">
            <a class="btn btn-info" href="viewClientes.aspx">Lista de clientes</a>
        </div>
    </div>

    <script type="text/javascript">
        $("input[id*='txtCpf']").inputmask({
            mask: ['999.999.999-99'],
            keepStatic: true
        });

        function is_cpf(c) {

            if ((c = c.replace(/[^\d]/g, "")).length != 11)
                return false

            if (c == "00000000000")
                return false;

            var r;
            var s = 0;

            for (i = 1; i <= 9; i++)
                s = s + parseInt(c[i - 1]) * (11 - i);

            r = (s * 10) % 11;

            if ((r == 10) || (r == 11))
                r = 0;

            if (r != parseInt(c[9]))
                return false;

            s = 0;

            for (i = 1; i <= 10; i++)
                s = s + parseInt(c[i - 1]) * (12 - i);

            r = (s * 10) % 11;

            if ((r == 10) || (r == 11))
                r = 0;

            if (r != parseInt(c[10]))
                return false;

            return true;
        }



        cpfCheck = function (el) {
            document.getElementById('cpfResponse').innerHTML = is_cpf(el.value) ? '<span style="color:green">válido</span>' : '<span style="color:red">inválido</span>';
            if (el.value == '') document.getElementById('cpfResponse').innerHTML = '';
        }

        var today = new Date();
        var dd = today.getDate();
        var mm = today.getMonth() + 1;
        var yyyy = today.getFullYear();
        if (dd < 10) {
            dd = '0' + dd
        }
        if (mm < 10) {
            mm = '0' + mm
        }
        today = yyyy + '-' + mm + '-' + dd;
        document.getElementById("dataNasc").setAttribute("max", today);
    </script>
</body>
</html>
