Write-Host "Starting..."
Write-Host ""
Write-Host "Installing AzureAD Module..."
Write-Host ""

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

Write-Host ""
Write-Host "Installing AzureAD Module..."
Write-Host ""

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
Get-InstalledModule

Write-Host ""
Write-Host "Completed"
Write-Host ""
Write-Host "Opening Exchange Online admin page..."
Start-Process "https://debug.to"
