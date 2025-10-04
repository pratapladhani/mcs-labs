#!/usr/bin/env pwsh

# Credential Setup Helper for MCS Labs Playwright Testing

Write-Host "🔐 Playwright Authentication Setup Helper" -ForegroundColor Green
Write-Host ""

# Check if .env file exists
if (-not (Test-Path ".env")) {
    Write-Host "📄 Creating .env file from template..." -ForegroundColor Yellow
    Copy-Item ".env.example" ".env"
}

# Read current .env file
$envContent = Get-Content ".env" -Raw

# Check if credentials are still placeholders
$needsSetup = $envContent -match "your\.email@company\.com" -or $envContent -match "your_password"

if ($needsSetup) {
    Write-Host "⚠️  Credentials not configured yet" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "You have several options:" -ForegroundColor White
    Write-Host ""
    Write-Host "1. 📝 Manual Setup (Recommended)" -ForegroundColor Cyan
    Write-Host "   - Edit the .env file manually with your credentials"
    Write-Host "   - Replace 'your.email@company.com' with your actual email"
    Write-Host "   - Replace 'your_password' with your actual password"
    Write-Host ""
    Write-Host "2. 🛡️  Interactive Setup" -ForegroundColor Cyan
    Write-Host "   - Tests will open a browser for you to login manually"
    Write-Host "   - More secure but requires interaction during test runs"
    Write-Host ""
    Write-Host "3. 🔑 App Password (If you have MFA)" -ForegroundColor Cyan
    Write-Host "   - Go to https://account.microsoft.com/security"
    Write-Host "   - Create an App Password under 'Additional security options'"
    Write-Host "   - Use the app password instead of your regular password"
    Write-Host ""
    
    $choice = Read-Host "Choose setup method (1=Manual, 2=Interactive, 3=Help with MFA) [1]"
    
    switch ($choice) {
        "1" {
            Write-Host ""
            Write-Host "📝 Manual Setup Selected" -ForegroundColor Green
            $email = Read-Host "Enter your Microsoft 365 email"
            $password = Read-Host "Enter your password (or app password)" -AsSecureString
            $passwordText = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($password))
            
            # Update .env file
            $envContent = $envContent -replace "your\.email@company\.com", $email
            $envContent = $envContent -replace "your_password", $passwordText
            
            Set-Content ".env" $envContent
            Write-Host "✅ Credentials saved to .env file" -ForegroundColor Green
        }
        "2" {
            Write-Host ""
            Write-Host "🛡️  Interactive Setup Selected" -ForegroundColor Green
            Write-Host "Tests will open a browser window for manual login"
            Write-Host "No credentials needed in .env file"
        }
        "3" {
            Write-Host ""
            Write-Host "🔑 MFA App Password Setup:" -ForegroundColor Green
            Write-Host "1. Go to https://account.microsoft.com/security"
            Write-Host "2. Sign in with your Microsoft account"
            Write-Host "3. Select 'Additional security options'"
            Write-Host "4. Under 'App passwords' select 'Create a new app password'"
            Write-Host "5. Choose a name like 'Playwright Testing'"
            Write-Host "6. Copy the generated password"
            Write-Host "7. Use this app password in the .env file instead of your regular password"
            Write-Host ""
            Write-Host "Then run this script again and choose option 1"
        }
        default {
            Write-Host "📝 Defaulting to Manual Setup" -ForegroundColor Yellow
            Write-Host "Please edit the .env file manually with your credentials"
        }
    }
} else {
    Write-Host "✅ Credentials appear to be configured" -ForegroundColor Green
}

Write-Host ""
Write-Host "🧪 Ready to test!" -ForegroundColor Green
Write-Host "Run: npm test tests/persistent-auth-setup.ts" -ForegroundColor White
Write-Host ""
Write-Host "📖 For more details, see AUTHENTICATION-GUIDE.md" -ForegroundColor Cyan