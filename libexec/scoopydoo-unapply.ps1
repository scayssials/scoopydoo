# Usage: scoopydoo apply <config> [options]
# Summary: Unapply configuration
# Help:
# e.g. The usual way to unapply a configuration:
#      scoopydoo unapply myConfig
#
# Options:
#   -include:  Comma separated app. Will only unapply configuration for those apps
#   -force:     Do not ask to confirm
#
# This will uninstall your configuration apps
# This will also cleanup all your configurations extras

Param(
    [String]
    $name,
    [String[]]
    $include,
    [String[]]
    $exclude,
    [Switch]
    $force
)

# Import useful scripts
. "$PSScriptRoot\..\lib\logger.ps1"
. "$PSScriptRoot\..\lib\core.ps1"

# Set global variables
$configPath = "$PSScriptRoot\..\config\$name"

if (!$name) {
    LogWarn "<config> is missing."
    LogMessage ""
    LogMessage "Usage: scoopydoo unapply <config>"
    LogMessage ""
    return
}

EnsureConfigInstalled $name
# update scoop / update all buckets
DoUnverifiedSslGitAction {
    scoop update
}
EnsurescoopydooVersion $configPath

. "$PSScriptRoot\..\API\configAPI.ps1" $name $force
. "$configPath\main.ps1" -mode "unapply" -include $include -exclude $exclude
