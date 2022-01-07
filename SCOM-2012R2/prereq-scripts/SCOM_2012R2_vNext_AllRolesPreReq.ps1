#####################################################################################################################################
#Updated Script created by Kevin Greene to support SCOM 2012 R2 and SCOM vNext Release.                                             #
#Original SCOM 2012 SP1 scripts can be found here -                                                                                 #
#http://kevingreeneitblog.blogspot.ie/2013/01/scom-2012-sp1-prerequisites-posh-way.html                                             #
#                                                                                                                                   #
#Credit for original script idea and content goes to Steve Beaumont and Tim McFadden.                                               #
#Please modify the $dwnld variable to specify your download folder location.                                                        #
#                                                                                                                                   #
#####################################################################################################################################

Write-Host "PowerShell Unrestricted Execution Policy access is required to run this script." -ForegroundColor Green
Start-Sleep -s 3

Write-Host "If applicable, please use the (Set-ExecutionPolicy Unrestricted) command to allow the script to run." -ForegroundColor Yellow
Start-Sleep -s 10

Write-Host "Installing Windows Roles and Features for SCOM components...." -ForegroundColor Magenta
Start-Sleep -s 5
Import-Module ServerManager
Add-WindowsFeature Web-Server,NET-Framework-Core,NET-HTTP-Activation,NET-WCF-HTTP-Activation45,Web-Mgmt-Console,Web-Net-Ext,Web-Net-Ext45,Web-Static-Content,Web-Default-Doc,Web-Dir-Browsing,Web-Http-Errors,Web-Http-Logging,Web-Request-Monitor,Web-Filtering,Web-Stat-Compression,Web-ISAPI-Ext,Web-ISAPI-Filter,Web-Metabase,Web-Asp-Net,Web-Windows-Auth,Windows-Identity-Foundation –restart

Write-Host "Creating download folder location...." -ForegroundColor Magenta
Start-Sleep -s 5

$dwnld = "C:\SCOMVNEXTPrereqs"
if (!(Test-Path -path $dwnld))
 {
 New-Item $dwnld -type directory
 }

Write-Host "Downloading and installing SQLSysClrTypes prerequisite...." -ForegroundColor Magenta
Start-Sleep -s 5

$object = New-Object Net.WebClient
$RPTurl = 'http://download.microsoft.com/download/F/E/D/FEDB200F-DE2A-46D8-B661-D019DFE9D470/ENU/x64/SQLSysClrTypes.msi'
$object.DownloadFile($RPTurl, "$dwnld\SQLSysClrTypes.msi")
msiexec /qb /i "$dwnld\SQLSysClrTypes.msi" | Out-Null

Write-Host "Checking download folder location exists...." -ForegroundColor Yellow
Start-Sleep -s 5

$dwnld = "C:\SCOMVNEXTPrereqs"
if (!(Test-Path -path $dwnld))
 {
 New-Item $dwnld -type directory
 }

Write-Host "Downloading and installing ReportViewer prerequisite...." -ForegroundColor Magenta
Start-Sleep -s 5

$object = New-Object System.Net.WebClient
$RPTurl = 'http://download.microsoft.com/download/F/B/7/FB728406-A1EE-4AB5-9C56-74EB8BDDF2FF/ReportViewer.msi'
$object.DownloadFile($RPTurl, "$dwnld\ReportViewer.msi")
msiexec /qb /i "$dwnld\ReportViewer.msi" | Out-Null

Write-Host "That's it, all that's left to do now is to restart your server and you're done!" -ForegroundColor Green
