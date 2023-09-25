# Lettre de lecteur de la clé USB
$usbDriveLetter = "E:"
# Répertoire de lancement automatique
$startupDirectory = [System.IO.Path]::Combine([System.Environment]::GetFolderPath("Startup"))

# Vérifier si la clé USB est accessible
if (Test-Path -Path $usbDriveLetter -PathType Container) {
    # Liste tous les fichiers dans la clé USB
    $files = Get-ChildItem -Path $usbDriveLetter

    # Copier chaque fichier dans le répertoire de lancement automatique
    foreach ($file in $files) {
        if ($file.PSIsContainer -eq $false) {
            Copy-Item -Path $file.FullName -Destination $startupDirectory -Force
        }
        else {
            Write-Host "Ignoré : $($file.FullName) n'est pas un fichier."
        }
    }

    Write-Host "Copie terminée."
}
else {
    Write-Host "La clé USB n'est pas accessible ou n'existe pas."
}

# Utilisateur actuel
$currentUsername = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
Write-Host "Les fichiers de $usbDriveLetter ont été copiés dans le répertoire de lancement automatique de $currentUsername."
