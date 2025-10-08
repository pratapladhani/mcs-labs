# PowerShell Lab Generation Script
# Reads from lab-config.yml and generates semantic filenames matching original lab folder names

param(
    [switch]$Help = $false
)

if ($Help) {
    Write-Host @"
╔═══════════════════════════════════════════════════════════════════════════════════════╗
║                             MCS Labs - Jekyll Generator                               ║
╚═══════════════════════════════════════════════════════════════════════════════════════╝

USAGE:
    .\Generate-Labs.ps1 [-Help]

DESCRIPTION:
    Generates Jekyll-compatible markdown files from lab configuration with semantic filenames
    that match the original lab folder names (e.g., agent-builder-web.md).
    
    Generated files include proper front matter, journey metadata, and permalinks for the
    4-journey navigation system (Quick Start, Business User, Developer, Autonomous AI).

REQUIREMENTS:
    - PowerShell 5.1+ or PowerShell Core
    - powershell-yaml module (auto-installed if missing)
    - lab-config.yml configuration file
    - Source lab files in labs/[lab-id]/README.md

OUTPUT:
    Generated files are placed in _labs/ directory for Jekyll processing.

"@ -ForegroundColor Cyan
    exit 0
}

Write-Host "╔═══════════════════════════════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║                             MCS Labs - Jekyll Generator                               ║" -ForegroundColor Cyan
Write-Host "╚═══════════════════════════════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""
Write-Host "🏷️  Generating semantic filenames (matching lab folder names)" -ForegroundColor Yellow

# Install PowerShell YAML module if not present
if (-not (Get-Module -ListAvailable -Name powershell-yaml)) {
    Write-Host "📦  Installing PowerShell YAML module..." -ForegroundColor Yellow
    try {
        Install-Module -Name powershell-yaml -Force -Scope CurrentUser -ErrorAction Stop
        Write-Host "✅  PowerShell YAML module installed successfully" -ForegroundColor Green
    } catch {
        Write-Host "❌  Failed to install PowerShell YAML module: $($_.Exception.Message)" -ForegroundColor Red
        exit 1
    }
}

Import-Module powershell-yaml -ErrorAction Stop

# Validate lab-config.yml exists
if (-not (Test-Path "lab-config.yml")) {
    Write-Host "❌  lab-config.yml not found in current directory" -ForegroundColor Red
    Write-Host "    Please ensure you're running this script from the repository root" -ForegroundColor Yellow
    exit 1
}

Write-Host "📖  Reading lab configuration from lab-config.yml..." -ForegroundColor Green

# Read and parse lab-config.yml
try {
    $configContent = Get-Content "lab-config.yml" -Raw -ErrorAction Stop
    $config = ConvertFrom-Yaml $configContent -ErrorAction Stop
} catch {
    Write-Host "❌  Failed to read or parse lab-config.yml: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

Write-Host "📁  Creating _labs directory..." -ForegroundColor Green
New-Item -ItemType Directory -Path "_labs" -Force | Out-Null

# Function to process a lab with enhanced error handling
function ConvertTo-JekyllLab {
    param(
        [Parameter(Mandatory)]$Lab,
        [Parameter(Mandatory)][int]$Order,
        [Parameter(Mandatory)][string]$SectionName,
        [Parameter(Mandatory)][string]$LabType
    )
    
    $lab_key = $Lab.id
    $title = $Lab.title
    $duration = $Lab.duration
    $difficulty = $Lab.difficulty
    $journeys = $Lab.journeys
    
    $source_file = "labs/$lab_key/README.md"
    $target_file = "_labs/$lab_key.md"  # Always use semantic names
    
    if (Test-Path $source_file) {
        Write-Host "  📝  Processing $SectionName`: $lab_key -> $(Split-Path $target_file -Leaf)" -ForegroundColor Cyan
        
        try {
            # Read the source file
            $content = Get-Content $source_file -Raw -ErrorAction Stop
            
            # Create Jekyll front matter with journey metadata
            $front_matter = @"
---
layout: lab
title: "$title"
"@
            
            # Add order for main labs
            if ($LabType -ne "optional") {
                $front_matter += "`norder: $Order"
            }
            
            $front_matter += @"
`nduration: $duration
difficulty: $difficulty
lab_type: $LabType
"@
            
            # Add journeys if they exist
            if ($journeys -and $journeys.Count -gt 0) {
                $journeyArray = $journeys | ForEach-Object { "`"$_`"" }
                $journeyString = "[" + ($journeyArray -join ", ") + "]"
                $front_matter += "`njourneys: $journeyString"
            }
            
            $front_matter += @"
`npermalink: /labs/$lab_key/
---

$content
"@
            
            # Write to target file
            $front_matter | Set-Content $target_file -Encoding UTF8 -ErrorAction Stop
            Write-Host "    ✅  Created $(Split-Path $target_file -Leaf)" -ForegroundColor Green
            return $true
        } catch {
            Write-Host "    ❌  Failed to process $lab_key`: $($_.Exception.Message)" -ForegroundColor Red
            return $false
        }
    } else {
        Write-Host "    ⚠️   Source file not found: $source_file" -ForegroundColor Yellow
        return $false
    }
}

