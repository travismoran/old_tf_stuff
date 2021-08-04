#./gen_acme_le_cert.ps1 -host mysite.testdomain.com -hostalias mysite -sitename mysite -path C:\certstore\
# Limitations - Path MUST have a trailing slash C:\certstore\ not C:\certstore

$epoch = [int][double]::Parse((Get-Date -UFormat %s))
$the_dns = "iisdev01.YOURDOMAIN.com"
$acme_alias = "iisdev01"
$iis_name = "Default Web Site"
$where = "C:\certstore\"

#Param
#(
#  [string]$the_dns,
#  [string]$hostalias,
#  [string]$iis_name,
#  [string]$where
#)

mkdir $where
# Test if working 
Get-ACMEChallengeHandlerProfile -ListChallengeHandlers 

# Create Certificate Steps
New-ACMEIdentifier -Dns $the_dns -Alias $acme_alias$epoch
Complete-ACMEChallenge $acme_alias$epoch -ChallengeType http-01 -Handler iis -HandlerParameters @{ WebSiteRef = $iis_name }
Submit-ACMEChallenge $acme_alias$epoch -ChallengeType http-01
(Update-ACMEIdentifier $acme_alias$epoch -ChallengeType http-01).Challenges | Where-Object {$_.Type -eq "http-01"}
Update-ACMEIdentifier $acme_alias$epoch
New-ACMECertificate $acme_alias$epoch -Generate -Alias certalias$epoch
Submit-ACMECertificate certalias$epoch
Update-ACMECertificate certalias$epoch
Get-ACMECertificate certalias$epoch -ExportKeyPEM "$where$acme_alias$epoch.key.pem"
Get-ACMECertificate certalias$epoch -ExportCsrPEM "$where$acme_alias$epoch.csr.pem"
Get-ACMECertificate certalias$epoch -ExportCertificatePEM "$where$acme_alias$epoch.crt.pem" -ExportCertificateDER "$where$acme_alias$epoch.crt"
Get-ACMECertificate certalias$epoch -ExportIssuerPEM "$where$acme_alias$epoch-issuer.crt.pem" -ExportIssuerDER "$where$acme_alias$epoch-issuer.crt"
Get-ACMECertificate certalias$epoch -ExportPkcs12 "$where$acme_alias$epoch.pfx"

#Import Newly Generated SSL Certificate
Set-Location -Path cert:\localMachine\my
Import-PfxCertificate -FilePath "$where$acme_alias$epoch.pfx"

# Import IIS Management PowerShell Module
Import-Module WebAdministration
cd IIS:\SslBindings
$hostHeader = "iisdev01.YOURDOMAIN.com"

New-WebBinding -Name "Default Web Site" -Protocol "https" -Port 443 -HostHeader $hostHeader -SslFlags 1
#The name specified would be the name of the web site you’d like to add the binding to.  
#The protocol and port are standard for SSL bindings. The host header is the URL you’d like the web site to respond to.  Finally, SslFlags with a value of 1 enables SNI for this binding.
$certificate = Get-ChildItem Cert:\LocalMachine\My | Where-Object {$_.FriendlyName -eq "CN=iisdev01.YOURDOMAIN.com"}
New-Item -Path "IIS:\SslBindings\!443!iisdev01.YOURDOMAIN.com" -Value $certificate -SSLFlags 1

#$certificate = Get-ChildItem Cert:\LocalMachine\My | Where-Object {$_.subject -like "*YOURDOMAIN*" -and $_.FriendlyName -like "*iisdev01*"} | Select-Object -ExpandProperty Thumbprint
#cd IIS:\SslBindings
#$certificate | New-Item  0.0.0.0:443
#New-Item -Path "IIS:\SslBindings\!443!iisdev01.YOURDOMAIN.com" -Value $certificate -SSLFlags 1

#Invoke-Command -session $session {$CertShop=Get-ChildItem -Path Cert:\LocalMachine\My | where-Object {$_.subject -like "*YOURDOMAIN*" -and $_.FriendlyName -like "*iisdev01*"} | Select-Object -ExpandProperty Thumbprint}



