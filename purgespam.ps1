Write-Host "`nConnecting to IPPS Session (Security & Compliance`n)"
$userUPN = Read-Host "Please enter your work email"
Connect-IPPSSession -UserPrincipalName $userUPN

$phish1 = Read-Host "Enter phishing email no.1"
Set-ComplianceSearch -Identity "Phish Mail (JY)" -ContentMatchQuery "$phish1"
Start-ComplianceSearch -Identity "Phish Mail (JY)" -Confirm:$false -Force

