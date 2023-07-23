Import-Module ActiveDirectory

$csvPath = Read-Host "Enter path to CSV file"
$outputPath = Read-Host "Enter output CSV file path"

# Read CSV file
$accounts = Import-Csv $csvPath

# Array to store modified accounts
$modifiedAccounts = @()

foreach ($account in $accounts) {
    $samAccountName = $account.samAccountName
    $user = Get-ADUser -Filter "samAccountName -eq '$samAccountName'"

    if ($user) {
        $displayName = $user.GivenName
        $user.DisplayName = $displayName
        Set-ADUser -Identity $user -DisplayName $displayName

        # Store modified account details
        $modifiedAccounts += [PSCustomObject]@{
            SamAccountName = $samAccountName
            DisplayName = $displayName
        }

        Write-Host "Modified DisplayName for '$samAccountName': $displayName"
    } else {
        Write-Host "Account with samAccountName '$samAccountName' not found."
    }
}

# Export modified accounts to CSV file
if ($modifiedAccounts.Count -gt 0) {
    $modifiedAccounts | Export-Csv -Path $outputPath -NoTypeInformation
    Write-Host "Changes exported to CSV file: $outputPath"
} else {
    Write-Host "No changes made. CSV file not exported."
}
