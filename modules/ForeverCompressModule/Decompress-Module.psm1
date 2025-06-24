Function Format-Archive {
param(
    [string] $Source
)
    $Destination = [System.IO.Path]::GetFileNameWithoutExtension("$(Resolve-Path $Source)")
    Start-Process 7ZA -ArgumentList "x `"$Source`" -o`"$Destination`"" -NoNewWindow -Wait
}