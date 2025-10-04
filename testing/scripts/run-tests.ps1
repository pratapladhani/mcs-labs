#!/usr/bin/env pwsh

<#
.SYNOPSIS
    Quick setup and test runner for Microsoft Copilot Studio Labs

.DESCRIPTION
    This script provides a convenient way to set up and run Playwright tests
    for Microsoft Copilot Studio labs with persistent authentication.

.PARAMETER Action
    The action to perform: setup, auth, test, or all

.PARAMETER Lab
    Specific lab to test (optional)

.PARAMETER Headless
    Run tests in headless mode (default: false for better debugging)

.EXAMPLE
    .\run-tests.ps1 -Action all
    Sets up everything and runs all tests

.EXAMPLE
    .\run-tests.ps1 -Action auth
    Run interactive authentication setup only

.EXAMPLE
    .\run-tests.ps1 -Action test -Lab agent-builder-web
    Run specific lab tests
#>

param(
    [Parameter(Mandatory = $true)]
    [ValidateSet("setup", "auth", "test", "all", "clean")]
    [string]$Action,
    
    [string]$Lab = "",
    
    [switch]$Headless = $false
)

# Ensure we're in the testing directory
$scriptDir = Split-Path -Parent $PSScriptRoot
if (Test-Path (Join-Path $scriptDir "package.json")) {
    # We're already in the testing directory
    Set-Location $scriptDir
} else {
    # Look for testing directory in parent
    $parentDir = Split-Path -Parent $scriptDir
    $testingDir = Join-Path $parentDir "testing"
    if (Test-Path (Join-Path $testingDir "package.json")) {
        Set-Location $testingDir
    } else {
        Write-Error "Could not find testing directory with package.json. Current location: $(Get-Location)"
        exit 1
    }
}

# Colors for output
$Green = "`e[32m"
$Blue = "`e[34m"
$Yellow = "`e[33m"
$Red = "`e[31m"
$Reset = "`e[0m"

function Write-Status {
    param($Message, $Color = $Green)
    Write-Host "${Color}✅ $Message${Reset}"
}

function Write-Info {
    param($Message)
    Write-Host "${Blue}ℹ️  $Message${Reset}"
}

function Write-Warning {
    param($Message)
    Write-Host "${Yellow}⚠️  $Message${Reset}"
}

function Write-Error {
    param($Message)
    Write-Host "${Red}❌ $Message${Reset}"
}

function Show-Banner {
    Write-Host "${Blue}"
    Write-Host "╔══════════════════════════════════════════════════════════════╗"
    Write-Host "║         Microsoft Copilot Studio Labs - Test Runner         ║"
    Write-Host "║                    Playwright + TypeScript                   ║"
    Write-Host "╚══════════════════════════════════════════════════════════════╝"
    Write-Host "${Reset}"
}

function Test-Prerequisites {
    Write-Info "Checking prerequisites..."
    
    # Check Node.js
    try {
        $nodeVersion = node --version 2>$null
        if ($nodeVersion) {
            Write-Status "Node.js version: $nodeVersion"
        } else {
            throw "Node.js not found"
        }
    } catch {
        Write-Error "Node.js is required but not installed"
        Write-Info "Please install Node.js from https://nodejs.org/"
        return $false
    }
    
    # Check npm
    try {
        $npmVersion = npm --version 2>$null
        if ($npmVersion) {
            Write-Status "npm version: $npmVersion"
        } else {
            throw "npm not found"
        }
    } catch {
        Write-Error "npm is required but not found"
        return $false
    }
    
    return $true
}

function Install-Dependencies {
    Write-Info "Installing npm dependencies..."
    
    if (!(Test-Path "package.json")) {
        Write-Error "package.json not found. Are you in the correct directory?"
        return $false
    }
    
    try {
        npm install
        Write-Status "Dependencies installed successfully"
        return $true
    } catch {
        Write-Error "Failed to install dependencies: $_"
        return $false
    }
}

function Install-Browsers {
    Write-Info "Installing Playwright browsers..."
    
    try {
        npx playwright install
        Write-Status "Playwright browsers installed successfully"
        return $true
    } catch {
        Write-Error "Failed to install Playwright browsers: $_"
        return $false
    }
}

function Setup-Authentication {
    Write-Info "Setting up persistent authentication profile..."
    Write-Warning "This will open a browser window for interactive login"
    Write-Info "Please complete the Microsoft 365 login process"
    
    try {
        if ($Headless) {
            Write-Warning "Cannot run authentication setup in headless mode"
            Write-Info "Running with --headed flag for interactive login"
            npx playwright test tests/persistent-profile-auth.ts --headed
        } else {
            npx playwright test tests/persistent-profile-auth.ts --headed
        }
        Write-Status "Authentication setup completed!"
        Write-Info "Your login will persist across all future test runs"
        return $true
    } catch {
        Write-Error "Authentication setup failed: $_"
        Write-Info "Please try running the authentication setup manually:"
        Write-Info "npx playwright test tests/persistent-profile-auth.ts --headed"
        return $false
    }
}

