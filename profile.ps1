if ($args[0] -ne "reload") {
Clear-Host
Write-Host -ForegroundColor Black -Object (' ')
Write-Host -ForegroundColor Black -BackgroundColor DarkGray -Object ('===========================================================================')
Write-Host -ForegroundColor Black -BackgroundColor DarkGray -Object ('                                                                           ')
Write-Host -ForegroundColor Black -BackgroundColor DarkGray -Object (' ______                            _                                       ')
Write-Host -ForegroundColor Black -BackgroundColor DarkGray -Object ('|  ____|                          ( )                                      ')
Write-Host -ForegroundColor Black -BackgroundColor DarkGray -Object ('| |__ ___  _ __ _____   _____ _ __|/ ___                                   ')
Write-Host -ForegroundColor Black -BackgroundColor DarkGray -Object ('|  __/ _ \|  __/ _ \ \ / / _ \  __| / __|                                  ')
Write-Host -ForegroundColor Black -BackgroundColor DarkGray -Object ('| | | (_) | | |  __/\ V /  __/ |    \__ \                                  ')
Write-Host -ForegroundColor Black -BackgroundColor DarkGray -Object ('|_|  \___/|_|  \___| \_/ \___|_|    |___/                                  ')
Write-Host -ForegroundColor Black -BackgroundColor DarkGray -Object ('                                                                           ')
Write-Host -ForegroundColor Black -BackgroundColor DarkGray -Object ('             _____                           _          _ _                ')
Write-Host -ForegroundColor Black -BackgroundColor DarkGray -Object ('            |  __ \                         | |        | | |               ')
Write-Host -ForegroundColor Black -BackgroundColor DarkGray -Object ('            | |__) |____      _____ _ __ ___| |__   ___| | |               ')
Write-Host -ForegroundColor Black -BackgroundColor DarkGray -Object ('            |  ___/ _ \ \ /\ / / _ \  __/ __|  _ \ / _ \ | |               ')
Write-Host -ForegroundColor Black -BackgroundColor DarkGray -Object ('            | |  | (_) \ V  V /  __/ |  \__ \ | | |  __/ | |               ')
Write-Host -ForegroundColor Black -BackgroundColor DarkGray -Object ('            |_|   \___/ \_/\_/ \___|_|  |___/_| |_|\___|_|_|               ')
Write-Host -ForegroundColor Black -BackgroundColor DarkGray -Object ('                                                                           ')
Write-Host -ForegroundColor Black -BackgroundColor DarkGray -Object ('===========================================================================')

Import-Module '.\bin\ntobjectmanager.2.0.1\NtObjectManager.psd1'
}

Import-Module '.\bin\gsudo\gsudoModule'
# Import-Module '.\modules\performancer\Performancer.psd1'
Import-Module '.\modules\GetDirectorySize\Get-DirectorySize.psd1'
# Import-Module '.\bin\fplayer\fplayer.psd1' -DisableNameChecking
Import-Module '.\modules\DirectoryManager\DirectoryManager.psd1'
Import-Module '.\modules\ForeverCompressModule\Compress-Module.psm1'
Import-Module '.\components\alias.psm1'
Import-Module '.\components\controlpanel.psm1'
Import-Module '.\components\elevator.psm1'
Import-Module '.\components\file.psm1'
Import-Module '.\components\internet.psm1'
Import-Module '.\components\math.psm1'
Import-Module '.\components\password.psm1'
Import-Module '.\components\time.psm1'

# Anaconda settings
$Env:CONDA_EXE = "D:\Anaconda\Scripts\conda.exe"
$Env:_CE_M = ""
$Env:_CE_CONDA = ""
$Env:_CONDA_ROOT = "D:\Anaconda"
$Env:_CONDA_EXE = "D:\Anaconda\Scripts\conda.exe"
$CondaModuleArgs = @{ChangePs1 = $True}
Import-Module "$Env:_CONDA_ROOT\shell\condabin\Conda.psm1" -ArgumentList $CondaModuleArgs

Remove-Variable CondaModuleArgs
# conda activate 'C:\ProgramData\anaconda3'

$Global:forever = Resolve-Path $PSScriptRoot

