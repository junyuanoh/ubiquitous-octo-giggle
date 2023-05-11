# Import the list of SAMAccountNames from a CSV file
$samAccounts = Import-Csv -Path "C:\Users\satsaa_ad12\Desktop\leftover_accounts.csv"

# Loop through each SAMAccountName and get its lastlogondate attribute
$results = foreach ($account in $samAccounts) {
    $samAccountName = $account.SAMAccountName
    $user = Get-ADUser -Identity $samAccountName -Properties LastLogonDate
    [PSCustomObject]@{
        SamAccountName = $samAccountName
        LastLogon = $user.LastLogonDate
    }
}

# Export the results to a CSV file
$results | Export-Csv -Path "C:\Users\satsaa_ad12\Desktop\leftover_output.csv" -NoTypeInformation
