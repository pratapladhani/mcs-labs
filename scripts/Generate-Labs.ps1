# PowerShell Lab Generation Script
# Reads from lab-config.yml and generates semantic filenames matching original lab folder names

param(
    [switch]$Help = $false
)

if ($Help) {
    Write-Host @"
╔═════════════════════════════════════════════════════════════════════════════}

# If no valid journeys were loaded, use defaults
if ($journeyMeta.Keys.Count -eq 0) {
    Write-Host "⚠️  No valid journey definitions found, using defaults..." -ForegroundColor Yellow
    $journeyMeta = @{
        "quick-start" = @{ title = "Quick Start Journey"; description = "Essential labs to get started quickly"; icon = "🚀"; difficulty = "Beginner"; estimated_time = "3-4 hours" }
        "business-user" = @{ title = "Business User Journey"; description = "Business solutions and applications"; icon = "💼"; difficulty = "Intermediate"; estimated_time = "8-12 hours" }
        "developer" = @{ title = "Developer Journey"; description = "Technical depth and development practices"; icon = "🔧"; difficulty = "Advanced"; estimated_time = "10-15 hours" }
        "autonomous-ai" = @{ title = "Autonomous AI Journey"; description = "Advanced autonomous agents"; icon = "🤖"; difficulty = "Expert"; estimated_time = "6-8 hours" }
    }
}╗
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

# Validate lab-config.yml exists (check both current directory and parent)
$configPath = if (Test-Path "./lab-config.yml") { "./lab-config.yml" } elseif (Test-Path "../lab-config.yml") { "../lab-config.yml" } else { $null }

if (-not $configPath) {
    Write-Host "❌  lab-config.yml not found in current or parent directory" -ForegroundColor Red
    Write-Host "    Please ensure the lab-config.yml file exists in the repository root" -ForegroundColor Yellow
    exit 1
}

Write-Host "📖  Reading lab configuration from $configPath..." -ForegroundColor Green

# Define base paths (works whether run from root or scripts folder)
$basePath = if (Test-Path "./labs") { "." } else { ".." }
$labsPath = "$basePath/labs"
$outputPath = "$basePath/_labs"
$indexPath = "$basePath/labs/index.md"

# Read and parse lab-config.yml
try {
    $configContent = Get-Content $configPath -Raw -ErrorAction Stop
    $config = ConvertFrom-Yaml $configContent -ErrorAction Stop
} catch {
    Write-Host "❌  Failed to read or parse lab-config.yml: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

Write-Host "📁  Creating _labs directory..." -ForegroundColor Green
New-Item -ItemType Directory -Path $outputPath -Force | Out-Null

# Extract lab orders from config
$labOrders = @{}
if ($config.lab_orders) {
    Write-Host "📋  Loading lab order configuration..." -ForegroundColor Green
    $labOrders = $config.lab_orders
    Write-Host "  ✅ Loaded order values for $($labOrders.Keys.Count) labs" -ForegroundColor Green
}

# Extract lab journeys from config
$script:labJourneys = @{}
if ($config.lab_journeys) {
    Write-Host "🎯  Loading lab journey configuration..." -ForegroundColor Green
    $script:labJourneys = $config.lab_journeys
    Write-Host "  ✅ Loaded journey assignments for $($script:labJourneys.Keys.Count) labs" -ForegroundColor Green
}

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
    
    $source_file = "$basePath/labs/$lab_key/README.md"
    $target_file = "$outputPath/$lab_key.md"  # Always use semantic names
    
    if (Test-Path $source_file) {
        Write-Host "  📝  Processing $SectionName`: $lab_key -> $(Split-Path $target_file -Leaf)" -ForegroundColor Cyan
        
        try {
            # Read the source file
            $content = Get-Content $source_file -Raw -ErrorAction Stop
            
            # Extract description from README content (first paragraph after title)
            $description = ""
            $lines = $content -split "`n"
            $foundTitle = $false
            $foundDescription = $false
            
            foreach ($line in $lines) {
                $line = $line.Trim()
                
                # Skip until we find the main heading
                if ($line -match "^#\s+") {
                    $foundTitle = $true
                    continue
                }
                
                # After title, look for first substantial paragraph
                if ($foundTitle -and -not $foundDescription) {
                    if ($line -and -not $line.StartsWith("#") -and -not $line.StartsWith("---") -and -not $line.StartsWith("<!--")) {
                        $description = $line
                        $foundDescription = $true
                        break
                    }
                }
            }
            
            # Fallback to config description if we couldn't extract one
            if (-not $description) {
                $description = $Lab.description
            }
            
            # Create Jekyll front matter with journey metadata
            $front_matter = @"
---
layout: lab
title: "$title"
"@
            
            # Add order (now that we have configured values for all labs)
            $front_matter += "`norder: $Order"
            
            $front_matter += @"
`nduration: $duration
difficulty: $difficulty
lab_type: $LabType
section: $SectionName
"@
            
            # Add journeys if they exist
            if ($journeys -and $journeys.Count -gt 0) {
                $journeyArray = $journeys | ForEach-Object { "`"$_`"" }
                $journeyString = "[" + ($journeyArray -join ", ") + "]"
                $front_matter += "`njourneys: $journeyString"
            }
            
            # Add extracted description
            $front_matter += "`ndescription: `"$description`""
            
            # Clean up content - remove leading/trailing whitespace and normalize newlines
            $cleanContent = $content.Trim()
            
            # Remove duplicate title from content if it matches (avoid double headers in PDF)
            $lines = $cleanContent -split "`n"
            if ($lines.Count -gt 0 -and $lines[0] -match "^#\s+(.+)") {
                $contentTitle = $matches[1].Trim()
                if ($contentTitle -eq $title) {
                    # Remove the first line (duplicate title) and any following empty lines
                    $lines = $lines[1..($lines.Length-1)]
                    while ($lines.Count -gt 0 -and [string]::IsNullOrWhiteSpace($lines[0])) {
                        $lines = $lines[1..($lines.Length-1)]
                    }
                    $cleanContent = $lines -join "`n"
                }
            }
            
            $front_matter += @"

---

$cleanContent
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
        # Check if this is an external lab (has url or repository field)
        if ($Lab.url -or $Lab.repository) {
            Write-Host "  🌐  Processing external $SectionName`: $lab_key -> $(Split-Path $target_file -Leaf)" -ForegroundColor Cyan
            
            try {
                # Use description from config for external labs
                $description = if ($Lab.description) { $Lab.description } else { "External lab hosted at $($Lab.url)" }
                
                # Create Jekyll front matter for external lab
                $front_matter = @"
---
layout: lab
title: "$title"
"@
                
                # Add order (now that we have configured values for all labs)
                $front_matter += "`norder: $Order"
                
                $front_matter += @"
`nduration: $duration
difficulty: $difficulty
lab_type: $LabType
section: $SectionName
external: true
"@
                
                # Add external URL and repository info
                if ($Lab.url) {
                    $front_matter += "`nurl: `"$($Lab.url)`""
                }
                if ($Lab.repository) {
                    $front_matter += "`nrepository: `"$($Lab.repository)`""
                }
                
                # Add journeys if they exist
                if ($journeys -and $journeys.Count -gt 0) {
                    $journeyArray = $journeys | ForEach-Object { "`"$_`"" }
                    $journeyString = "[" + ($journeyArray -join ", ") + "]"
                    $front_matter += "`njourneys: $journeyString"
                }
                
                # Add description
                $front_matter += "`ndescription: `"$description`""
                
                # Create content for external lab (title already in front matter)
                $external_content = @"

---

$description

## 🌐 External Repository

This lab is hosted in an external repository. Click the link below to access the full lab content:

**Repository**: [$($Lab.repository)]($($Lab.url))

## Lab Details

- **Duration**: $duration minutes
- **Difficulty**: $difficulty
- **Type**: External Lab

## Getting Started

1. Navigate to the [external repository]($($Lab.url))
2. Follow the README instructions in that repository
3. Complete the lab exercises as directed

---

*This is an external lab. All content and instructions are maintained in the linked repository.*
"@
                
                $front_matter += $external_content
                
                # Write to target file
                $front_matter | Set-Content $target_file -Encoding UTF8 -ErrorAction Stop
                Write-Host "    ✅  Created external lab $(Split-Path $target_file -Leaf)" -ForegroundColor Green
                return $true
            } catch {
                Write-Host "    ❌  Failed to process external lab $lab_key`: $($_.Exception.Message)" -ForegroundColor Red
                return $false
            }
        } else {
            Write-Host "    ⚠️   Source file not found: $source_file" -ForegroundColor Yellow
            return $false
        }
    }
}

