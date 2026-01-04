using CapaPresentacion.ServiceReferenceWCF;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CapaPresentacion
{
    public partial class Usuario : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Verificar si hay un ID en QueryString para edición
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
                    UsuarioDTO usuario = cliente.ConsultarPorId(id);

                    if (usuario != null)
                    {
                        txtNombre.Text = usuario.Nombre;
                        txtFechaNacimiento.Text = usuario.FechaNacimiento.ToString("yyyy-MM-dd");
                        ddlSexo.SelectedValue = usuario.Sexo;

                        // Guardar el ID en ViewState para la actualización
                        ViewState["UsuarioId"] = id;
                    }
                }
            }
            catch (Exception ex)
            {
                MostrarMensaje($"Error al cargar usuario: {ex.Message}", false);
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

                        // Verificar si es actualización o inserción
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

                        MostrarMensaje(mensaje, resultado);

                        if (resultado)
                        {
                            LimpiarFormulario();
                        }
                    }
                }
                catch (Exception ex)
                {
                    MostrarMensaje($"Error: {ex.Message}", false);
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

        private void MostrarMensaje(string mensaje, bool exito)
        {
            lblMensaje.Text = mensaje;
            lblMensaje.CssClass = exito ? "message success" : "message error";
            lblMensaje.Visible = true;
        }
    }
}