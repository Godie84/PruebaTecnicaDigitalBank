using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;

namespace ServicioWCF
{
    [ServiceContract]
    public interface IUsuarioService
    {
        [OperationContract]
        int Agregar(UsuarioDTO usuario);

        [OperationContract]
        bool Modificar(UsuarioDTO usuario);

        [OperationContract]
        List<UsuarioDTO> Consultar();

        [OperationContract]
        UsuarioDTO ConsultarPorId(int id);

        [OperationContract]
        bool Eliminar(int id);
    }

    [DataContract]
    public class UsuarioDTO
    {
        [DataMember]
        public int Id { get; set; }

        [DataMember]
        public string Nombre { get; set; }

        [DataMember]
        public DateTime FechaNacimiento { get; set; }

        [DataMember]
        public string Sexo { get; set; }
    }
}