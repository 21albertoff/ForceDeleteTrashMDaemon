# Define la ruta base de la carpeta Usuarios
$basePath = "rutaDeUsuario"

# Define la lista de usuarios a excluir
$excludedUsers = @("usuario1", "usuario2")

Write-Host "=====================================================================" -ForegroundColor DarkCyan
Write-Host "| Eliminación de papelera Correo MDaemon v1.0 - Alberto Fuentes     |" -ForegroundColor DarkCyan
Write-Host "=====================================================================" -ForegroundColor DarkCyan
Write-Host ""
Write-Host "- Carpeta de registro: " -NoNewline -ForegroundColor Gray 
Write-Host "$basePath" -ForegroundColor Cyan 
Write-Host "- Usuarios exluidos en el registro :" -NoNewline -ForegroundColor Gray 
Write-Host "[$excludedUsers]" -ForegroundColor Cyan
Write-Host ""
Write-Host "Realizando proceso de eliminación..." -ForegroundColor DarkYellow
# Busca todas las carpetas "Elementos Eliminados" dentro de la ruta base
$deletedItemsFolders = Get-ChildItem -Path $basePath -Recurse -Directory -Filter "Elementos eliminados.IMAP"
Write-Host ""

# Itera sobre cada carpeta y elimina los archivos que empiezan por "md"
foreach ($folder in $deletedItemsFolders) {
#    # Comprueba si el usuario esta excluido
    if ($excludedUsers -notcontains $folder.Parent.Name) {
        $parentNameFolder = $folder.Parent.Name
        Get-ChildItem -Path $folder.FullName -File | Where-Object { $_.Name -match "^md" } | Remove-Item -Force
        Write-Host "Vaciando carpeta 'Elementos eliminados.IMAP' a " -NoNewline
        Write-Host "$parentNameFolder" -ForegroundColor Yellow
    }
}

# Busca todas las carpetas "Delete Items" dentro de la ruta base
$deletedItemsFolders = Get-ChildItem -Path $basePath -Recurse -Directory -Filter "Deleted Items.IMAP"

# Itera sobre cada carpeta y elimina los archivos que empiezan por "md"
foreach ($folder in $deletedItemsFolders) {
    # Comprueba si el usuario esta excluido
    if ($excludedUsers -notcontains $folder.Parent.Name) {
        $parentNameFolder = $folder.Parent.Name
        Get-ChildItem -Path $folder.FullName -File | Where-Object { $_.Name -match "^md" } | Remove-Item -Force
        Write-Host "Vaciando carpeta 'Deleted Items.IMAP' a " -NoNewline
        Write-Host "$parentNameFolder" -ForegroundColor Yellow
    }
}

Write-Host "==========================================" -ForegroundColor Green
Write-Host "Proceso de eliminación realizado con EXITO" -ForegroundColor Green
Write-Host "==========================================" -ForegroundColor Green

