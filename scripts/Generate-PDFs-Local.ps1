# PowerShell Local PDF Generation Script
# Generates HTML and PDF files locally using the same process as GitHub Actions

param(
    [switch]$Help = $false,
    [switch]$SkipInstall = $false,
    [string]$LabFilter = ""
)

if ($Help) {
    Write-Host @"
╔═════════════════════════════════════════════════════════════════════════════════════════╗
║                           MCS Labs - Local PDF Generator                                   ║
╚═════════════════════════════════════════════════════════════════════════════════════════╝

USAGE:
    .\Generate-PDFs-Local.ps1 [-SkipInstall] [-LabFilter <lab-name>] [-Help]

DESCRIPTION:
    Generates HTML and PDF files locally using the same process as GitHub Actions.
    This includes markdown preprocessing, HTML conversion with Pandoc, and PDF generation
    with Puppeteer.

PARAMETERS:
    -SkipInstall    Skip Node.js dependency installation
    -LabFilter      Generate PDFs only for specific lab (e.g., "agent-builder-web")
    -Help          Show this help message

REQUIREMENTS:
    - PowerShell 5.1+ or PowerShell Core
    - Node.js 18+ (for Puppeteer PDF generation)
    - Pandoc (for Markdown to HTML conversion)

OUTPUT:
    Generated files are placed in local-dist/ directory:
    - HTML files: local-dist/{lab-name}/{lab-name}.html
    - PDF files: local-dist/{lab-name}/{lab-name}.pdf
    - Jekyll assets: assets/pdfs/{lab-name}.pdf

"@ -ForegroundColor Cyan
    exit 0
}

Write-Host "╔═══════════════════════════════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║                           MCS Labs - Local PDF Generator                               ║" -ForegroundColor Cyan
Write-Host "╚═══════════════════════════════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan

# Function to check if a command exists
function Test-Command {
    param([string]$Command)
    try {
        Get-Command $Command -ErrorAction Stop | Out-Null
        return $true
    } catch {
        return $false
    }
}

# Check requirements
Write-Host "🔍  Checking requirements..." -ForegroundColor Yellow

if (-not (Test-Command "node")) {
    Write-Host "❌  Node.js not found. Please install Node.js 18+ from https://nodejs.org/" -ForegroundColor Red
    exit 1
}

$nodeVersion = (node --version).Substring(1)
Write-Host "  ✅  Node.js version: $nodeVersion" -ForegroundColor Green

if (-not (Test-Command "pandoc")) {
    Write-Host "❌  Pandoc not found. Please install Pandoc from https://pandoc.org/installing.html" -ForegroundColor Red
    exit 1
}

$pandocVersion = (pandoc --version | Select-Object -First 1).Split(' ')[1]
Write-Host "  ✅  Pandoc version: $pandocVersion" -ForegroundColor Green

# Install Node.js dependencies
if (-not $SkipInstall) {
    Write-Host "📦  Installing Node.js dependencies..." -ForegroundColor Yellow
    npm install
    if ($LASTEXITCODE -ne 0) {
        Write-Host "❌  Failed to install Node.js dependencies" -ForegroundColor Red
        exit 1
    }
    Write-Host "  ✅  Dependencies installed" -ForegroundColor Green
} else {
    Write-Host "⏭️   Skipping dependency installation" -ForegroundColor Yellow
}

# Create output directories
Write-Host "📁  Creating output directories..." -ForegroundColor Yellow
$outputDir = "local-dist"
$assetsDir = "assets/pdfs"

if (Test-Path $outputDir) {
    Remove-Item -Recurse -Force $outputDir
}
New-Item -ItemType Directory -Path $outputDir -Force | Out-Null

if (-not (Test-Path $assetsDir)) {
    New-Item -ItemType Directory -Path $assetsDir -Force | Out-Null
}

Write-Host "  ✅  Output directories created" -ForegroundColor Green

