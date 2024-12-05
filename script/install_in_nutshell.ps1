# Parameter help description
[Parameter]
[string]
$InstallPath = $(Get-Location).Path
function CheckPsVersion {
    return $PSVersionTable.PSVersion
}

function InstallTeams {
    $downloadLink = "https://go.microsoft.com/fwlink/?linkid=2281613&clcid=0x40c&culture=fr-fr&country=fr"
    try {
        # Téléchargement de l'installer
        Write-Output "Downloading Microsoft Teams installer..."
        Invoke-WebRequest -Uri $downloadLink -OutFile $InstallPath -UseBasicParsing
        Write-Output "Teams installer downloaded to: $InstallPath"

        Write-Output "Installing Microsoft Teams..."
        Start-Process -FilePath "$InstallPath\MSTeamsSetup.exe"
        Write-Output "Microsoft Teams has been installed successfully"
        
        # todo: supprimé le msTeamssetup une fois installé
        #Remove-Item -Path "$InstallPath\MSTeamsSetup.exe" -Force
    }
    catch {
        Write-Error "An error has been encountered: " + $_.Exception.Message
    }
}
function InstallVsCode {
    $downloadLink = "https://vscode.download.prss.microsoft.com/dbazure/download/stable/f1a4fb101478ce6ec82fe9627c43efbf9e98c813/VSCodeUserSetup-x64-1.95.3.exe"

    try {
        Write-Output "Downloading Visual Studio Code installer..."
        Invoke-WebRequest -Uri $downloadLink -OutFile $InstallPath -UseBasicParsing
        Write-Output "Visual Studio Code installer downloaded to: $InstallPath"
        Write-Output "Installing VSCode"
        #TODO: Faire en sorte de ne pas utiliser le nom de l'installer en harde code mais de le récupérer dans un tableau
        Start-Process -FilePath "$InstallPath\VSCodeUserSetup-x64-1.95.3.exe"
        Write-Output "VSCode has been installed successfully"
    }
    catch {
        Write-Error "An error has been encountered: " + $_.Exception.Message
    }
}
function InstallDocker {
    $downloadLink = "https://desktop.docker.com/win/main/amd64/Docker%20Desktop%20Installer.exe?utm_source=docker&utm_medium=webreferral&utm_campaign=dd-smartbutton&utm_location=module&_gl=1*1mq0u4u*_gcl_au*NjY4NTY5NTgwLjE3MzMzODI3NDg.*_ga*MTgyMDcxMzA3MC4xNzMzMzgyNzQ4*_ga_XJWPQMJYHQ*MTczMzM4Mjc0OC4xLjEuMTczMzM4Mjc3NS4zMy4wLjA."

    try {
        Write-Output "Downloading docker desktop installer..."
        Invoke-WebRequest -Uri $downloadLink -OutFile $InstallPath -UseBasicParsing
        Write-Output "docker desktop installer downloaded to: $InstallPath"
        Write-Output "Installing docker desktop"

        #TODO: Faire en sorte de ne pas utiliser le nom de l'installer en harde code mais de le récupérer dans un tableau
        Start-Process -FilePath "$InstallPath\Docker Desktop Installer.exe"
        Write-Output "Docker Desktop has been installed successfully"
    }
    catch {
        Write-Error "An error has been encountered: " + $_.Exception.Message
    }
}
function CheckForDocker {
    $isDockergroupHere = Get-LocalGroup | Where-Object {$_.Name -like "*docker*"}
    if($null -ne $isDockergroupHere){
        return $true
    }
    else{
        return $false
    }
}

$PowershellVersion = CheckPsVersion
$currentuser = [System.Security.Principal.WindowsIdentity]::GetCurrent()
$principalUser = New-Object System.Security.Principal.WindowsPrincipal($currentuser)

if (($PowershellVersion.Major -lt 5) -or ($PowershellVersion.Major -lt 7) ) {
    Write-Error "Your version of powershell is to old to execute this script"
}
InstallTeams
InstallVsCode
if ($principalUser.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)){
    try {
        $isDockerHere = CheckForDocker
        if($isDockerHere){
            $currentuser = $currentuser.Name
            $username = $currentUser.Split('\')[-1]
            Write-Output "Adding user to docker group"
            net localgroup docker-users $username /ADD
            Write-Output "Your user has been added to the docker-users group"
        }
        else {
            InstallDocker
        }
    }
    catch {
        Write-Error ("An error has been encountered: " + $_.Exception.Message)
    }
}
else {
    Write-Output "Script not used with administrator rights - docker cannot be installed or used"
}
