Connect-ExchangeOnline
# Specify the mailbox you want to retrieve delegated access members for
$mailbox = Read-Host "Enter mailbox"

# Get the mailbox permissions
$permissions = Get-MailboxPermission -Identity $mailbox | Where-Object { $_.AccessRights -like "*FullAccess*" -and $_.IsInherited -eq $false }

# Loop through each permission and retrieve member properties
foreach ($permission in $permissions) {
    $member = $permission.User
    $memberProperties = Get-User -Identity $member

    # Display member properties
    Write-Host "Member: $($memberProperties.DisplayName)"
    Write-Host "UserPrincipalName: $($memberProperties.UserPrincipalName)"
    Write-Host "Title: $($memberProperties.Title)"
    Write-Host "Department: $($memberProperties.Department)"
    Write-Host "Company: $($memberProperties.Company)"
    # Add more properties as needed

}

##
Connect-ExchangeOnline

# Specify the mailbox you want to retrieve delegated access members for
$mailbox = Read-Host "Enter mailbox"
$exportPath = "\\Mac\Home\Desktop\OutputCSV\$mailbox.csv"

# Get the mailbox permissions
$permissions = Get-MailboxPermission -Identity $mailbox | Where-Object { $_.AccessRights -like "*FullAccess*" -and $_.IsInherited -eq $false }

# Create an array to store the results
$delegatedMembers = @()

# Loop through each permission and retrieve member properties
foreach ($permission in $permissions) {
    $member = $permission.User
    $memberProperties = Get-User -Identity $member

    # Create an object to store the member properties
    $memberObject = [PSCustomObject]@{
        MemberName = $memberProperties.DisplayName
        UserPrincipalName = $memberProperties.UserPrincipalName
        Title = $memberProperties.Title
        Department = $memberProperties.Department
        Company = $memberProperties.Company
        WhenCreated = $memberProperties.WhenCreated
        # Add more properties as needed
    }

    # Add the member object to the array
    $delegatedMembers += $memberObject
}

# Export the results to a CSV file
$delegatedMembers | Export-Csv -Path $exportPath -NoTypeInformation
