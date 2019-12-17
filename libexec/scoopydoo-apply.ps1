# Usage: scoopydoo apply <config> [options]
# Summary: Apply configuration
# Help:
# e.g. The usual way to apply a configuration:
#      scoopydoo apply myConfig
#
# Options:
#   -include:  Comma separated app. Will only apply configuration for those apps
#   -force:     Do not ask to confirm
#
# This will install/update your buckets and apps in their latest specified versions
# This will also apply all your configurations extras

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
    LogMessage "Usage: scoopydoo apply <config>"
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
. "$configPath\main.ps1" -mode "apply" -include $include -exclude $exclude
