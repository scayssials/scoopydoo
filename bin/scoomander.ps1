param($cmd)

. "$PSScriptRoot\..\lib\commands.ps1"
. "$PSScriptRoot\..\lib\logger.ps1"

$global_command = "scoopydoo $cmd $args"
$commands = commands
if ('--version' -contains $cmd -or (!$cmd -and '-v' -contains $args)) {
    scoop info scoopydoo
}
elseif (@($null, '--help', '/?') -contains $cmd -or $args[0] -contains '-h') { exec 'help' $args }
elseif ($commands -contains $cmd) {
    exec $cmd $args
} else {
    "scoopydoo: '$cmd' isn't a scoopydoo command. See 'scoopydoo help'."; exit 1
}

