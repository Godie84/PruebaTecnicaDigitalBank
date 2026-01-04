<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UsuarioConsulta.aspx.cs" Inherits="CapaPresentacion.UsuarioConsulta" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Consulta de Usuarios</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- SweetAlert2 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <style>
        body {
            background-color: #f4f4f4;
        }
        .container-custom {
            max-width: 1000px;
            margin: 40px auto;
            background-color: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .gridview th {
            background-color: #007bff;
            color: white;
        }
        .gridview td, .gridview th {
            padding: 10px;
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
        <!-- ScriptManager necesario para que funcionen los scripts en postbacks -->
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

        <div class="container-custom">
            <h2 class="mb-4">Listado de Usuarios</h2>

            <asp:Button ID="btnNuevo" runat="server" Text="Nuevo Usuario" CssClass="btn btn-primary mb-3" 
                OnClick="btnNuevo_Click" />

            <!-- GridView con Bootstrap -->
            <asp:GridView ID="gvUsuarios" runat="server"
                AutoGenerateColumns="False"
                CssClass="table table-striped table-bordered gridview"
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
