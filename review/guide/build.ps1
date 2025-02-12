. (Join-Path $PSScriptRoot ../../.tools/pandoc.ps1)

New-Slides (Join-Path $PSScriptRoot presentation.md) review_guide_presentation.html
