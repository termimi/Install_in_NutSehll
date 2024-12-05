function Assert-Equal {
    param (
        [scriptblock]$action,
        $expected
    )
    # Le symbole & est l'opérateur d'appel en PowerShell. Il est utilisé pour exécuter un script ou un bloc de script.
    # La ligne permet de recupérer le retour de l'action
    $result = (& $action | Out-String).Trim() 
    if([string]$expected -eq [string]$result){
        Write-Host "test réussi"
    }
    else {
        Write-Host "test echoué"
        Write-Host("expected :" + $expected)
        Write-Host("result :" + $result)

    }
}
function Assert-Like {
    param (
        [scriptblock]$action,
        $expected
    )
    # Le symbole & est l'opérateur d'appel en PowerShell. Il est utilisé pour exécuter un script ou un bloc de script.
    # La ligne permet de recupérer le retour de l'action
    $result = (& $action | Out-String).Trim() 
    if("$expected" -like "*$result*"){
        Write-Host "test réussi"
    }
    else {
        Write-Host "test echoué"
        Write-Host("expected :" + $expected)
        Write-Host("result :" + $result)

    }
}
Write-Host "Test1"
$excpectedResult = "L’utilisateur ou groupe global suivant n’existe pas : wefwefd."
Assert-Like -action { .\install_in_nutshell.ps1 -CompleteInstall $false -UserToAdd wefwefd > $null 2>&1} -expected $excpectedResult

net localgroup docker-users po66qga /DELETE > $null 2>&1
Write-Host "Test2"
$excpectedResult = "La commande s'est terminée correctement."
Assert-Like -action { .\install_in_nutshell.ps1 -CompleteInstall $false -UserToAdd po66qga > $null 2>&1} -expected $excpectedResult

Write-Host "Test3"
$excpectedResult = "Le nom de compte spécifié est déjà membre du groupe."
Assert-Like -action { .\install_in_nutshell.ps1 -CompleteInstall $false -UserToAdd po66qga > $null 2>&1} -expected $excpectedResult

