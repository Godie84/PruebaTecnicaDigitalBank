Dockerización de PruebaTecnica
Esta guía explica cómo dockerizar y ejecutar la solución completa con Docker.
Requisitos Previos

Docker Desktop instalado y en ejecución
Windows con soporte para contenedores Windows
Visual Studio 2019 o superior
Al menos 8GB de RAM disponible

Estructura de Archivos
PruebaTecnica/
├── sql-scripts/
│   ├── init-database.sql
│   └── entrypoint.sh
├── ServicioWCF/publish/
├── CapaPresentacion/publish/
├── Dockerfile.sqlserver
├── Dockerfile.wcf
├── Dockerfile.web
├── docker-compose.yml
├── build-and-publish.ps1
└── docker-build.ps1
Paso 1: Preparar el entorno

Crea la carpeta sql-scripts en la raíz de la solución
Copia los archivos init-database.sql y entrypoint.sh en esa carpeta
Copia los Dockerfiles en la raíz de la solución
Copia el docker-compose.yml en la raíz

Paso 2: Compilar y publicar la solución
Ejecuta el script de PowerShell:
powershell.\build-and-publish.ps1
Este script:

Restaura paquetes NuGet
Compila la solución en modo Release
Publica ServicioWCF y CapaPresentacion
Actualiza las configuraciones para Docker

Paso 3: Construir y ejecutar los contenedores
powershell.\docker-build.ps1
O manualmente:
bash# Construir imágenes
docker-compose build

# Iniciar contenedores
docker-compose up -d

# Ver logs
docker-compose logs -f
Paso 4: Acceder a la aplicación

Aplicación Web: http://localhost:8080
Servicio WCF: http://localhost:8081/UsuarioService.svc
SQL Server: localhost:1433

Usuario: sa
Password: YourStrong@Password123



Comandos Útiles
bash# Ver estado de contenedores
docker-compose ps

# Ver logs en tiempo real
docker-compose logs -f

# Detener contenedores
docker-compose down

# Eliminar todo (incluyendo volúmenes)
docker-compose down -v

# Reiniciar un servicio específico
docker-compose restart webapp

# Acceder a un contenedor
docker exec -it pruebatecnica-sqlserver /bin/bash
Solución de Problemas
Error: "Cannot connect to SQL Server"
Espera unos 30 segundos después de iniciar los contenedores para que SQL Server se inicialice completamente.
Error: "WCF Service not found"
Verifica que el servicio WCF esté corriendo:
bashdocker-compose logs serviciowcf
Contenedores no inician
Verifica que Docker Desktop esté en modo Windows containers:

Click derecho en el icono de Docker en la bandeja del sistema
Selecciona "Switch to Windows containers"

Configuración de Producción
Para producción, cambia:

La contraseña de SQL Server en docker-compose.yml
Las cadenas de conexión en los Web.config
Agrega HTTPS y certificados SSL
Configura volúmenes persistentes para la base de datos

Limpieza
Para eliminar todo:
bashdocker-compose down -v
docker rmi pruebatecnica-sqlserver pruebatecnica-wcf pruebatecnica-webapp
docker volume prune