# Usage: scoopydoo config add|list|rm [<args>]
# Summary: Add, list or remove configs.
# Help:
# Configurations are repositories of scoopydoo configurations.
# scoopydoo comes without any configuration
# Configurations are installed in scoop\persist\scoopydoo\config
#
# To add a configuration:
#
#     scoopydoo config add -name <String> -url <String> [-branch <String>] [-force]
#     [-branch <String>]: to checkout the configuration in a specific branch. (master is checkouted by default, and a new branch current is created from it)
#     [-force] : force override of a configuration with the same name
#
# To remove a configuration:
#
#     scoopydoo config rm -name <String> [-force]
#     [-force] : do not ask permission
#
# To list all added configurations:
#
#     scoopydoo config list

Param(
    [String]
    $action,
    [String]
    $name,
    [String]
    $url,
    [String]
    $branch = "current",
    [Switch]
    $force
)

# Import useful scripts
. "$PSScriptRoot\..\lib\logger.ps1"
. "$PSScriptRoot\..\lib\core.ps1"

# Set global variables
$scoopTarget = $env:SCOOP

Switch ($action) {
    { @("add", "rm") -contains $_ } {
        if (!$name) {
            LogWarn "<name> missing"
            LogMessage ""
            LogMessage "Usage: scoopydoo config $_ <name>"
            LogMessage ""
            return
        }
    }
    "add" {
        # Ask for override if the configuration already exist
        if (IsConfigInstalled $name) {
            if (!$force) {
                $decision = takeDecision "A configuration named '$name' already exist, would you like to override it ?"
                if ($decision -ne 0) {
                    LogWarn 'Cancelled'
                    return
                }
            }
            Remove-Item "$scoopTarget\persist\scoopydoo\config\$name" -Force -Recurse
            LogInfo "Old configuration '$name' was erased."
        }
        # Clone configuration and checkout to the specified branch
        try {
            DoUnverifiedSslGitAction {
                Invoke-Utility git lfs install
                Invoke-Utility git clone $url "$scoopTarget\persist\scoopydoo\config\$name"
            }
        }
        catch {
            LogWarn "Impossible to Clone '$url' to '$scoopTarget\persist\scoopydoo\config\$name'. Check the error message and your git configuration."
            throw
        }
        Push-Location "$scoopTarget\persist\scoopydoo\config\$name"
        $exist = git rev-parse --verify --quiet $branch
        if (!$exist) { git checkout -b $branch }
        else { git checkout $branch }
        Pop-Location
        LogInfo "Configuration '$name' was added."
        LogMessage "You can now use: "
        LogMessage ""
        LogMessage "     scoopydoo apply $name"
        LogMessage ""
        LogMessage "to install it."
        ; Break
    }
    "rm" {
        if (!$force) {
            $decision = takeDecision "Do you really want to remove the configuration '$name'? Be sure to unapply it before delete it."
            if ($decision -ne 0) {
                LogWarn 'Remove configuration cancelled.'
                return
            }
        }
        Remove-Item "$scoopTarget\persist\scoopydoo\config\$name" -Force -Recurse
        LogMessage ""
        LogInfo "Configuration '$name' was removed."
        ; Break
    }
    "list" {
        LogMessage "Installed scoopydoo configurations: "
        $Folders = Get-ChildItem "$scoopTarget\persist\scoopydoo\config\" -Directory -Name
        foreach ($Folder in $Folders) {
            $Folder = Split-Path -Path $Folder -Leaf
            LogMessage " * $Folder"
        }
        ; Break
    }
    default {
        Invoke-Expression "$PSScriptRoot\scoopydoo-help.ps1 $cmd"
    }
}
