# -----------------------------------
# Secrets management
# -----------------------------------

$volumePath = "C:\Nick\EncryptedVolume.hc"

$maxAttempts = 5
$veraCryptPassword = ""

for ($i = 1; $i -le $maxAttempts; $i++) {
    Read-Host "Press any key to start authentication"
    $veraCryptPassword = op read "op://Employee/VeraCrypt/password"
    if (![string]::IsNullOrEmpty($veraCryptPassword) -and $veraCryptPassword.Length -gt 0) {
        Write-Output "Authentication completed successfully"
        break
    }
    Write-Output "No password found on attmept $i of $maxAttempts"
}
if (!$veraCryptPassword.Length -gt 0 -and [string]::IsNullOrEmpty($veraCryptPassword)) {
    Write-Error "Could not get 1Password connected"
    exit 1
}

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
