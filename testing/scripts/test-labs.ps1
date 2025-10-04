#!/usr/bin/env pwsh

<#
.SYNOPSIS
    Wrapper script for Microsoft Copilot Studio Labs testing framework

.DESCRIPTION
    This script provides easy access to the testing framework from the root directory.
    All testing files have been moved to the 'testing' directory to keep them separate
    from the lab content.

.PARAMETER Action
    The action to perform: setup, auth, test, or all

.PARAMETER Lab
    Specific lab to test (optional)

.PARAMETER Headless
    Run tests in headless mode (default: false)

.EXAMPLE
    .\test-labs.ps1 -Action all
    Complete setup and run all tests

.EXAMPLE
    .\test-labs.ps1 -Action auth
    Set up authentication only

.EXAMPLE
    .\test-labs.ps1 -Action test -Lab agent-builder-web
    Run specific lab tests
#>

param(
    [Parameter(Mandatory = $false)]
    [ValidateSet("setup", "auth", "test", "all", "clean", "help")]
    [string]$Action = "help",
    
    [string]$Lab = "",
    
    [switch]$Headless = $false
)

# Colors for output
$Blue = "`e[34m"
$Green = "`e[32m"
$Yellow = "`e[33m"
$Reset = "`e[0m"

function Show-TestingInfo {
    Write-Host "${Blue}"
    Write-Host "╔══════════════════════════════════════════════════════════════╗"
    Write-Host "║         Microsoft Copilot Studio Labs - Testing             ║"
    Write-Host "║                    Framework Wrapper                         ║"
    Write-Host "╚══════════════════════════════════════════════════════════════╝"
    Write-Host "${Reset}"
    Write-Host ""
    Write-Host "${Green}ℹ️  You are in the testing directory - framework is ready to use${Reset}"
    Write-Host ""
    Write-Host "${Yellow}Quick Start:${Reset}"
    Write-Host "  ${Green}.\scripts\test-labs.ps1 -Action all${Reset}     # Complete setup and run all tests"
    Write-Host "  ${Green}.\scripts\test-labs.ps1 -Action auth${Reset}    # Set up authentication only"
    Write-Host "  ${Green}.\scripts\test-labs.ps1 -Action test${Reset}    # Run all tests"
    Write-Host ""
    Write-Host "${Yellow}Available Actions:${Reset}"
    Write-Host "  ${Green}setup${Reset}  - Install dependencies and browsers"
    Write-Host "  ${Green}auth${Reset}   - Set up interactive authentication"
    Write-Host "  ${Green}test${Reset}   - Run tests (specify -Lab for specific lab)"
    Write-Host "  ${Green}all${Reset}    - Complete setup and run all tests"
    Write-Host "  ${Green}clean${Reset}  - Clean test environment"
    Write-Host ""
    Write-Host "${Yellow}Documentation:${Reset}"
    Write-Host "  📁 Current Directory: ${Green}testing/${Reset}"
    Write-Host "  📚 Full Documentation: ${Green}docs/README-Testing.md${Reset}"
    Write-Host "  🎯 Quick Start Guide: ${Green}README.md${Reset}"
    Write-Host ""
}

# Since we're already in the testing directory, check for the main script
$mainScript = "scripts\run-tests.ps1"
if (!(Test-Path $mainScript)) {
    Write-Host "${Red}❌ Main test script not found at: $mainScript${Reset}" -ForegroundColor Red
    Write-Host "Please ensure the testing framework is properly set up."
    exit 1
}

if ($Action -eq "help") {
    Show-TestingInfo
    exit 0
}

# Execute the main testing script
Write-Host "${Green}🚀 Running testing framework...${Reset}"
Write-Host "${Blue}ℹ️  Executing: $mainScript -Action $Action -Lab '$Lab' $(if($Headless) { '-Headless' })${Reset}"
Write-Host ""

try {
    $params = @{
        Action = $Action
    }
    
    if ($Lab) {
        $params.Lab = $Lab
    }
    
    if ($Headless) {
        $params.Headless = $true
    }
    
    & $mainScript @params
    
    Write-Host ""
    Write-Host "${Green}✅ Testing framework execution completed!${Reset}"
} catch {
    Write-Host "${Red}❌ Error executing testing framework: $_${Reset}" -ForegroundColor Red
    exit 1
}