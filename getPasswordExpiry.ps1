# Import the MSOnline module
Import-Module MSOnline

# Connect to Azure AD
Connect-MsolService

# Define the path to the input CSV file
$csvPath = Read-Host "Enter input"

# Define the path for the output CSV file
$outputCsvPath = Read-host "Enter output"

# Read the CSV file
$users = Import-Csv -Path $csvPath

# Initialize an array to store the results
$results = @()

# Loop through each user in the CSV
foreach ($user in $users) {
    $userPrincipalName = $user.UserPrincipalName

    # Retrieve user information
    $userInfo = Get-MsolUser -UserPrincipalName $userPrincipalName | Select-Object DisplayName, UserPrincipalName, LastPasswordChangeTimeStamp

    # Add the user information to the results array
    $results += $userInfo
}

# Export the results to a CSV file
$results | Export-Csv -Path $outputCsvPath -NoTypeInformation
