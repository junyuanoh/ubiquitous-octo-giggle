[DateTime]$start = [DateTime]::UtcNow.AddDays(-1)
[DateTime]$end = [DateTime]::UtcNow
[DateTime]$currentStart = $start
[DateTime]$currentEnd = $end
$record = "AzureActiveDirectory"
$resultSize = 5000
Search-UnifiedAuditLog -StartDate $currentStart -EndDate $currentEnd -RecordType $record -SessionCommand ReturnLargeSet -ResultSize $resultSize -UserIds satsvn_junyuanoh@sats.com.sg

Connect-ExchangeOnline 
$csvloc1 = Read-Host "Enter path to .csv (accepts with or without quotes)" 
$csvloc2 = $csvloc1.Replace("`"","")
$users = Import-Csv $csvloc2
[DateTime]$start = [DateTime]::UtcNow.AddDays(-14)
[DateTime]$end = [DateTime]::UtcNow
[DateTime]$currentStart = $start
[DateTime]$currentEnd = $end
$record = "AzureActiveDirectory"
$resultSize = 5000

foreach ($user in $users) {
    $upn = $user.UserPrincipalName
    Search-UnifiedAuditLog -StartDate $currentStart -EndDate $currentEnd -RecordType $record -SessionCommand ReturnLargeSet -ResultSize $resultSize -UserIds $upn | Export-Csv -Path "\\Mac\Home\Desktop\TestCSV\userPrimaryID_08-05.csv" -NoTypeInformation -Append
}

Connect-ExchangeOnline 

[DateTime]$start = [DateTime]::UtcNow.AddDays(-11)
[DateTime]$end = [DateTime]::UtcNow
[DateTime]$currentStart = $start
[DateTime]$currentEnd = $end
$resultSize = 5000
$upn = Read-Host "Enter UPN"

Search-UnifiedAuditLog -StartDate $currentStart -EndDate $currentEnd -SessionCommand ReturnLargeSet -ResultSize $resultSize -UserIds $upn | Export-Csv -Path "\\Mac\Home\Desktop\TestCSV\$upn.csv" -NoTypeInformation -Append


