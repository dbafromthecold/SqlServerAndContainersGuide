if (Get-Module ADSNotebook -ListAvailable) {
    Write-Output "You don't have the required module to create the notebooks"
    Install-Module ADSNotebook -Scope CurrentUser -Confirm
}

$Wikilocation = 'C:\Users\mrrob\OneDrive\Documents\GitHub\ClonedForked\SqlServerAndContainersGuide.wiki'
$GitLocation = 'C:\Users\mrrob\OneDrive\Documents\GitHub\ClonedForked\SqlServerAndContainersGuide'

Copy-Item -Path $Wikilocation\images -Destination $GitLocation\Notebooks\ -Recurse -Force

$wikipages = Get-ChildItem $Wikilocation\*md
$j = 1
$cells = @()
Get-Variable *block* | Remove-Variable
foreach ($page in $wikipages) {
    $content = Get-Content $page.FullName
    $lasttype = 'Text'
    $vars = 'Text', 'Code'
    $blockcontent = ''
    $i = 1
    $content.ForEach{
        Write-Verbose "Starting Line"
        $line = $psitem
        $line = $line.Replace('[[', '![](..').Replace(']]', ')')
        if ($line.StartsWith('    ')) {
            Write-Verbose "This is a code line: $line"
            $type = 'code'
        }
        else {
            $type = 'text'
            Write-Verbose "This is a not code line: $line"
        }
        if ($lasttype -eq $type) {
            Write-Verbose "Set blockcontent"
            $blockcontent = $blockcontent + "`r" + $line 
        }
        else {   
            $celltype = $vars -ne $type | Out-String 
            $celltype = $celltype.Replace("`r`n", '')
            $block = New-ADSWorkBookCell -Type $celltype -Text $blockcontent
            New-Variable -Name "block_$j$i" -Value $block 
            $blockcontent = $line
            $cells = $cells + $block
            $i ++
        }
        $lasttype = $type
        $message = "Text $text "
        Write-Verbose $message
        Write-Verbose "Code - $code"
        Write-Verbose "Finished Line"
    }
    # $cells = $cells.TrimEnd(',') |Out-String
    $path = "$GitLocation\Notebooks\dotnet\" + $page.Name.replace('.md', '.ipynb')
    New-ADSWorkBook -Path $path -cells $cells -Type DotNetPowerShell
    $path = "$GitLocation\Notebooks\notdotnet\" + $page.Name.replace('.md', '.ipynb')
    New-ADSWorkBook -Path $path -cells $cells -Type PowerShell
    $cells = @()
    $j ++
}