if ($args[0] -ne "reload") { 
    try { Stop-Transcript } catch {}
    $start_time = Get-Date -Format 'yyyy-MM-dd_hh-mm-ss'
    $Global:logs = Resolve-Path "$forever\logs"
    Start-Transcript -Path "$logs\ForeverShell_$start_time.log"

}

if ($True -eq $PSStyle.FileInfo.Extension.ContainsKey('.nupkg')) {
    $PSStyle.FileInfo.Extension.Remove('.nupkg')
}

$archiveExtensions = @(
    '.f7z', '.z', '.archived'
)

foreach ($ext in $archiveExtensions) {
    if ($False -eq $PSStyle.FileInfo.Extension.ContainsKey($ext)) {
        $PSStyle.FileInfo.Extension.Add($ext, "`e[35m")
    }
}

$textExtensions = @(
    '.txt', '.text', '.docx', '.pptx', '.xlsx', '.csv', '.doc', '.ppt', '.xls'
)
foreach ($ext in $textExtensions) {
    if ($False -eq $PSStyle.FileInfo.Extension.ContainsKey($ext)) {
        $PSStyle.FileInfo.Extension.Add($ext, "`e[33m")
    }
}

$mediaExtensions = @(
    '.3g2', '.3ga', '.3ga2', '.3gp', '.3gp2', '.3gpp', '.3iv', '.a52', '.ac3', '.adt', '.aif', '.aiff', '.aifc', '.amr', '.awb', '.au', '.snd', '.ay', '.cue', '.dts', '.dtshd', '.dv', '.hdv', '.divx', '.eac3', '.evo', '.evob', '.flac', '.flc', '.fli', '.flic', '.f4a', '.f4v', '.flv', '.gbs', '.gym', '.gxf', '.hes', '.kss', '.lpcm', '.m3u', '.m3u8', '.mlp', '.mp3', '.m1a', '.m2a', '.mp1', '.mp2', '.mpa', '.m1v', '.m2v', '.mod', '.mp2v', '.mpe', '.mpeg', '.mpg', '.mpv', '.mpv2', '.tod', '.m2t', '.m2ts', '.mts', '.mtv', '.trp', '.ts', '.tsa', '.tsv', '.tts', '.m4a', '.mp4', '.mp4v', '.m4v', '.mpeg4', '.mpg4', '.mk3d', '.mka', '.mkv', '.dvr', '.dvr-ms', '.ape', '.nsf', '.nsfe', '.nut', '.nsv', '.oga', '.ogg', '.ogm', '.ogv', '.opus', '.pcm', '.pls', '.mov', '.hdmov', '.qt', '.aac', '.264', '.avc', '.h264', '.x264', '.265', '.h265', '.hevc', '.x265', '.yuv', '.ra', '.ram', '.rm', '.rmvb', '.sap', '.shn', '.spc', '.spx', '.thd', '.thd+ac3', '.truehd', '.true-hd', '.tta', '.vgm', '.vgz', '.avi', '.vfw', '.vob', '.vro', '.wv', '.wav', '.weba', '.webm', '.wma', '.asf', '.wm', '.wmv', '.wtv', '.xvid', '.y4m', '.jpg', '.jpeg', '.png', '.gif', '.webp', '.dng', '.heic', '.ncm', '.kgm', '.kgma'
)
foreach ($ext in $mediaExtensions) {
    if ($False -eq $PSStyle.FileInfo.Extension.ContainsKey($ext)) {
        $PSStyle.FileInfo.Extension.Add($ext, "`e[96m")
    }
}

