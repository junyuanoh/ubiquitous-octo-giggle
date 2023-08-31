# Connect to Exchange Online PowerShell
Connect-ExchangeOnline

# Replace these variables with your own values
$csvFilePath = Read-host "Enter .csv"  # Path to the CSV file containing UserPrincipalNames
$groupName = "Insight Ecosystem"        # Replace with the name of the M365 Unified Group

# Function to add users to the Unified Group
function Add-UserToUnifiedGroup {
    param (
        [string]$userPrincipalName,
        [string]$groupName
    )

    try {
        # Get the Unified Group
        $group = Get-UnifiedGroup -Identity $groupName -ErrorAction Stop

        # Add the user to the group
        Add-UnifiedGroupLinks -Identity $group.Identity -LinkType Members -Links $userPrincipalName -ErrorAction Stop

        Write-Host "Added user: $userPrincipalName to the group: $groupName"
    }
    catch {
        Write-Host "Error occurred while adding user: $userPrincipalName to the group: $groupName"
        Write-Host $_.Exception.Message
    }
}

# Read the CSV file and add users to the Unified Group
try {
    $users = Import-Csv -Path $csvFilePath
    foreach ($user in $users) {
        $userPrincipalName = $user.UserPrincipalName
        Add-UserToUnifiedGroup -userPrincipalName $userPrincipalName -groupName $groupName
    }
}
catch {
    Write-Host "Error occurred while processing the CSV file."
    Write-Host $_.Exception.Message
}
