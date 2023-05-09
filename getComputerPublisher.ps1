Get-ADComputer -Filter {OperatingSystem -Like "*Windows*"} -Properties * | ForEach-Object {Invoke-Command -ComputerName $_.Name -ScriptBlock {$apps = Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, Publisher, InstallDate | Sort-Object DisplayName; $apps += Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, Publisher, InstallDate | Sort-Object DisplayName; $apps | Select-Object DisplayName, Publisher, InstallDate | Export-Csv -Path "C:\Users\satsaa_ad12\Desktop\$($_.Name).csv" -NoTypeInformation}}


Get-WmiObject -Class "Win32_Product" -ComputerName "sats-vdi-vm01.satsnet.com.sg" | Select-Object Name, Version, Vendor | Export-Csv -Path "C:\Users\satsaa_ad12\Desktop\installed_apps.csv" -NoTypeInformation -Encoding UTF8


reg query "\\SATS-NB-23943K\HKLM\Software\Microsoft\Windows\CurrentVersion\Uninstall" /s /f "DisplayName" /f "DisplayVersion" /f "Publisher" /t "REG_SZ" /e /v "DisplayName" /v "DisplayVersion" /v "Publisher") > "C:\path\to\file\installed_apps.csv"

Get-WmiObject -Class Win32reg_AddRemovePrograms -ComputerName sats-vdi-vm01.satsnet.com.sg | Select-Object * | Export-Csv -path "C:\Users\satsaa_ad12\Desktop\installed_programs32.csv"

Get-WmiObject -Class Win32Reg_AddRemovePrograms64 -ComputerName SATS-NB-23943K | Select-Object * | Export-Csv -path "C:\Users\satsaa_ad12\Desktop\installed_programs_4.csv"