Function Global:prompt {
    $global:whoami = [Security.Principal.WindowsIdentity]::GetCurrent()
    
    $currentRole = ""
    $currentPath = "`e[93m$($executionContext.SessionState.Path.CurrentLocation)`e[0m"
    
    if ($whoami.IsSystem -eq $True -and $whoami.Owner -eq 'S-1-5-18') {
        $currentRole = "`e[41m`e[33m[TrustedInstaller]`e[0m"
    } elseif ($whoami.IsSystem -eq $True) {
        $currentRole = "`e[41m`e[33m[System]`e[0m"
    } elseif (([Security.Principal.WindowsPrincipal] $whoami).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator) -eq $True) {
        $currentRole = "`e[43m`e[30m[Administrator]`e[0m"
    } else {
        $currentRole = "`e[43m`e[30m[User]`e[0m"
    }

    $currentUser = "`e[90m$($whoami.Name)`e[0m"
    
    $gitBranch = & GIT rev-parse --abbrev-ref HEAD 2>$null
    if ($LASTEXITCODE -eq 0) {
        $gitInfo = "`e[95m[$gitBranch]`e[0m"
    } else {
        $gitInfo = ""
    }

    if ($Env:CONDA_PROMPT_MODIFIER) {
        $modifiedCondaEnv = "`e[94m$Env:CONDA_PROMPT_MODIFIER`e[0m"
    }
    
    "$currentRole $currentUser $modifiedCondaEnv $currentPath $gitInfo`n> "
}

# Function Global:Reload-ForeverPowershell {
#     profile.ps1 reload
# }

Function Global:Supervise-Powershell {
    $startupCommand = 'pwsh.exe -Nologo -NoExit -File "C:\psScript\At-Startup.ps1" reload'
    gsudo $startupCommand 
}

# Function Global:Call-Everything {
# param (
#     [Parameter(Mandatory=$true)]
#     [string]$text
# )
#     EVERYTHING -search "$text"
# }

#$processMemoryUsage = Get-WmiObject WIN32_PROCESS | Sort-Object -Property ws -Descending | Select-Object -first 5 processname, @{Name="Mem Usage(MB)";Expression={[math]::round($_.ws / 1mb)}}


$Global:videos = "$home\Videos"
$Global:pictures = "$home\Pictures"
$Global:downloads = "$home\Downloads"
$Global:music = "$home\Music"
$Global:desktop = "$home\Desktop"
$Global:hosts = "$env:windir\System32\drivers\etc\hosts"
$Global:screenshots = "$home\Pictures\Screenshots"

if ($args[0] -ne "reload") {
$_PSVersion = $PSVersionTable.PSVersion.ToString()
$_PSEdition = $PSVersionTable.PSEdition.ToString()
$_PSOS = $PSVersionTable.OS.ToString()
$_PSPlatform = $PSVersionTable.Platform.ToString()
Write-Host -ForegroundColor Cyan -Object ("                     Windows Powershell $_PSVersion                     ")
Write-Host -ForegroundColor DarkYellow -Object ('                                                                           ')
Write-Host -ForegroundColor Red -Object ('Initiative Text Printed! Because this is the exact text! Haha!!')
Write-Host -ForegroundColor Yellow -Object ("PSVersion                      $_PSVersion")
Write-Host -ForegroundColor Yellow -Object ("PSEdition                      $_PSEdition")
Write-Host -ForegroundColor Yellow -Object ("BuildVersion                   $_PSOS")
Write-Host -ForegroundColor Yellow -Object ("CLRVersion                     $_PSPlatform")
Write-Host -ForegroundColor White -Object (" ")

Write-Host "Windows Powershell Forever Edition    " -ForegroundColor DarkCyan -NoNewline
Write-Host 'as ' -NoNewline
Write-Host "$($whoami.Name)" -ForegroundColor DarkYellow
if ($whoami.Name -eq 'nt authority\System') {
    Write-Host 'WARNING: ' -ForegroundColor DarkRed -NoNewline
    Write-Host 'Process instance called by TrustedInstaller ' -ForegroundColor DarkYellow -NoNewline
    Write-Host '(NT Authority\System)' -ForegroundColor Red
    Write-Host 'Make sure you know how you started this instance' -ForegroundColor Red
    Write-Host ""
}
Write-Host ""
}

# conda activate xxx
# conda activate xxx
conda activate default

# pip install thefuck
# $Env:PYTHONIOENCODING='utf-8'
# Invoke-Expression "$(thefuck --alias)"

if ($args[0] -eq "reload" -and $whoami -eq 'nt authority\System') {
    Write-Host 'WARNING: ' -ForegroundColor DarkRed -NoNewline
    Write-Host 'Process instance called by TrustedInstaller ' -ForegroundColor DarkYellow -NoNewline
    Write-Host '(NT Authority\System)' -ForegroundColor Red
    Write-Host 'Make sure you know how you started this instance' -ForegroundColor Red
    Write-Host ""
}