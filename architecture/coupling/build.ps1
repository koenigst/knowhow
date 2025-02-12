. (Join-Path $PSScriptRoot ../../.tools/pandoc.ps1)

New-Slides (Join-Path $PSScriptRoot presentation.md) coupling_presentation.html
