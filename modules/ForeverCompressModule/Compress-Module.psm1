Function Compress-Archive {
param(
    [switch] $Help = $False,
    [Parameter(Mandatory=$true)]
    [string] $Source,
    [Parameter(Mandatory=$true)]
    [string] $Destination,
    [string] $Method = "zstd",
    [string] $Split = "undefined",
    [switch] $Extreme = $False

)
    if ($Help -eq $True) {
        Write-Host "Compress-Archive Powershell Module" -ForegroundColor Green -NoNewline
        Write-Host " by Forever" -ForegroundColor White
        Write-Host ""
        Write-Host "Usage:"
        Write-Host "    c <source> <destination> [method] [-Extreme]"
        Write-Host ""
        Write-Host "Switch [method]: "
        Write-Host '    zstd (default)   --> [-Extreme] option is available '
        Write-Host '    zip'
        Write-Host '    flzma2 (always using Extreme ratio)'
        Write-Host ''
        return ""
    }
    
    $CommandLineArgs = "a `"$Destination`" `"$Source`" "
    
    Write-Host "Compress-Archive Powershell Module" -ForegroundColor Green
    switch ($Method) {
        "zstd" {            
            $CommandLineArgs += "-m0=zstd "
            
            if ($Extreme -eq $True) {
                Write-Host "Using zstd level-22 [Highest] to compress  " -ForegroundColor DarkCyan -NoNewline
                Write-Host "(Extreme profile costs more memory)" -ForegroundColor Red
                
                $CommandLineArgs += "-mx=22 "
                # 7ZA a "$Destination" -m0=zstd -mx=22 "$Source"
            } 
            else {
                Write-Host "Using zstd level-19 [High] to compress" -ForegroundColor DarkCyan
                $CommandLineArgs += "-mx=19 "
                # ZIP zstd 19 $Destination $Source
                # 7ZA a "$Destination" -m0=zstd -mx=19 "$Source"
            }
            
            if ($Split -ne "undefined") {
                Write-Host "$Split Split" -ForegroundColor DarkYellow
                $CommandLineArgs += "-v$Split "
                # 7ZA a "$Destination" -m0=zstd -mx=22 -v$Split "$Source"
            }
            
            Write-Host "$CommandLineArgs" -ForegroundColor DarkGray
            Start-Process 7ZA -ArgumentList "$CommandLineArgs" -NoNewWindow -Wait
            return ""
        }    
        "flzma2" {            
            $CommandLineArgs += "-m0=flzma2 "
            
            Write-Host "Using flzma2 level-9 [Extreme] to compress" -ForegroundColor DarkCyan
            $CommandLineArgs += "-mx=19 "
            # ZIP flzma2 9 $Destination $Source
            # 7ZA a "$Destination" -m0=flzma2 -mx=9 "$Source"
            
            if ($Split -ne "undefined") {
                Write-Host "$Split Split" -ForegroundColor DarkYellow
                $CommandLineArgs += "-v$Split "
                # 7ZA a "$Destination" -m0=zstd -mx=22 -v$Split "$Source"
            }
            
            Write-Host "$CommandLineArgs" -ForegroundColor DarkGray
            Start-Process 7ZA -ArgumentList "$CommandLineArgs" -NoNewWindow -Wait
            return ""
        }
        "zip" {
            $CommandLineArgs += "-tzip "
            Write-Host "Using zip to compress" -ForegroundColor DarkCyan
            # ZIP flzma2 9 $Destination $Source
            Start-Process 7ZA -ArgumentList "$CommandLineArgs" -NoNewWindow -Wait
            return ""
        }
    }
}