# Function to process markdown similar to GitHub Actions workflow
function Convert-MarkdownToHtml {
    param(
        [string]$LabDir,
        [string]$LabName,
        [string]$OutputDir
    )
    
    Write-Host "  🔄  Processing lab: $LabName" -ForegroundColor Cyan
    
    $labOutputDir = Join-Path $OutputDir $LabName
    New-Item -ItemType Directory -Path $labOutputDir -Force | Out-Null
    
    $readmePath = Join-Path $LabDir "README.md"
    if (-not (Test-Path $readmePath)) {
        Write-Host "    ❌  README.md not found in $LabDir" -ForegroundColor Red
        return @{ Success = $false }
    }
    
    # Enter lab directory for relative path processing
    Push-Location $LabDir
    
    try {
        # Preprocessing - same as GitHub Actions
        $processedFile = "${LabName}_processed.md"
        Copy-Item "README.md" $processedFile
        
        Write-Host "    🔄  Preprocessing markdown content..." -ForegroundColor Gray
        
        # Process callouts using PowerShell (simpler than awk)
        $content = Get-Content $processedFile -Raw
        
        # Process callout blocks
        $content = $content -replace '(?m)^> \[!(NOTE|TIP|IMPORTANT|WARNING|CAUTION)\](.*)$', '> <div class="$($matches[1].ToLower())">**$($matches[1].ToUpper()):** $2'
        $content = $content -replace '(?m)^(?!> )(.*)(?<=</div>)', '$1`n</div>'
        
        # Clean headers (remove emojis and special characters)
        $content = $content -replace '(?m)^(#{2,4})\s*[^\w\s]+\s*([a-zA-Z].*)$', '$1 $2'
        
        # Fix anchor links
        $content = $content -replace '\(#[^\w\s-]+\s*-?\s*([a-z][^)]*)\)', '(#$1)'
        $content = $content -replace '\(#-([a-zA-Z][^)]*)\)', '(#$1)'
        
        Set-Content -Path $processedFile -Value $content -Encoding UTF8
        
        # Extract title
        $titleMatch = $content | Select-String -Pattern '^# (.+)' | Select-Object -First 1
        $labTitle = if ($titleMatch) { 
            $titleMatch.Matches[0].Groups[1].Value -replace '[*_`]', ''
        } else { 
            "$LabName - Microsoft Copilot Studio Labs" 
        }
        
        Write-Host "    📋  Document title: $labTitle" -ForegroundColor Gray
        
        # Convert with Pandoc - use absolute paths
        $absLabOutputDir = if (Test-Path $labOutputDir) { 
            (Resolve-Path $labOutputDir).Path 
        } else { 
            (New-Item -ItemType Directory -Path $labOutputDir -Force).FullName 
        }
        $htmlOutput = Join-Path $absLabOutputDir "$LabName.html"
        
        # Get CSS path - handle both local and Docker execution
        $workspaceRoot = if ($PWD.Path -match "workspace") { 
            "/workspace" 
        } elseif (Test-Path "../../.github/styles/html.css") {
            (Resolve-Path "../..").Path
        } else {
            # Fallback - navigate up from current lab directory
            (Get-Item $PWD).Parent.Parent.FullName
        }
        $cssPath = Join-Path $workspaceRoot ".github/styles/html.css"
        
        Write-Host "    🎨  Using CSS path: $cssPath" -ForegroundColor Gray
        Write-Host "    🔄  Converting to HTML with Pandoc..." -ForegroundColor Gray
        
        $pandocArgs = @(
            $processedFile
            "-o"
            $htmlOutput
            "--standalone"
            "--self-contained"
            "--css=$cssPath"
            "--html-q-tags"
            "--section-divs"
            "--id-prefix="
            "--metadata"
            "title=$labTitle"
            "--metadata"
            "lang=en"
            "-f"
            "markdown+auto_identifiers+gfm_auto_identifiers+emoji+header_attributes"
            "-t"
            "html5"
        )
        
        & pandoc @pandocArgs
        
        if ($LASTEXITCODE -eq 0 -and (Test-Path $htmlOutput)) {
            Write-Host "    ✅  HTML conversion successful" -ForegroundColor Green
            
            # Post-process HTML (same as GitHub Actions)
            $htmlContent = Get-Content $htmlOutput -Raw
            
            # Remove title block header
            $htmlContent = $htmlContent -replace '<header id="title-block-header">.*?</header>', ''
            
            # Clean up IDs and anchors
            $htmlContent = $htmlContent -replace 'id=""', ''
            $htmlContent = $htmlContent -replace 'id="[[:space:]]*"', ''
            $htmlContent = $htmlContent -replace 'href="#[[:space:]]*([^"[:space:]]*)[[:space:]]*"', 'href="#$1"'
            
            # External links
            $htmlContent = $htmlContent -replace '<a href="(https?://[^"]*)"', '<a href="$1" target="_blank" rel="noopener noreferrer"'
            
            # Add favicon
            $htmlContent = $htmlContent -replace '</head>', '  <link rel="icon" href="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAxMDAgMTAwIj4KICA8Y2lyY2xlIGN4PSI1MCIgY3k9IjUwIiByPSI0NSIgZmlsbD0iIzJCNTc5QSIvPgogIDx0ZXh0IHg9IjUwIiB5PSI2NSIgZm9udC1mYW1pbHk9IkFyaWFsLHNhbnMtc2VyaWYiIGZvbnQtc2l6ZT0iNDUiIGZvbnQtd2VpZ2h0PSJib2xkIiBmaWxsPSJ3aGl0ZSIgdGV4dC1hbmNob3I9Im1pZGRsZSI+TDwvdGV4dD4KPC9zdmc+">`n</head>'
            
            Set-Content -Path $htmlOutput -Value $htmlContent -Encoding UTF8
            
            # Cleanup
            Remove-Item $processedFile -Force
            
            return @{
                Success = $true
                HtmlPath = $htmlOutput
                Title = $labTitle
            }
        } else {
            Write-Host "    ❌  Pandoc conversion failed" -ForegroundColor Red
            return @{ Success = $false }
        }
    } finally {
        Pop-Location
    }
}

