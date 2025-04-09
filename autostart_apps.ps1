# -----------------------------------
# Secrets management
# -----------------------------------

$keepassVaultPath = "C:\Users\nick\OneDrive - Norges vassdrags- og energidirektorat\Dokumenter\Conf\NVE_passwords.kdbx"
$mainPasswordEntryName = "A normal NVE User account"
$volumePath = "C:\Nick\EncryptedVolume.hc"
$veraPasswordEntryName = "AAA VeraCrypt"

$maxAttempts = 5
$mainPassword = ""

for ($i = 1; $i -le $maxAttempts; $i++) {
    $mainPassword = keep show -a password $keepassVaultPath $mainPasswordEntryName
    if ($mainPassword -and $mainPassword.Length -gt 0) {
        Write-Output "Password accepted!"
        break
    }
    Write-Output "Wrong password. Attempt ($i of $maxAttempts)"
}
if (-not $mainPassword.Length -gt 0) {
    Write-Output "No password.. exiting"
    exit 1
}

# Start KeePassXC GUI
$mainPassword | KeePassXC.exe --pw-stdin "$keepassVaultPath"

# Get Vera Crypt password and mount drive
$veraCryptPassword = $mainPassword | keep show -q -a password $keepassVaultPath $veraPasswordEntryName
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
