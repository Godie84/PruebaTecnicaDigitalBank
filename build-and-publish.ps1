# Script para compilar y publicar la solución

Write-Host "=== Compilando y publicando solución ===" -ForegroundColor Green

# Variables
$solutionPath = ".\PruebaTecnica.sln"
$msbuildPath = "C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe"
# Ajusta la ruta según tu versión de Visual Studio

# Verificar que MSBuild existe
if (-not (Test-Path $msbuildPath)) {
    Write-Host "ERROR: No se encontró MSBuild en $msbuildPath" -ForegroundColor Red
    Write-Host "Intentando encontrar MSBuild automáticamente..." -ForegroundColor Yellow
    
    # Buscar MSBuild
    $msbuildPath = Get-ChildItem "C:\Program Files\Microsoft Visual Studio" -Recurse -Filter "MSBuild.exe" -ErrorAction SilentlyContinue | 
        Where-Object { $_.FullName -like "*\Current\Bin\MSBuild.exe" } | 
        Select-Object -First 1 -ExpandProperty FullName
    
    if (-not $msbuildPath) {
        Write-Host "ERROR: No se pudo encontrar MSBuild" -ForegroundColor Red
        exit 1
    }
    Write-Host "MSBuild encontrado en: $msbuildPath" -ForegroundColor Green
}

# Restaurar paquetes NuGet
Write-Host "`n1. Restaurando paquetes NuGet..." -ForegroundColor Cyan
& $msbuildPath $solutionPath /t:Restore /p:Configuration=Release /v:minimal

if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR al restaurar paquetes NuGet" -ForegroundColor Red
    exit 1
}

# Compilar la solución
Write-Host "`n2. Compilando solución..." -ForegroundColor Cyan
& $msbuildPath $solutionPath /p:Configuration=Release /v:minimal

if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR al compilar la solución" -ForegroundColor Red
    exit 1
}

# Publicar ServicioWCF
Write-Host "`n3. Publicando ServicioWCF..." -ForegroundColor Cyan
$wcfPublishPath = ".\ServicioWCF\publish"
if (Test-Path $wcfPublishPath) {
    Remove-Item -Recurse -Force $wcfPublishPath
}
New-Item -ItemType Directory -Path $wcfPublishPath -Force | Out-Null

& $msbuildPath ".\ServicioWCF\ServicioWCF.csproj" `
    /p:Configuration=Release `
    /p:DeployOnBuild=true `
    /p:WebPublishMethod=FileSystem `
    /p:publishUrl=$wcfPublishPath `
    /p:DeleteExistingFiles=True `
    /v:minimal

if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR al publicar ServicioWCF" -ForegroundColor Red
    exit 1
}

# Publicar CapaPresentacion
Write-Host "`n4. Publicando CapaPresentacion..." -ForegroundColor Cyan
$webPublishPath = ".\CapaPresentacion\publish"
if (Test-Path $webPublishPath) {
    Remove-Item -Recurse -Force $webPublishPath
}
New-Item -ItemType Directory -Path $webPublishPath -Force | Out-Null

& $msbuildPath ".\CapaPresentacion\CapaPresentacion.csproj" `
    /p:Configuration=Release `
    /p:DeployOnBuild=true `
    /p:WebPublishMethod=FileSystem `
    /p:publishUrl=$webPublishPath `
    /p:DeleteExistingFiles=True `
    /v:minimal

if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR al publicar CapaPresentacion" -ForegroundColor Red
    exit 1
}

# Actualizar Web.config con cadenas de conexión para Docker
Write-Host "`n5. Actualizando configuraciones para Docker..." -ForegroundColor Cyan

# ServicioWCF Web.config
$wcfConfig = "$wcfPublishPath\Web.config"
if (Test-Path $wcfConfig) {
    $content = Get-Content $wcfConfig -Raw
    $content = $content -replace 'Data Source=localhost', 'Data Source=sqlserver'
    $content = $content -replace 'Integrated Security=True', 'User ID=sa;Password=YourStrong@Password123'
    $content | Set-Content $wcfConfig -NoNewline
    Write-Host "  - ServicioWCF Web.config actualizado" -ForegroundColor Green
}

# CapaPresentacion Web.config - Actualizar endpoint del servicio WCF
$webConfig = "$webPublishPath\Web.config"
if (Test-Path $webConfig) {
    $content = Get-Content $webConfig -Raw
    # Buscar y reemplazar la dirección del endpoint
    $content = $content -replace 'address="http://localhost:\d+/UsuarioService\.svc"', 'address="http://serviciowcf/UsuarioService.svc"'
    $content | Set-Content $webConfig -NoNewline
    Write-Host "  - CapaPresentacion Web.config actualizado" -ForegroundColor Green
}

Write-Host "`n=== Compilación y publicación completada ===" -ForegroundColor Green
Write-Host "Archivos listos para Docker en:" -ForegroundColor Yellow
Write-Host "  - $wcfPublishPath" -ForegroundColor White
Write-Host "  - $webPublishPath" -ForegroundColor White
Write-Host "`nAhora puedes ejecutar: .\docker-build.ps1" -ForegroundColor Cyan