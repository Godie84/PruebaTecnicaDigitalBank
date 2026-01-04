using CapaDatos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;

namespace ServicioWCF
{
    public class UsuarioService : IUsuarioService
    {
        private UsuarioDAL usuarioDAL;

        public UsuarioService()
        {
            usuarioDAL = new UsuarioDAL();
        }

        public int Agregar(UsuarioDTO usuario)
        {
            try
            {
                Usuario usuarioEntidad = new Usuario
                {
                    Nombre = usuario.Nombre,
                    FechaNacimiento = usuario.FechaNacimiento,
                    Sexo = usuario.Sexo
                };

                return usuarioDAL.Agregar(usuarioEntidad);
            }
            catch (Exception ex)
            {
                throw new FaultException($"Error al agregar usuario: {ex.Message}");
            }
        }

        public bool Modificar(UsuarioDTO usuario)
        {
            try
            {
                Usuario usuarioEntidad = new Usuario
                {
                    Id = usuario.Id,
                    Nombre = usuario.Nombre,
                    FechaNacimiento = usuario.FechaNacimiento,
                    Sexo = usuario.Sexo
                };

                return usuarioDAL.Modificar(usuarioEntidad);
            }
            catch (Exception ex)
            {
                throw new FaultException($"Error al modificar usuario: {ex.Message}");
            }
        }

        public List<UsuarioDTO> Consultar()
        {
            try
            {
                List<Usuario> usuarios = usuarioDAL.Consultar();
                return usuarios.Select(u => new UsuarioDTO
                {
                    Id = u.Id,
                    Nombre = u.Nombre,
                    FechaNacimiento = u.FechaNacimiento,
                    Sexo = u.Sexo
                }).ToList();
            }
            catch (Exception ex)
            {
                throw new FaultException($"Error al consultar usuarios: {ex.Message}");
            }
        }

        public UsuarioDTO ConsultarPorId(int id)
        {
            try
            {
                Usuario usuario = usuarioDAL.ConsultarPorId(id);
                if (usuario != null)
                {
                    return new UsuarioDTO
                    {
                        Id = usuario.Id,
                        Nombre = usuario.Nombre,
                        FechaNacimiento = usuario.FechaNacimiento,
                        Sexo = usuario.Sexo
                    };
                }
                return null;
            }
            catch (Exception ex)
            {
                throw new FaultException($"Error al consultar usuario: {ex.Message}");
            }
        }

        public bool Eliminar(int id)
        {
            try
            {
                return usuarioDAL.Eliminar(id);
            }
            catch (Exception ex)
            {
                throw new FaultException($"Error al eliminar usuario: {ex.Message}");
            }
        }
    }
}