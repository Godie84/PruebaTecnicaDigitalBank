# PruebaTecnica# Sistema de Gestión de Usuarios – .NET Web Forms + WCF
 
 ## Descripción del proyecto
 
 Este proyecto implementa un sistema de registro y consulta de usuarios utilizando arquitectura por capas:

 - Capa de Presentación: Web Forms (ASP.NET)

 - Capa de Negocios: Servicio WCF (UsuarioService)

 - Capa de Datos: Acceso a base de datos mediante UsuarioDAL y procedimientos almacenados

 ## El sistema permite:

 - Registrar nuevos usuarios
 - Consultar usuarios existentes
 - Modificar usuarios
 - Eliminar usuarios

 ## Arquitectura por capas

 1. Capa de Presentación (Web Forms)

 ## Archivos principales:

 - Usuario.aspx → formulario para registrar o editar un usuario
 - UsuarioConsulta.aspx → muestra la lista de usuarios en un GridView

 ## Características:

 - Validación de campos (Nombre obligatorio, Fecha de Nacimiento obligatoria, Sexo obligatorio)
 - Botones para Guardar, Modificar y Eliminar usuarios
 - Comunicación con el WCF usando UsuarioServiceClient

 ## Flujo:

 - El usuario ingresa datos en el formulario
 - La página llama al WCF
 - Los resultados se muestran en la interfaz

 2. Capa de Negocios (Servicio WCF)

 ## Archivo principal: UsuarioService.svc y UsuarioService.cs

 - Interfaz: IUsuarioService
 - Agregar(UsuarioDTO usuario) → devuelve el Id del usuario agregado
 - Modificar(UsuarioDTO usuario) → devuelve true o false según éxito
 - Consultar() → devuelve lista de usuarios
 - ConsultarPorId(int id) → devuelve un usuario específico
 - Eliminar(int id) → devuelve true o false según éxito

 ## DTO: UsuarioDTO

 - Contiene Id, Nombre, FechaNacimiento, Sexo

 Responsabilidad:

 - Transformar DTO a entidad (Usuario)
 - Invocar métodos de la capa de datos (UsuarioDAL)
 - Manejo de errores mediante FaultException

 3. Capa de Datos (DAL)

 - Archivo principal: UsuarioDAL.cs
 - Entidad: Usuario
 - Propiedades: Id, Nombre, FechaNacimiento, Sexo

 Funciones principales:
 - Agregar(Usuario usuario)
 - Modificar(Usuario usuario)
 - Consultar()
 - ConsultarPorId(int id)
 - Eliminar(int id)

 Base de datos:

 Tabla Usuarios con campos: Id (PK), Nombre, FechaNacimiento, Sexo

 Procedimientos almacenados para operaciones CRUD

 Procedimiento técnico
 1. Configuración del entorno

 Visual Studio 2019 o superior

 .NET Framework 4.7.2

 SQL Server (Express o completo)

 Asegurarse de que la cadena de conexión en CapaDatos apunte a tu base de datos:

<connectionStrings>
    <add name="PruebaTecnicaDB" connectionString="Data Source=.;Initial Catalog=PruebaTecnica;Integrated Security=True" providerName="System.Data.SqlClient" />
</connectionStrings>


La capa de presentación tiene un Service Reference apuntando al WCF:

<endpoint address="http://localhost:52979/UsuarioService.svc"
          binding="basicHttpBinding"
          contract="ServiceReferenceWCF.IUsuarioService" />

2. Ejecución

 - Crear la base de datos y la tabla Usuarios con los procedimientos almacenados proporcionados.

 - Abrir la solución en Visual Studio.

 - Compilar la solución.

 - Ejecutar el proyecto Web Forms.

 - La página inicial es Usuario.aspx.

 - Desde aquí se pueden registrar o modificar usuarios.

 - Para consultar usuarios, acceder a UsuarioConsulta.aspx.

 3. Flujo de datos
    [Usuario.aspx / UsuarioConsulta.aspx]
            │
            ▼
    [UsuarioServiceClient (WCF)]
            │
            ▼
    [UsuarioService (Capa de Negocios)]
            │
            ▼
    [UsuarioDAL (Capa de Datos)]
            │
            ▼
    [Base de Datos SQL Server]

 Características implementadas

 Arquitectura 3 capas (Presentación, Negocios, Datos)

 Registro, Consulta, Modificación y Eliminación de usuarios

 Validaciones de campos en la UI

 Uso de DTOs para transferencia de datos

 Manejo de errores con mensajes amigables en la UI

 Estructura del proyecto
    /CapaPresentacion
        Usuario.aspx
        UsuarioConsulta.aspx
        Web.config
        ServiceReferenceWCF

    /ServicioWCF
        UsuarioService.svc
        IUsuarioService.cs
        UsuarioDTO.cs

    /CapaDatos
        UsuarioDAL.cs
        Usuario.cs
        Procedimientos almacenados SQL
