# Install PS7 - https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-windows?view=powershell-7.3
# Run PS7 on machine 

#Source: https://pnp.github.io/powershell/articles/installation.html
#PnP only works on PS7
Install-Module PnP.PowerShell -Scope CurrentUser

#Install SharePoint Online Client Components SDK - https://www.microsoft.com/en-us/download/details.aspx?id=42038

#consent on behalf with GA. This has been done for SBI already, so skip
#Register-PnPManagementShellAccess 

#same like connect-sposervice
Connect-PnPOnline servbridge-admin.sharepoint.com -Credentials (Get-Credential)

#to connect to a single site 
Connect-PnPonline "servbridge.sharepoint.com/sites/SingtelProject-SATS" -Credentials (Get-Credential)


#References: 
#https://pnp.github.io/powershell/articles/authentication.html
#https://www.sharepointdiary.com/2018/12/download-install-sharepoint-online-client-side-sdk-using-powershell.html
#https://www.sharepointdiary.com/2019/08/connect-sharepoint-online-powershell-using-mfa.html
#https://www.microsoft.com/en-us/download/details.aspx?id=35588
#https://sharepoint.stackexchange.com/questions/156074/running-powershell-csom-towards-a-sharepoint-online-site
#https://sharepoint.stackexchange.com/questions/286702/pnp-powershell-script-document-library-inventory (for PnP built-in file name)

