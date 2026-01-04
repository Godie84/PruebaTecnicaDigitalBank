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

 ```bash
-- Crear la base de datos
CREATE DATABASE PruebaTecnicaDB;
GO

USE PruebaTecnicaDB;
GO

-- Crear la tabla Usuario
CREATE TABLE Usuario (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL,
    FechaNacimiento DATE NOT NULL,
    Sexo CHAR(1) NOT NULL CHECK (Sexo IN ('M', 'F'))
);
GO


-- =============================================
-- Procedimiento: INSERTAR Usuario
-- =============================================
CREATE PROCEDURE sp_Usuario_Insertar
    @Nombre NVARCHAR(100),
    @FechaNacimiento DATE,
    @Sexo CHAR(1)
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO Usuario (Nombre, FechaNacimiento, Sexo)
    VALUES (@Nombre, @FechaNacimiento, @Sexo);
    
    SELECT SCOPE_IDENTITY() AS Id;
END
GO

-- =============================================
-- Procedimiento: MODIFICAR Usuario
-- =============================================
CREATE PROCEDURE sp_Usuario_Modificar
    @Id INT,
    @Nombre NVARCHAR(100),
    @FechaNacimiento DATE,
    @Sexo CHAR(1)
AS
BEGIN
    SET NOCOUNT ON;
    
    UPDATE Usuario
    SET Nombre = @Nombre,
        FechaNacimiento = @FechaNacimiento,
        Sexo = @Sexo
    WHERE Id = @Id;
    
    SELECT @@ROWCOUNT AS FilasAfectadas;
END
GO

-- =============================================
-- Procedimiento: CONSULTAR Todos los Usuarios
-- =============================================
CREATE PROCEDURE sp_Usuario_Consultar
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT Id, Nombre, FechaNacimiento, Sexo
    FROM Usuario
    ORDER BY Id DESC;
END
GO

-- =============================================
-- Procedimiento: CONSULTAR Usuario por ID
-- =============================================
CREATE PROCEDURE sp_Usuario_ConsultarPorId
    @Id INT
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT Id, Nombre, FechaNacimiento, Sexo
    FROM Usuario
    WHERE Id = @Id;
END
GO

-- =============================================
-- Procedimiento: ELIMINAR Usuario
-- =============================================
CREATE PROCEDURE sp_Usuario_Eliminar
    @Id INT
AS
BEGIN
    SET NOCOUNT ON;
    
    DELETE FROM Usuario
    WHERE Id = @Id;
    
    SELECT @@ROWCOUNT AS FilasAfectadas;
END
GO

-- Insertar datos de prueba
INSERT INTO Usuario (Nombre, FechaNacimiento, Sexo)
VALUES 
    ('Juan Pérez', '1990-05-15', 'M'),
    ('María García', '1985-08-22', 'F'),
    ('Carlos López', '1992-03-10', 'M');
GO
 ```

 ## Procedimiento técnico
 
 1. Configuración del entorno

 - Visual Studio 2022 o superior
 - .NET Framework 4.7.2
 - SQL Server (Express o completo)

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

 - Arquitectura 3 capas (Presentación, Negocios, Datos)
 - Registro, Consulta, Modificación y Eliminación de usuarios
 - Validaciones de campos en la UI
 - Uso de DTOs para transferencia de datos
 - Manejo de errores con mensajes amigables en la UI

 Estructura del proyecto:

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
