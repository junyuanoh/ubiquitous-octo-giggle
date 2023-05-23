# sign-in logs
Connect-AzureAD

$csvloc1 = Read-Host "Enter path to .csv" 
$csvloc2 = $csvloc1.Replace("`"","")
$users = Import-Csv $csvloc2

foreach ($user in $users) {
    $upn = $user.UserPrincipalName
    Get-AzureADAuditSignInLogs -Filter "startsWith(userPrincipalName,'$upn')" | Export-Csv -Path "\\Mac\Home\Desktop\OutputCSV\$upn.csv" -NoTypeInformation
}

# get sign-in logs filtered to IP Address
# https://learn.microsoft.com/en-us/powershell/module/azuread/get-azureadauditsigninlogs?view=azureadps-2.0-preview
# https://infrasos.com/get-azureadauditsigninlogs-find-sign-in-logs-for-last-30-days-with-powershell/


Connect-AzureAD

$csvloc1 = Read-Host "Enter path to .csv" 
$csvloc2 = $csvloc1.Replace("`"","")
$users = Import-Csv $csvloc2
$ipaddress = Read-Host "Enter ipaddress"

foreach ($user in $users) {
    $upn = $user.UserPrincipalName
    Get-AzureADAuditSignInLogs -Filter "startsWith(userPrincipalName,'$upn')" | Where-Object { $_.IpAddress -eq $ipaddress } | Export-Csv -Path "\\Mac\Home\Desktop\OutputCSV\INC000023753531\sign-in\$upn.csv" -NoTypeInformation
}


