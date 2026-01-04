using CapaPresentacion.ServiceReferenceWCF;
using System;
using System.Web.UI;

namespace CapaPresentacion
{
    public partial class Usuario : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["id"] != null)
                {
                    int id = Convert.ToInt32(Request.QueryString["id"]);
                    CargarUsuario(id);
                    btnGuardar.Text = "Actualizar";
                }
            }
        }

        private void CargarUsuario(int id)
        {
            try
            {
                using (UsuarioServiceClient cliente = new UsuarioServiceClient())
                {
                    var usuario = cliente.ConsultarPorId(id);
                    if (usuario != null)
                    {
                        txtNombre.Text = usuario.Nombre;
                        txtFechaNacimiento.Text = usuario.FechaNacimiento.ToString("yyyy-MM-dd");
                        ddlSexo.SelectedValue = usuario.Sexo;
                        ViewState["UsuarioId"] = id;
                    }
                }
            }
            catch (Exception ex)
            {
                MostrarAlerta($"Error al cargar usuario: {ex.Message}", "error");
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    using (UsuarioServiceClient cliente = new UsuarioServiceClient())
                    {
                        UsuarioDTO usuario = new UsuarioDTO
                        {
                            Nombre = txtNombre.Text.Trim(),
                            FechaNacimiento = Convert.ToDateTime(txtFechaNacimiento.Text),
                            Sexo = ddlSexo.SelectedValue
                        };

                        bool resultado;
                        string mensaje;

                        if (ViewState["UsuarioId"] != null)
                        {
                            usuario.Id = Convert.ToInt32(ViewState["UsuarioId"]);
                            resultado = cliente.Modificar(usuario);
                            mensaje = resultado ? "Usuario actualizado correctamente" : "Error al actualizar usuario";
                        }
                        else
                        {
                            int id = cliente.Agregar(usuario);
                            resultado = id > 0;
                            mensaje = resultado ? "Usuario registrado correctamente" : "Error al registrar usuario";
                        }

                        MostrarAlerta(mensaje, resultado ? "success" : "error");

                        if (resultado)
                            LimpiarFormulario();
                    }
                }
                catch (Exception ex)
                {
                    MostrarAlerta($"Error: {ex.Message}", "error");
                }
            }
        }

        protected void btnConsultar_Click(object sender, EventArgs e)
        {
            Response.Redirect("UsuarioConsulta.aspx");
        }

        private void LimpiarFormulario()
        {
            txtNombre.Text = string.Empty;
            txtFechaNacimiento.Text = string.Empty;
            ddlSexo.SelectedIndex = 0;
            ViewState["UsuarioId"] = null;
            btnGuardar.Text = "Guardar";
        }

        private void MostrarAlerta(string mensaje, string tipo)
        {
            string script = $"Swal.fire({{ text: '{mensaje}', icon: '{tipo}', confirmButtonText: 'Aceptar' }});";
            ScriptManager.RegisterStartupScript(this, this.GetType(), Guid.NewGuid().ToString(), script, true);
        }
    }
}
