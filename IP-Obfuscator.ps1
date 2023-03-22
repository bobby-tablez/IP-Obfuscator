$ip = Read-Host -Prompt "IP address to obfuscate (IPv4 only)"

if (-not ([System.Net.IPAddress]::TryParse($ip, [ref]$null))) {
        throw "Invalid IP address: $ip"
        Exit
    }

$ipmod = $ip -split '\.'
$first = $ipmod[0]
$hex = [System.Convert]::ToString($first,16)

$decimal = 0

for ($i = 1; $i -lt 4; $i++) {
    $decimal += [int]::Parse($ipmod[$i]) * [Math]::Pow(256, 3 - $i)
}

$final = "0x" + $hex + "." + $decimal 

Write-Host "`nYour obfuscated IP address:"
Write-Host $final -ForegroundColor Yellow
