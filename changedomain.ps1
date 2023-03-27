Connect-MsolService 
$csvloc1 = Read-Host "Enter path to .csv (accepts with or without quotes)" 
$csvloc2 = $csvloc1.Replace("`"","")
$users = Import-Csv $csvloc2
foreach($user in $users) {
        $oldupn = $user.oldUserPrincipalName
        $upn = $user.UserPrincipalName
        Set-MsolUserPrincipalName -UserPrincipalName $oldupn -NewUserPrincipalName $upn
        Get-MsolUser -UserPrincipalName $upn | Format-List Licenses, UserPrincipalName, UsageLocation
}