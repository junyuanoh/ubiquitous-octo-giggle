Write-Host "`nStarting...`n"
Write-Host "`nSetting execution policy to remote signed`n"

Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force

Write-Host "Installing AzureAD Module...`n"

#Check if module is installed & imported, do it if not:
$module = "AzureAD"
if((Get-Module -Name $module) -eq $null) {
    #Check if module is installed:
    if (Get-Module -ListAvailable -Name $module) {
        Write-Output "$module module is already installed";
        #Check if module is imported:
        if((Get-Module -Name $module) -ne $null) {
            Write-Output " and is already imported (i.e. its cmdlets are ready/available to be used.)";
            Write-Output "Installation Path: `n`t" (Get-Module -Name $module).Path;
        } else {
            Write-Output ", however, it is NOT imported yet - importing it now";
            Import-Module $module;
        }
    }else{
        Write-Output "$module module is NOT installed - installing it now"
        try {
            Install-Module -Name $module -AllowClobber -Confirm:$False -Force -Scope CurrentUser #suppressed prompt.
        }
        catch [Exception] {
            $_.message 
            exit
        }
        Write-Output "$module installed successfully - importing it now";
        Import-Module $module;
    }
};

Write-Host "`nInstalling MSOnline Module...`n"

#Check if module is installed & imported, do it if not:
$module = "MSOnline"
if((Get-Module -Name $module) -eq $null) {
    #Check if module is installed:
    if (Get-Module -ListAvailable -Name $module) {
        Write-Output "$module module is already installed";
        #Check if module is imported:
        if((Get-Module -Name $module) -ne $null) {
            Write-Output " and is already imported (i.e. its cmdlets are ready/available to be used.)";
            Write-Output "Installation Path: `n`t" (Get-Module -Name $module).Path;
        } else {
            Write-Output ", however, it is NOT imported yet - importing it now";
            Import-Module $module;
        }
    }else{
        Write-Output "$module module is NOT installed - installing it now"
        try {
            Install-Module -Name $module -AllowClobber -Confirm:$False -Force -Scope CurrentUser #suppressed prompt.
        }
        catch [Exception] {
            $_.message 
            exit
        }
        Write-Output "$module installed successfully - importing it now";
        Import-Module $module;
    }
};

Write-Host ""
Write-Host "Installing ExchangeOnlineManagement Module..."
Write-Host ""

#Check if module is installed & imported, do it if not:
$module = "ExchangeOnlineManagement"
if((Get-Module -Name $module) -eq $null) {
    #Check if module is installed:
    if (Get-Module -ListAvailable -Name $module) {
        Write-Output "$module module is already installed";
        #Check if module is imported:
        if((Get-Module -Name $module) -ne $null) {
            Write-Output " and is already imported (i.e. its cmdlets are ready/available to be used.)";
            Write-Output "Installation Path: `n`t" (Get-Module -Name $module).Path;
        } else {
            Write-Output ", however, it is NOT imported yet - importing it now";
            Import-Module $module;
        }
    }else{
        Write-Output "$module module is NOT installed - installing it now"
        try {
            Install-Module -Name $module -AllowClobber -Confirm:$False -Force -Scope CurrentUser #suppressed prompt.
        }
        catch [Exception] {
            $_.message 
            exit
        }
        Write-Output "$module installed successfully - importing it now";
        Import-Module $module;
    }
};

Write-Host ""
Write-Host "Installing SPO Management Module..."
Write-Host ""

#Check if module is installed & imported, do it if not:
$module = "Microsoft.Online.SharePoint.PowerShell"
if((Get-Module -Name $module) -eq $null) {
    #Check if module is installed:
    if (Get-Module -ListAvailable -Name $module) {
        Write-Output "$module module is already installed";
        #Check if module is imported:
        if((Get-Module -Name $module) -ne $null) {
            Write-Output " and is already imported (i.e. its cmdlets are ready/available to be used.)";
            Write-Output "Installation Path: `n`t" (Get-Module -Name $module).Path;
        } else {
            Write-Output ", however, it is NOT imported yet - importing it now";
            Import-Module $module;
        }
    }else{
        Write-Output "$module module is NOT installed - installing it now"
        try {
            Install-Module -Name $module -AllowClobber -Confirm:$False -Force -Scope CurrentUser #suppressed prompt.
        }
        catch [Exception] {
            $_.message 
            exit
        }
        Write-Output "$module installed successfully - importing it now";
        Import-Module $module;
    }
};

Write-Host ""
Write-Host "Installing AIP Service Module..."
Write-Host ""

#Check if module is installed & imported, do it if not:
$module = "AIPService"
if((Get-Module -Name $module) -eq $null) {
    #Check if module is installed:
    if (Get-Module -ListAvailable -Name $module) {
        Write-Output "$module module is already installed";
        #Check if module is imported:
        if((Get-Module -Name $module) -ne $null) {
            Write-Output " and is already imported (i.e. its cmdlets are ready/available to be used.)";
            Write-Output "Installation Path: `n`t" (Get-Module -Name $module).Path;
        } else {
            Write-Output ", however, it is NOT imported yet - importing it now";
            Import-Module $module;
        }
    }else{
        Write-Output "$module module is NOT installed - installing it now"
        try {
            Install-Module -Name $module -AllowClobber -Confirm:$False -Force -Scope CurrentUser #suppressed prompt.
        }
        catch [Exception] {
            $_.message 
            exit
        }
        Write-Output "$module installed successfully - importing it now";
        Import-Module $module;
    }
};

