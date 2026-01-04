using CapaPresentacion.ServiceReferenceWCF;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CapaPresentacion
{
    public partial class UsuarioConsulta : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarUsuarios();
            }
        }

        private void CargarUsuarios()
        {
            try
            {
                using (UsuarioServiceClient cliente = new UsuarioServiceClient())
                {
                    var usuarios = cliente.Consultar();
                    gvUsuarios.DataSource = usuarios;
                    gvUsuarios.DataBind();
                }
            }
            catch (Exception ex)
            {
                MostrarMensaje($"Error al cargar usuarios: {ex.Message}", false);
            }
        }

        protected void btnNuevo_Click(object sender, EventArgs e)
        {
            Response.Redirect("Usuario.aspx");
        }

        protected void gvUsuarios_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "Modificar")
            {
                Response.Redirect($"Usuario.aspx?id={id}");
            }
            else if (e.CommandName == "Eliminar")
            {
                EliminarUsuario(id);
            }
        }

        private void EliminarUsuario(int id)
        {
            try
            {
                using (UsuarioServiceClient cliente = new UsuarioServiceClient())
                {
                    bool resultado = cliente.Eliminar(id);

                    if (resultado)
                    {
                        MostrarMensaje("Usuario eliminado correctamente", true);
                        CargarUsuarios();
                    }
                    else
                    {
                        MostrarMensaje("No se pudo eliminar el usuario", false);
                    }
                }
            }
            catch (Exception ex)
            {
                MostrarMensaje($"Error al eliminar usuario: {ex.Message}", false);
            }
        }

        private void MostrarMensaje(string mensaje, bool exito)
        {
            lblMensaje.Text = mensaje;
            lblMensaje.CssClass = exito ? "message success" : "message error";
            lblMensaje.Visible = true;
        }
    }
}