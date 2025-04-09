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
