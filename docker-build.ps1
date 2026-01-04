# Script para construir y ejecutar los contenedores Docker

Write-Host "=== Construyendo y ejecutando contenedores Docker ===" -ForegroundColor Green

# Detener y eliminar contenedores existentes
Write-Host "`n1. Deteniendo contenedores existentes..." -ForegroundColor Cyan
docker-compose down -v

# Construir las imágenes
Write-Host "`n2. Construyendo imágenes Docker..." -ForegroundColor Cyan
docker-compose build --no-cache

# Iniciar los contenedores
Write-Host "`n3. Iniciando contenedores..." -ForegroundColor Cyan
docker-compose up -d

# Mostrar estado
Write-Host "`n4. Estado de los contenedores:" -ForegroundColor Cyan
docker-compose ps

Write-Host "`n=== Despliegue completado ===" -ForegroundColor Green
Write-Host "`nAccede a la aplicación en:" -ForegroundColor Yellow
Write-Host "  - Aplicación Web: http://localhost:8080" -ForegroundColor White
Write-Host "  - Servicio WCF:   http://localhost:8081/UsuarioService.svc" -ForegroundColor White
Write-Host "  - SQL Server:     localhost:1433" -ForegroundColor White
Write-Host "`nPara ver logs: docker-compose logs -f" -ForegroundColor Cyan
Write-Host "Para detener:  docker-compose down" -ForegroundColor Cyan