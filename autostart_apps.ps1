# -----------------------------------
# Secrets management
# -----------------------------------

$volumePath = "C:\Nick\EncryptedVolume.hc"
$keepassVaultPath = "C:\Users\nick\OneDrive - Norges vassdrags- og energidirektorat\Dokumenter\Conf\NVE_passwords.kdbx"
$mainPasswordEntryName = "A normal NVE User account"
$veraPasswordEntryName = "AAA VeraCrypt"

$maxAttempts = 5
$veraCryptPassword = ""
$mainPassword = ""

for ($i = 1; $i -le $maxAttempts; $i++) {
    $mainPassword = keep show -a password $keepassVaultPath $mainPasswordEntryName
    if (-not [string]::IsNullOrWhiteSpace($mainPassword)) {
        Write-Output "Password accepted!"
        break
    }
    Write-Output "Wrong password. Attempt ($i of $maxAttempts)"
}
if ([string]::IsNullOrWhiteSpace($mainPassword)) {
    Write-Output "No password.. exiting"
    exit 1
}

# Start KeePassXC GUI
#$mainPassword | KeePassXC.exe --pw-stdin "$keepassVaultPath"
#Start-Process -Filepath "KeePassXC.exe" -ArgumentList "`"$keepassVaultPath`""
#Write-Output "Started KeePassXC GUI"

# Get Vera Crypt password and mount drive
$veraCryptPassword = $mainPassword | keepassxc-cli.exe show -q -a password $keepassVaultPath $veraPasswordEntryName
Write-Output "Mounting encrypted partition..."
VeraCrypt.exe /v $volumePath /l A /p $veraCryptPassword /q /s
# Sleep while drive is mounting
Start-Sleep 9


# -----------------------------------
# Other apps
# -----------------------------------

# Start Obsidian

$name = "Obsidian"
Write-Output "Starting {$name}"
# ~~ Uncomment if Obsidian is installed as an Appx Package
# $packageName = Get-AppxPackage | Where-Object { $_.Name -match $name } | Select-Object -ExpandProperty PackageFamilyName
#$packageName = "nve.Obsidian_hwxf5dwcp4wbm"
#Start-Process shell:AppsFolder\$packageName!$name

Start-Process -FilePath C:\Users\nick\AppData\Local\Programs\obsidian\Obsidian.exe -WorkingDirectory C:\Users\nick\AppData\Local\Programs\obsidian\ -WindowStyle Hidden -RedirectStandardOutput "NUL"


# Start 202020

Write-Output "Starting 202020"
$name = "202020"
# $packageName = Get-AppxPackage | Where-Object { $_.Name -match $name } | Select-Object -ExpandProperty PackageFamilyName
$packageName = "44686MichaelChen.202020_1xnyq3bbv8tvj"
Start-Process shell:AppsFolder\$packageName!App

Write-Output "Updating security champion fraction"
# Update the security champion-fraction with updated information
Sprint-Report.exe sc --use-vault
# Update background picture with new information
C:\Nick\Bin\BGInfo\Bginfo.exe "C:\Nick\Bin\BGInfo\nve_background.bgi" /timer:0 /silent /nolicprompt
