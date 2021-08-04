# Setup ACMESharp
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Force
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
Install-Module -Name ACMESharp -Force
Install-Module -Name ACMESharp.Providers.IIS -Force
Import-Module ACMESharp
Enable-ACMEExtensionModule -ModuleName ACMESharp.Providers.IIS
Get-ACMEExtensionModule | Select-Object -Expand Name  
Initialize-ACMEVault 

# Register User - emails will be sent here for cert expiration ect.
New-ACMERegistration -Contacts mailto:NAME@YOURDOMAIN.COM -AcceptTos