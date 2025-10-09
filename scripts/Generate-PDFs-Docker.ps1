#!/usr/bin/env pwsh

# Docker-based PDF Generation Script
# Generates PDFs using Docker container with all dependencies included

param(
    [switch]$Help = $false,
    [switch]$Build = $false,
    [string]$LabFilter = "",
    [switch]$Interactive = $false
)

if ($Help) {
    Write-Host @"
╔═════════════════════════════════════════════════════════════════════════════════════════╗
║                        MCS Labs - Docker PDF Generator                                     ║
╚═════════════════════════════════════════════════════════════════════════════════════════╝

USAGE:
    .\Generate-PDFs-Docker.ps1 [-Build] [-LabFilter <lab-name>] [-Interactive] [-Help]

DESCRIPTION:
    Generates HTML and PDF files using Docker container with Pandoc, Node.js, and Puppeteer.
    This provides a consistent environment that matches GitHub Actions.

PARAMETERS:
    -Build         Force rebuild of Docker image
    -LabFilter     Generate PDFs only for specific lab (e.g., "agent-builder-web")
    -Interactive   Open interactive shell in container for debugging
    -Help         Show this help message

REQUIREMENTS:
    - Docker Desktop
    - Docker Compose

OUTPUT:
    Generated files are placed in:
    - HTML files: local-dist/{lab-name}/{lab-name}.html
    - PDF files: local-dist/{lab-name}/{lab-name}.pdf
    - Jekyll assets: assets/pdfs/{lab-name}.pdf

EXAMPLES:
    # Generate all PDFs (build image if needed)
    .\Generate-PDFs-Docker.ps1

    # Force rebuild and generate all PDFs
    .\Generate-PDFs-Docker.ps1 -Build

    # Generate PDF for specific lab
    .\Generate-PDFs-Docker.ps1 -LabFilter "agent-builder-web"

    # Open interactive shell for debugging
    .\Generate-PDFs-Docker.ps1 -Interactive

"@ -ForegroundColor Cyan
    exit 0
}

Write-Host "╔═══════════════════════════════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║                        MCS Labs - Docker PDF Generator                                 ║" -ForegroundColor Cyan
Write-Host "╚═══════════════════════════════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan

# Check if Docker is running
Write-Host "🐳  Checking Docker..." -ForegroundColor Yellow
try {
    docker version | Out-Null
    if ($LASTEXITCODE -ne 0) {
        throw "Docker command failed"
    }
    Write-Host "  ✅  Docker is running" -ForegroundColor Green
} catch {
    Write-Host "❌  Docker is not running or not installed. Please start Docker Desktop." -ForegroundColor Red
    exit 1
}

# Build or rebuild image if requested
if ($Build) {
    Write-Host "🔨  Building Docker image..." -ForegroundColor Yellow
    docker-compose build jekyll-dev
    if ($LASTEXITCODE -ne 0) {
        Write-Host "❌  Failed to build Docker image" -ForegroundColor Red
        exit 1
    }
    Write-Host "  ✅  Docker image built successfully" -ForegroundColor Green
}

# Interactive mode
if ($Interactive) {
    Write-Host "🐚  Opening interactive shell..." -ForegroundColor Yellow
    docker-compose run --rm jekyll-dev pwsh
    exit 0
}

# Add lab filter if specified
$scriptArgs = "-SkipInstall"
if ($LabFilter) {
    $scriptArgs += " -LabFilter '$LabFilter'"
}

# Build command
$command = "pwsh -File scripts/Generate-PDFs-Local.ps1 $scriptArgs"

Write-Host "📄  Generating PDFs in Docker container..." -ForegroundColor Yellow
if ($LabFilter) {
    Write-Host "    Filtering for lab: $LabFilter" -ForegroundColor Gray
}

# Run PDF generation
docker-compose run --rm jekyll-dev pwsh -c $command

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "🎉  PDF generation completed successfully!" -ForegroundColor Green
    Write-Host ""
    Write-Host "📁  Generated files:" -ForegroundColor Yellow
    Write-Host "    HTML files: local-dist/{lab-name}/{lab-name}.html" -ForegroundColor White
    Write-Host "    PDF files: local-dist/{lab-name}/{lab-name}.pdf" -ForegroundColor White
    Write-Host "    Jekyll assets: assets/pdfs/{lab-name}.pdf" -ForegroundColor White
    Write-Host ""
    Write-Host "💡  To start the Jekyll development server with PDFs:" -ForegroundColor Cyan
    Write-Host "    docker-compose up jekyll-dev" -ForegroundColor White
} else {
    Write-Host "❌  PDF generation failed. Check the output above for errors." -ForegroundColor Red
    Write-Host ""
    Write-Host "💡  For debugging, try:" -ForegroundColor Cyan
    Write-Host "    .\Generate-PDFs-Docker.ps1 -Interactive" -ForegroundColor White
    exit 1
}