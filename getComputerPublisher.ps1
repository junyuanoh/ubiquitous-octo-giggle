Get-ADComputer -Filter {OperatingSystem -Like "*Windows*"} -Properties * | ForEach-Object {Invoke-Command -ComputerName $_.Name -ScriptBlock {$apps = Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, Publisher, InstallDate | Sort-Object DisplayName; $apps += Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, Publisher, InstallDate | Sort-Object DisplayName; $apps | Select-Object DisplayName, Publisher, InstallDate | Export-Csv -Path "C:\Users\satsaa_ad12\Desktop\$($_.Name).csv" -NoTypeInformation}}


Get-WmiObject -Class "Win32_Product" -ComputerName "sats-vdi-vm01.satsnet.com.sg" | Select-Object Name, Version, Vendor | Export-Csv -Path "C:\Users\satsaa_ad12\Desktop\installed_apps.csv" -NoTypeInformation -Encoding UTF8


reg query "\\SATS-NB-23943K\HKLM\Software\Microsoft\Windows\CurrentVersion\Uninstall" /s /f "DisplayName" /f "DisplayVersion" /f "Publisher" /t "REG_SZ" /e /v "DisplayName" /v "DisplayVersion" /v "Publisher") > "C:\path\to\file\installed_apps.csv"

Get-WmiObject -Class Win32reg_AddRemovePrograms -ComputerName sats-vdi-vm01.satsnet.com.sg | Select-Object * | Export-Csv -path "C:\Users\satsaa_ad12\Desktop\installed_programs32.csv"

Get-WmiObject -Class Win32Reg_AddRemovePrograms64 -ComputerName SATS-NB-23943K | Select-Object * | Export-Csv -path "C:\Users\satsaa_ad12\Desktop\installed_programs_4.csv"

####

# Import ActiveDirectory and CIM modules
Import-Module ActiveDirectory
Import-Module CimCmdlets

# Set computer name
$computerName = "SATS-PC-12694V"

# Get computer object from Active Directory
$computer = Get-ADComputer -Identity $computerName -Properties *

# Get OS version number
$osVersionNumber = (Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName $computerName).Version

# Get HDD serial number
$hddSerialNumber = (Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DeviceID='C:'" -ComputerName $computerName).VolumeSerialNumber

# Get user name
$userName = $computer.Description

# Get MAC addresses
$macAddresses = (Get-CimInstance -ClassName Win32_NetworkAdapterConfiguration -Filter "IPEnabled=true" -ComputerName $computerName).MACAddress

# Get installed applications
$installedApplications = Get-CimInstance -ClassName Win32_Product -ComputerName $computerName | Select-Object Name, Version

# Get Internet Explorer version
$ieVersion = (Get-ItemProperty "HKLM:\Software\Microsoft\Internet Explorer" -Name Version).Version

# Get full operating system name and service pack level
$osInfo = (Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName $computerName).Caption
if ((Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName $computerName).ServicePackMajorVersion -ne $null) {
  $osInfo += " Service Pack $(Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName $computerName).ServicePackMajorVersion"
}

# Get DNS servers
$dnsServers = (Get-DnsClientServerAddress -AddressFamily IPv4 -ComputerName $computerName).ServerAddresses

# Get DHCP servers
$dhcpServers = (Get-DhcpServerInDC -ComputerName $computerName).DhcpServerName

# Get computer serial number
$computerSerialNumber = $computer.SerialNumber

# Get computer model
$computerModel = $computer.Model

# Display results
Write-Host "Computer Name: $computerName"
Write-Host "OS Version Number: $osVersionNumber"
Write-Host "HDD Serial Number: $hddSerialNumber"
Write-Host "User Name: $userName"
Write-Host "MAC Addresses: $macAddresses"
Write-Host "Installed Applications:"
$installedApplications | Format-Table -AutoSize
Write-Host "Internet Explorer Version: $ieVersion"
Write-Host "Full Operating System Name and Service Pack Level: $osInfo"
Write-Host "DNS Servers: $dnsServers"
Write-Host "DHCP Servers: $dhcpServers"
Write-Host "Computer Serial Number: $computerSerialNumber"
Write-Host "Computer Model: $computerModel"


# Set computer name
$computerName = "SATS-NB-23943K"

# Get OS version number
$osVersionNumber = (Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName $computerName).Version

# Display the OS version number
Write-Host "Computer: $computerName"
Write-Host "OS Version Number: $osVersionNumber"

###

$csvloc1 = Read-Host "Enter path to .csv" 
$csvloc2 = $csvloc1.Replace("`"","")
$users = Import-Csv $csvloc2

foreach ($user in $users) {
    $upn = $user.Hostname
    Get-WmiObject -Class Win32Reg_AddRemovePrograms64 -ComputerName $upn | Select-Object * | Export-Csv -Path "\\Mac\Home\Desktop\AD Scripts\$upn.csv" -NoTypeInformation
}