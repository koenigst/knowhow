function New-Slides {
  param (
    [Parameter(Mandatory, Position = 0)]
    [ValidateScript({ $_ | Test-Path })]
    [System.IO.FileInfo]$SourceFile,

    [Parameter(Mandatory, Position = 1)]
    [string]$OutputFileName,

    [System.IO.FileInfo]$OutputDirectory,
    [string]$OutputDirectoryName = 'output',
    [switch]$InstallPandoc
  )

  if ($OutputDirectory -eq $null) {
    $OutputDirectory = [System.IO.FileInfo](Join-Path $SourceFile.Directory $OutputDirectoryName)
  }

  if (-not (Test-Path $OutputDirectory)) {
    New-Item $OutputDirectory -Type Directory
  }

  $outputFile = [System.IO.FileInfo](Join-Path $OutputDirectory $OutputFileName)

  if ($InstallPandoc) {
    winget install --source winget --exact --id JohnMacFarlane.Pandoc --disable-interactivity
  }

  pandoc -t dzslides -s $SourceFile.FullName -o $outputFile.FullName --embed-resources --standalone
}
