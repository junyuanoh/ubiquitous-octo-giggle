# Define the path to the input file containing SamAccountNames
$filePath = "C:\Users\satsaa_ad12\Desktop\nosyncaccount_clear.csv"

# Read the SamAccountNames from the file
$users = Get-Content -Path $filePath

# Iterate through each SamAccountName and clear the ExtensionAttribute15 attribute
foreach ($user in $users) {
    try {
        # Get the user object
        $userObj = Get-ADUser -Identity $user -ErrorAction Stop

        # Clear the ExtensionAttribute15 attribute
        $userObj | Set-ADUser -Clear 'ExtensionAttribute15' -ErrorAction Stop

        Write-Host "ExtensionAttribute15 cleared for user: $user"
    }
    catch {
        Write-Host "Failed to clear ExtensionAttribute15 for user: $user. Error: $_"
    }
}
