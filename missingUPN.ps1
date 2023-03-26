
function todaydate {
    Get-Date -Format "dd-MM-yyyy"
}
$date = todaydate
$sam = "88017648"
$ticket = "INC000023387097"
$upn = -join($sam,"@satsnet.com.sg")
$email = -join($sam,"@sats.com.sg")
Set-AdUser -Identity $sam -EmailAddress $email -UserPrincipalName $upn -Description "Modified by: [Jun Yuan, $date, $ticket]"
Get-ADuser $sam -properties UserPrincipalName, EmailAddress, Description, Company | Select UserPrincipalName, EmailAddress, Description, Company

