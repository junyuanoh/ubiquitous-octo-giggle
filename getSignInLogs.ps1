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

#single IP
Connect-AzureAD

$csvloc1 = Read-Host "Enter path to .csv" 
$csvloc2 = $csvloc1.Replace("`"","")
$users = Import-Csv $csvloc2
$ipaddress = Read-Host "Enter ipaddress"

foreach ($user in $users) {
    $upn = $user.UserPrincipalName
    Get-AzureADAuditSignInLogs -Filter "startsWith(userPrincipalName,'$upn')" | Where-Object { $_.IpAddress -eq $ipaddress } | Export-Csv -Path "\\Mac\Home\Desktop\OutputCSV\INC000023723557\sign-in\$upn.csv" -NoTypeInformation
}


#multi IP
Connect-AzureAD

$userPrincipalNameCSV = Read-Host "Enter path to .csv for UPN" 
$ipAddressCSV = Read-Host "Enter path to .csv for IP" 
$exportCSV = Read-Host "Enter path to export"
$userPrincipalNameData = Import-Csv -Path $userPrincipalNameCSV
$ipAddressData = Import-Csv -Path $ipAddressCSV

foreach ($user in $userPrincipalNameData) {
    foreach ($ip in $ipAddressData) {
        #Create a file name using the convention: userprincipalname_ipaddress.csv
        $fileName = "$($user.UserPrincipalName)_$($ip.IPAddress).csv"
        
        #Export sign-in logs for the specified IP address
        $signIns = Install-Module AzureADPreview
 -Filter "IpAddress eq '$($ip.IPAddress)' and UserPrincipalName eq '$($user.UserPrincipalName)'"
        
        #Export the sign-in logs to a CSV file
        $signIns | Export-Csv -Path "$exportCSV\$fileName" -NoTypeInformation
    }
}