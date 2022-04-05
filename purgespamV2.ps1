Write-Host "`nConnecting to IPPS Session (Security & Compliance`n)"
$userUPN = Read-Host "Please enter your work email"
Connect-IPPSSession -UserPrincipalName $userUPN

$phish1 = Read-Host "Enter phishing email no.1"

while ($true) {
if ($phish1) { 
    Set-ComplianceSearch -Identity "Phish Mail (JY)" -ContentMatchQuery "from=$phish1" | Start-ComplianceSearch -Identity "Phish Mail (JY)" -Confirm:$false -Force
    break
}
elseif ($phish1 = "Q") {
    Write-Host "Ending session..."
    #Get-PSSession | Remove-PSSession
    break
}
else {
    $phish1 = Read-Host "Enter phishing email no.1"
}
}



