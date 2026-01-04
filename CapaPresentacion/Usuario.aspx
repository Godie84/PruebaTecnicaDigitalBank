<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Usuario.aspx.cs" Inherits="CapaPresentacion.Usuario" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Registro de Usuario</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- SweetAlert2 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <style>
        body {
            background-color: #f4f4f4;
        }
        .container-custom {
            max-width: 500px;
            margin: 40px auto;
            background-color: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .validator {
            color: #dc3545;
            font-size: 12px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

        <div class="container-custom">
            <h2 class="mb-4">Registro de Usuario</h2>

            <div class="mb-3">
                <label for="txtNombre" class="form-label">Nombre:</label>
                <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" MaxLength="100"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvNombre" runat="server" 
                    ControlToValidate="txtNombre" 
                    ErrorMessage="El nombre es obligatorio" 
                    CssClass="validator"
                    Display="Dynamic">
                </asp:RequiredFieldValidator>
            </div>

            <div class="mb-3">
                <label for="txtFechaNacimiento" class="form-label">Fecha de Nacimiento:</label>
                <asp:TextBox ID="txtFechaNacimiento" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvFecha" runat="server" 
                    ControlToValidate="txtFechaNacimiento" 
                    ErrorMessage="La fecha de nacimiento es obligatoria" 
                    CssClass="validator"
                    Display="Dynamic">
                </asp:RequiredFieldValidator>
            </div>

            <div class="mb-3">
                <label for="ddlSexo" class="form-label">Sexo:</label>
                <asp:DropDownList ID="ddlSexo" runat="server" CssClass="form-select">
                    <asp:ListItem Value="">-- Seleccione --</asp:ListItem>
                    <asp:ListItem Value="M">Masculino</asp:ListItem>
                    <asp:ListItem Value="F">Femenino</asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvSexo" runat="server" 
                    ControlToValidate="ddlSexo" 
                    InitialValue=""
                    ErrorMessage="Debe seleccionar el sexo" 
                    CssClass="validator"
                    Display="Dynamic">
                </asp:RequiredFieldValidator>
            </div>

            <div class="d-flex gap-2">
                <asp:Button ID="btnGuardar" runat="server" Text="Guardar" CssClass="btn btn-primary" OnClick="btnGuardar_Click" />
                <asp:Button ID="btnConsultar" runat="server" Text="Ver Usuarios" CssClass="btn btn-secondary" 
                    OnClick="btnConsultar_Click" CausesValidation="false" />
            </div>
        </div>
    </form>
</body>
</html>
