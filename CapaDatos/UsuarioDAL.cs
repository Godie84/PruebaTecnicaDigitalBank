using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace CapaDatos
{
    public class UsuarioDAL
    {
        private readonly string connectionString;

        public UsuarioDAL()
        {
            connectionString = ConfigurationManager.ConnectionStrings["PruebaTecnicaDB"].ConnectionString;
        }

        /// <summary>
        /// Agrega un nuevo usuario a la base de datos
        /// </summary>
        public int Agregar(Usuario usuario)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_Usuario_Insertar", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@Nombre", usuario.Nombre);
                        cmd.Parameters.AddWithValue("@FechaNacimiento", usuario.FechaNacimiento);
                        cmd.Parameters.AddWithValue("@Sexo", usuario.Sexo);

                        conn.Open();
                        int id = Convert.ToInt32(cmd.ExecuteScalar());
                        return id;
                    }
                }
            }
            catch (SqlException ex)
            {
                throw new Exception($"Error al agregar usuario en la base de datos: {ex.Message}", ex);
            }
        }

        /// <summary>
        /// Modifica un usuario existente
        /// </summary>
        public bool Modificar(Usuario usuario)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_Usuario_Modificar", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@Id", usuario.Id);
                        cmd.Parameters.AddWithValue("@Nombre", usuario.Nombre);
                        cmd.Parameters.AddWithValue("@FechaNacimiento", usuario.FechaNacimiento);
                        cmd.Parameters.AddWithValue("@Sexo", usuario.Sexo);

                        conn.Open();
                        int filasAfectadas = Convert.ToInt32(cmd.ExecuteScalar());
                        return filasAfectadas > 0;
                    }
                }
            }
            catch (SqlException ex)
            {
                throw new Exception($"Error al modificar usuario en la base de datos: {ex.Message}", ex);
            }
        }

        /// <summary>
        /// Consulta todos los usuarios
        /// </summary>
        public List<Usuario> Consultar()
        {
            List<Usuario> usuarios = new List<Usuario>();

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_Usuario_Consultar", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        conn.Open();
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                usuarios.Add(new Usuario
                                {
                                    Id = Convert.ToInt32(reader["Id"]),
                                    Nombre = reader["Nombre"].ToString(),
                                    FechaNacimiento = Convert.ToDateTime(reader["FechaNacimiento"]),
                                    Sexo = reader["Sexo"].ToString()
                                });
                            }
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                throw new Exception($"Error al consultar usuarios en la base de datos: {ex.Message}", ex);
            }

            return usuarios;
        }

        /// <summary>
        /// Consulta un usuario por su ID
        /// </summary>
        public Usuario ConsultarPorId(int id)
        {
            Usuario usuario = null;

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_Usuario_ConsultarPorId", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@Id", id);

                        conn.Open();
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                usuario = new Usuario
                                {
                                    Id = Convert.ToInt32(reader["Id"]),
                                    Nombre = reader["Nombre"].ToString(),
                                    FechaNacimiento = Convert.ToDateTime(reader["FechaNacimiento"]),
                                    Sexo = reader["Sexo"].ToString()
                                };
                            }
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                throw new Exception($"Error al consultar usuario por ID en la base de datos: {ex.Message}", ex);
            }

            return usuario;
        }

        /// <summary>
        /// Elimina un usuario por su ID
        /// </summary>
        public bool Eliminar(int id)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_Usuario_Eliminar", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@Id", id);

                        conn.Open();
                        int filasAfectadas = Convert.ToInt32(cmd.ExecuteScalar());
                        return filasAfectadas > 0;
                    }
                }
            }
            catch (SqlException ex)
            {
                throw new Exception($"Error al eliminar usuario en la base de datos: {ex.Message}", ex);
            }
        }
    }
}