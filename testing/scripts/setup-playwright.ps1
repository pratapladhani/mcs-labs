#!/usr/bin/env pwsh

# MCS Labs Playwright Setup Script
# This script sets up the Playwright testing environment for Microsoft Copilot Studio Labs

Write-Host "🚀 Setting up Playwright testing for MCS Labs..." -ForegroundColor Green

# Check if Node.js is installed
try {
    $nodeVersion = node --version
    Write-Host "✅ Node.js version: $nodeVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ Node.js is not installed. Please install Node.js from https://nodejs.org/" -ForegroundColor Red
    exit 1
}

# Install npm dependencies
Write-Host "📦 Installing npm dependencies..." -ForegroundColor Yellow
npm install

if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Failed to install npm dependencies" -ForegroundColor Red
    exit 1
}

# Install Playwright browsers
Write-Host "🌐 Installing Playwright browsers..." -ForegroundColor Yellow
npx playwright install

if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Failed to install Playwright browsers" -ForegroundColor Red
    exit 1
}

# Create auth directory
$authDir = "playwright\.auth"
if (!(Test-Path $authDir)) {
    New-Item -ItemType Directory -Path $authDir -Force
    Write-Host "📁 Created auth directory: $authDir" -ForegroundColor Green
}

# Check if .env file exists
if (!(Test-Path ".env")) {
    Write-Host "⚠️  No .env file found. Creating from .env.example..." -ForegroundColor Yellow
    Copy-Item ".env.example" ".env"
    Write-Host "📝 Please edit .env file with your credentials before running tests" -ForegroundColor Cyan
    Write-Host "   Required variables:" -ForegroundColor Cyan
    Write-Host "   - M365_USERNAME" -ForegroundColor Cyan
    Write-Host "   - M365_PASSWORD" -ForegroundColor Cyan
    Write-Host "   - SHAREPOINT_URL" -ForegroundColor Cyan
} else {
    Write-Host "✅ .env file already exists" -ForegroundColor Green
}

Write-Host ""
Write-Host "🎉 Setup complete! You can now run tests with:" -ForegroundColor Green
Write-Host "   npm test                 # Run all tests" -ForegroundColor Cyan
Write-Host "   npm run test:headed      # Run with browser visible" -ForegroundColor Cyan
Write-Host "   npm run test:ui          # Run in UI mode" -ForegroundColor Cyan
Write-Host "   npm run test:debug       # Run in debug mode" -ForegroundColor Cyan
Write-Host ""
Write-Host "📖 For more information, see tests/README.md" -ForegroundColor Yellow