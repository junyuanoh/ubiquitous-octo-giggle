
$getdate = Get-Date -Format "dd-MM-yyyy HH:mm:ss"
Write-Host "Timestamp: $getdate" -foregroundcolor "yellow"
$hostname = Hostname
$services = @("DHCP", "DHCPServer", "SAPSPrint", "Spooler", "lpdsvc")

foreach ($service in $services) {
    $serviceStatus = Get-Service -Name $service -ErrorAction SilentlyContinue
    if ($serviceStatus -eq $null) {
        Write-Host "'$hostname': Service '$service' does not exist. Skipping..."
    } elseif ($serviceStatus.Status -eq "Running") {
        Write-Host "'$hostname': Service '$service' is already running. Passing..." -foregroundcolor "green"
    } else {
        Write-Host "'$hostname': Service '$service' is NOT running. Starting..." -foregroundcolor "red"
        Start-Service -Name $service
    }
}





###
#version with output

# Get the current date in the specified format (DDMMYYYY)
$datePattern = Get-Date -Format "ddMMyyyy"

# Construct the output file path
$outputFilePath = "C:\${datePattern}_PatchingChecks.txt"

$getdate = Get-Date -Format "dd-MM-yyyy HH:mm:ss"

# Create and write the timestamp to the output file
$timestamp = "Timestamp: $getdate`n"
$timestamp | Out-File -FilePath $outputFilePath -Append -Encoding utf8

$hostname = Hostname
$services = @("DHCP", "DHCPServer", "SAPSPrint", "Spooler", "lpdsvc")

foreach ($service in $services) {
    $serviceStatus = Get-Service -Name $service -ErrorAction SilentlyContinue
    if ($serviceStatus -eq $null) {
        $output = "'$hostname': Service '$service' does not exist. Skipping..."
    } elseif ($serviceStatus.Status -eq "Running") {
        $output = "'$hostname': Service '$service' is already running. Passing..."
    } else {
        $output = "'$hostname': Service '$service' is not running. Starting..."
        Start-Service -Name $service
    }

    # Append the output to the output file
    $output | Out-File -FilePath $outputFilePath -Append -Encoding utf8
}

Write-Host "Results have been saved to $outputFilePath"