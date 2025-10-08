# Build script for Windows development environment
# Generates Jekyll lab files and provides instructions for serving

param(
    [switch]$Help = $false
)

if ($Help) {
    Write-Host @"
╔═══════════════════════════════════════════════════════════════════════════════════════╗
║                               MCS Labs - Build Script                                 ║
╚═══════════════════════════════════════════════════════════════════════════════════════╝

USAGE:
    .\Build.ps1 [-Help]

DESCRIPTION:
    Generates Jekyll lab files from source content and lab-config.yml using semantic
    filenames that match the original lab folder names, then provides instructions
    for running the Jekyll development server.

"@ -ForegroundColor Cyan
    exit 0
}

Write-Host "🏗️   Generating Jekyll lab files from source and config..." -ForegroundColor Green
Write-Host ""

# Check if Generate-Labs.ps1 exists
if (-not (Test-Path "Generate-Labs.ps1")) {
    Write-Host "❌  Generate-Labs.ps1 not found in current directory" -ForegroundColor Red
    Write-Host "    Please ensure you're running this script from the repository root" -ForegroundColor Yellow
    exit 1
}

# Run the lab generation script  
try {
    & ".\Generate-Labs.ps1"
    
    if ($LASTEXITCODE -ne 0) {
        throw "Lab generation failed with exit code $LASTEXITCODE"
    }
} catch {
    Write-Host "❌  Lab generation failed: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "✅  Lab generation complete!" -ForegroundColor Green
Write-Host "🚀  You can now run: jekyll serve" -ForegroundColor Yellow
Write-Host ""
Write-Host "💡  Tip: To run Jekyll in Docker, use:" -ForegroundColor Cyan
Write-Host "    docker run --rm -p 4000:4000 -v `"`${PWD}:/srv/jekyll`" jekyll/jekyll:4 jekyll serve --host 0.0.0.0" -ForegroundColor Gray