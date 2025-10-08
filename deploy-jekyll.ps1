# =============================================================================
# 🚀 DEPLOY JEKYLL JOURNEY SYSTEM TO GITHUB
# =============================================================================
# This script helps you safely deploy the Jekyll journey system to GitHub
# while preserving your rollback options.
# =============================================================================

param(
    [switch]$Execute,
    [string]$Message = "🎮 Deploy gamified Jekyll journey system"
)

Write-Host "🚀 Deploy Jekyll Journey System" -ForegroundColor Cyan
Write-Host "================================" -ForegroundColor Cyan

# Check current branch
$currentBranch = git branch --show-current
Write-Host "📍 Current branch: $currentBranch" -ForegroundColor Yellow

if ($currentBranch -ne "jekyll-lab-browser") {
    Write-Host "⚠️  You need to be on the jekyll-lab-browser branch!" -ForegroundColor Red
    Write-Host "🔄 Switch with: git checkout jekyll-lab-browser" -ForegroundColor Blue
    exit 1
}

# Check git status
$gitStatus = git status --porcelain
$hasChanges = $gitStatus.Count -gt 0

Write-Host ""
Write-Host "🎯 DEPLOYMENT PLAN:" -ForegroundColor Magenta
Write-Host "  1. Commit any pending changes" -ForegroundColor White
Write-Host "  2. Push to jekyll-lab-browser branch" -ForegroundColor White
Write-Host "  3. Trigger GitHub Actions deployment" -ForegroundColor White
Write-Host "  4. Deploy to preview URL" -ForegroundColor White
Write-Host ""

if ($hasChanges) {
    Write-Host "📝 Pending changes detected:" -ForegroundColor Yellow
    git status --short
    Write-Host ""
}

Write-Host "🌐 Expected URLs after deployment:" -ForegroundColor Cyan
Write-Host "  Jekyll Preview: https://yourusername.github.io/mcs-labs-jekyll" -ForegroundColor Green
Write-Host "  Main System:    https://yourusername.github.io/mcs-labs" -ForegroundColor Blue
Write-Host ""

if (-not $Execute) {
    Write-Host "⚠️  DRY RUN MODE - Add -Execute to actually deploy" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Commands that would run:" -ForegroundColor Gray
    if ($hasChanges) {
        Write-Host "  git add ." -ForegroundColor Gray
        Write-Host "  git commit -m '$Message'" -ForegroundColor Gray
    }
    Write-Host "  git push origin jekyll-lab-browser" -ForegroundColor Gray
    Write-Host ""
    Write-Host "To execute: .\deploy-jekyll.ps1 -Execute" -ForegroundColor Green
    exit 0
}

# Execute deployment
Write-Host ""
Write-Host "🚀 Executing deployment..." -ForegroundColor Blue

try {
    if ($hasChanges) {
        Write-Host "📝 Committing changes..." -ForegroundColor Blue
        git add .
        git commit -m $Message
        
        if ($LASTEXITCODE -ne 0) {
            throw "Git commit failed"
        }
    }
    
    Write-Host "⬆️  Pushing to GitHub..." -ForegroundColor Blue
    git push origin jekyll-lab-browser
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Host "✅ DEPLOYMENT INITIATED!" -ForegroundColor Green
        Write-Host "=====================================" -ForegroundColor Green
        Write-Host "🎯 Branch: jekyll-lab-browser pushed to GitHub" -ForegroundColor Green
        Write-Host "⚙️  GitHub Actions should start deploying automatically" -ForegroundColor Blue
        Write-Host ""
        Write-Host "🔗 Next Steps:" -ForegroundColor Cyan
        Write-Host "  1. Check GitHub Actions: https://github.com/yourusername/mcs-labs/actions" -ForegroundColor White
        Write-Host "  2. Wait for deployment to complete (~2-5 minutes)" -ForegroundColor White
        Write-Host "  3. Test your Jekyll system at the preview URL" -ForegroundColor White
        Write-Host ""
        Write-Host "🛡️  Rollback option always available:" -ForegroundColor Cyan
        Write-Host "  .\rollback-to-main.ps1 -Execute" -ForegroundColor White
        Write-Host ""
        Write-Host "🎮 Happy testing!" -ForegroundColor Green
    } else {
        throw "Git push failed"
    }
} catch {
    Write-Host "❌ DEPLOYMENT FAILED: $_" -ForegroundColor Red
    Write-Host "💡 Check git status and try again" -ForegroundColor Yellow
    exit 1
}