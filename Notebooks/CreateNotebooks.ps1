if (Get-Module ADSNotebook -ListAvailable) {
    Write-Output "You don't have the required module to create the notebooks"
    Install-Module ADSNotebook -Scope CurrentUser -Confirm
}

$Wikilocation = 'C:\Users\mrrob\OneDrive\Documents\GitHub\ClonedForked\SqlServerAndContainersGuide.wiki'
$GitLocation = 'C:\Users\mrrob\OneDrive\Documents\GitHub\ClonedForked\SqlServerAndContainersGuide'

$dotnetnotebookpath = "$GitLocation\Notebooks\dotnet\"
$notdotnetnotebookpath = "$GitLocation\Notebooks\notdotnet\"

Copy-Item -Path $Wikilocation\images -Destination $GitLocation\Notebooks\ -Recurse -Force

$wikipages = Get-ChildItem $Wikilocation\*md

foreach ($page in $wikipages) {

    Convert-AdsGithubWikiToNotebook -FilePath $page.FullName -NotebookDirectory $dotnetnotebookpath -NotebookType DotNetPowerShell 
    Convert-AdsGithubWikiToNotebook -FilePath $page.FullName -NotebookDirectory $notdotnetnotebookpath -NotebookType PowerShell 
}