# Track processing statistics
$totalLabs = 0
$processedLabs = 0
$failedLabs = 0
$order = 1

Write-Host "🔄  Converting labs with journey metadata..." -ForegroundColor Yellow
Write-Host ""

# Process all lab sections dynamically
# Auto-generate section metadata from config or use intelligent defaults
$sectionMeta = @{}

# ===== HELPER FUNCTIONS =====

function Get-UnifiedCollection {
    param(
        [Parameter(Mandatory)]$Collection,
        [string[]]$SkipKeys = @()
    )
    
    $result = @{}
    
    if ($Collection -is [System.Collections.Hashtable]) {
        foreach ($key in $Collection.Keys) {
            if ($key -notin $SkipKeys) {
                $result[$key] = $Collection[$key]
            }
        }
    } else {
        foreach ($property in $Collection.PSObject.Properties) {
            if ($property.Name -notin $SkipKeys) {
                $result[$property.Name] = $property.Value
            }
        }
    }
    
    return $result
}

function Get-JourneyStats {
    param(
        [Parameter(Mandatory)]$JourneyName,
        [Parameter(Mandatory)]$AllLabs
    )
    
    $labCount = 0
    $totalDuration = 0
    
    foreach ($lab in $AllLabs) {
        if ($lab.journeys -and $JourneyName -in $lab.journeys) {
            $labCount++
            $totalDuration += $lab.duration
        }
    }
    
    return @{ LabCount = $labCount; TotalDuration = $totalDuration }
}

# ===== AUTO-DISCOVERY FUNCTIONS =====

