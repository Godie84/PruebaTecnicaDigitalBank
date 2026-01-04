#!/bin/bash

# Iniciar SQL Server en segundo plano
/opt/mssql/bin/sqlservr &

# Esperar a que SQL Server esté listo
echo "Esperando a que SQL Server esté listo..."
sleep 30s

# Ejecutar los scripts de inicialización
echo "Ejecutando scripts de inicialización..."
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD -d master -i /usr/src/app/init-database.sql

echo "Base de datos inicializada correctamente"

# Mantener el contenedor en ejecución
wait