# Function to generate PDF using Node.js script
function Convert-HtmlToPdf {
    param(
        [string]$HtmlPath,
        [string]$PdfPath,
        [string]$Title
    )
    
    Write-Host "    📄  Generating PDF..." -ForegroundColor Gray
    
    & node ".github/scripts/generate-pdf.js" $HtmlPath $PdfPath $Title
    
    if ($LASTEXITCODE -eq 0 -and (Test-Path $PdfPath)) {
        Write-Host "    ✅  PDF generation successful" -ForegroundColor Green
        return $true
    } else {
        Write-Host "    ❌  PDF generation failed" -ForegroundColor Red
        return $false
    }
}

# Process labs
Write-Host "🔄  Processing labs..." -ForegroundColor Yellow

$labDirs = Get-ChildItem -Path "labs" -Directory | Where-Object { $_.Name -ne "." -and $_.Name -ne ".." }

if ($LabFilter) {
    $labDirs = $labDirs | Where-Object { $_.Name -eq $LabFilter }
    if (-not $labDirs) {
        Write-Host "❌  Lab '$LabFilter' not found" -ForegroundColor Red
        exit 1
    }
}

$successCount = 0
$totalCount = 0

foreach ($labDir in $labDirs) {
    $labName = $labDir.Name
    $totalCount++
    
    Write-Host "📝  Processing: $labName" -ForegroundColor Yellow
    
    # Convert to HTML
    $htmlResult = Convert-MarkdownToHtml -LabDir $labDir.FullName -LabName $labName -OutputDir $outputDir
    
    if ($htmlResult.Success) {
        # Generate PDF
        $pdfPath = Join-Path (Split-Path $htmlResult.HtmlPath) "$labName.pdf"
        
        if (Convert-HtmlToPdf -HtmlPath $htmlResult.HtmlPath -PdfPath $pdfPath -Title $htmlResult.Title) {
            # Copy PDF to Jekyll assets
            $assetsPdfPath = Join-Path $assetsDir "$labName.pdf"
            Copy-Item $pdfPath $assetsPdfPath -Force
            Write-Host "  ✅  Copied PDF to Jekyll assets: $assetsPdfPath" -ForegroundColor Green
            $successCount++
        }
    }
}

Write-Host ""
Write-Host "╔═══════════════════════════════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║                                GENERATION COMPLETE                                     ║" -ForegroundColor Cyan
Write-Host "╚═══════════════════════════════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan

Write-Host "📊  Processing Summary:" -ForegroundColor Yellow
Write-Host "    Total labs processed: $totalCount" -ForegroundColor White
Write-Host "    Successfully generated: $successCount" -ForegroundColor Green
Write-Host "    Failed: $($totalCount - $successCount)" -ForegroundColor Red

if ($successCount -gt 0) {
    Write-Host ""
    Write-Host "📁  Output locations:" -ForegroundColor Yellow
    Write-Host "    HTML files: $outputDir\{lab-name}\{lab-name}.html" -ForegroundColor White
    Write-Host "    PDF files: $outputDir\{lab-name}\{lab-name}.pdf" -ForegroundColor White
    Write-Host "    Jekyll PDFs: $assetsDir\{lab-name}.pdf" -ForegroundColor White
    Write-Host ""
    Write-Host "🎉  PDFs are now available for Jekyll site!" -ForegroundColor Green
    Write-Host "    The PDF download buttons in your lab cards and pages will now work locally." -ForegroundColor White
}