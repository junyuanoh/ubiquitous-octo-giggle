Connect-AzureAD

$csvloc1 = Read-Host "Enter path to .csv" 
$csvloc2 = $csvloc1.Replace("`"","")
$users = Import-Csv $csvloc2

foreach ($user in $users) {
    $upn = $user.UserPrincipalName
    Get-AzureADAuditDirectoryLogs -Filter "targetResources/any(tr:tr/UserPrincipalName eq '$upn')" | Export-Csv -Path "\\Mac\Home\Desktop\AD Scripts\$upn.csv" -NoTypeInformation
}