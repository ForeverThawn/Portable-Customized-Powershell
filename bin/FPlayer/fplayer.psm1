Function Play-MediaFile {
param (
    [Parameter(Mandatory=$true)]  [string]$FilePath,
    [Parameter(Mandatory=$false)] [switch]$NoVideo,
    [Parameter(Mandatory=$false)] [switch]$NoAudio,
    [Parameter(Mandatory=$false)] [string]$SubtitlePath,
    [Parameter(Mandatory=$false)] [int]$Volume,
    [Parameter(Mandatory=$false)] [switch]$Fullscreen,
    [Parameter(Mandatory=$false)] [switch]$Reload
)
    $cmdlet = "Write-Host ('(Raw) Fplayer called by console') -ForegroundColor Red ;"
    $cmdlet += "Write-Host ('$FilePath') -ForegroundColor Yellow ; fplayer "
    $cmdlet += "'$FilePath'"
    if ($NoVideo) { $cmdlet += " --no-video"}
    if ($NoAudio) { $cmdlet += " --no-audio"}
    if ($SubtitlePath) { $cmdlet += " --subtitle=$SubtitlePath"}
    if ($Volume) { $cmdlet += " --volume=$Volume"}
    if ($Fullscreen) { $cmdlet += " --fullscreen"}
    if ($Reload) { $cmdlet += " --resume-playback=no"}
    $global:fplayer = Start-Process -FilePath "powershell.exe" -ArgumentList "-Command $cmdlet" -PassThru
    Write-Host 'Player process created: ' -ForegroundColor Green -NoNewline
    Write-Host 'Using ' -NoNewline
    Write-Host '$fplayer' -ForegroundColor DarkCyan -NoNewline
    Write-Host ' to track'
}

Set-Alias -Name "play" -Value "Play-MediaFile"
