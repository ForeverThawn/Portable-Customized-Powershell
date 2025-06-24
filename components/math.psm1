$Global:e = 2.7182818284590452353602874713527
$Global:pi = 3.1415926535897932384626433832795
$Global:tau = 6.28318530717958647692528676627

Function Global:Get-SquareRootValue($value) {
    $p = [Double]::Parse($value)
    return [math]::Sqrt($p)
}

Function Global:Get-PowerValue($base, $exp) {
    $a = [Double]::Parse($base)
    $b = [Double]::Parse($exp)
    return [math]::Pow($a, $b)
}

Function Global:Get-AbsoluteValue($value) {
    return [math]::Abs($value)
}

Function Global:Get-ArcCosineValue($value) {
    return [math]::Acos($value)
}

Function Global:Get-ArcCosineHyperbolicValue($value) {
    return [math]::Acosh($value)
}

Function Global:Get-ArcSineValue($value) {
    return [math]::Asin($value)
}

Function Global:Get-ArcSineHyperbolicValue($value) {
    return [math]::Asinh($value)
}

Function Global:Get-ArcTangentValue($value) {
    return [math]::Atan($value)
}

Function Global:Get-ArcTangent2Value($a, $b) {
    return [math]::Atan2($a, $b)
}

Function Global:Get-CubeRootValue($value) {
    return [math]::Cbrt($value)
}

Function Global:Get-CeilingValue($value) {
    return [math]::Ceiling($value)
}

Function Global:Get-CosineValue($value) {
    return [math]::Cos($value)
}

Function Global:Get-CosineHyperbolicValue($value) {
    return [math]::Cosh($value)
}

Function Global:Get-ExponentialValue($value) {
    return [math]::Exp($value)
}

Function Global:Get-FloorValue($value) {
    return [math]::Floor($value)
}

Function Global:Get-NaturalLogValue($value) {
    return [math]::Log($value)
}

Function Global:Get-Log2Value($exp) {
    return [math]::Log2($exp)
}

Function Global:Get-Log10Value($exp) {
    return [math]::Log10($exp)
}

Function Global:Get-SineValue($value) {
    return [math]::Sin($value)
}

Function Global:Get-SineHyperbolicValue($value) {
    return [math]::Sinh($value)
}

Function Global:Get-TangentValue($value) {
    return [math]::Tan($value)
}

Function Global:Get-TangentHyperbolicValue($value) {
    return [math]::Tanh($value)
}

Function Global:Get-RoundValue($value) {
    return [math]::Round($value)
}


Set-Alias -Name "sqrt" -Value "Get-SquareRootValue" -Option AllScope -Scope Global
Set-Alias -Name "pow" -Value "Get-PowerValue" -Option AllScope -Scope Global
Set-Alias -Name "acos" -Value "Get-ArcCosineValue" -Option AllScope -Scope Global
Set-Alias -Name "asin" -Value "Get-ArcSineValue" -Option AllScope -Scope Global
Set-Alias -Name "atan" -Value "Get-ArcTangentValue" -Option AllScope -Scope Global
Set-Alias -Name "atan2" -Value "Get-ArcTangent2Value" -Option AllScope -Scope Global
Set-Alias -Name "cos" -Value "Get-CosineValue" -Option AllScope -Scope Global
Set-Alias -Name "sin" -Value "Get-SineValue" -Option AllScope -Scope Global
Set-Alias -Name "tan" -Value "Get-TangentValue" -Option AllScope -Scope Global
Set-Alias -Name "ln" -Value "Get-NaturalLogValue" -Option AllScope -Scope Global
Set-Alias -Name "log2" -Value "Get-Log2Value" -Option AllScope -Scope Global
Set-Alias -Name "log10" -Value "Get-Log10Value" -Option AllScope -Scope Global
Set-Alias -Name "acosh" -Value "Get-ArcCosineHyperbolicValue" -Option AllScope -Scope Global
Set-Alias -Name "asinh" -Value "Get-ArcSineHyperbolicValue" -Option AllScope -Scope Global
Set-Alias -Name "atanh" -Value "Get-ArcTangentHyperbolicValue" -Option AllScope -Scope Global
Set-Alias -Name "cosh" -Value "Get-CosineHyperbolicValue" -Option AllScope -Scope Global
Set-Alias -Name "sinh" -Value "Get-SineHyperbolicValue" -Option AllScope -Scope Global
Set-Alias -Name "tanh" -Value "Get-TangentHyperbolicValue" -Option AllScope -Scope Global
Set-Alias -Name "exp" -Value "Get-ExponentialValue" -Option AllScope -Scope Global
Set-Alias -Name "abs" -Value "Get-AbsoluteValue" -Option AllScope -Scope Global
Set-Alias -Name "floor" -Value "Get-FloorValue" -Option AllScope -Scope Global
Set-Alias -Name "ceiling" -Value "Get-CeilingValue" -Option AllScope -Scope Global
Set-Alias -Name "round" -Value "Get-RoundValue" -Option AllScope -Scope Global
Set-Alias -Name "cbrt" -Value "Get-CubeRootValue" -Option AllScope -Scope Global
