# Set input and output file paths - set to the local path of the jumphost
$csvPath = "C:\path\to\input.csv"
$outputPath = "C:\path\to\output.csv"
$computerList = Import-Csv $csvPath

$output = @()
foreach ($computer in $computerList) {
  # Check if computer exists in Active Directory
  $adComputer = Get-ADComputer -Filter "Name -eq '$($computer.Hostname)'"
  $output += [PSCustomObject] @{
    Hostname = $computer.Hostname
    Exists = [bool]$adComputer
  }
  if ($adComputer) {
    Write-Host "Computer $($computer.Hostname) exists."
  } else {
    Write-Host "Computer $($computer.Hostname) does not exist."
  }
}
$output | Export-Csv $outputPath -NoTypeInformation


Get-ADComputer -Filter * -Properties * | Export-Csv "C:\Users\satsaa_adsupport01\Desktop\computers_21082023.csv" -NoTypeInformation

###
#get last logon 

# Import the Active Directory module
Import-Module ActiveDirectory

# Define the path to the input CSV file and output CSV file
$csvFilePath = Read-Host "Input"
$outputFilePath = Read-Host "Output"

# Read the CSV file containing computer hostnames
$computers = Import-Csv $csvFilePath

# Initialize an array to store the results
$results = @()

# Loop through each computer in the CSV
foreach ($computer in $computers) {
    $computerName = $computer.Hostname

    # Get the computer object from Active Directory
    $adComputer = Get-ADComputer -Filter { Name -eq $computerName }

    # Check if the computer object was found
    if ($adComputer) {
        $LastLogonDate = [DateTime]::FromFileTime($adComputer.LastLogonDate)
        $result = [PSCustomObject]@{
            "ComputerName" = $computerName
            "LastLogonDate"    = $LastLogonDate
        }
        $results += $result
    } else {
        Write-Host "Computer '$computerName' not found in Active Directory."
    }
}

# Export the results to a CSV file
$results | Export-Csv -Path $outputFilePath -NoTypeInformation

Write-Host "Results exported to $outputFilePath"

###
#get all properties

# Import the Active Directory module
Import-Module ActiveDirectory

# Define the path to the input CSV file and output CSV file
$csvFilePath = Read-Host "Input"
$outputFilePath = Read-Host "Output"

# Read the CSV file containing computer hostnames
$computers = Import-Csv $csvFilePath

# Initialize an array to store the results
$results = @()

# Loop through each computer in the CSV
foreach ($computer in $computers) {
    $computerName = $computer.Hostname

    # Get the computer object from Active Directory with all properties
    $adComputer = Get-ADComputer -Filter { Name -eq $computerName } -Properties *

    # Check if the computer object was found
    if ($adComputer) {
        $results += $adComputer
    } else {
        Write-Host "Computer '$computerName' not found in Active Directory."
    }
}

# Export the results to a CSV file
$results | Export-Csv -Path $outputFilePath -NoTypeInformation

Write-Host "Results exported to $outputFilePath"
