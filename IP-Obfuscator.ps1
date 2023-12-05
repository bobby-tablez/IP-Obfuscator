<# 
.SYNOPSIS
    Obfuscate IP addresses (IPv4 only)
.DESCRIPTION 
     This quick tool obfuscates IP addreses using hexadecimal, decimal, octal and mixed notation conversions.
.NOTES 
    Use at your own risk! For educational purposes only.
.LINK 
    https://github.com/bobby-tablez/IP-Obfuscator/blob/main/IP-Obfuscator.ps1
#>

$ip = Read-Host -Prompt "IP address to obfuscate (IPv4 only)"
$ipmod = $ip -split '\.'

if (-not ([System.Net.IPAddress]::TryParse($ip, [ref]$null))) {
    throw "Invalid IP address: $ip"
    Exit
}

Function HexMerge {  
    $hexOneOctets = $ipmod | ForEach-Object {
            $hexOne = [Convert]::ToString($_, 16)
            If ($hexOne.Length -eq 1) { $hexOne = "0" + $hexOne }
            $hexOne
        }

    $hexOneAddress = $hexOneOctets -join ''
    Return "0X" + $hexOneAddress.ToUpper()
}

Function HexAll {   
    $hexAllOctets = $ipmod | ForEach-Object {
            $hexAll = [Convert]::ToString($_, 16)
            If ($hexAll.Length -eq 1) { $hexAll = "0" + $hexAll }
            $hexAll
        }

    $hexAllAddress = $hexAllOctets -join '.0x'
    Return "0X" + $hexAllAddress.ToUpper()
}

Function HexThree {   
    $mixedOctetsThree = $ipmod[0..2] | ForEach-Object {
        "0x" + [Convert]::ToString($_, 16)
    }
    $mixedOctetsThree += $ipmod[3]

    $mixedAddressThree = $mixedOctetsThree -join '.'
    Return $mixedAddressThree.ToUpper()
}

Function HexTwo {   
    $mixedOctetsTwo = $ipmod[0..1] | ForEach-Object {
        "0x" + [Convert]::ToString($_, 16)
    }
    $mixedOctetsTwo += $ipmod[2..3]

    $mixedAddressTwo = $mixedOctetsTwo -join '.'
    Return $mixedAddressTwo.ToUpper()
}

Function HexOne {   
    $mixedOctetsOne = $ipmod[0]
    $hexOne = "0x" + [Convert]::ToString($mixedOctetsOne, 16)
    $hexRest = $ipmod[1..3] -join '.'

    $mixedAddressOne = $hexOne + "." + $hexRest
    Return $mixedAddressOne.ToUpper()
}

Function HexFull {    
    $padHexOctets = $ipmod | ForEach-Object {
        $hexPad = "0x" + [Convert]::ToString($_, 16).PadLeft(8, '0')
        $hexPad
    }

    $padHexAddress = $padHexOctets -join '.'
    Return $padHexAddress.ToUpper()
}

Function HexFullThree {   
    $mixedHexFullThree = $ipmod[0..2] | ForEach-Object {
        "0x" + [Convert]::ToString($_, 16).PadLeft(8, '0')
    }
    $mixedHexFullThree += $ipmod[3]

    $mixedHexAddrThree = $mixedHexFullThree -join '.'
    Return $mixedHexAddrThree.ToUpper()
}

Function HexFullTwo {   
    $mixedHexFullTwo = $ipmod[0..1] | ForEach-Object {
        "0x" + [Convert]::ToString($_, 16).PadLeft(8, '0')
    }
    $mixedHexFullTwo += $ipmod[2..3]

    $mixedHexAddrTwo = $mixedHexFullTwo -join '.'
    Return $mixedHexAddrTwo.ToUpper()
}

