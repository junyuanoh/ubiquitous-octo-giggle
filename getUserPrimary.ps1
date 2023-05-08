Connect-MsolService 
$csvloc1 = Read-Host "Enter path to .csv (accepts with or without quotes)" 
$csvloc2 = $csvloc1.Replace("`"","")
$users = Import-Csv $csvloc2

foreach ($user in $users) {
    $upn = $user.samAccountName
    Get-User -identity $upn | Select-Object WindowsEmailAddress, UserPrincipalName | Export-Csv -Path "\\Mac\Home\Desktop\TestCSV\userPrimaryID_08-05.csv" -NoTypeInformation -Append
}