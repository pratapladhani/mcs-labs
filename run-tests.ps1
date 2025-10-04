#!/usr/bin/env pwsh

# Simple test runner for MCS Labs Playwright tests
param(
    [string]$TestFile = "",
    [switch]$Headed = $false,
    [switch]$Debug = $false,
    [switch]$UI = $false
)

Write-Host "🧪 Running MCS Labs Playwright Tests..." -ForegroundColor Green

# Build the command
$command = "npx playwright test"

if ($TestFile) {
    $command += " $TestFile"
}

if ($Headed) {
    $command += " --headed"
}

if ($Debug) {
    $command += " --debug"
}

if ($UI) {
    $command = "npx playwright test --ui"
}

Write-Host "Running: $command" -ForegroundColor Yellow
Write-Host ""

# Execute the command
Invoke-Expression $command

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "✅ Tests completed successfully!" -ForegroundColor Green
} else {
    Write-Host ""
    Write-Host "❌ Tests failed with exit code: $LASTEXITCODE" -ForegroundColor Red
}

# Show report if available
if (Test-Path "playwright-report\index.html") {
    Write-Host ""
    Write-Host "📊 Test report available at: playwright-report\index.html" -ForegroundColor Cyan
    Write-Host "Run 'npm run test:report' to view it" -ForegroundColor Cyan
}