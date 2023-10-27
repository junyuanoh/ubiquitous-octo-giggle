# Import ActiveDirectory module
Import-Module ActiveDirectory

$csvPath = Read-Host "Enter path to input .csv" 
$outputPath = "C:\Users\satsaa_adsupport01\Desktop\user_26-10-2023.csv"
$userList = Import-Csv $csvPath

#use 2 lines below to immediately get attributes of a group
#$userList = Get-ADGroupMember -Identity "SG CF All Users Group" | Select SamAccountName
#$outputPath = "C:\Users\satsaa_adsupport01\Desktop\SG CF All Users Group_user_23-08-2023.csv"


# Initialize output array
$output = @()
foreach ($user in $userList) {

  $adUser = Get-ADUser -Filter "SamAccountName -eq '$($user.SamAccountName)'" `
    -Properties *
  if ($adUser) {
    $output += [PSCustomObject] @{
      Enabled           = $adUser.Enabled
      SamAccountName    = $adUser.SamAccountName
      UserPrincipalName = $adUser.UserPrincipalName
      EmailAddress      = $adUser.EmailAddress
      GivenName         = $adUser.GivenName
      SurName           = $adUser.Surname
      DisplayName       = $adUser.DisplayName
      Title             = $adUser.Title
      Department        = $adUser.Department
      Company           = $adUser.Company
      EmployeeNumber    = $adUser.EmployeeNumber
      EmployeeType      = $adUser.EmployeeType
      Description       = $adUser.Description
      whenCreated       = $adUser.whenCreated
      Office            = $adUser.Office
      HomePhone         = $adUser.HomePhone
      Fax               = $adUser.Fax
      IPPhone           = $adUser.ipPhone
      Pager             = $adUser.pager
      Mobile            = $adUser.mobile
      MobilePhone       = $adUser.MobilePhone
      Country           = $adUser.country
    }
  }
}
$output | Export-Csv $outputPath -NoTypeInformation

###
#check if account exist

# Define the path to the CSV file
$csvPath = Read-host "Input"

# Define the path to the output CSV file
$outputPath = Read-host "Output"

# Import the Active Directory module if not already loaded
if (-not (Get-Module -Name ActiveDirectory)) {
    Import-Module ActiveDirectory
}

# Initialize an array to store the results
$results = @()

# Read the CSV file
$csvData = Import-Csv -Path $csvPath

foreach ($entry in $csvData) {
    $samAccountName = $entry.SamAccountName

    # Check if the account exists in Active Directory
    $user = Get-ADUser -Filter { SamAccountName -eq $samAccountName } -Properties Enabled,UserPrincipalName,EmailAddress,GivenName,Surname,DisplayName,Title,Department,Company,EmployeeNumber,Description,whenCreated,whenChanged -ErrorAction SilentlyContinue

    if ($user) {
        # Account exists, add the user data to the results array
        $results += $user | Select-Object Enabled, SamAccountName, UserPrincipalName, EmailAddress, GivenName, Surname, DisplayName, Title, Department, Company, EmployeeNumber, Description, whenCreated, whenChanged
    } else {
        # Account does not exist, create a remark
        $results += [PSCustomObject]@{
            SamAccountName = $samAccountName
            Remark         = "Account does not exist"
        }
    }
}

# Export the results to a CSV file
$results | Export-Csv -Path $outputPath -NoTypeInformation

Write-Host "Script completed. Results exported to $outputPath"


#####

# Define the path to the CSV file
$csvPath = Read-host "Input"

# Define the path to the output CSV file
$outputPath = Read-host "Output"

# Initialize an array to store the results
$results = @()

# Import the Active Directory module if not already loaded
if (-not (Get-Module -Name ActiveDirectory)) {
    Import-Module ActiveDirectory
}

# Read the CSV file
$csvData = Import-Csv -Path $csvPath

foreach ($entry in $csvData) {
    $samAccountName = $entry.SamAccountName

    # Check if the account exists in Active Directory
    $user = Get-ADUser -Filter { SamAccountName -eq $samAccountName } -Properties Enabled -ErrorAction SilentlyContinue

    if ($user) {
        # Account exists, check if it is enabled
        if ($user.Enabled) {
            $status = "Enabled"
        } else {
            $status = "Disabled"
        }
    } else {
        # Account does not exist
        $status = "Account does not exist"
    }

    # Create a custom object with the results
    $resultObject = [PSCustomObject]@{
        SamAccountName = $samAccountName
        Status         = $status
    }

    # Add the result to the results array
    $results += $resultObject
}

# Export the results to a CSV file
$results | Export-Csv -Path $outputPath -NoTypeInformation

Write-Host "Script completed. Results exported to $outputPath"
