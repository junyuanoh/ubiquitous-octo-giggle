#for MG Graph
Connect-MgGraph -Scope AuditLog.Read.All
$csvloc1 = Read-Host "Enter path to .csv" 
$csvloc2 = $csvloc1.Replace("`"","")
$users = Import-Csv $csvloc2
foreach ($user in $users) {
    $upn = $user.UserPrincipalName
    Get-MgAuditLogDirectoryAudit -filter "TargetResources/any(t:t/UserPrincipalName eq '$upn') and ActivityDisplayName eq 'Set force change user password'" | Export-Csv -Path "C:\Users\Administrator\Desktop\$upn.csv" -NoTypeInformation
}