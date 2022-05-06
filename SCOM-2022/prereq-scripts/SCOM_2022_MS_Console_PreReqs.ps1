#####################################################################################################################################
#Updated Script created by Kevin Greene to support the SCOM 2022 release.         				                                    #
#Original SCOM Prereq scripts can be found here -                                                                                 #
#http://kevingreeneitblog.blogspot.ie/2013/01/scom-2012-sp1-prerequisites-posh-way.html                                             #
#                                                                                                                                   #
#Credit for original script idea and content goes to Steve Beaumont and Tim McFadden.                                               #
#Please modify the $dwnld variable to specify your download folder location                                                         #
#####################################################################################################################################

Write-Host "PowerShell Unrestricted Execution Policy access is required to run this script." -ForegroundColor Green
Start-Sleep -s 5

Write-Host "If applicable, please use the (Set-ExecutionPolicy Unrestricted) command to allow the script to run." -ForegroundColor Yellow
Start-Sleep -s 10

Write-Host `n"Creating download folder location...." -ForegroundColor Magenta
Start-Sleep -s 5

$dwnld = "C:\SCOMPrereqs"
if (!(Test-Path -path $dwnld)) {
    New-Item $dwnld -type directory
}

Write-Host `n"Downloading and installing SQLSysClrTypes prerequisite...." -ForegroundColor Green
Start-Sleep -s 5

$object = New-Object Net.WebClient
$RPTurl = 'https://download.microsoft.com/download/d/d/1/dd194c5c-d859-49b8-ad64-5cbdcbb9b7bd/SQLSysClrTypes.msi'
$object.DownloadFile($RPTurl, "$dwnld\SQLSysClrTypes.msi")
msiexec /qb /i "$dwnld\SQLSysClrTypes.msi" | Out-Null

Write-Host `n"Checking download folder location exists...." -ForegroundColor Yellow
Start-Sleep -s 5

$dwnld = "C:\SCOMPrereqs"
if (!(Test-Path -path $dwnld)) {
    New-Item $dwnld -type directory
}

Write-Host `n"Downloading and installing ReportViewer prerequisite...." -ForegroundColor Magenta
Start-Sleep -s 5

$object = New-Object System.Net.WebClient
$RPTurl = 'https://download.microsoft.com/download/A/1/2/A129F694-233C-4C7C-860F-F73139CF2E01/ENU/x86/ReportViewer.msi'
$object.DownloadFile($RPTurl, "$dwnld\ReportViewer.msi")
msiexec /qb /i "$dwnld\ReportViewer.msi" | Out-Null

Write-Host `n"That's it, you're good to go!" -ForegroundColor Green