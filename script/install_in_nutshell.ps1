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
        
        # todo: supprimé le msTeamssetup une fois installé
        #Remove-Item -Path "$InstallPath\MSTeamsSetup.exe" -Force
    }
    catch {
        Write-Error "An error has been encoutred: " $_.Exception.Message
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
    }
    catch {
        Write-Error "An error has been encoutred: " $_.Exception.Message
    }
}

$PowershellVersion = CheckPsVersion

if (($PowershellVersion.Major -lt 5) -or ($PowershellVersion.Major -lt 7) ) {
    Write-Error "Your version of powershell is to old to execute this script"
}
InstallTeams
InstallVsCode