Write-Host ""
Write-Host "Installing PackageManagement Module..."
Write-Host ""

#Check if module is installed & imported, do it if not:
$module = "PackageManagement"
if((Get-Module -Name $module) -eq $null) {
    #Check if module is installed:
    if (Get-Module -ListAvailable -Name $module) {
        Write-Output "$module module is already installed";
        #Check if module is imported:
        if((Get-Module -Name $module) -ne $null) {
            Write-Output " and is already imported (i.e. its cmdlets are ready/available to be used.)";
            Write-Output "Installation Path: `n`t" (Get-Module -Name $module).Path;
        } else {
            Write-Output ", however, it is NOT imported yet - importing it now";
            Import-Module $module;
        }
    }else{
        Write-Output "$module module is NOT installed - installing it now"
        try {
            Install-Module -Name $module -AllowClobber -Confirm:$False -Force -Scope CurrentUser #suppressed prompt.
        }
        catch [Exception] {
            $_.message 
            exit
        }
        Write-Output "$module installed successfully - importing it now";
        Import-Module $module;
    }
};

Write-Host ""
Write-Host "Installing MicrosoftTeams Module..."
Write-Host ""

#Check if module is installed & imported, do it if not:
$module = "MicrosoftTeams"
if((Get-Module -Name $module) -eq $null) {
    #Check if module is installed:
    if (Get-Module -ListAvailable -Name $module) {
        Write-Output "$module module is already installed";
        #Check if module is imported:
        if((Get-Module -Name $module) -ne $null) {
            Write-Output " and is already imported (i.e. its cmdlets are ready/available to be used.)";
            Write-Output "Installation Path: `n`t" (Get-Module -Name $module).Path;
        } else {
            Write-Output ", however, it is NOT imported yet - importing it now";
            Import-Module $module;
        }
    }else{
        Write-Output "$module module is NOT installed - installing it now"
        try {
            Install-Module -Name $module -AllowClobber -Confirm:$False -Force -Scope CurrentUser #suppressed prompt.
        }
        catch [Exception] {
            $_.message 
            exit
        }
        Write-Output "$module installed successfully - importing it now";
        Import-Module $module;
    }
};

Write-Host ""
Write-Host "Installing Microsoft.PowerApps.Administration.PowerShell Module..."
Write-Host ""

#Check if module is installed & imported, do it if not:
$module = "Microsoft.PowerApps.Administration.PowerShell"
if((Get-Module -Name $module) -eq $null) {
    #Check if module is installed:
    if (Get-Module -ListAvailable -Name $module) {
        Write-Output "$module module is already installed";
        #Check if module is imported:
        if((Get-Module -Name $module) -ne $null) {
            Write-Output " and is already imported (i.e. its cmdlets are ready/available to be used.)";
            Write-Output "Installation Path: `n`t" (Get-Module -Name $module).Path;
        } else {
            Write-Output ", however, it is NOT imported yet - importing it now";
            Import-Module $module;
        }
    }else{
        Write-Output "$module module is NOT installed - installing it now"
        try {
            Install-Module -Name $module -AllowClobber -Confirm:$False -Force -Scope CurrentUser #suppressed prompt.
        }
        catch [Exception] {
            $_.message 
            exit
        }
        Write-Output "$module installed successfully - importing it now";
        Import-Module $module;
    }
};

Write-Host ""
Write-Host "Installing Microsoft.PowerApps.PowerShell Module..."
Write-Host ""

#Check if module is installed & imported, do it if not:
$module = "Microsoft.PowerApps.PowerShell"
if((Get-Module -Name $module) -eq $null) {
    #Check if module is installed:
    if (Get-Module -ListAvailable -Name $module) {
        Write-Output "$module module is already installed";
        #Check if module is imported:
        if((Get-Module -Name $module) -ne $null) {
            Write-Output " and is already imported (i.e. its cmdlets are ready/available to be used.)";
            Write-Output "Installation Path: `n`t" (Get-Module -Name $module).Path;
        } else {
            Write-Output ", however, it is NOT imported yet - importing it now";
            Import-Module $module;
        }
    }else{
        Write-Output "$module module is NOT installed - installing it now"
        try {
            Install-Module -Name $module -AllowClobber -Confirm:$False -Force -Scope CurrentUser #suppressed prompt.
        }
        catch [Exception] {
            $_.message 
            exit
        }
        Write-Output "$module installed successfully - importing it now";
        Import-Module $module;
    }
};

Write-Host ""
Write-Host "Installing PowerShellGet Module..."
Write-Host ""

#Check if module is installed & imported, do it if not:
$module = "PowerShellGet"
if((Get-Module -Name $module) -eq $null) {
    #Check if module is installed:
    if (Get-Module -ListAvailable -Name $module) {
        Write-Output "$module module is already installed";
        #Check if module is imported:
        if((Get-Module -Name $module) -ne $null) {
            Write-Output " and is already imported (i.e. its cmdlets are ready/available to be used.)";
            Write-Output "Installation Path: `n`t" (Get-Module -Name $module).Path;
        } else {
            Write-Output ", however, it is NOT imported yet - importing it now";
            Import-Module $module;
        }
    }else{
        Write-Output "$module module is NOT installed - installing it now"
        try {
            Install-Module -Name $module -AllowClobber -Confirm:$False -Force -Scope CurrentUser #suppressed prompt.
        }
        catch [Exception] {
            $_.message 
            exit
        }
        Write-Output "$module installed successfully - importing it now";
        Import-Module $module;
    }
};

Write-Host ""
Get-InstalledModule
Write-Host "Module installation completed"


