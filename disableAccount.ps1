$csvPath = Read-Host "Enter the path to the input CSV file"
$ouPath = "OU=Disabled,DC=satsnet,DC=com,DC=sg"
$description = "Disabled by: [Jun Yuan, 30-05-2023, RITM000000090797]"

$users = Import-Csv -Path $csvPath
foreach ($user in $users) {
    $samAccountName = $user.SamAccountName
    Set-ADUser $samAccountName -Description $description -Enabled $false
    Write-Host "Account '$samAccountName' disabled."
}
foreach ($user in $users) {
    $samAccountName = $user.SamAccountName
    Get-ADUser -Identity $samAccountName | Move-ADObject -TargetPath $ouPath
    Write-Host "Account '$samAccountName' disabled and moved to '$ouPath'"
}

