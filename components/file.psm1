Function Global:Rename-Items {
param(
    [string] $dir,
    [string] $file_type,
    [string] $find, 
    [string] $replace_to
)
    <#
    .SYNOPSIS
    Replace the specified string from specified files

    .DESCRIPTION
    Rename-Items <directory> <file_type> <find_string> <replace_to>
    
    Examples:
        > Rename-Items . txt "abc" ""
        > Rename-Items X:\test\ zip "nocopy" "ok"
        
    .EXAMPLE

    > Rename-Items . txt "abc" ""
    > Rename-Items X:\test\ zip "nocopy" "ok"

    #>
    $file_type = '*.' + $file_type
    Get-ChildItem $dir -i $file_type -r | foreach {
        Rename-Item $_.FullName $_.FullName.Replace("$find", "$replace_to")
    }
}

Function Global:Get-Hash {
param(
    [Parameter(Mandatory = $true)] [string] $File,
    [Parameter(Mandatory = $false)] [ValidateSet('SHA256', 'SHA384', 'SHA512', 'SHA1', 'MD5', 'all')] [string] $Algorithm = 'all'
)
    if ($Algorithm -eq 'all') {
        $Algorithms = @('SHA256', 'SHA384', 'SHA512', 'SHA1', 'MD5')
        $Hashs = @()

        foreach ($each in $Algorithms) {
            $Hashs += Get-FileHash -Algorithm $each -Path $File
        }

        $constructed_results = @()

        foreach ($Hash in $Hashs) {
            $constructed_results += [PSCustomObject]@{
                Algorithm = "$($Hash.Algorithm)"; 
                Hash = $Hash.Hash
            }
        }
        return $constructed_results
    }

    $constructed_results = @(
        [PSCustomObject]@{
            Algorithm = $Algorithm.ToUpper(); 
            Hash = (Get-FileHash -Algorithm $Algorithm -Path $File).Hash
        }
    )

    return $constructed_results
    
}

Function Invoke-CheckHash {
param(
    [Parameter(Mandatory = $true)] [string] $File,
    [Parameter(Mandatory = $true)] [ValidateSet('SHA256', 'SHA384', 'SHA512', 'SHA1', 'MD5')] [string] $Algorithm,
    [Parameter(Mandatory = $true)] [string] $Checksum
)
    $hash = Get-FileHash -Algorithm $Algorithm -Path $File

    $constructed_results = @(
        [PSCustomObject]@{
            File = "$File"; 
            Algorithm = $Algorithm.ToUpper();
            Valid = ($hash.Hash -eq $Checksum)
        }
    )

    return $constructed_results
}

function Global:Write-BinaryFile {
param (
    [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
    [byte[]]$Bytes,

    [Parameter(Mandatory = $true)]
    [string]$FilePath
)

begin {
    $allBytes = [System.Collections.Generic.List[byte]]::new()
}

process {
    $allBytes.AddRange($Bytes)
}

end {
    function _timeout($u, $key) {
        $seconds = 9
        $startTime = Get-Date
        $timeOut = New-TimeSpan -Seconds $seconds
        Write-Host ('File already exists, overwriting?: ') -NoNewline
        Write-Host ("$u") -ForegroundColor DarkYellow -NoNewline
        Write-Host (' ?')
        Write-Host ('[Y] Yes, ') -NoNewline
        Write-Host ('[N] No') -ForegroundColor Yellow -NoNewline
        Write-Host ("    (default is '$($key)')") -ForegroundColor DarkGray 
        # Basic progress bar
        [Console]::CursorLeft = 0
        [Console]::Write("[")
        [Console]::CursorLeft = $seconds + 2
        [Console]::Write("]")
        [Console]::CursorLeft = 1
        while (-not [System.Console]::KeyAvailable) {
            $currentTime = Get-Date
            Start-Sleep -s 1
            Write-Host "#" -ForegroundColor Green -NoNewline
            if ($currentTime -gt $startTime + $timeOut) {
                Break
            }
        }
        if ([System.Console]::KeyAvailable) {
            $response = [System.Console]::ReadKey($true).Key
        }
        else {
            $response = $key
        }
        return $response.ToString()
    }

    if (Test-Path $FilePath) {
        $FilePath = Resolve-Path $FilePath
        $res = _timeout $FilePath 'N'
        if ($res -eq 'Y') {
            [Console]::CursorLeft = 0
            Write-Host "Overwrite file: $FilePath" -ForegroundColor DarkYellow
            Write-Host ""
        }
        else {
            [Console]::CursorLeft = 0
            Write-Host "Skipping..    " -ForegroundColor DarkCyan
            return
        }

    }

    New-Item -Path $FilePath -InformationAction SilentlyContinue -Force | Out-Null

    try {
        [System.IO.File]::WriteAllBytes($FilePath, $allBytes.ToArray())
        Write-Host "Successfully write to file：$FilePath`n"
        Get-Item $FilePath
    }
    catch {
        Write-Error "Write Error：$($_.Exception.Message)"
    }
}
}    

Function Global:New-Directory {
param (
    [Parameter(Mandatory=$true)]
    [string]$Path
)
    New-Item -Name "$Path" -ItemType Directory
    CD $Path
}

Set-Alias -Name 'mdcd' -Value 'New-Directory' -Option AllScope -Scope Global
Set-Alias -Name 'Check-Hash' -Value 'Invoke-CheckHash' -Option AllScope -Scope Global