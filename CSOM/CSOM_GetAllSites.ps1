# Load SharePoint CSOM Assemblies
Add-Type -Path "C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\16\ISAPI\Microsoft.SharePoint.Client.dll"
Add-Type -Path "C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\16\ISAPI\Microsoft.SharePoint.Client.Runtime.dll"

# Specify SharePoint Online admin site URL
$AdminSiteURL = "https://servbridge-admin.sharepoint.com"

# Admin Credentials
$Cred = Get-Credential

# Output CSV File Path
$CSVFilePath = "C:\temp\allsites.csv"

# Connect to SharePoint Online
$AdminCtx = New-Object Microsoft.SharePoint.Client.ClientContext($AdminSiteURL)
$AdminCtx.Credentials = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($Cred.UserName,$Cred.Password)

# Retrieve all sites in the tenant
$Tenant = New-Object Microsoft.Online.SharePoint.TenantAdministration.Tenant($AdminCtx)
$SiteProperties = $Tenant.GetSiteProperties(0, $true)
$AdminCtx.Load($SiteProperties)
$AdminCtx.ExecuteQuery()

# Create an array to store site information
$SiteInfoArray = @()

# Iterate through each site and extract information
foreach ($SiteProp in $SiteProperties) {
    $SiteInfo = New-Object PSObject -Property @{
        "SiteURL" = $SiteProp.Url
        "SiteTitle" = $SiteProp.Title
        "StorageQuota" = $SiteProp.StorageQuota
        "StorageUsage" = $SiteProp.StorageUsageCurrent
        "Template" = $SiteProp.Template
        "CreatedDate" = $SiteProp.TimeCreated
        "LastModifiedDate" = $SiteProp.TimeLastModified
    }
    $SiteInfoArray += $SiteInfo
}

# Export site information to a CSV file
$SiteInfoArray | Export-Csv -Path $CSVFilePath -NoTypeInformation

Write-Host "All SharePoint sites in the tenant exported to $CSVFilePath"
