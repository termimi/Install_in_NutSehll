function CheckPsVersion {
    return $PSVersionTable.PSVersion
}

function InstallTeams {
    param (
        [Parameter()]
        [string]$InstallPath = $(Get-Location).Path
    )
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

$PowershellVersion = CheckPsVersion

if (($PowershellVersion.Major -lt 5) -or ($PowershellVersion.Major -lt 7) ) {
    Write-Error "Your version of powershell is to old to execute this script"
}
InstallTeams
