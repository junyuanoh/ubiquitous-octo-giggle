Write-Host "`nConnecting to IPPS Session (Security & Compliance`n)"
$userUPN = Read-Host "Please enter your work email"
Connect-IPPSSession -UserPrincipalName $userUPN

$phish1 = Read-Host "Enter phishing email no.1"
Set-ComplianceSearch -Identity "Phish Mail (JY)" -ContentMatchQuery "from=$phish1"
Start-ComplianceSearch -Identity "Phish Mail (JY)" -Confirm:$false -Force

$phish2 = Read-Host "Enter phishing email no.2"
Set-ComplianceSearch -Identity "JY (Phish) 2" -ContentMatchQuery "from=$phish2"
Start-ComplianceSearch -Identity "JY (Phish) 2" -Confirm:$false -Force

$phish3 = Read-Host "Enter phishing email no.3"
Set-ComplianceSearch -Identity "JY (Phish) 3" -ContentMatchQuery "from=$phish3"
Start-ComplianceSearch -Identity "JY (Phish) 3" -Confirm:$false -Force

$phish4 = Read-Host "Enter phishing email no.4"
Set-ComplianceSearch -Identity "JY (Phish) 4" -ContentMatchQuery "from=$phish4"
Start-ComplianceSearch -Identity "JY (Phish) 4" -Confirm:$false -Force

$phish5 = Read-Host "Enter phishing email no.5"
Set-ComplianceSearch -Identity "JY (Phish) 5" -ContentMatchQuery "from=$phish5"
Start-ComplianceSearch -Identity "JY (Phish) 5" -Confirm:$false -Force

$phish6 = Read-Host "Enter phishing email no.6"
Set-ComplianceSearch -Identity "JY (Phish) 6" -ContentMatchQuery "from=$phish6"
Start-ComplianceSearch -Identity "JY (Phish) 6" -Confirm:$false -Force

$phish7 = Read-Host "Enter phishing email no.7"
Set-ComplianceSearch -Identity "JY (Phish) 7" -ContentMatchQuery "from=$phish7"
Start-ComplianceSearch -Identity "JY (Phish) 7" -Confirm:$false -Force

$phish8 = Read-Host "Enter phishing email no.8"
Set-ComplianceSearch -Identity "JY (Phish) 8" -ContentMatchQuery "from=$phish8"
Start-ComplianceSearch -Identity "JY (Phish) 8" -Confirm:$false -Force

$phish9 = Read-Host "Enter phishing email no.9"
Set-ComplianceSearch -Identity "JY (Phish) 9" -ContentMatchQuery "from=$phish9"
Start-ComplianceSearch -Identity "JY (Phish) 9" -Confirm:$false -Force

$phish10 = Read-Host "Enter phishing email no.10"
Set-ComplianceSearch -Identity "JY (Phish) 10" -ContentMatchQuery "from=$phish10"
Start-ComplianceSearch -Identity "JY (Phish) 10" -Confirm:$false -Force