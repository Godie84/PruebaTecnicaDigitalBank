using CapaPresentacion.ServiceReferenceWCF;
using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CapaPresentacion
{
    public partial class UsuarioConsulta : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                CargarUsuarios();
        }

        private void CargarUsuarios()
        {
            try
            {
                using (UsuarioServiceClient cliente = new UsuarioServiceClient())
                {
                    gvUsuarios.DataSource = cliente.Consultar();
                    gvUsuarios.DataBind();
                }
            }
            catch (Exception ex)
            {
                MostrarAlerta($"Error al cargar usuarios: {ex.Message}", "error");
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
                Response.Redirect($"Usuario.aspx?id={id}");
            else if (e.CommandName == "Eliminar")
                EliminarUsuario(id);
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
                        MostrarAlerta("Usuario eliminado correctamente", "success");
                        CargarUsuarios();
                    }
                    else
                        MostrarAlerta("No se pudo eliminar el usuario", "error");
                }
            }
            catch (Exception ex)
            {
                MostrarAlerta($"Error al eliminar usuario: {ex.Message}", "error");
            }
        }

        // Método para mostrar SweetAlert2
        private void MostrarAlerta(string mensaje, string tipo)
        {
            string script = $"Swal.fire({{ text: '{mensaje}', icon: '{tipo}', confirmButtonText: 'Aceptar' }});";
            ScriptManager.RegisterStartupScript(this, this.GetType(), Guid.NewGuid().ToString(), script, true);
        }
    }
}