function Get-LabFromReadme {
    param(
        [Parameter(Mandatory)][string]$LabPath,
        [Parameter(Mandatory)][string]$LabId
    )
    
    $readmePath = Join-Path $LabPath "README.md"
    if (-not (Test-Path $readmePath)) {
        return $null
    }
    
    try {
        $content = Get-Content $readmePath -Raw -ErrorAction Stop
        $lines = $content -split "`n"
        
        # Initialize lab object with defaults
        $lab = @{
            id = $LabId
            title = ""
            duration = 30  # Default duration
            difficulty = 100  # Default difficulty
            description = ""
            journeys = @()
            section = ""  # Will be auto-assigned if not specified
            tags = @()
        }
        
        # Look for YAML front matter first
        if ($content -match '^---\s*\n(.*?)\n---\s*\n') {
            Write-Host "  📋  Found YAML front matter in $LabId" -ForegroundColor Cyan
            # TODO: Parse YAML front matter when we add it to README files
        }
        
        # Parse structured content
        $inTable = $false
        $foundTitle = $false
        
        foreach ($line in $lines) {
            $line = $line.Trim()
            
            # Extract title from first heading
            if (-not $foundTitle -and $line -match "^#\s+(.+)") {
                $lab.title = $matches[1].Trim()
                $foundTitle = $true
                continue
            }
            
            # Extract description from content after title
            if ($foundTitle -and -not $lab.description -and $line -and 
                -not $line.StartsWith("#") -and -not $line.StartsWith("---") -and 
                -not $line.StartsWith("<!--") -and -not $line.StartsWith("|")) {
                $lab.description = $line
            }
            
            # Parse lab details table
            if ($line -match "Level.*Persona.*Duration.*Purpose") {
                $inTable = $true
                continue
            }
            
            if ($inTable -and $line -match "^\|\s*(\d+)\s*\|\s*([^|]+)\s*\|\s*(\d+)\s*minutes?\s*\|\s*(.+)\s*\|") {
                $lab.difficulty = [int]$matches[1]
                $lab.duration = [int]$matches[3]
                # Use table description if we don't have one yet
                if (-not $lab.description) {
                    $lab.description = $matches[4].Trim()
                }
                $inTable = $false
            }
        }
        
        # Auto-assign section based on difficulty and folder patterns
        if (-not $lab.section) {
            $lab.section = Get-AutoSection -LabId $LabId -Difficulty $lab.difficulty
        }
        
        # Assign journeys from config or auto-assign based on difficulty and keywords
        if ($script:labJourneys.ContainsKey($LabId)) {
            $lab.journeys = $script:labJourneys[$LabId]
            Write-Host "    🎯 Using explicit journey assignment: $($lab.journeys -join ', ')" -ForegroundColor Magenta
        } elseif ($lab.journeys.Count -eq 0) {
            $lab.journeys = Get-AutoJourneys -Lab $lab
            Write-Host "    🤖 Using automatic journey assignment: $($lab.journeys -join ', ')" -ForegroundColor Yellow
        }
        
        return $lab
    }
    catch {
        Write-Host "  ❌  Error parsing $LabId`: $($_.Exception.Message)" -ForegroundColor Red
        return $null
    }
}

function Get-AutoSection {
    param(
        [string]$LabId,
        [int]$Difficulty
    )
    
    # Section assignment based on patterns and difficulty
    if ($LabId -match "external|mcp-external") { return "external_labs" }
    if ($LabId -match "30-mins|optional") { return "optional_labs" }
    if ($LabId -match "autonomous") { return "advanced_labs" }
    if ($LabId -match "mcp|pipeline|kit|measure") { return "specialized_labs" }
    
    # Difficulty-based assignment
    if ($Difficulty -le 100) { return "core_learning_path" }
    if ($Difficulty -le 200) { return "intermediate_labs" }
    return "advanced_labs"
}

function Get-AutoJourneys {
    param($Lab)
    
    $journeys = @()
    $title = $Lab.title.ToLower()
    $id = $Lab.id.ToLower()
    
    # Journey assignment based on content analysis
    if ($Lab.difficulty -le 100 -or $title -match "start|begin|first|basic") {
        $journeys += "quick-start"
    }
    
    if ($title -match "business|maker" -or $Lab.difficulty -le 200) {
        $journeys += "business-user"
    }
    
    if ($title -match "developer|technical|integration|pipeline|mcp" -or $id -match "setup|pipeline|mcp") {
        $journeys += "developer"
    }
    
    if ($id -match "autonomous" -or $title -match "autonomous|ai automation") {
        $journeys += "autonomous-ai"
    }
    
    # Ensure every lab has at least one journey
    if ($journeys.Count -eq 0) {
        if ($Lab.difficulty -le 150) {
            $journeys += "business-user"
        } else {
            $journeys += "developer"
        }
    }
    
    return $journeys
}

function Get-AllLabsFromFolders {
    $discoveredLabs = @()
    $labFolders = Get-ChildItem "$basePath/labs" -Directory | Where-Object { 
        $_.Name -ne "lab-template.md" -and (Test-Path (Join-Path $_.FullName "README.md"))
    }
    
    Write-Host "🔍  Auto-discovering labs from folders..." -ForegroundColor Yellow
    
    foreach ($folder in $labFolders) {
        $lab = Get-LabFromReadme -LabPath $folder.FullName -LabId $folder.Name
        if ($lab) {
            $discoveredLabs += $lab
            Write-Host "  ✅  Discovered: $($folder.Name)" -ForegroundColor Green
        } else {
            Write-Host "  ⚠️   Failed to parse: $($folder.Name)" -ForegroundColor Yellow
        }
    }
    
    # Add external labs from config if they exist (they won't have local folders)
    if ($config.external_labs) {
        Write-Host "🌐  Adding external labs from config..." -ForegroundColor Cyan
        foreach ($externalLab in $config.external_labs) {
            $lab = @{
                id = $externalLab.id
                title = $externalLab.title
                duration = $externalLab.duration
                difficulty = if ($externalLab.difficulty -match '\d+') { [int]($externalLab.difficulty -replace '\D','') } else { 200 }
                description = $externalLab.description
                journeys = if ($externalLab.journeys) { $externalLab.journeys } else { @("developer") }
                section = "external_labs"
                url = $externalLab.url
                repository = $externalLab.repository
            }
            $discoveredLabs += $lab
            Write-Host "  ✅  Added external lab: $($externalLab.id)" -ForegroundColor Green
        }
    }
    
    Write-Host "📊  Discovered $($discoveredLabs.Count) labs total" -ForegroundColor Cyan
    return $discoveredLabs
}

# ===== END AUTO-DISCOVERY FUNCTIONS =====

