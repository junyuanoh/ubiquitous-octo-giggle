#Load SharePoint CSOM Assemblies
Add-Type -Path "C:\Program Files\SharePoint Online Management Shell\Microsoft.Online.SharePoint.PowerShell\Microsoft.SharePoint.Client.dll"
Add-Type -Path "C:\Program Files\SharePoint Online Management Shell\Microsoft.Online.SharePoint.PowerShell\Microsoft.SharePoint.Client.Runtime.dll"
Add-Type -Path "C:\Program Files\SharePoint Online Management Shell\Microsoft.Online.SharePoint.PowerShell\Microsoft.Online.SharePoint.Client.Tenant.dll"
   
#Get All Site collections from the Tenant- Including Modern Team sites and communication sites
Function Get-SPOSites($AdminSiteURL, $Cred)
{
    #Setup credentials to connect
    $Credentials = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($Cred.Username, $Cred.Password)
    
    #Setup the context
    $Ctx = New-Object Microsoft.SharePoint.Client.ClientContext($AdminSiteURL)
    $Ctx.Credentials = $Credentials
   
    #Get the tenant object 
    $Tenant = New-Object Microsoft.Online.SharePoint.TenantAdministration.Tenant($ctx)
   
    #Get All Site Collections
    $SiteCollections=$Tenant.GetSitePropertiesFromSharePoint(0,$true)
    $Ctx.Load($SiteCollections)
    $Ctx.ExecuteQuery()
  
    #Iterate through Each site collection
    ForEach($Site in $SiteCollections)
    {
        Write-host $Site.URL
    }
}
   
#Set Parameters
$AdminSiteUrl = "https://servbridge-admin.sharepoint.com/"
$Cred= Get-Credential
 
#sharepoint online powershell list all sites
Get-SPOSites -AdminSiteURL $AdminSiteUrl -Cred $Cred



#####


Import-Module Microsoft.Online.SharePoint.Powershell
 
#Config Parameters
$AdminSiteURL="https://servbridge-admin.sharepoint.com"
 
#Get Credentials to connect to the SharePoint Admin Center
$Cred = Get-Credential
 
#Connect to SharePoint Online Admin Center
Connect-SPOService -Url $AdminSiteURL -Credential $Cred
 
#Get All site collections which has /sites in its path
Get-SPOSite -Filter { Url -like '*/sites*' } -Limit All
 
#Get All site collections of Group site template
#Get-SPOSite -Filter { Template -eq "GROUP#0" } -Limit All