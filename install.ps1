$sourceDir = $PSScriptRoot
$targetDir = "C:\Users\$env:USERNAME"

# Get all files and directories except install.ps1 and readme.md
$items = Get-ChildItem -Path $sourceDir -Recurse | Where-Object {
    $_.FullName -notmatch "install.ps1|readme.md"
}

foreach ($item in $items) {
    $targetPath = Join-Path -Path $targetDir -ChildPath $item.FullName.Substring($sourceDir.Length + 1)
    if ($item.PSIsContainer) {
        New-Item -ItemType Directory -Path $targetPath -Force
    } else {
        New-Item -ItemType HardLink -Path $targetPath -Value $item.FullName
    }
}