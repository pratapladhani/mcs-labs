# =============================================================================
# 🔄 ROLLBACK TO MAIN SYSTEM SCRIPT
# =============================================================================
# This script helps you easily rollback to the main lab portal system
# while preserving your Jekyll journey system work.
# =============================================================================

param(
    [switch]$Execute,
    [switch]$Force
)

Write-Host "🔄 MCS Labs - Rollback to Main System" -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan

# Check current branch
$currentBranch = git branch --show-current
Write-Host "📍 Current branch: $currentBranch" -ForegroundColor Yellow

if ($currentBranch -eq "main") {
    Write-Host "✅ Already on main branch! The main lab portal system is active." -ForegroundColor Green
    Write-Host "🌐 Your site should be at: https://yourusername.github.io/mcs-labs" -ForegroundColor Blue
    exit 0
}

Write-Host ""
Write-Host "🎯 ROLLBACK PLAN:" -ForegroundColor Magenta
Write-Host "  1. Switch to main branch" -ForegroundColor White
Write-Host "  2. Main lab portal system will be active" -ForegroundColor White
Write-Host "  3. Your Jekyll work stays safe in jekyll-lab-browser branch" -ForegroundColor White
Write-Host ""

if (-not $Execute) {
    Write-Host "⚠️  DRY RUN MODE - Add -Execute to actually perform rollback" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Commands that would run:" -ForegroundColor Gray
    Write-Host "  git checkout main" -ForegroundColor Gray
    Write-Host ""
    Write-Host "To execute: .\rollback-to-main.ps1 -Execute" -ForegroundColor Green
    exit 0
}

# Confirm rollback
if (-not $Force) {
    Write-Host "⚠️  This will switch you back to the main lab portal system." -ForegroundColor Yellow
    Write-Host "   Your Jekyll work will be preserved in the jekyll-lab-browser branch." -ForegroundColor Yellow
    $confirm = Read-Host "Continue? (y/N)"
    if ($confirm -ne "y" -and $confirm -ne "Y") {
        Write-Host "❌ Rollback cancelled." -ForegroundColor Red
        exit 1
    }
}

# Execute rollback
Write-Host ""
Write-Host "🔄 Executing rollback..." -ForegroundColor Blue

try {
    # Switch to main branch
    Write-Host "📍 Switching to main branch..." -ForegroundColor Blue
    git checkout main
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Host "✅ ROLLBACK COMPLETE!" -ForegroundColor Green
        Write-Host "=====================================" -ForegroundColor Green
        Write-Host "🌐 Main lab portal system is now active" -ForegroundColor Green
        Write-Host "📂 Your Jekyll work is preserved in jekyll-lab-browser branch" -ForegroundColor Blue
        Write-Host ""
        Write-Host "🔗 URLs:" -ForegroundColor Cyan
        Write-Host "  Main site: https://yourusername.github.io/mcs-labs" -ForegroundColor White
        Write-Host ""
        Write-Host "🔄 To switch back to Jekyll system:" -ForegroundColor Cyan
        Write-Host "  git checkout jekyll-lab-browser" -ForegroundColor White
    } else {
        throw "Git checkout failed"
    }
} catch {
    Write-Host "❌ ROLLBACK FAILED: $_" -ForegroundColor Red
    Write-Host "💡 You may need to resolve conflicts or check git status" -ForegroundColor Yellow
    exit 1
}