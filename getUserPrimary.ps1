Connect-MsolService 
$csvloc1 = Read-Host "Enter path to .csv (accepts with or without quotes)" 
$csvloc2 = $csvloc1.Replace("`"","")
$users = Import-Csv $csvloc2

foreach ($user in $users) {
    $upn = $user.samAccountName
    Get-User -identity $upn | Select-Object WindowsEmailAddress, UserPrincipalName | Export-Csv -Path "\\Mac\Home\Desktop\TestCSV\userPrimaryID_08-05.csv" -NoTypeInformation -Append
}

#AD
Connect-MsolService 
$csvloc1 = Read-Host "Enter path to .csv (accepts with or without quotes)" 
$csvloc2 = $csvloc1.Replace("`"","")
$users = Import-Csv $csvloc2

foreach ($user in $users) {
    $upn = $user.UserPrincipalName
    Get-ADUser -Filter {samAccountName -eq $upn} -Properties * | Select -Property Enabled, SamAccountName, UserPrincipalName, EmailAddress, GivenName, Surname, DisplayName, Title, Department, Company, EmployeeNumber, Description, whenCreated, whenChanged | Export-CSV -path C:\Users\satsaa_adsupport01\Desktop\IE_user_28-07-2023.csv -NoTypeInformation
}

###

# Replace these variables with your own values
$csvInputFilePath = Read-Host "Enter path to .csv"   # Path to the CSV file containing SamAccountNames
$csvOutputFilePath = "C:\Users\satsaa_adsupport01\Desktop\IE_user_28-07-2023.csv"           # Path to the output CSV file to store user properties

# Function to get user properties and export to CSV
function Export-UserPropertiesToCSV {
    param (
        [string]$samAccountName,
        [string]$outputFilePath
    )

    try {
        # Get the user object
        $user = Get-ADUser -Filter {SamAccountName -eq $samAccountName} -Properties Enabled, UserPrincipalName, EmailAddress, GivenName, Surname, DisplayName, Title, Department, Company, EmployeeNumber, Description, whenCreated, whenChanged
        if ($user) {
            # Select the desired properties to export
            $exportProperties = @{
                Enabled           = $user.Enabled
                SamAccountName    = $user.SamAccountName
                UserPrincipalName = $user.UserPrincipalName
                EmailAddress      = $user.EmailAddress
                GivenName         = $user.GivenName
                SurName           = $user.Surname
                DisplayName       = $user.DisplayName
                Title             = $user.Title
                Department        = $user.Department
                Company           = $user.Company
                EmployeeNumber    = $user.EmployeeNumber
                Description       = $user.Description
                whenCreated       = $user.whenCreated
                whenChanged       = $user.whenChanged
                # Add more properties as needed
            }

            # Export properties to CSV
            $exportProperties | Export-Csv -Path $outputFilePath -Append -NoTypeInformation
            Write-Host "Exported properties for user: $samAccountName"
        } else {
            Write-Host "User with SamAccountName: $samAccountName not found."
            $notFoundProperties = @{
                Enabled           = "Not found"
                SamAccountName    = $samAccountName
                UserPrincipalName = "Not found"
                EmailAddress      = "Not found"
                GivenName         = "Not found"
                SurName           = "Not found"
                DisplayName       = "Not found"
                Title             = "Not found"
                Department        = "Not found"
                Company           = "Not found"
                EmployeeNumber    = "Not found"
                Description       = "Not found"
                whenCreated       = "Not found"
                whenChanged       = "Not found"
                # Add more properties as needed
            }

            # Export not found properties to CSV
            $notFoundProperties | Export-Csv -Path $outputFilePath -Append -NoTypeInformation
        }
    }
    catch {
        Write-Host "Error occurred while exporting properties for user: $samAccountName"
        Write-Host $_.Exception.Message
    }
}

# Read the CSV file and export user properties
try {
    $samAccountNames = Import-Csv -Path $csvInputFilePath
    foreach ($samAccountName in $samAccountNames) {
        $samAccountName = $samAccountName.SamAccountName
        Export-UserPropertiesToCSV -samAccountName $samAccountName -outputFilePath $csvOutputFilePath
    }
}
catch {
    Write-Host "Error occurred while processing the CSV file."
    Write-Host $_.Exception.Message
}
