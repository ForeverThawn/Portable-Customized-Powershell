Function Global:New-Password {
param (
    [int] $Length = 8,
    [switch] $SpecialCharacter = $False
)
    if ($SpecialCharacter) {
        $characters = "ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnpqrstuvwxyz1234567890!@#$%^&*()_+-="
    } else {
        $characters = "ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnpqrstuvwxyz1234567890"
    }
    $randomString = -join ((1..$length) | ForEach-Object { $characters[(Get-Random -Minimum 0 -Maximum $characters.Length)] })
    return $randomString
}