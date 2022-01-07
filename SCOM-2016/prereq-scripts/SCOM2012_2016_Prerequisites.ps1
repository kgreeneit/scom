#####################################################################################################################################
#Updated Script created by Oskar Landman to support the SCOM 2016 release running on Windows 2016                                   #
#Updated Script created by Kevin Greene to support the SCOM 2016 release.                                                           #
#Original SCOM 2012 SP1 scripts can be found here -                                                                                 #
#http://kevingreeneitblog.blogspot.ie/2013/01/scom-2012-sp1-prerequisites-posh-way.html                                             #
#                                                                                                                                   #
#Credit for original script idea and content goes to Steve Beaumont and Tim McFadden.                                               #
#Please modify the $dwnld variable to specify your download folder location                                                         #
#                                                                                                                                   #
#####################################################################################################################################

Write-Host "PowerShell Unrestricted Execution Policy access is required to run this script." -ForegroundColor Yellow
Write-Host "If applicable, please use the (Set-ExecutionPolicy Unrestricted) command to allow the script to run." -ForegroundColor Yellow
Write-Host `n"Installing Windows roles and features for SCOM components...." -ForegroundColor Magenta

$a = new-object -comobject wscript.shell 
$VersionAnswer = $a.popup("Installing on Windows Server 2016?",0,"OS Selection",4)  
If ($VersionAnswer -eq 6) 
        {
         $ConsoleAnswer = $a.popup("Web Console Installation Yes / No",0,"Windows Server 2016 Installing Prerequisites",4)
            if($ConsoleAnswer -eq 6)
                    {
                            $a.popup("Please add the Windows Server 2016 source",0,"Web Console Installation")
                            $source = read-host "Give path to sources, please? (example:D:\sources\sxs)"
                            Write-Host `n"Installing .Net Framework 3.5 feature from Windows Media source...." -ForegroundColor Magenta
            
                            #Import-Module ServerManager
                          # Install-WindowsFeature -Name NET-Framework-Core -Source $source -Restart:$false

                            Write-Host `n"Installing remaining roles and features...." -ForegroundColor Magenta
               
                          #  Add-WindowsFeature Web-WebServer,Web-Mgmt-Console,Web-Default-Doc, Web-Dir-Browsing,Web-Http-Errors,Web-Http-Logging,Web-Request-Monitor,Web-Static-Content,Web-Stat-Compression,Web-Filtering,Web-Windows-Auth,Web-Metabase,Web-asp-Net45,NET-WCF-HTTP-Activation45,Web-Asp-Net
                            
                        }
                
        $SCOMversion = $a.popup("SCOM 2016 installation Yes / No? ",0,"SCOM Version",4)
        if($SCOMversion -eq 6) #SCOM 2016 Installation
        {
           Write-Host `n"Checking SCOM 2016 download folder location exists...." -ForegroundColor Yellow
            
                $dwnld = "C:\SCOM2016Prereqs"
            
                if (Test-Path -path $dwnld)
                        {
                            Write-Host `n"Downloads already exist now installing...." -ForegroundColor Magenta
                            Start-Sleep -s 5
                            Write-Host `n"Installing SQLSysClrTypes prerequisite...." -ForegroundColor Green
                            msiexec /qb /i "$dwnld\SQLSysClrTypes.msi" | Out-Null
                            Write-Host `n"Installing ReportViewer prerequisite...." -ForegroundColor Green
                            msiexec /qb /i "$dwnld\ReportViewer.msi" | Out-Null
                        }
                else
                        {
                            Write-Host `n"Download folder not exists...." -ForegroundColor Yellow
                            New-Item $dwnld -type directory

                            Write-Host `n"Download folder Created! --> C:\SCOM2016Prereqs" -ForegroundColor Yellow
                            Write-Host `n"Downloading and installing SQLSysClrTypes prerequisite...." -ForegroundColor Green

                    

                            $object = New-Object Net.WebClient
                            $RPTurl = 'https://download.microsoft.com/download/1/3/0/13089488-91FC-4E22-AD68-5BE58BD5C014/ENU/x64/SQLSysClrTypes.msi'
                            $object.DownloadFile($RPTurl, "$dwnld\SQLSysClrTypes.msi")
                            msiexec /qb /i "$dwnld\SQLSysClrTypes.msi" | Out-Null

                            Write-Host `n"Downloading and installing ReportViewer prerequisite...." -ForegroundColor Magenta
                    

                            $object = New-Object System.Net.WebClient
                            $RPTurl = 'https://download.microsoft.com/download/A/1/2/A129F694-233C-4C7C-860F-F73139CF2E01/ENU/x86/ReportViewer.msi'
                            $object.DownloadFile($RPTurl, "$dwnld\ReportViewer.msi")
                            msiexec /qb /i "$dwnld\ReportViewer.msi" | Out-Null
                         }
                    }
        else #SCOM 2012 Installation
        {
                        Write-Host `n"Checking SCOM 2012 download folder location exists...." -ForegroundColor Yellow

                        $dwnld = "C:\SCOM2012Prereqs"
                        if (Test-Path -path $dwnld)
                             {
                                Write-Host `n"Downloads already exist now installing...." -ForegroundColor Magenta
                                Write-Host `n"Installing SQLSysClrTypes prerequisite...." -ForegroundColor Green
                                msiexec /qb /i "$dwnld\SQLSysClrTypes.msi" | Out-Null
                                Write-Host `n"Installing ReportViewer prerequisite...." -ForegroundColor Green
                                msiexec /qb /i "$dwnld\ReportViewer.msi" | Out-Null
                             }
                        else
                             {
                                Write-Host `n"Download folder not exists...." -ForegroundColor Yellow
                                New-Item $dwnld -type directory

                                Write-Host `n"Download folder Created! --> C:\SCOM2012Prereqs" -ForegroundColor Yellow
                                Write-Host `n"Downloading and installing SQLSysClrTypes prerequisite...." -ForegroundColor Green
                    

                                $object = New-Object Net.WebClient
                                $RPTurl = 'http://download.microsoft.com/download/F/E/D/FEDB200F-DE2A-46D8-B661-D019DFE9D470/ENU/x86/SQLSysClrTypes.msi'
                                $object.DownloadFile($RPTurl, "$dwnld\SQLSysClrTypes.msi")
                                msiexec /qb /i "$dwnld\SQLSysClrTypes.msi" | Out-Null

                                Write-Host `n"Downloading and installing ReportViewer prerequisite...." -ForegroundColor Magenta
                    

                                $object = New-Object System.Net.WebClient
                                $RPTurl = 'http://download.microsoft.com/download/F/B/7/FB728406-A1EE-4AB5-9C56-74EB8BDDF2FF/ReportViewer.msi'
                                $object.DownloadFile($RPTurl, "$dwnld\ReportViewer.msi")
                                msiexec /qb /i "$dwnld\ReportViewer.msi" | Out-Null
                             }







          }
            
            

            Write-Host `n"That's it, all that's left to do now is to restart your server and you're done!" -ForegroundColor Green
        }
else 
        { 
            $ConsoleAnswer = $a.popup("Web Console Installation Yes / No",0,"Windows Server 2012 Installing Prerequisites",4)
            if($ConsoleAnswer -eq 6)
            {
             $a.popup("Please add the Windows Server 2012 source",0,"Web Console Installation")
             $source = read-host "Give path to sources, please? (example:D:\sources\sxs)"
             Write-Host `n"Installing .Net Framework 3.5 feature from Windows Media source...." -ForegroundColor Magenta
             
             Import-Module ServerManager
             Install-WindowsFeature -Name NET-Framework-Core -Source D:\sources\sxs -Restart:$false

             Write-Host `n"Installing remaining roles and features...." -ForegroundColor Magenta
             Start-Sleep -s 5
             Add-WindowsFeature Web-Server,NET-HTTP-Activation,NET-WCF-HTTP-Activation45,Web-Mgmt-Console,Web-Net-Ext,Web-Net-Ext45,Web-Static-Content,Web-Default-Doc,Web-Dir-Browsing,Web-Http-Errors,Web-Http-Logging,Web-Request-Monitor,Web-Filtering,Web-Stat-Compression,Web-ISAPI-Ext,Web-ISAPI-Filter,Web-Metabase,Web-Asp-Net,Web-Windows-Auth,Windows-Identity-Foundation –restart
             }

            Write-Host `n"Checking download folder location exists...." -ForegroundColor Yellow

            $SCOMversion = $a.popup("SCOM 2016 installation Yes / No? ",0,"SCOM Version",4)
        if($SCOMversion -eq 6) #SCOM 2016 Installation
        {
           Write-Host `n"Checking SCOM 2016 download folder location exists...." -ForegroundColor Yellow
            
                $dwnld = "C:\SCOM2016Prereqs"
            
                if (Test-Path -path $dwnld)
                        {
                            Write-Host `n"Downloads already exist now installing...." -ForegroundColor Magenta
                            Start-Sleep -s 5
                            Write-Host `n"Installing SQLSysClrTypes prerequisite...." -ForegroundColor Green
                            msiexec /qb /i "$dwnld\SQLSysClrTypes.msi" | Out-Null
                            Write-Host `n"Installing ReportViewer prerequisite...." -ForegroundColor Green
                            msiexec /qb /i "$dwnld\ReportViewer.msi" | Out-Null
                        }
                else
                        {
                            Write-Host `n"Download folder not exists...." -ForegroundColor Yellow
                            New-Item $dwnld -type directory

                            Write-Host `n"Download folder Created! --> C:\SCOM2016Prereqs" -ForegroundColor Yellow
                            Write-Host `n"Downloading and installing SQLSysClrTypes prerequisite...." -ForegroundColor Green

                    

                            $object = New-Object Net.WebClient
                            $RPTurl = 'https://download.microsoft.com/download/1/3/0/13089488-91FC-4E22-AD68-5BE58BD5C014/ENU/x64/SQLSysClrTypes.msi'
                            $object.DownloadFile($RPTurl, "$dwnld\SQLSysClrTypes.msi")
                            msiexec /qb /i "$dwnld\SQLSysClrTypes.msi" | Out-Null

                            Write-Host `n"Downloading and installing ReportViewer prerequisite...." -ForegroundColor Magenta
                    

                            $object = New-Object System.Net.WebClient
                            $RPTurl = 'https://download.microsoft.com/download/A/1/2/A129F694-233C-4C7C-860F-F73139CF2E01/ENU/x86/ReportViewer.msi'
                            $object.DownloadFile($RPTurl, "$dwnld\ReportViewer.msi")
                            msiexec /qb /i "$dwnld\ReportViewer.msi" | Out-Null
                         }
                    }
        else #SCOM 2012 Installation
        {
                        Write-Host `n"Checking SCOM 2012 download folder location exists...." -ForegroundColor Yellow

                        $dwnld = "C:\SCOM2012Prereqs"
                        if (Test-Path -path $dwnld)
                             {
                                Write-Host `n"Downloads already exist now installing...." -ForegroundColor Magenta
                                Write-Host `n"Installing SQLSysClrTypes prerequisite...." -ForegroundColor Green
                                msiexec /qb /i "$dwnld\SQLSysClrTypes.msi" | Out-Null
                                Write-Host `n"Installing ReportViewer prerequisite...." -ForegroundColor Green
                                msiexec /qb /i "$dwnld\ReportViewer.msi" | Out-Null
                             }
                        else
                             {
                                Write-Host `n"Download folder not exists...." -ForegroundColor Yellow
                                New-Item $dwnld -type directory

                                Write-Host `n"Download folder Created! --> C:\SCOM2012Prereqs" -ForegroundColor Yellow
                                Write-Host `n"Downloading and installing SQLSysClrTypes prerequisite...." -ForegroundColor Green
                    

                                $object = New-Object Net.WebClient
                                $RPTurl = 'http://download.microsoft.com/download/F/E/D/FEDB200F-DE2A-46D8-B661-D019DFE9D470/ENU/x86/SQLSysClrTypes.msi'
                                $object.DownloadFile($RPTurl, "$dwnld\SQLSysClrTypes.msi")
                                msiexec /qb /i "$dwnld\SQLSysClrTypes.msi" | Out-Null

                                Write-Host `n"Downloading and installing ReportViewer prerequisite...." -ForegroundColor Magenta
                    

                                $object = New-Object System.Net.WebClient
                                $RPTurl = 'http://download.microsoft.com/download/F/B/7/FB728406-A1EE-4AB5-9C56-74EB8BDDF2FF/ReportViewer.msi'
                                $object.DownloadFile($RPTurl, "$dwnld\ReportViewer.msi")
                                msiexec /qb /i "$dwnld\ReportViewer.msi" | Out-Null
                             }







          }
            

            Write-Host `n"That's it, all that's left to do now is to restart your server and you're done!" -ForegroundColor Green

        } 