Function HexFullOne {   
    $mixedHexFullOne = $ipmod[0]
    $hexFullOne = "0x" + [Convert]::ToString($mixedHexFullOne, 16).PadLeft(8, '0')
    $hexFullRest = $ipmod[1..3] -join '.'

    $mixedHexAddrOne = $hexFullOne + "." + $hexFullRest
    Return $mixedHexAddrOne.ToUpper()
}

Function HexDec {    
    $first = $ipmod[0]
    $hexDec = [System.Convert]::ToString($first,16)

    $decimal = 0

    For ($i = 1; $i -lt 4; $i++) {
        $decimal += [int]::Parse($ipmod[$i]) * [Math]::Pow(256, 3 - $i)
    }

    $final = "0X" + $hexDec + "." + $decimal 
    Return $final.ToUpper()
}

Function Decimal {   
    $DecIP = 0

    For ($p = 3; $p -ge 0; $p--) {
        $DecIP += [Math]::Pow(256, $p) * [int]$ipmod[3 - $p]
    }

    Return $DecIP  
}

Function LongDec {   
    $long = 0
    for ($i = 0; $i -lt 4; $i++) {
        $long += [int]$ipmod[$i] * [Math]::Pow(256, 3 - $i)
    }

    $octal = "0" + [Convert]::ToString($long, 8)

    Return $octal -replace 'o', ''
}

Function DottedOctal {   
    $octalOctets = $ipmod | ForEach-Object {
        $dotOctal = [Convert]::ToString($_, 8).PadLeft(4, '0')
        $dotOctal
    }

    $octalAddr = $octalOctets -join '.'
    Return $octalAddr
}

Function OctalThree {   
    $mixedOctThree = $ipmod[0..2] | ForEach-Object {
        [Convert]::ToString($_, 8).PadLeft(4, '0')
    }
    $mixedOctThree += $ipmod[3]

    $mixedOctThree = $mixedOctThree -join '.'
    Return $mixedOctThree
}

Function OctalTwo {   
    $mixedOctTwo = $ipmod[0,1] | ForEach-Object {
        [Convert]::ToString($_, 8).PadLeft(4, '0')
    }
    $mixedOctTwo += $ipmod[2,3]

    $mixedOctTwo = $mixedOctTwo -join '.'
    Return $mixedOctTwo
}

Function OctalOne {   
    $mixedOctOne = $ipmod[0]
    $octOne = [Convert]::ToString($mixedOctOne, 8).PadLeft(4, '0')
    $octRest = $ipmod[1..3] -join '.'

    $mixedOctOne = $octOne + "." + $octRest
    Return $mixedOctOne
}

Function PaddedOctal {   
    $octalOctets = $ipmod | ForEach-Object {
        $dotOctal = [Convert]::ToString($_, 8).PadLeft(8, '0')
        $dotOctal
    }

    $octalAddr = $octalOctets -join '.'
    Return $octalAddr
}

Function PaddedOctalThree {   
    $mixedPadOctThree = $ipmod[0..2] | ForEach-Object {
        [Convert]::ToString($_, 8).PadLeft(8, '0')
    }
    $mixedPadOctThree += $ipmod[3]

    $mixedPadOctThree = $mixedPadOctThree -join '.'
    Return $mixedPadOctThree
}

Function PaddedOctalTwo {   
    $mixedPadOctTwo = $ipmod[0,1] | ForEach-Object {
        [Convert]::ToString($_, 8).PadLeft(8, '0')
    }
    $mixedPadOctTwo += $ipmod[2,3]

    $mixedPadOctTwo = $mixedPadOctTwo -join '.'
    Return $mixedPadOctTwo
}

Function PaddedOctalOne {   
    $mixedPadOctOne = $ipmod[0]
    $octPadOne = [Convert]::ToString($mixedPadOctOne, 8).PadLeft(8, '0')
    $octPadRest = $ipmod[1..3] -join '.'

    $mixedPadOctOne = $octPadOne + "." + $octPadRest
    Return $mixedPadOctOne
}