# Load section definitions from config file
if ($config.sections) {
    Write-Host "📋  Loading section definitions from config..." -ForegroundColor Cyan
    
    $sections = Get-UnifiedCollection -Collection $config.sections
    foreach ($sectionKey in $sections.Keys) {
        $sectionData = $sections[$sectionKey]
        if ($sectionData -and $sectionData.title) {
            $sectionMeta[$sectionKey] = @{
                displayName = $sectionData.title
                icon = $sectionData.icon
                sectionName = $sectionData.slug
                labType = if ($sectionData.type) { $sectionData.type } else { "main" }
                description = $sectionData.description
            }
            Write-Host "  ✅ Loaded section: $sectionKey" -ForegroundColor Green
        }
    }
}

# If no valid sections were loaded, use intelligent defaults
if ($sectionMeta.Keys.Count -eq 0) {
    Write-Host "🤖  No valid section definitions found, using intelligent defaults..." -ForegroundColor Yellow
    $sectionMeta = @{
        "core_learning_path" = @{ displayName = "Core Learning Path"; icon = "📚"; sectionName = "core"; labType = "main"; description = "Essential foundation labs" }
        "intermediate_labs" = @{ displayName = "Intermediate Labs"; icon = "🎯"; sectionName = "intermediate"; labType = "main"; description = "Build on core concepts" }
        "advanced_labs" = @{ displayName = "Advanced Labs"; icon = "🚀"; sectionName = "advanced"; labType = "main"; description = "Complex scenarios" }
        "specialized_labs" = @{ displayName = "Specialized Labs"; icon = "⚡"; sectionName = "specialized"; labType = "main"; description = "Tools and utilities" }
        "optional_labs" = @{ displayName = "Optional Labs"; icon = "🔧"; sectionName = "optional"; labType = "optional"; description = "Alternative versions" }
        "external_labs" = @{ displayName = "External Labs"; icon = "�"; sectionName = "external"; labType = "external"; description = "External repositories" }
    }
}



# ===== AUTO-DISCOVERY PROCESSING =====

# Get all labs from folder scanning
$allLabs = Get-AllLabsFromFolders

# Group labs by section
$labsBySection = @{}
foreach ($lab in $allLabs) {
    $section = $lab.section
    if (-not $labsBySection[$section]) {
        $labsBySection[$section] = @()
    }
    $labsBySection[$section] += $lab
}

# Process each discovered section
foreach ($sectionKey in $labsBySection.Keys) {
    $sectionLabs = $labsBySection[$sectionKey]
    
    # Get section metadata (with fallback if not defined)
    $meta = $sectionMeta[$sectionKey]
    if (-not $meta) {
        $meta = @{ 
            displayName = $sectionKey -replace '_', ' ' -replace '\b\w', { $_.Value.ToUpper() }; 
            icon = "📁"; 
            sectionName = $sectionKey -replace '_.*', ''; 
            labType = if ($sectionKey -eq "optional_labs") { "optional" } elseif ($sectionKey -eq "external_labs") { "external" } else { "main" }
            description = "Auto-discovered section"
        }
    }
    
    Write-Host "$($meta.icon)  $($meta.displayName) ($($sectionLabs.Count) labs)" -ForegroundColor Magenta
    
    foreach ($lab in $sectionLabs) {
        $totalLabs++
        
        # Use configured order or fallback to sequential/default
        if ($labOrders.ContainsKey($lab.id)) {
            $labOrder = $labOrders[$lab.id]
        } elseif ($meta.labType -eq "optional") {
            $labOrder = 0  # Optional labs get 0 if not configured
        } else {
            $labOrder = $order  # Sequential fallback
        }
        
        if (ConvertTo-JekyllLab -Lab $lab -Order $labOrder -SectionName $meta.sectionName -LabType $meta.labType) {
            $processedLabs++
        } else {
            $failedLabs++
        }
        
        if ($meta.labType -ne "optional") { $order++ }
    }
    Write-Host ""
}

# Create Dynamic Journey Index (No Separate Journey Files)
Write-Host "🛤️  Creating Dynamic Journey System (collections only)..." -ForegroundColor Magenta

# Remove journeys directory - no more separate files
if (Test-Path "journeys") {
    Write-Host "  🗑️  Removing redundant journeys folder..." -ForegroundColor Yellow
    Remove-Item "journeys" -Recurse -Force
    Write-Host "    ✅  Removed duplicate journey files" -ForegroundColor Green
}

# Read journey metadata from config file
$journeyMeta = @{}
if ($config.journeys) {
    Write-Host "🛤️  Loading journey definitions from config..." -ForegroundColor Cyan
    
    $journeys = Get-UnifiedCollection -Collection $config.journeys
    foreach ($journeyName in $journeys.Keys) {
        $journeyData = $journeys[$journeyName]
        if ($journeyData -and $journeyData.title -and $journeyData.description) {
            $journeyMeta[$journeyName] = @{
                title = $journeyData.title
                description = $journeyData.description
                icon = $journeyData.icon
                difficulty = $journeyData.difficulty
                estimated_time = $journeyData.estimated_time
            }
            Write-Host "  ✅ Loaded journey: $journeyName" -ForegroundColor Green
        }
    }
} else {
    Write-Host "⚠️  No journey definitions found in config, using defaults..." -ForegroundColor Yellow
    # Fallback to minimal defaults if journeys section is missing
    $journeyMeta = @{
        "quick-start" = @{ title = "Quick Start"; description = "Essential labs"; icon = "🚀"; difficulty = "Beginner"; estimated_time = "3-4 hours" }
        "business-user" = @{ title = "Business User"; description = "Business solutions"; icon = "�"; difficulty = "Intermediate"; estimated_time = "8-12 hours" }
        "developer" = @{ title = "Developer"; description = "Technical depth"; icon = "🔧"; difficulty = "Advanced"; estimated_time = "10-15 hours" }
        "autonomous-ai" = @{ title = "Autonomous AI"; description = "Advanced agents"; icon = "🤖"; difficulty = "Expert"; estimated_time = "6-8 hours" }
    }
}

