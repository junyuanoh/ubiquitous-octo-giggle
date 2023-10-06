###Single library scan
#Load SharePoint CSOM Assemblies
Add-Type -Path "C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\16\ISAPI\Microsoft.SharePoint.Client.dll"
Add-Type -Path "C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\16\ISAPI\Microsoft.SharePoint.Client.Runtime.dll"
[System.Reflection.Assembly]::LoadWithPartialName(“Microsoft.SharePoint.Client”)
[System.Reflection.Assembly]::LoadWithPartialName(“Microsoft.SharePoint.Client.Runtime”)
      
##Configure tenant, export, credentials, and CSV parameters
Write-Host "Example: 'https://tenant.sharepoint.com/sites/sitenamehere', replace tenant and sitenamehere"
$SiteURL= Read-host "Enter SharePoint site URL (w/o quotes)"
#Default is Documents. Or, any other lists where items reside in.
$ListName = "Documents"
#Output CSV path.
Write-Host "`nExample: 'C:\temp\sitenamehere.csv'"
$CSVPath = Read-host "Enter output path (w/o quotes)"
#Throttles below code to prevent overloading of server
$BatchSize = 500
#Get Credentials to connect. Account must have SharePoint Administrator role, and MFA must not be enabled
$Cred = Get-Credential

##Main Code
Try {
    #Setup the context
    $Ctx = New-Object Microsoft.SharePoint.Client.ClientContext($SiteURL)
    $Ctx.Credentials = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($Cred.UserName,$Cred.Password)
      
    #Get the Document Library
    $List =$Ctx.Web.Lists.GetByTitle($ListName)
      
    #Define CAML Query to Get List Items in batches
    $Query = New-Object Microsoft.SharePoint.Client.CamlQuery
    $Query.ViewXml ="
    <View Scope='RecursiveAll'>
        <Query>
            <OrderBy><FieldRef Name='ID' Ascending='TRUE'/></OrderBy>
        </Query>
        <RowLimit Paged='TRUE'>$BatchSize</RowLimit>
    </View>"
 
    $DataCollection = @()
    Do
    {
        #get List items
        $ListItems = $List.GetItems($Query) 
        $Ctx.Load($ListItems)
        $Ctx.ExecuteQuery() 
 
        #Iterate through each item in the document library
        ForEach($ListItem in $ListItems)
        {
            #Collects data based on Scope required
            $Data = New-Object PSObject -Property ([Ordered] @{
                Name = $ListItem.FieldValues.FileLeafRef
                LastModified = $ListItem.FieldValues.Modified
                LastModifiedTimestamp = $ListItem.FieldValues.SMLastModifiedDate
                LastModifiedBy = $ListItem.FieldValues.Editor.Email
                Location = $ListItem.FieldValues.FileDirRef
                ContentType = $ListItem.FieldValues.File_x0020_Type
                FileSize = $ListItem.FieldValues.File_x0020_Size
                CheckOut = $ListItem.FieldValues.IsCheckedoutToLocal
                VersionNumber = $ListItem.FieldValues.ContentVersion
                NeverCheckedIn = $ListItem.FieldValues._CheckinComment
                CreatedDate = $ListItem.FieldValues.Created
                CreatedDateTimestamp = $ListItem.FieldValues.Created_x0020_Date
                CreatedBy = $ListItem.FieldValues.Author.Email
            })
            $DataCollection += $Data
        }
        $Query.ListItemCollectionPosition = $ListItems.ListItemCollectionPosition
    }While($Query.ListItemCollectionPosition -ne $null)
 
    #Export Documents data to CSV
    $DataCollection | Export-Csv -Path $CSVPath -Force -NoTypeInformation
    Write-host -f Green "Document Library $SiteURL Exported to CSV!"
}
Catch {
    write-host -f Red "Error:" $_.Exception.Message
}


