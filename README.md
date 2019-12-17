<p align="center">
<!--<img src="scoop.png" alt="Long live Scoop!"/>-->
    <h1 align="center">scoopydoo</h1>
</p>
<p align="center">
<b><a href="https://github.com/scayssials/scoopydoo#what-does-scoopydoo-do">Features</a></b>
|
<b><a href="https://github.com/scayssials/scoopydoo#installation">Installation</a></b>
|
<b><a href="https://github.com/scayssials/scoopydoo/wiki">Documentation</a></b>
</p>

- - -
<p align="center" >
    <a href="https://github.com/scayssials/scoopydoo">
        <img src="https://img.shields.io/github/languages/code-size/scayssials/scoopydoo.svg" alt="Code Size" />
    </a>
    <a href="https://github.com/scayssials/scoopydoo">
        <img src="https://img.shields.io/github/repo-size/scayssials/scoopydoo.svg" alt="Repository size" />
    </a>
    <a href="https://github.com/scayssials/scoopydoo/blob/master/LICENSE">
        <img src="https://img.shields.io/github/license/scayssials/scoopydoo.svg" alt="License" />
    </a>    
</p>

scoopydoo is a scoop orchestrator for Windows.

## What does scoopydoo do

scoopydoo install a configurable list of programs on your machine thanks to Scoop.

scoopydoo allows users to use complex configuration in order to create and maintain a development environment. 

## Requirements

- Windows 7 SP1+ / Windows Server 2008+
- [PowerShell 5](https://aka.ms/wmf5download) (or later, include [PowerShell Core](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-windows?view=powershell-6)) and [.NET Framework 4.5](https://www.microsoft.com/net/download) (or later)
- PowerShell must be enabled for your user account e.g. `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser`

## Installation

Run the following command from your PowerShell to install:
- Scoop to its default location (`C:\Users\<user>\scoop`) or the one specified during installation 
- Git
- 7zip
- scoopydoo

```powershell
Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/scayssials/scoopydoo/master/bin/install.ps1')

# or shorter
iwr -useb 'https://raw.githubusercontent.com/scayssials/scoopydoo/master/bin/install.ps1' | iex
```

Once installed, run `scoopydoo help` for instructions.

The default Scoop setup is configured so all user installed programs Scoop and scoopydoo itself live in `C:\Users\<user>\scoop`.
These settings can be changed through scoop directly (see [scoop wiki](https://github.com/lukesampson/scoop/wiki)).

scoopydoo configurations are in `C:\Users\<user>\scoop\app\scoopydoo\current\config`

scoopydoo plugins are in `C:\Users\<user>\scoop\app\scoopydoo\current\plugins`

## More

[scoopydoo wiki](https://github.com/scayssials/scoopydoo/wiki)