function Run-Tests {
    param($SpecificLab = "")
    
    $headedFlag = if ($Headless) { "" } else { "--headed" }
    
    if ($SpecificLab) {
        Write-Info "Running tests for lab: $SpecificLab"
        try {
            npx playwright test "tests/$SpecificLab.spec.ts" $headedFlag
            Write-Status "Lab tests completed successfully!"
            return $true
        } catch {
            Write-Error "Lab tests failed: $_"
            return $false
        }
    } else {
        Write-Info "Running all tests..."
        try {
            npx playwright test $headedFlag
            Write-Status "All tests completed successfully!"
            return $true
        } catch {
            Write-Error "Some tests failed: $_"
            Write-Info "Check the output above for details"
            return $false
        }
    }
}

function Clean-Environment {
    Write-Info "Cleaning test environment..."
    
    # Remove browser profile
    if (Test-Path "playwright/.auth/chromium-profile") {
        Remove-Item -Recurse -Force "playwright/.auth/chromium-profile"
        Write-Status "Removed browser profile"
    }
    
    # Remove test results
    if (Test-Path "test-results") {
        Remove-Item -Recurse -Force "test-results"
        Write-Status "Removed test results"
    }
    
    # Remove playwright report
    if (Test-Path "playwright-report") {
        Remove-Item -Recurse -Force "playwright-report"
        Write-Status "Removed test reports"
    }
    
    Write-Status "Environment cleaned successfully!"
}

function Show-Help {
    Write-Host "${Blue}"
    Write-Host "Available Actions:"
    Write-Host "  setup  - Install dependencies and browsers"
    Write-Host "  auth   - Set up interactive authentication"
    Write-Host "  test   - Run tests (specify -Lab for specific lab)"
    Write-Host "  all    - Complete setup and run all tests"
    Write-Host "  clean  - Clean test environment and profiles"
    Write-Host ""
    Write-Host "Available Labs:"
    Write-Host "  agent-builder-web     - Agent Builder Web lab validation"
    Write-Host "  lab-validation        - General lab validation"
    Write-Host ""
    Write-Host "Examples:"
    Write-Host "  .\run-tests.ps1 -Action all"
    Write-Host "  .\run-tests.ps1 -Action auth"
    Write-Host "  .\run-tests.ps1 -Action test -Lab agent-builder-web"
    Write-Host "  .\run-tests.ps1 -Action test -Headless"
    Write-Host "${Reset}"
}

# Main execution
Show-Banner

switch ($Action) {
    "setup" {
        Write-Info "🔧 Setting up testing environment..."
        
        if (!(Test-Prerequisites)) { exit 1 }
        if (!(Install-Dependencies)) { exit 1 }
        if (!(Install-Browsers)) { exit 1 }
        
        Write-Status "🎉 Setup completed successfully!"
        Write-Info "Next step: Run authentication setup with:"
        Write-Info ".\run-tests.ps1 -Action auth"
    }
    
    "auth" {
        Write-Info "🔐 Setting up authentication..."
        
        if (!(Setup-Authentication)) { exit 1 }
        
        Write-Status "🎉 Authentication ready!"
        Write-Info "Now you can run tests with:"
        Write-Info ".\run-tests.ps1 -Action test"
    }
    
    "test" {
        Write-Info "🧪 Running tests..."
        
        if (!(Run-Tests -SpecificLab $Lab)) { exit 1 }
        
        Write-Status "🎉 Testing completed!"
    }
    
    "all" {
        Write-Info "🚀 Complete setup and test run..."
        
        if (!(Test-Prerequisites)) { exit 1 }
        if (!(Install-Dependencies)) { exit 1 }
        if (!(Install-Browsers)) { exit 1 }
        if (!(Setup-Authentication)) { exit 1 }
        if (!(Run-Tests)) { exit 1 }
        
        Write-Status "🎉 Everything completed successfully!"
        Write-Info "Your testing environment is ready for regular use"
    }
    
    "clean" {
        Write-Info "🧹 Cleaning environment..."
        Clean-Environment
        Write-Status "🎉 Environment cleaned!"
    }
    
    default {
        Write-Error "Unknown action: $Action"
        Show-Help
        exit 1
    }
}

Write-Host ""
Write-Info "Testing framework ready! Check docs/README-Testing.md for detailed documentation."