Function PrintIt {
    Write-Host "`nFormat Type`t`t" -nonewline; Write-Host "Obfuscated IP: "  -nonewline; Write-Host -ForegroundColor Red "($ip)"
    Write-Host ('-' * $Host.UI.RawUI.WindowSize.Width)
    Write-Host -ForegroundColor DarkYellow "Hexadecimal (No Dots):`t" -nonewline; Write-Host -ForegroundColor Yellow $(HexMerge)
    Write-Host -ForegroundColor DarkYellow "Hexadecimal (Dots):`t" -nonewline; Write-Host -ForegroundColor Yellow $(HexAll)
    Write-Host -ForegroundColor DarkYellow "Hexadecimal (Dots[3]):`t" -nonewline; Write-Host -ForegroundColor Yellow $(HexThree)
    Write-Host -ForegroundColor DarkYellow "Hexadecimal (Dots[2]):`t" -nonewline; Write-Host -ForegroundColor Yellow $(HexTwo)
    Write-Host -ForegroundColor DarkYellow "Hexadecimal (Dots[1]):`t" -nonewline; Write-Host -ForegroundColor Yellow $(HexOne)
    Write-Host -ForegroundColor DarkYellow "Hexadecimal (Full):`t" -nonewline; Write-Host -ForegroundColor Yellow $(HexFull)
    Write-Host -ForegroundColor DarkYellow "Hexadecimal (Full[3]):`t" -nonewline; Write-Host -ForegroundColor Yellow $(HexFullThree)
    Write-Host -ForegroundColor DarkYellow "Hexadecimal (Full[2]):`t" -nonewline; Write-Host -ForegroundColor Yellow $(HexFullTwo)
    Write-Host -ForegroundColor DarkYellow "Hexadecimal (Full[1]):`t" -nonewline; Write-Host -ForegroundColor Yellow $(HexFullOne)
    Write-Host -ForegroundColor DarkYellow "Hex + Decimal:`t`t" -nonewline; Write-Host -ForegroundColor Yellow $(HexDec)
    Write-Host -ForegroundColor DarkYellow "Decimal:`t`t" -nonewline; Write-Host -ForegroundColor Yellow $(Decimal)
    Write-Host -ForegroundColor DarkYellow "LongOctal:`t`t" -nonewline; Write-Host -ForegroundColor Yellow $(LongDec)
    Write-Host -ForegroundColor DarkYellow "Octal:`t`t`t" -nonewline; Write-Host -ForegroundColor Yellow $(DottedOctal)
    Write-Host -ForegroundColor DarkYellow "Octal: (Dots[3])`t" -nonewline; Write-Host -ForegroundColor Yellow $(OctalThree)
    Write-Host -ForegroundColor DarkYellow "Octal: (Dots[2])`t" -nonewline; Write-Host -ForegroundColor Yellow $(OctalTwo)
    Write-Host -ForegroundColor DarkYellow "Octal: (Dots[1])`t" -nonewline; Write-Host -ForegroundColor Yellow $(OctalOne)
    Write-Host -ForegroundColor DarkYellow "PaddedOctal:`t`t" -nonewline; Write-Host -ForegroundColor Yellow $(PaddedOctal)
    Write-Host -ForegroundColor DarkYellow "PaddedOctal (Dots[3]):`t" -nonewline; Write-Host -ForegroundColor Yellow $(PaddedOctalThree)
    Write-Host -ForegroundColor DarkYellow "PaddedOctal (Dots[2]):`t" -nonewline; Write-Host -ForegroundColor Yellow $(PaddedOctalTwo)
    Write-Host -ForegroundColor DarkYellow "PaddedOctal (Dots[1]):`t" -nonewline; Write-Host -ForegroundColor Yellow $(PaddedOctalOne)
    Write-Host ('-' * $Host.UI.RawUI.WindowSize.Width)
    Write-Host ""
}


try {
    PrintIt
}
Catch{
    Write-Host "Error: $($_.Exception.Message)"
    Exit 1
}

