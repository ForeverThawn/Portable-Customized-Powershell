$input = [System.Convert]::toDouble($args[0])
$ret = $input / 1024.0 
Write-Host ($ret) -NoNewline
Write-Host " KB"