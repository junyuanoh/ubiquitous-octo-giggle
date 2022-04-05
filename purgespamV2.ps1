Write-Host "`nConnecting to IPPS Session (Security & Compliance)`n"
$userUPN = Read-Host "Please enter your work email"
Connect-IPPSSession -UserPrincipalName $userUPN

Write-Host "`n This script will set compliance search to your specified email address,`n run the compliance search, and add it into a mail flow blacklist."
Write-Host "`nEnter 'Q' to quit`n"

$phish1 = (Read-Host "Enter phishing email no.1").Trim()
$phish1 = $phish1 -replace "\s", ""

while ($true) {
    if ($phish1 -eq "" -or $phish1 -eq $null) {
        $phish1 = (Read-Host "Enter phishing email no.1").Trim()
        $phish1 = $phish1 -replace "\s",""
    }
    elseif ($phish1 -in 'Q', 'q') {
        Write-Host "Ending session..."
        break
    }
    else {
        Write-Host "Starting compliance search and adding email address to blacklist transport rule..."
        Set-ComplianceSearch -Identity "Phish Mail (JY)" -ContentMatchQuery "from=$phish1"
        Start-ComplianceSearch -Identity "Phish Mail (JY)" -Confirm:$false -Force
        Set-TransportRule "Blacklist email address 7" -from ((Get-TransportRule "Blacklist email address 7").From += "$phish1")
        break
    }
}

$phish2 = (Read-Host "Enter phishing email no.2").Trim()
$phish2 = $phish2 -replace "\s", ""

while ($true) {
    if ($phish2 -eq "" -or $phish2 -eq $null) {
        $phish2 = (Read-Host "Enter phishing email no.2").Trim()
        $phish2 = $phish2 -replace "\s",""
    }
    elseif ($phish2 -in 'Q', 'q') {
        Write-Host "Ending session..."
        break
    }
    else {
        Write-Host "Starting compliance search and adding email address to blacklist transport rule..."
        Set-ComplianceSearch -Identity "JY (Phish) 2" -ContentMatchQuery "from=$phish2"
        Start-ComplianceSearch -Identity "JY (Phish) 2" -Confirm:$false -Force
        Set-TransportRule "Blacklist email address 7" -from ((Get-TransportRule "Blacklist email address 7").From += "$phish2")
        break
    }
}

$phish3 = (Read-Host "Enter phishing email no.3").Trim()
$phish3 = $phish3 -replace "\s", ""

while ($true) {
    if ($phish3 -eq "" -or $phish3 -eq $null) {
        $phish3 = (Read-Host "Enter phishing email no.3").Trim()
        $phish3 = $phish3 -replace "\s",""
    }
    elseif ($phish3 -in 'Q', 'q') {
        Write-Host "Ending session..."
        break
    }
    else {
        Write-Host "Starting compliance search and adding email address to blacklist transport rule..."
        Set-ComplianceSearch -Identity "JY (Phish) 3" -ContentMatchQuery "from=$phish3"
        Start-ComplianceSearch -Identity "JY (Phish) 3" -Confirm:$false -Force
        Set-TransportRule "Blacklist email address 7" -from ((Get-TransportRule "Blacklist email address 7").From += "$phish3")
        break
    }
}

$phish4 = (Read-Host "Enter phishing email no.4").Trim()
$phish4 = $phish4 -replace "\s", ""

while ($true) {
    if ($phish4 -eq "" -or $phish4 -eq $null) {
        $phish4 = (Read-Host "Enter phishing email no.4").Trim()
        $phish4 = $phish4 -replace "\s",""
    }
    elseif ($phish4 -in 'Q', 'q') {
        Write-Host "Ending session..."
        break
    }
    else {
        Write-Host "Starting compliance search and adding email address to blacklist transport rule..."
        Set-ComplianceSearch -Identity "JY (Phish) 4" -ContentMatchQuery "from=$phish4"
        Start-ComplianceSearch -Identity "JY (Phish) 4" -Confirm:$false -Force
        Set-TransportRule "Blacklist email address 7" -from ((Get-TransportRule "Blacklist email address 7").From += "$phish4")
        break
    }
}

$phish5 = (Read-Host "Enter phishing email no.5").Trim()
$phish5 = $phish5 -replace "\s", ""

while ($true) {
    if ($phish5 -eq "" -or $phish5 -eq $null) {
        $phish5 = (Read-Host "Enter phishing email no.5").Trim()
        $phish5 = $phish5 -replace "\s",""
    }
    elseif ($phish5 -in 'Q', 'q') {
        Write-Host "Ending session..."
        break
    }
    else {
        Write-Host "Starting compliance search and adding email address to blacklist transport rule..."
        Set-ComplianceSearch -Identity "JY (Phish) 5" -ContentMatchQuery "from=$phish5"
        Start-ComplianceSearch -Identity "JY (Phish) 5" -Confirm:$false -Force
        Set-TransportRule "Blacklist email address 7" -from ((Get-TransportRule "Blacklist email address 7").From += "$phish5")
        break
    }
}

