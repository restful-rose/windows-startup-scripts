# -----------------------------------
# Secrets management
# -----------------------------------

$volumePath = "C:\Nick\EncryptedVolume.hc"

# Get Vera Crypt password and mount drive
$veraCryptPassword = op read "op://Employee/VeraCrypt/password"
Write-Output "Mounting encrypted partition..."
VeraCrypt.exe /v $volumePath /l A /p $veraCryptPassword /q /s
# Sleep while drive is mounting
Start-Sleep 9


# -----------------------------------
# Other apps
# -----------------------------------

# Start Obsidian

$name = "Obsidian"
# $packageName = Get-AppxPackage | Where-Object { $_.Name -match $name } | Select-Object -ExpandProperty PackageFamilyName
$packageName = "nve.Obsidian_hwxf5dwcp4wbm"
Start-Process shell:AppsFolder\$packageName!$name


# Start 202020

$name = "202020"
# $packageName = Get-AppxPackage | Where-Object { $_.Name -match $name } | Select-Object -ExpandProperty PackageFamilyName
$packageName = "44686MichaelChen.202020_1xnyq3bbv8tvj"
Start-Process shell:AppsFolder\$packageName!App