# Track processing statistics
$totalLabs = 0
$processedLabs = 0
$failedLabs = 0
$order = 1

Write-Host "🔄  Converting labs with journey metadata..." -ForegroundColor Yellow
Write-Host ""

# Process core learning path
if ($config.core_learning_path -and $config.core_learning_path.Count -gt 0) {
    Write-Host "📚  Core Learning Path ($($config.core_learning_path.Count) labs)" -ForegroundColor Magenta
    foreach ($lab in $config.core_learning_path) {
        $totalLabs++
        if (ConvertTo-JekyllLab -Lab $lab -Order $order -SectionName "core" -LabType "main") {
            $processedLabs++
        } else {
            $failedLabs++
        }
        $order++
    }
    Write-Host ""
}

# Process intermediate labs
if ($config.intermediate_labs -and $config.intermediate_labs.Count -gt 0) {
    Write-Host "🎯  Intermediate Labs ($($config.intermediate_labs.Count) labs)" -ForegroundColor Magenta
    foreach ($lab in $config.intermediate_labs) {
        $totalLabs++
        if (ConvertTo-JekyllLab -Lab $lab -Order $order -SectionName "intermediate" -LabType "main") {
            $processedLabs++
        } else {
            $failedLabs++
        }
        $order++
    }
    Write-Host ""
}

# Process advanced labs
if ($config.advanced_labs -and $config.advanced_labs.Count -gt 0) {
    Write-Host "🚀  Advanced Labs ($($config.advanced_labs.Count) labs)" -ForegroundColor Magenta
    foreach ($lab in $config.advanced_labs) {
        $totalLabs++
        if (ConvertTo-JekyllLab -Lab $lab -Order $order -SectionName "advanced" -LabType "main") {
            $processedLabs++
        } else {
            $failedLabs++
        }
        $order++
    }
    Write-Host ""
}

# Process specialized labs
if ($config.specialized_labs -and $config.specialized_labs.Count -gt 0) {
    Write-Host "⚡  Specialized Labs ($($config.specialized_labs.Count) labs)" -ForegroundColor Magenta
    foreach ($lab in $config.specialized_labs) {
        $totalLabs++
        if (ConvertTo-JekyllLab -Lab $lab -Order $order -SectionName "specialized" -LabType "main") {
            $processedLabs++
        } else {
            $failedLabs++
        }
        $order++
    }
    Write-Host ""
}

# Process optional labs
if ($config.optional_labs -and $config.optional_labs.Count -gt 0) {
    Write-Host "🔧  Optional Labs ($($config.optional_labs.Count) labs)" -ForegroundColor Magenta
    foreach ($lab in $config.optional_labs) {
        $totalLabs++
        if (ConvertTo-JekyllLab -Lab $lab -Order 0 -SectionName "optional" -LabType "optional") {
            $processedLabs++
        } else {
            $failedLabs++
        }
    }
    Write-Host ""
}

# Display final statistics
Write-Host "╔═══════════════════════════════════════════════════════════════════════════════════════╗" -ForegroundColor Green
Write-Host "║                                 GENERATION COMPLETE                                   ║" -ForegroundColor Green
Write-Host "╚═══════════════════════════════════════════════════════════════════════════════════════╝" -ForegroundColor Green
Write-Host ""
Write-Host "📊  Processing Summary:" -ForegroundColor Cyan
Write-Host "    Total labs: $totalLabs" -ForegroundColor White
Write-Host "    Successfully processed: $processedLabs" -ForegroundColor Green
if ($failedLabs -gt 0) {
    Write-Host "    Failed: $failedLabs" -ForegroundColor Red
}
Write-Host ""

Write-Host "✨  Generated files use semantic names matching lab folders (e.g., 'agent-builder-web.md')" -ForegroundColor Cyan

Write-Host "🎯  Journey metadata included for navigation system" -ForegroundColor Cyan
Write-Host "📁  Output directory: _labs/" -ForegroundColor Cyan
Write-Host ""

if ($processedLabs -eq $totalLabs -and $failedLabs -eq 0) {
    Write-Host "🎉  All labs processed successfully!" -ForegroundColor Green
    Write-Host "🚀  You can now run: jekyll serve" -ForegroundColor Yellow
} else {
    Write-Host "⚠️   Some labs had issues. Please review the output above." -ForegroundColor Yellow
    if ($processedLabs -gt 0) {
        Write-Host "🚀  You can still run: jekyll serve (with available labs)" -ForegroundColor Yellow
    }
}