$phish6 = (Read-Host "Enter phishing email no.6").Trim()
$phish6 = $phish6 -replace "\s", ""

while ($true) {
    if ($phish6 -eq "" -or $phish6 -eq $null) {
        $phish6 = (Read-Host "Enter phishing email no.6").Trim()
        $phish6 = $phish6 -replace "\s",""
    }
    elseif ($phish6 -in 'Q', 'q') {
        Write-Host "Ending session..."
        break
    }
    else {
        Write-Host "Starting compliance search and adding email address to blacklist transport rule..."
        Set-ComplianceSearch -Identity "JY (Phish) 6" -ContentMatchQuery "from=$phish6"
        Start-ComplianceSearch -Identity "JY (Phish) 6" -Confirm:$false -Force
        Set-TransportRule "Blacklist email address 7" -from ((Get-TransportRule "Blacklist email address 7").From += "$phish6")
        break
    }
}

$phish7 = (Read-Host "Enter phishing email no.7").Trim()
$phish7 = $phish7 -replace "\s", ""

while ($true) {
    if ($phish7 -eq "" -or $phish7 -eq $null) {
        $phish7 = (Read-Host "Enter phishing email no.7").Trim()
        $phish7 = $phish7 -replace "\s",""
    }
    elseif ($phish7 -in 'Q', 'q') {
        Write-Host "Ending session..."
        break
    }
    else {
        Write-Host "Starting compliance search and adding email address to blacklist transport rule..."
        Set-ComplianceSearch -Identity "JY (Phish) 7" -ContentMatchQuery "from=$phish7"
        Start-ComplianceSearch -Identity "JY (Phish) 7" -Confirm:$false -Force
        Set-TransportRule "Blacklist email address 7" -from ((Get-TransportRule "Blacklist email address 7").From += "$phish7")
        break
    }
}

$phish8 = (Read-Host "Enter phishing email no.8").Trim()
$phish8 = $phish8 -replace "\s", ""

while ($true) {
    if ($phish8 -eq "" -or $phish8 -eq $null) {
        $phish8 = (Read-Host "Enter phishing email no.8").Trim()
        $phish8 = $phish8 -replace "\s",""
    }
    elseif ($phish8 -in 'Q', 'q') {
        Write-Host "Ending session..."
        break
    }
    else {
        Write-Host "Starting compliance search and adding email address to blacklist transport rule..."
        Set-ComplianceSearch -Identity "JY (Phish) 8" -ContentMatchQuery "from=$phish8"
        Start-ComplianceSearch -Identity "JY (Phish) 8" -Confirm:$false -Force
        Set-TransportRule "Blacklist email address 7" -from ((Get-TransportRule "Blacklist email address 7").From += "$phish8")
        break
    }
}

$phish9 = (Read-Host "Enter phishing email no.9").Trim()
$phish9 = $phish9 -replace "\s", ""

while ($true) {
    if ($phish9 -eq "" -or $phish9 -eq $null) {
        $phish9 = (Read-Host "Enter phishing email no.9").Trim()
        $phish9 = $phish9 -replace "\s",""
    }
    elseif ($phish9 -in 'Q', 'q') {
        Write-Host "Ending session..."
        break
    }
    else {
        Write-Host "Starting compliance search and adding email address to blacklist transport rule..."
        Set-ComplianceSearch -Identity "JY (Phish) 9" -ContentMatchQuery "from=$phish9"
        Start-ComplianceSearch -Identity "JY (Phish) 9" -Confirm:$false -Force
        Set-TransportRule "Blacklist email address 7" -from ((Get-TransportRule "Blacklist email address 7").From += "$phish9")
        break
    }
}

$phish10 = (Read-Host "Enter phishing email no.10").Trim()
$phish10 = $phish10 -replace "\s", ""

while ($true) {
    if ($phish10 -eq "" -or $phish10 -eq $null) {
        $phish10 = (Read-Host "Enter phishing email no.10").Trim()
        $phish10 = $phish10 -replace "\s",""
    }
    elseif ($phish10 -in 'Q', 'q') {
        Write-Host "Ending session..."
        break
    }
    else {
        Write-Host "Starting compliance search and adding email address to blacklist transport rule..."
        Set-ComplianceSearch -Identity "JY (Phish) 10" -ContentMatchQuery "from=$phish10"
        Start-ComplianceSearch -Identity "JY (Phish) 10" -Confirm:$false -Force
        Set-TransportRule "Blacklist email address 7" -from ((Get-TransportRule "Blacklist email address 7").From += "$phish10")
        break
    }
}

Write-Host "Completed.`nEnding session..."
Remove-PSSession $Session