Function Compress-ArchiveWithTimeStamp {
param (
    [switch] $Help = $False,
    [Parameter(Mandatory=$true)]
    [string] $Source,
    [string] $Method = "zstd",
    [string] $Split = "undefined",
    [switch] $WithTimeStamp = $False,
    [switch] $Extreme = $False
)
    <# 
    
    if ($Source.Length -eq 0) {
        Write-Error "Not a valid directory: $Source"
        Return
    }
    if (-not (Test-Path -Path $Source -PathType Container)) {
        Write-Error "Not a valid directory: $Source"
        Return 
    }
    
    Write-Host "Compress-Archive Powershell Module" -ForegroundColor Green
    $Destination = Get-Location
    $Filename = Split-Path $Source -Leaf
    $Destination = Join-Path -Path $Destination -ChildPath $Filename
    $CompressTimeStamp = Get-Date -Format "_yyyy-MM-dd_HH-mm-ss"

    $Destination = $Destination + $CompressTimeStamp + '.z'
    # Write-Host 'Type "c -Help" to show help' -ForegroundColor DarkYellow
    Write-Host "Using zstd level-19 [High] to compress" -ForegroundColor DarkCyan
    # ZIP zstd 19 $Destination $Source
    7ZA a "$Destination" -m0=zstd -mx=19 "$Source" 
    
    #>
    
    if ($Help -eq $True) {
        Write-Host "Compress-Archive Powershell Module" -ForegroundColor Green -NoNewline
        Write-Host " [Archive Mode] by Forever" -ForegroundColor White
        Write-Host ""
        Write-Host "Usage:"
        Write-Host "    c <source> <destination> [method] [-Extreme]"
        Write-Host ""
        Write-Host "Switch [method]: "
        Write-Host '    zstd (default)   --> [-Extreme] option is available '
        Write-Host '    zip'
        Write-Host '    flzma2 (always using Extreme ratio)'
        Write-Host ''
        return ""
    }
    
    $CommandLineArgsPrev = "a "
    # $CommandLineArgs = "a `"$Destination`" `"$Source`" "
    $CommandLineArgs = "`"$Source`" "
    
    Write-Host "Compress-Archive Powershell Module" -ForegroundColor Green
    switch ($Method) {
        "zstd" {            
            $CommandLineArgs += "-m0=zstd "
            
            if ($Extreme -eq $True) {
                Write-Host "Using zstd level-22 [Highest] to compress  " -ForegroundColor DarkCyan -NoNewline
                Write-Host "(Extreme profile costs more memory)" -ForegroundColor Red
                
                $CommandLineArgs += "-mx=22 "
                # 7ZA a "$Destination" -m0=zstd -mx=22 "$Source"
            } 
            else {
                Write-Host "Using zstd level-19 [High] to compress" -ForegroundColor DarkCyan
                $CommandLineArgs += "-mx=19 "
                # ZIP zstd 19 $Destination $Source
                # 7ZA a "$Destination" -m0=zstd -mx=19 "$Source"
            }
            
            if ($Split -ne "undefined") {
                Write-Host "$Split Split" -ForegroundColor DarkYellow
                $CommandLineArgs += "-v$Split "
                # 7ZA a "$Destination" -m0=zstd -mx=22 -v$Split "$Source"
            }
            
            $Destination = Split-Path $Source -Leaf
            if ($WithTimeStamp) {
                $CompressTimeStamp = Get-Date -Format "_yyyy-MM-dd_HH-mm-ss"
                $Destination = $Destination + $CompressTimeStamp + '.z'
            } else {
                $Destination = $Destination + '.z'
            }
            
            $CommandLineArgsPrev += "`"$Destination`" "
            $CommandLineArgsPrev += $CommandLineArgs
            $CommandLineArgs = $CommandLineArgsPrev
            Write-Host "$CommandLineArgs" -ForegroundColor DarkGray
            Start-Process 7ZA -ArgumentList "$CommandLineArgs" -NoNewWindow -Wait
            return ""
        }    
        "flzma2" {            
            $CommandLineArgs += "-m0=flzma2 "
            
            Write-Host "Using flzma2 level-9 [Extreme] to compress" -ForegroundColor DarkCyan
            $CommandLineArgs += "-mx=19 "
            # ZIP flzma2 9 $Destination $Source
            # 7ZA a "$Destination" -m0=flzma2 -mx=9 "$Source"
            
            if ($Split -ne "undefined") {
                Write-Host "$Split Split" -ForegroundColor DarkYellow
                $CommandLineArgs += "-v$Split "
                # 7ZA a "$Destination" -m0=zstd -mx=22 -v$Split "$Source"
            }
            
            $Destination = Split-Path $Source -Leaf
            if ($WithTimeStamp) {
                $CompressTimeStamp = Get-Date -Format "_yyyy-MM-dd_HH-mm-ss"
                $Destination = $Destination + $CompressTimeStamp + '.f7z'
            } else {
                $Destination = $Destination + '.f7z'
            }
            
            $CommandLineArgsPrev += "`"$Destination`" "
            $CommandLineArgsPrev += $CommandLineArgs
            $CommandLineArgs = $CommandLineArgsPrev
            Write-Host "$CommandLineArgs" -ForegroundColor DarkGray
            Start-Process 7ZA -ArgumentList "$CommandLineArgs" -NoNewWindow -Wait
            return ""
        }
        "zip" {
            Write-Host "Using zip to compress" -ForegroundColor DarkCyan
            # ZIP flzma2 9 $Destination $Source
            # 7ZA a "$Destination" -tzip "$Source"
            
            $Destination = Split-Path $Source -Leaf
            if ($WithTimeStamp) {
                $CompressTimeStamp = Get-Date -Format "_yyyy-MM-dd_HH-mm-ss"
                $Destination = $Destination + $CompressTimeStamp + '.z'
            } else {
                $Destination = $Destination + '.z'
            }
            
            $CommandLineArgsPrev += "`"$Destination`" "
            $CommandLineArgsPrev += $CommandLineArgs
            $CommandLineArgs = $CommandLineArgsPrev
            Write-Host "$CommandLineArgs" -ForegroundColor DarkGray
            Start-Process 7ZA -ArgumentList "$CommandLineArgs" -NoNewWindow -Wait
            return ""
        }
    }
}

Set-Alias -Name "c" -Value "Compress-Archive" -Option AllScope -Scope Global
Set-Alias -Name "z" -Value "Compress-ArchiveWithTimeStamp" -Option AllScope -Scope Global