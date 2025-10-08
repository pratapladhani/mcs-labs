# PowerShell conversion of convert-labs.sh
# Converts existing lab README files to Jekyll format with proper ordering

# Define labs with order|title|duration|level
$labs = @{
    "agent-builder-web" = "1|Web-based AI Assistant with Agent Builder|45|100"
    "agent-builder-sharepoint" = "2|SharePoint AI Assistant with Agent Builder|60|200"
    "standard-orchestrator" = "3|Standard Orchestrator|75|100"
    "setup-for-success" = "4|ALM Best Practices Setup|60|200"
    "public-website-agent" = "5|Public Website Agent|90|100"
    "mbr-prep-sharepoint-agent" = "6|MBR Agent Deploy to SharePoint|75|100"
    "ask-me-anything" = "7|Ask Me Anything Agent|90|200"
    "autonomous-support-agent" = "8|Autonomous Support Agent|120|200"
    "autonomous-account-news" = "9|Autonomous Account News Agent|120|200"
    "autonomous-cua" = "10|Autonomous Agent with Computer-Using Agents|150|200"
    "pipelines-and-source-control" = "11|Pipelines and Source Control|60|300"
    "copilot-studio-kit" = "12|Copilot Studio Kit|60|200"
    "measure-success" = "13|Measure Success|45|300"
    "mcp-qualify-lead" = "14|Model Context Protocol Integration|90|200"
}

# Define optional labs
$optional_labs = @{
    "ask-me-anything-30-mins" = "Ask Me Anything Agent (30 min version)|30|200"
}

Write-Host "Creating _labs directory..." -ForegroundColor Green
New-Item -ItemType Directory -Path "_labs" -Force | Out-Null

Write-Host "Converting main labs..." -ForegroundColor Yellow

foreach ($lab_key in $labs.Keys) {
    $lab_info = $labs[$lab_key] -split '\|'
    $order = $lab_info[0]
    $title = $lab_info[1]
    $duration = $lab_info[2]
    $level = $lab_info[3]
    
    $source_file = "labs/$lab_key/README.md"
    $target_file = "_labs/$($order.PadLeft(2, '0'))-$lab_key.md"
    
    if (Test-Path $source_file) {
        Write-Host "Processing: $lab_key -> $target_file" -ForegroundColor Cyan
        
        # Read the source file
        $content = Get-Content $source_file -Raw
        
        # Create Jekyll front matter
        $front_matter = @"
---
layout: lab
title: "$title"
order: $order
duration: $duration
difficulty: $level
lab_type: main
permalink: /labs/$lab_key/
---

$content
"@
        
        # Write to target file
        $front_matter | Set-Content $target_file -Encoding UTF8
        Write-Host "✓ Created $target_file" -ForegroundColor Green
    } else {
        Write-Host "⚠ Warning: Source file not found: $source_file" -ForegroundColor Red
    }
}

Write-Host "`nConverting optional labs..." -ForegroundColor Yellow

foreach ($lab_key in $optional_labs.Keys) {
    $lab_info = $optional_labs[$lab_key] -split '\|'
    $title = $lab_info[0]
    $duration = $lab_info[1]
    $level = $lab_info[2]
    
    $source_file = "labs/$lab_key/README.md"
    $target_file = "_labs/optional-$lab_key.md"
    
    if (Test-Path $source_file) {
        Write-Host "Processing: $lab_key -> $target_file" -ForegroundColor Cyan
        
        # Read the source file
        $content = Get-Content $source_file -Raw
        
        # Create Jekyll front matter
        $front_matter = @"
---
layout: lab
title: "$title"
duration: $duration
difficulty: $level
lab_type: optional
permalink: /labs/$lab_key/
---

$content
"@
        
        # Write to target file
        $front_matter | Set-Content $target_file -Encoding UTF8
        Write-Host "✓ Created $target_file" -ForegroundColor Green
    } else {
        Write-Host "⚠ Warning: Source file not found: $source_file" -ForegroundColor Red
    }
}

Write-Host "`n✅ Lab conversion completed!" -ForegroundColor Green
Write-Host "Generated $(($labs.Count + $optional_labs.Count)) lab files in _labs directory" -ForegroundColor Green