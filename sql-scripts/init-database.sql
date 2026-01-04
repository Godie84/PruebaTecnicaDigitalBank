-- Crear la base de datos
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'PruebaTecnicaDB')
BEGIN
    CREATE DATABASE PruebaTecnicaDB;
END
GO

USE PruebaTecnicaDB;
GO

-- Crear la tabla Usuario
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Usuario]') AND type in (N'U'))
BEGIN
    CREATE TABLE Usuario (
        Id INT IDENTITY(1,1) PRIMARY KEY,
        Nombre NVARCHAR(100) NOT NULL,
        FechaNacimiento DATE NOT NULL,
        Sexo CHAR(1) NOT NULL CHECK (Sexo IN ('M', 'F'))
    );
END
GO

-- Procedimiento: INSERTAR Usuario
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_Usuario_Insertar')
    DROP PROCEDURE sp_Usuario_Insertar;
GO

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

-- Procedimiento: MODIFICAR Usuario
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_Usuario_Modificar')
    DROP PROCEDURE sp_Usuario_Modificar;
GO

CREATE PROCEDURE sp_Usuario_Modificar
    @Id INT,
    @Nombre NVARCHAR(100),
    @FechaNacimiento DATE,
    @Sexo CHAR(1)
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE Usuario
    SET Nombre = @Nombre, FechaNacimiento = @FechaNacimiento, Sexo = @Sexo
    WHERE Id = @Id;
    SELECT @@ROWCOUNT AS FilasAfectadas;
END
GO

-- Procedimiento: CONSULTAR Todos
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_Usuario_Consultar')
    DROP PROCEDURE sp_Usuario_Consultar;
GO

CREATE PROCEDURE sp_Usuario_Consultar
AS
BEGIN
    SET NOCOUNT ON;
    SELECT Id, Nombre, FechaNacimiento, Sexo FROM Usuario ORDER BY Id DESC;
END
GO

-- Procedimiento: CONSULTAR por ID
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_Usuario_ConsultarPorId')
    DROP PROCEDURE sp_Usuario_ConsultarPorId;
GO

CREATE PROCEDURE sp_Usuario_ConsultarPorId
    @Id INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT Id, Nombre, FechaNacimiento, Sexo FROM Usuario WHERE Id = @Id;
END
GO

-- Procedimiento: ELIMINAR Usuario
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_Usuario_Eliminar')
    DROP PROCEDURE sp_Usuario_Eliminar;
GO

CREATE PROCEDURE sp_Usuario_Eliminar
    @Id INT
AS
BEGIN
    SET NOCOUNT ON;
    DELETE FROM Usuario WHERE Id = @Id;
    SELECT @@ROWCOUNT AS FilasAfectadas;
END
GO

-- Insertar datos de prueba
IF NOT EXISTS (SELECT * FROM Usuario)
BEGIN
    INSERT INTO Usuario (Nombre, FechaNacimiento, Sexo)
    VALUES 
        ('Juan Pérez', '1990-05-15', 'M'),
        ('María García', '1985-08-22', 'F'),
        ('Carlos López', '1992-03-10', 'M');
END
GO

PRINT 'Base de datos inicializada correctamente';
GO