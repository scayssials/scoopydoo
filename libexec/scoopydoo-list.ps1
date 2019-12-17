# Usage: scoopydoo list [options]
# Summary: List configurations
# Help:
# scoopydoo list

Param()

# Import useful scripts
. "$PSScriptRoot\..\lib\logger.ps1"

# Set global variables
$scoopTarget = $env:SCOOP

LogMessage "scoopydoo configurations: "
$Folders = Get-ChildItem "$scoopTarget\persist\scoopydoo\config\" -Directory -Name
foreach ($Folder in $Folders) {
    $Folder = Split-Path -Path $Folder -Leaf
    LogMessage " * $Folder"
}
; Break
