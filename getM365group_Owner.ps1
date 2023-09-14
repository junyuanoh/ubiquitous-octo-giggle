#this works but takes a really long time if there are multiple M365 groups in the tenant
# Connect to your Microsoft 365 account (if not already connected)
Connect-ExchangeOnline -UserPrincipalName "satsvn_junyuanoh@sats.com.sg" 

# Get a list of all unified groups
$groups = Get-UnifiedGroup -ResultSize Unlimited

# Create an empty array to store the results
$results = @()

# Loop through each group and retrieve owners
foreach ($group in $groups) {
    $groupOwners = $group | Get-UnifiedGroupLinks -LinkType Owners
    $ownerNames = $groupOwners.PrimarySmtpAddress -join ', '

    $result = [PSCustomObject]@{
        GroupName = $group.DisplayName
        Owners = $ownerNames
    }

    $results += $result
}

# Export the results to a CSV file
$results | Export-Csv -Path "\\Mac\Home\Desktop\OutputCSV\group_owners_23-08-2023.csv" -NoTypeInformation

