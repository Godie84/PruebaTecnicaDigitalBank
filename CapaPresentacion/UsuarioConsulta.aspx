<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UsuarioConsulta.aspx.cs" Inherits="CapaPresentacion.UsuarioConsulta" %>


<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Consulta de Usuarios</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 1000px;
            margin: 0 auto;
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        h2 {
            color: #333;
            margin-bottom: 20px;
        }
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            margin-bottom: 20px;
            text-decoration: none;
            display: inline-block;
        }
        .btn-primary {
            background-color: #007bff;
            color: white;
        }
        .btn-primary:hover {
            background-color: #0056b3;
        }
        .btn-danger {
            background-color: #dc3545;
            color: white;
        }
        .btn-danger:hover {
            background-color: #c82333;
        }
        .btn-warning {
            background-color: #ffc107;
            color: #212529;
        }
        .btn-warning:hover {
            background-color: #e0a800;
        }
        .btn-sm {
            padding: 5px 10px;
            font-size: 12px;
            margin-right: 5px;
        }
        .message {
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 4px;
        }
        .success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        .gridview {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        .gridview th {
            background-color: #007bff;
            color: white;
            padding: 12px;
            text-align: left;
            font-weight: bold;
        }
        .gridview td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }
        .gridview tr:hover {
            background-color: #f5f5f5;
        }
        .gridview tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        .no-data {
            text-align: center;
            padding: 20px;
            color: #666;
            font-style: italic;
        }
    </style>
    <script type="text/javascript">
        function confirmarEliminacion() {
            return confirm('¿Está seguro de que desea eliminar este usuario?');
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h2>Listado de Usuarios</h2>
            
            <asp:Button ID="btnNuevo" runat="server" Text="Nuevo Usuario" CssClass="btn btn-primary" 
                OnClick="btnNuevo_Click" />
            
            <asp:Label ID="lblMensaje" runat="server" CssClass="message" Visible="false"></asp:Label>
            
            <asp:GridView ID="gvUsuarios" runat="server" 
                AutoGenerateColumns="False"
                CssClass="gridview"
                OnRowCommand="gvUsuarios_RowCommand"
                DataKeyNames="Id"
                EmptyDataText="No hay usuarios registrados">
                
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="ID" />
                    <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
                    <asp:BoundField DataField="FechaNacimiento" HeaderText="Fecha de Nacimiento" DataFormatString="{0:dd/MM/yyyy}" />
                    <asp:TemplateField HeaderText="Sexo">
                        <ItemTemplate>
                            <%# Eval("Sexo").ToString() == "M" ? "Masculino" : "Femenino" %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Acciones">
                        <ItemTemplate>
                            <asp:Button ID="btnModificar" runat="server" 
                                Text="Modificar" 
                                CommandName="Modificar" 
                                CommandArgument='<%# Eval("Id") %>'
                                CssClass="btn btn-warning btn-sm" />
                            <asp:Button ID="btnEliminar" runat="server" 
                                Text="Eliminar" 
                                CommandName="Eliminar" 
                                CommandArgument='<%# Eval("Id") %>'
                                CssClass="btn btn-danger btn-sm"
                                OnClientClick="return confirmarEliminacion();" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>