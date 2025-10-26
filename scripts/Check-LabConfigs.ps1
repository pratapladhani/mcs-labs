# Lab Configuration Audit Script
# Checks for labs that exist in folders but are missing configuration entries

param(
    [switch]$Fix,
    [switch]$Verbose
)

Write-Host "`n🔍 Lab Configuration Audit" -ForegroundColor Cyan
Write-Host "================================`n" -ForegroundColor Cyan

# Excluded event/special folders (not expected to have local folders)
$excludedFolders = @("bootcamp", "azure-ai-workshop", "mcs-in-a-day")

# External labs (configured but intentionally have no local folder)
$externalLabs = @("mcs-mcp-external")

# Get all lab folders
$labFolders = Get-ChildItem -Path "labs\" -Directory | 
Where-Object { $_.Name -notin $excludedFolders } |
Select-Object -ExpandProperty Name

Write-Host "📁 Found $($labFolders.Count) lab folders (excluding event folders)`n" -ForegroundColor Gray

# Extract lab IDs from lab-config.yml
$configContent = Get-Content -Path "lab-config.yml" -Raw
$configIds = [regex]::Matches($configContent, 'id:\s*"([^"]+)"') | 
ForEach-Object { $_.Groups[1].Value }

Write-Host "⚙️  Found $($configIds.Count) configured labs in lab-config.yml`n" -ForegroundColor Gray

# Check for missing configurations
$missingConfigs = $labFolders | Where-Object { $_ -notin $configIds }
$orphanedConfigs = $configIds | Where-Object { $_ -notin $labFolders -and $_ -notin $externalLabs }

# Report results
if ($missingConfigs.Count -gt 0) {
    Write-Host "⚠️  LABS MISSING CONFIG ENTRIES:" -ForegroundColor Yellow
    Write-Host "================================" -ForegroundColor Yellow
    foreach ($lab in $missingConfigs) {
        Write-Host "  ❌ $lab" -ForegroundColor Red
        
        if ($Verbose) {
            $readmePath = "labs\$lab\README.md"
            if (Test-Path $readmePath) {
                $readme = Get-Content $readmePath -Raw
                if ($readme -match '##\s*([^\n]+)') {
                    Write-Host "     Title: $($matches[1])" -ForegroundColor Gray
                }
            }
        }
    }
    Write-Host ""
    
    if ($Fix) {
        Write-Host "🔧 Would add template entries (not implemented - manual edit required)" -ForegroundColor Yellow
        Write-Host "   Please update lab-config.yml with the following sections:" -ForegroundColor Yellow
        Write-Host "   1. lab_metadata" -ForegroundColor Yellow
        Write-Host "   2. lab_orders" -ForegroundColor Yellow
        Write-Host "   3. lab_journeys`n" -ForegroundColor Yellow
    }
    else {
        Write-Host "💡 Tip: Run with -Verbose to see lab titles" -ForegroundColor Cyan
        Write-Host "💡 Tip: See docs/NEW_LAB_CHECKLIST.md for update instructions`n" -ForegroundColor Cyan
    }
}
else {
    Write-Host "✅ All lab folders have config entries" -ForegroundColor Green
}

if ($orphanedConfigs.Count -gt 0) {
    Write-Host "`n⚠️  CONFIGS WITHOUT MATCHING FOLDERS:" -ForegroundColor Yellow
    Write-Host "=====================================" -ForegroundColor Yellow
    foreach ($config in $orphanedConfigs) {
        Write-Host "  ⚠️  $config (config exists but no labs/$config/ folder)" -ForegroundColor Red
    }
    Write-Host ""
}

# Summary
Write-Host "`n📊 AUDIT SUMMARY" -ForegroundColor Cyan
Write-Host "================" -ForegroundColor Cyan
Write-Host "Total lab folders: $($labFolders.Count)" -ForegroundColor Gray
Write-Host "Total configured: $($configIds.Count)" -ForegroundColor Gray
Write-Host "Missing configs: $($missingConfigs.Count)" -ForegroundColor $(if ($missingConfigs.Count -gt 0) { "Red" } else { "Green" })
Write-Host "Orphaned configs: $($orphanedConfigs.Count)" -ForegroundColor $(if ($orphanedConfigs.Count -gt 0) { "Yellow" } else { "Green" })

if ($missingConfigs.Count -eq 0 -and $orphanedConfigs.Count -eq 0) {
    Write-Host "`n✨ Configuration is in sync with lab folders!`n" -ForegroundColor Green
}
else {
    Write-Host "`n⚠️  Configuration needs attention. See docs/NEW_LAB_CHECKLIST.md`n" -ForegroundColor Yellow
    exit 1
}