# Display journey statistics (no separate files created)
Write-Host "�  Journey Statistics:" -ForegroundColor Cyan
foreach ($journeyName in $journeyMeta.Keys) {
    $journey = $journeyMeta[$journeyName]
    $journeyStats = Get-JourneyStats -JourneyName $journeyName -AllLabs $allLabs
    $journeyLabCount = $journeyStats.LabCount
    $totalDuration = $journeyStats.TotalDuration
    
    Write-Host "  $($journey.icon) $($journey.title): $journeyLabCount labs ($totalDuration minutes)" -ForegroundColor Green
}

# Generate All Labs Index Page Dynamically (Enhanced Version)
Write-Host "📋  Generating enhanced All Labs index page..." -ForegroundColor Magenta

# Ensure labs directory exists
New-Item -ItemType Directory -Path "labs" -Force | Out-Null

# Build dynamic journey buttons
$journeyButtons = ""
foreach ($journeyKey in $config.journeys.Keys) {
    $journey = $config.journeys[$journeyKey]
    $journeyButtons += "    <button onclick=`"filterByJourney('$journeyKey')`" class=`"filter-btn`" id=`"$journeyKey-btn`">$($journey.icon) $($journey.title.Replace(' Journey', ''))</button>`n"
}

# Build dynamic section buttons
$sectionButtons = ""
foreach ($sectionKey in $config.sections.Keys) {
    $section = $config.sections[$sectionKey]
    $sectionButtons += "    <button onclick=`"filterBySection('$($section.slug)')`" class=`"filter-btn section-btn`" id=`"$($section.slug)-btn`">$($section.icon) $($section.title)</button>`n"
}

# Build dynamic journey metadata for JavaScript
$journeyMetadata = ""
foreach ($journeyKey in $config.journeys.Keys) {
    $journey = $config.journeys[$journeyKey]
    $journeyMetadata += "  '$journeyKey': { title: '$($journey.icon) $($journey.title)', description: '$($journey.description)', difficulty: '$($journey.difficulty)', estimatedTime: '$($journey.estimated_time)' },`n"
}
$journeyMetadata = $journeyMetadata.TrimEnd(",`n")

# Build dynamic enhanced All Labs content
$allLabsContent = @"
---
layout: default
title: Labs
description: Microsoft Copilot Studio labs - browse all or filter by learning journey
---

<div id="journey-header" style="display: none;" class="journey-header">
  <h1 id="journey-title"></h1>
  <p id="journey-description"></p>
  <div id="journey-stats" class="journey-stats"></div>
</div>

<div id="all-labs-header">
  <h1>All Labs</h1>
  <p>Browse all available Microsoft Copilot Studio labs. Choose individual labs or follow our learning journeys for a guided experience.</p>
</div>

<div class="filter-section">
  <h3>Filter by Journey</h3>
  <p class="filter-hint">Click a filter to apply it, click again to show all labs</p>
  <div class="lab-filters">
$journeyButtons  </div>
</div>

<div class="filter-section">
  <h3>Filter by Section</h3>
  <div class="lab-filters">
$sectionButtons  </div>
</div>

<div class="labs-grid" id="labs-container">
{% for lab in site.labs %}
  <div class="lab-card" data-difficulty="{{ lab.difficulty }}" data-duration="{{ lab.duration }}" data-journeys="{{ lab.journeys | join: ',' }}" data-section="{{ lab.section }}">
    <div class="lab-header">
      <h3><a href="{{ '/labs/' | relative_url }}{{ lab.slug }}/">{{ lab.title }}</a></h3>
      <div class="lab-meta">
        <span class="section {{ lab.section }}">{{ lab.section | capitalize }}</span>
        <span class="difficulty">Level {{ lab.difficulty }}</span>
        <span class="duration">{{ lab.duration }}min</span>
      </div>
    </div>
    <div class="lab-description">
      {{ lab.description }}
    </div>
    <div class="lab-journeys">
      <small>Journeys: 
      {% for journey in lab.journeys %}
        <span class="journey-tag" onclick="filterByJourney('{{ journey }}')">{{ journey }}</span>
      {% endfor %}
      </small>
    </div>
    <div class="lab-actions">
      <a href="{{ '/labs/' | relative_url }}{{ lab.slug }}/" class="btn btn-primary">Start Lab</a>
      {% assign pdf_url = '/assets/pdfs/' | append: lab.slug | append: '.pdf' | relative_url %}
      <a href="{{ pdf_url }}" class="btn btn-secondary pdf-btn" target="_blank" rel="noopener noreferrer" title="Download PDF version">
        📄 PDF
      </a>
    </div>
  </div>
{% endfor %}
</div>

<script>
// Journey metadata
const journeys = {
$journeyMetadata
};

function showAllLabs() {
  document.getElementById('all-labs-header').style.display = 'block';
  document.getElementById('journey-header').style.display = 'none';
  
  // Show all lab cards
  const cards = document.querySelectorAll('.lab-card');
  cards.forEach(card => card.style.display = 'block');
  
  // Clear active buttons
  document.querySelectorAll('.filter-btn').forEach(btn => btn.classList.remove('active'));
  
  // Update URL
  history.pushState({}, '', '{{ "/labs/" | relative_url }}');
}

