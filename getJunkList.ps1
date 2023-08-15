# Specify the specific email address you want to check
$specificEmail = "noreply@sats1.com"

# Path to the CSV file containing UPNs
$csvFilePath = Read-Host "Input"

# Read the CSV file and process each row
$csvData = Import-Csv -Path $csvFilePath

foreach ($row in $csvData) {
    $upn = $row.UPN
    
    # Get the blocked senders and recipient lists for the user
    $blockedSendersAndDomains = (Get-MailboxJunkEmailConfiguration -Identity $upn).BlockedSendersAndDomains
    $blockedRecipients = (Get-MailboxJunkEmailConfiguration -Identity $upn).BlockedRecipients

    # Check if the specific email address is in the blocked senders or recipients list
    $isBlockedSender = $blockedSendersAndDomains -contains $specificEmail
    $isBlockedRecipient = $blockedRecipients -contains $specificEmail

    Write-Host "User: $upn"
    if ($isBlockedSender) {
        Write-Host "Blocked Sender: $specificEmail"
    }
    if ($isBlockedRecipient) {
        Write-Host "Blocked Recipient: $specificEmail"
    }
    if (-not $isBlockedSender -and -not $isBlockedRecipient) {
        Write-Host "Email not found in blocked senders or recipients lists."
    }
    Write-Host ""
}


###

# Specify the specific email address you want to check
$specificEmail = "noreply@sats1.com"

# Path to the CSV file containing UPNs
$csvFilePath = Read-Host "Input"

# Path to the output CSV file
$outputCsvFilePath = Read-Host "Output"

# Create an array to store results
$results = @()

# Read the CSV file and process each row
$csvData = Import-Csv -Path $csvFilePath

foreach ($row in $csvData) {
    $upn = $row.UPN
    
    # Get the blocked senders and recipient lists for the user
    $blockedSendersAndDomains = (Get-MailboxJunkEmailConfiguration -Identity $upn).BlockedSendersAndDomains
    $blockedRecipients = (Get-MailboxJunkEmailConfiguration -Identity $upn).BlockedRecipients

    # Check if the specific email address is in the blocked senders or recipients list
    $isBlockedSender = $blockedSendersAndDomains -contains $specificEmail
    $isBlockedRecipient = $blockedRecipients -contains $specificEmail

    # Create a custom object with the results
    $resultObject = [PSCustomObject]@{
        User = $upn
        BlockedSender = $isBlockedSender
        BlockedRecipient = $isBlockedRecipient
    }

    # Add the result object to the results array
    $results += $resultObject
}

# Export the results to a CSV file
$results | Export-Csv -Path $outputCsvFilePath -NoTypeInformation

Write-Host "Results exported to $outputCsvFilePath"
