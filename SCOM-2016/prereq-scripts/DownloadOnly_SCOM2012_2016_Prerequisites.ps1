$2012dwnld = "C:\SCOM2012Prereqs"

New-Item $2012dwnld -type directory
Write-Host `n"Download folder Created! --> C:\SCOM2012Prereqs" -ForegroundColor Yellow

                    
#SQLClrTypes2012
Write-Host `n"Downloading  SQLSysClrTypes prerequisite...." -ForegroundColor Green

$object = New-Object Net.WebClient
$RPTurl = 'http://download.microsoft.com/download/F/E/D/FEDB200F-DE2A-46D8-B661-D019DFE9D470/ENU/x86/SQLSysClrTypes.msi'
$object.DownloadFile($RPTurl, "$2012dwnld\SQLSysClrTypes.msi")

#reportviewer2012
Write-Host `n"Downloading ReportViewer prerequisite...." -ForegroundColor Magenta
                    

$object = New-Object System.Net.WebClient
$RPTurl = 'http://download.microsoft.com/download/F/B/7/FB728406-A1EE-4AB5-9C56-74EB8BDDF2FF/ReportViewer.msi'
$object.DownloadFile($RPTurl, "$2012dwnld\ReportViewer.msi")



$2016dwnld = "C:\SCOM2016Prereqs"

New-Item $2016dwnld -type directory

Write-Host `n"Download folder Created! --> C:\SCOM2016Prereqs" -ForegroundColor Yellow

#SQLCLRtypes2014
Write-Host `n"Downloading SQLSysClrTypes prerequisite...." -ForegroundColor Green

$object = New-Object Net.WebClient
$RPTurl = 'https://download.microsoft.com/download/1/3/0/13089488-91FC-4E22-AD68-5BE58BD5C014/ENU/x64/SQLSysClrTypes.msi'
$object.DownloadFile($RPTurl, "$2016dwnld\SQLSysClrTypes.msi")

#reportviewer2015
Write-Host `n"Downloading ReportViewer prerequisite...." -ForegroundColor Magenta
                    
$object = New-Object System.Net.WebClient
$RPTurl = 'https://download.microsoft.com/download/A/1/2/A129F694-233C-4C7C-860F-F73139CF2E01/ENU/x86/ReportViewer.msi'
$object.DownloadFile($RPTurl, "$2016dwnld\ReportViewer.msi")
