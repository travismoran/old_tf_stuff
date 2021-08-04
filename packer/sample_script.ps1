Set-ExecutionPolicy Bypass -Scope Process -Force

Enable-WindowsOptionalFeature -Online -FeatureName IIS-WebServerRole

Enable-WindowsOptionalFeature -Online -FeatureName IIS-WebServer

Enable-WindowsOptionalFeature -Online -FeatureName IIS-CommonHttpFeatures

Enable-WindowsOptionalFeature -Online -FeatureName IIS-HttpErrors

Enable-WindowsOptionalFeature -Online -FeatureName IIS-HttpRedirect

Enable-WindowsOptionalFeature -Online -FeatureName IIS-ApplicationDevelopment

Install-WindowsFeature Net-Framework-Core

Install-WindowsFeature NET-Framework-45-Features

Enable-WindowsOptionalFeature -Online -FeatureName IIS-NetFxExtensibility45

Enable-WindowsOptionalFeature -Online -FeatureName IIS-HealthAndDiagnostics

Enable-WindowsOptionalFeature -Online -FeatureName IIS-HttpLogging

Enable-WindowsOptionalFeature -Online -FeatureName IIS-LoggingLibraries

Enable-WindowsOptionalFeature -Online -FeatureName IIS-RequestMonitor

Enable-WindowsOptionalFeature -Online -FeatureName IIS-HttpTracing

Enable-WindowsOptionalFeature -Online -FeatureName IIS-Security

Enable-WindowsOptionalFeature -Online -FeatureName IIS-RequestFiltering

Enable-WindowsOptionalFeature -Online -FeatureName IIS-Performance

Enable-WindowsOptionalFeature -Online -FeatureName IIS-WebServerManagementTools

Enable-WindowsOptionalFeature -Online -FeatureName IIS-IIS6ManagementCompatibility

Enable-WindowsOptionalFeature -Online -FeatureName IIS-Metabase

Enable-WindowsOptionalFeature -Online -FeatureName IIS-ManagementConsole

Enable-WindowsOptionalFeature -Online -FeatureName IIS-BasicAuthentication

Enable-WindowsOptionalFeature -Online -FeatureName IIS-WindowsAuthentication

Enable-WindowsOptionalFeature -Online -FeatureName IIS-StaticContent

Enable-WindowsOptionalFeature -Online -FeatureName IIS-DefaultDocument

Enable-WindowsOptionalFeature -Online -FeatureName IIS-WebSockets

Enable-WindowsOptionalFeature -Online -FeatureName IIS-ApplicationInit

Enable-WindowsOptionalFeature -Online -FeatureName IIS-NetFxExtensibility45

Enable-WindowsOptionalFeature -Online -FeatureName IIS-ASPNET45

Enable-WindowsOptionalFeature -Online -FeatureName IIS-ISAPIExtensions

Enable-WindowsOptionalFeature -Online -FeatureName IIS-ISAPIFilter

Enable-WindowsOptionalFeature -Online -FeatureName IIS-HttpCompressionStatic
# Install Chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
# Globally Auto confirm every action
choco feature enable -n allowGlobalConfirmation

choco install webdeploy /y

choco install urlrewrite /y

Import-Module WebAdministration 

choco install teamcity -params "username=YOURUSER password=YOURPASS" /y

choco install octopusdeploy /y

choco install octopusdeploy.tentacle /y

#New-WebAppPool -name "NewWebSiteAppPool"  -force
# nothing works after this line
#$appPool = Get-Item -name "NewWebSiteAppPool" 
#$appPool.processModel.identityType = "NetworkService"
#$appPool.enable32BitAppOnWin64 = 1
#$appPool | Set-Item
#md "c:\Web Sites\NewWebSite"

# All on one line
#$site = $site = new-WebSite -name "NewWebSite" `
#                            -PhysicalPath "c:\Web Sites\NewWebSite" `
#                            -HostHeader "home2.west-wind.com" `
#                            -ApplicationPool "NewWebSiteAppPool" `
#                            -force