function filterByJourney(journeyName) {
  const journey = journeys[journeyName];
  if (!journey) return;
  
  // Check if this filter is already active (toggle behavior)
  const button = document.getElementById(journeyName + '-btn');
  if (button.classList.contains('active')) {
    // Unselect - show all labs
    showAllLabs();
    return;
  }
  
  // Show journey header
  document.getElementById('all-labs-header').style.display = 'none';
  document.getElementById('journey-header').style.display = 'block';
  document.getElementById('journey-title').textContent = journey.title;
  document.getElementById('journey-description').textContent = journey.description;
  
  // Calculate and show stats
  const cards = document.querySelectorAll('.lab-card');
  let labCount = 0;
  let totalDuration = 0;
  
  cards.forEach(card => {
    const journeyData = card.dataset.journeys;
    if (journeyData) {
      const journeys = journeyData.split(',').map(j => j.trim());
      if (journeys.includes(journeyName)) {
        card.style.display = 'block';
        labCount++;
        totalDuration += parseInt(card.dataset.duration);
      } else {
        card.style.display = 'none';
      }
    } else {
      card.style.display = 'none';
    }
  });
  
  document.getElementById('journey-stats').innerHTML = 
    '<strong>Difficulty Level:</strong> ' + journey.difficulty + '<br>' +
    '<strong>Estimated Time:</strong> ' + journey.estimatedTime + '<br>' +
    '<strong>Total Labs:</strong> ' + labCount + ' labs (' + totalDuration + ' minutes)';
  
  // Update active button
  document.querySelectorAll('.filter-btn').forEach(btn => btn.classList.remove('active'));
  document.getElementById(journeyName + '-btn').classList.add('active');
  
  // Update URL
  history.pushState({}, '', '{{ "/labs/" | relative_url }}#' + journeyName);
}

function filterBySection(sectionName) {
  // Check if this filter is already active (toggle behavior)
  const button = document.getElementById(sectionName + '-btn');
  if (button.classList.contains('active')) {
    // Unselect - show all labs
    showAllLabs();
    return;
  }
  
  // Show all labs header (section filtering doesn't have dedicated header)
  document.getElementById('all-labs-header').style.display = 'block';
  document.getElementById('journey-header').style.display = 'none';
  
  // Filter cards by section
  const cards = document.querySelectorAll('.lab-card');
  let labCount = 0;
  let totalDuration = 0;
  
  cards.forEach(card => {
    const cardSection = card.dataset.section;
    if (cardSection === sectionName) {
      card.style.display = 'block';
      labCount++;
      totalDuration += parseInt(card.dataset.duration);
    } else {
      card.style.display = 'none';
    }
  });
  
  // Update active button
  document.querySelectorAll('.filter-btn').forEach(btn => btn.classList.remove('active'));
  document.getElementById(sectionName + '-btn').classList.add('active');
  
  // Update URL
  history.pushState({}, '', '{{ "/labs/" | relative_url }}#section-' + sectionName);
}

// Initialize based on URL hash or parameters
document.addEventListener('DOMContentLoaded', function() {
  // Check for hash first (e.g., #quick-start or #section-core)
  let hash = window.location.hash.substring(1);
  
  // Handle section filtering
  if (hash.startsWith('section-')) {
    const sectionName = hash.substring(8); // Remove 'section-' prefix
    filterBySection(sectionName);
    return;
  }
  
  // Handle journey filtering
  if (hash && journeys[hash]) {
    filterByJourney(hash);
    return;
  }
  
  // Fall back to URL parameters if no hash
  const urlParams = new URLSearchParams(window.location.search);
  const journey = urlParams.get('journey');
  
  if (journey && journeys[journey]) {
    filterByJourney(journey);
  } else {
    showAllLabs();
  }
});

// Listen for hash changes
window.addEventListener('hashchange', function() {
  const hash = window.location.hash.substring(1);
  
  // Handle section filtering
  if (hash.startsWith('section-')) {
    const sectionName = hash.substring(8);
    filterBySection(sectionName);
    return;
  }
  
  // Handle journey filtering
  if (hash && journeys[hash]) {
    filterByJourney(hash);
  } else {
    showAllLabs();
  }
});
</script>

<style>
.filter-section {
  margin: 1.5rem 0;
}

.filter-section h3 {
  margin-bottom: 0.5rem;
  color: #323130;
  font-size: 1.1rem;
  text-align: center;
}

.filter-hint {
  margin: 0 0 1rem 0;
  color: #605e5c;
  font-size: 0.9rem;
  text-align: center;
  font-style: italic;
}

.lab-filters {
  margin: 2rem 0;
  display: flex;
  gap: 1rem;
  flex-wrap: wrap;
  justify-content: center;
}

.filter-btn {
  padding: 0.75rem 1.5rem;
  border: 2px solid #0078d4;
  background: white;
  color: #0078d4;
  border-radius: 25px;
  cursor: pointer;
  font-weight: 500;
  transition: all 0.2s ease;
}

.filter-btn:hover {
  background: #e6f3ff;
}

.filter-btn.active {
  background: #0078d4;
  color: white;
  box-shadow: 0 2px 8px rgba(0, 120, 212, 0.3);
  transform: translateY(-1px);
}

.filter-btn.active:hover {
  background: #106ebe;
  box-shadow: 0 3px 12px rgba(0, 120, 212, 0.4);
}

