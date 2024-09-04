$sourceFileName = 'presentation.md'
$outputFileName = 'review_guide_presentation.html'

$rootDirectory = $PSScriptRoot
$sourceFile = Join-Path $rootDirectory $sourceFileName
$outputDirectory = Join-Path $rootDirectory 'output'
$outputFile = Join-Path $outputDirectory $outputFileName

if (-not (Test-Path $outputDirectory)) {
  New-Item $outputDirectory -Type Directory
}

pandoc -t dzslides -s $sourceFile -o $outputFile --embed-resources --standalone