.journey-header {
  text-align: center;
  margin-bottom: 2rem;
  padding: 2rem;
  background: linear-gradient(135deg, #0078d4, #106ebe);
  color: white;
  border-radius: 12px;
}

.journey-stats {
  margin-top: 1rem;
  font-size: 1.1rem;
}

.journey-tag {
  cursor: pointer;
  transition: all 0.2s ease;
}

.journey-tag:hover {
  background: #0078d4 !important;
  color: white !important;
}

.lab-meta .section {
  background: #f3f2f1;
  color: #323130;
  padding: 0.25rem 0.75rem;
  border-radius: 12px;
  font-size: 0.85rem;
  font-weight: 500;
  margin-right: 0.5rem;
}

.lab-meta .section.core {
  background: #e1f5fe;
  color: #0277bd;
}

.lab-meta .section.intermediate {
  background: #fff3e0;
  color: #f57c00;
}

.lab-meta .section.advanced {
  background: #fce4ec;
  color: #c2185b;
}

.lab-meta .section.specialized {
  background: #f3e5f5;
  color: #7b1fa2;
}

.lab-meta .section.optional {
  background: #e8f5e8;
  color: #2e7d32;
}

.lab-meta .section.external {
  background: #e3f2fd;
  color: #1565c0;
}
</style>

"@

# Collect unique sections that actually have labs (use our discovered labs)
$activeSections = @{}
foreach ($sectionKey in $labsBySection.Keys) {
    $sectionLabs = $labsBySection[$sectionKey]
    $meta = $sectionMeta[$sectionKey]
    if ($meta -and $sectionLabs.Count -gt 0) {
        $activeSections[$sectionKey] = @{
            meta = $meta
            labCount = $sectionLabs.Count
        }
    }
}

# Generate sections dynamically based on what exists
if ($false) { # Disabled - using unified approach instead
    Write-Host "  📊 Generating $($activeSections.Count) dynamic sections for All Labs page" -ForegroundColor Cyan
    
    foreach ($sectionKey in $activeSections.Keys) {
        $sectionInfo = $activeSections[$sectionKey]
        $meta = $sectionInfo.meta
        
        # Determine section description based on section type
        $sectionDescription = switch ($meta.sectionName) {
            "core" { "Essential foundation labs - start here first!" }
            "intermediate" { "Build on core concepts with practical applications" }
            "advanced" { "Complex scenarios and autonomous agents" }
            "specialized" { "DevOps, tools, and advanced utilities" }
            "optional" { "Alternative versions and specialized topics" }
            default { "Additional labs in this category" }
        }
        
        $allLabsContent += @"

## $($meta.icon) $($meta.displayName)
$sectionDescription

<div class="labs-grid">
{% for lab in site.labs %}
  {% if lab.section == '$($meta.sectionName)' %}
  <div class="lab-card" data-difficulty="{{ lab.difficulty }}" data-duration="{{ lab.duration }}" data-journeys="{{ lab.journeys | join: ',' }}" data-section="{{ lab.section }}">
    <div class="lab-header">
      <h3><a href="{{ '/labs/' | relative_url }}{{ lab.slug }}/">{{ lab.title }}</a></h3>
      <div class="lab-meta">
        <span class="section {{ lab.section }}">{{ lab.section | capitalize }}</span>
        <span class="difficulty">Level {{ lab.difficulty }}</span>
        <span class="duration">{{ lab.duration }}min</span>
      </div>
    </div>
    <div class="lab-description">
      {{ lab.description }}
    </div>
    <div class="lab-journeys">
      <small>Journeys: 
      {% for journey in lab.journeys %}
        <span class="journey-tag" onclick="filterByJourney('{{ journey }}')">{{ journey }}</span>
      {% endfor %}
      </small>
    </div>
    <div class="lab-actions">
      <a href="{{ '/labs/' | relative_url }}{{ lab.slug }}/" class="btn btn-primary">Start Lab</a>
      {% assign pdf_url = '/assets/pdfs/' | append: lab.slug | append: '.pdf' | relative_url %}
      <a href="{{ pdf_url }}" class="btn btn-secondary pdf-btn" target="_blank" rel="noopener noreferrer" title="Download PDF version">
        📄 PDF
      </a>
    </div>
  </div>
  {% endif %}
{% endfor %}
</div>
"@
    }
}

# Fallback section removed - we already have the main lab cards section above

# Add JavaScript for filtering functionality
$allLabsContent += @"

<script>
// Journey metadata (dynamically generated from config)
const journeys = {
$journeyMetadata
};

function showAllLabs() {
  document.getElementById('all-labs-header').style.display = 'block';
  document.getElementById('journey-header').style.display = 'none';
  
  // Show all lab cards
  const cards = document.querySelectorAll('.lab-card');
  cards.forEach(card => card.style.display = 'block');
  
  // Clear active buttons
  document.querySelectorAll('.filter-btn').forEach(btn => btn.classList.remove('active'));
  
  // Update URL
  history.pushState({}, '', '{{ "/labs/" | relative_url }}');
}

function filterByJourney(journeyName) {
  const journey = journeys[journeyName];
  if (!journey) return;
  
  // Show journey header
  document.getElementById('all-labs-header').style.display = 'none';
  document.getElementById('journey-header').style.display = 'block';
  document.getElementById('journey-title').textContent = journey.title;
  document.getElementById('journey-description').textContent = journey.description;
  
  // Calculate and show stats
  const cards = document.querySelectorAll('.lab-card');
  let labCount = 0;
  let totalDuration = 0;
  
  cards.forEach(card => {
    const journeyData = card.dataset.journeys;
    if (journeyData) {
      const journeys = journeyData.split(',').map(j => j.trim());
      if (journeys.includes(journeyName)) {
        card.style.display = 'block';
        labCount++;
        totalDuration += parseInt(card.dataset.duration);
      } else {
        card.style.display = 'none';
      }
    } else {
      card.style.display = 'none';
    }
  });
  
  document.getElementById('journey-stats').innerHTML = 
    '<strong>Difficulty Level:</strong> ' + journey.difficulty + '<br>' +
    '<strong>Estimated Time:</strong> ' + journey.estimatedTime + '<br>' +
    '<strong>Total Labs:</strong> ' + labCount + ' labs (' + totalDuration + ' minutes)';
  
  // Update active button
  document.querySelectorAll('.filter-btn').forEach(btn => btn.classList.remove('active'));
  document.getElementById(journeyName + '-btn').classList.add('active');
  
  // Update URL
  history.pushState({}, '', '{{ "/labs/" | relative_url }}#' + journeyName);
}

// Initialize based on URL hash or parameters
document.addEventListener('DOMContentLoaded', function() {
  // Check for hash first (e.g., #quick-start)
  let journey = window.location.hash.substring(1);
  
  // Fall back to URL parameters if no hash
  if (!journey) {
    const urlParams = new URLSearchParams(window.location.search);
    journey = urlParams.get('journey');
  }
  
  if (journey && journeys[journey]) {
    filterByJourney(journey);
  } else {
    showAllLabs();
  }
});

// Listen for hash changes
window.addEventListener('hashchange', function() {
  const journey = window.location.hash.substring(1);
  if (journey && journeys[journey]) {
    filterByJourney(journey);
  } else {
    showAllLabs();
  }
});
</script>

<style>
.lab-filters {
  margin: 2rem 0;
  display: flex;
  gap: 1rem;
  flex-wrap: wrap;
  justify-content: center;
}

.filter-btn {
  padding: 0.75rem 1.5rem;
  border: 2px solid #0078d4;
  background: white;
  color: #0078d4;
  border-radius: 25px;
  cursor: pointer;
  font-weight: 500;
  transition: all 0.2s ease;
}

.filter-btn:hover {
  background: #e6f3ff;
}

.filter-btn.active {
  background: #0078d4;
  color: white;
}

.journey-header {
  text-align: center;
  margin-bottom: 2rem;
  padding: 2rem;
  background: linear-gradient(135deg, #0078d4, #106ebe);
  color: white;
  border-radius: 12px;
}

.journey-stats {
  margin-top: 1rem;
  font-size: 1.1rem;
}

.journey-tag {
  cursor: pointer;
  transition: all 0.2s ease;
}

.journey-tag:hover {
  background: #0078d4 !important;
  color: white !important;
}
</style>

<div class="navigation-actions">
  <a href="{{ '/' | relative_url }}" class="btn btn-secondary">← Back to Home</a>
</div>
"@

Set-Content -Path $indexPath -Value $allLabsContent -Encoding UTF8
Write-Host "  ✅  Created enhanced labs/index.md (with dynamic journeys and sections)" -ForegroundColor Green

# Generate Main Index Page with Journey Cards
Write-Host "🏠  Generating main index page with journey cards..." -ForegroundColor Magenta

$mainIndexPath = "$basePath/index.md"

# Build journey cards dynamically
$journeyCards = ""
foreach ($journeyKey in $config.journeys.Keys) {
    $journey = $config.journeys[$journeyKey]
    $journeyStats = Get-JourneyStats -JourneyName $journeyKey -AllLabs $allLabs
    $labCount = $journeyStats.LabCount
    $totalDuration = $journeyStats.TotalDuration
    $durationHours = [math]::Round($totalDuration / 60, 1)
    
    # Determine level display
    $levelDisplay = $journey.difficulty
    if ($journey.difficulty -match "(\d+)-(\d+)") {
        $levelDisplay = "Level $($matches[1])-$($matches[2])"
    } elseif ($journey.difficulty -match "(\d+)") {
        $levelDisplay = "Level $($matches[1])"
    }
    
    # Determine time display
    $timeDisplay = "$durationHours hours"
    if ($durationHours -lt 1) {
        $timeDisplay = "$totalDuration mins"
    } elseif ($durationHours -ge 2) {
        $timeDisplay = "$([math]::Floor($durationHours))-$([math]::Ceiling($durationHours)) hours"
    }
    
    $journeyCards += @"
    <div class="journey-card $journeyKey">
        <h3>$($journey.icon) $($journey.title.Replace(' Journey', ''))</h3>
        <p>$($journey.description)</p>
        <div class="journey-meta">
            <span>⏱️ $timeDisplay</span>
            <span>📊 $levelDisplay</span>
            <span>📚 $labCount labs</span>
        </div>
        <a href="{{ '/labs/#$journeyKey' | relative_url }}" class="journey-btn">Start Journey →</a>
    </div>
    

"@
}
$journeyCards = $journeyCards.TrimEnd()

$mainIndexContent = @"
---
layout: default
title: Home
---

# Microsoft Copilot Studio Labs

Welcome to hands-on labs for building AI agents with Microsoft Copilot Studio. Choose your learning journey based on your goals and experience level.

## 🎯 **Choose Your Learning Journey**

<div class="journey-cards">
$journeyCards
</div>

---

## 🎯 **Getting Started**

1. **Choose your journey** above based on your goals and experience
2. **Follow the guided path** with labs specifically selected for your needs
3. **Build hands-on skills** with real Microsoft Copilot Studio projects
4. **Progress at your own pace** - each journey is self-contained

**Ready to build amazing AI agents?** Pick your journey and start learning! 🎉

- Join the community discussions for questions and insights
- Practice with your own use cases after completing each lab

Happy learning! 🎉
"@

Set-Content -Path $mainIndexPath -Value $mainIndexContent -Encoding UTF8
Write-Host "  ✅  Created main index.md with dynamic journey cards" -ForegroundColor Green

Write-Host ""

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