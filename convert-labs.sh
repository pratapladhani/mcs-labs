#!/bin/bash

# Jekyll Lab Converter Script
# Converts existing labs to Jekyll format with front matter

echo "🔄 Converting labs to Jekyll format..."

# Create _labs directory if it doesn't exist
mkdir -p _labs

# Lab configuration with order, title, duration, and difficulty
declare -A labs=(
    ["agent-builder-web"]="1|Web-based AI Assistant with Agent Builder|45|Beginner"
    ["agent-builder-sharepoint"]="2|SharePoint AI Assistant with Agent Builder|60|Beginner"
    ["setup-for-success"]="3|ALM Best Practices Setup|60|Beginner"
    ["public-website-agent"]="4|Public Website Agent|90|Intermediate"
    ["mbr-prep-sharepoint-agent"]="5|MBR Agent Deploy to SharePoint|75|Intermediate"
    ["ask-me-anything"]="6|Ask Me Anything Agent|90|Intermediate"
    ["autonomous-support-agent"]="7|Autonomous Support Agent|120|Advanced"
    ["autonomous-account-news"]="8|Autonomous Account News Agent|120|Advanced"
    ["autonomous-cua"]="9|Autonomous Agent with Computer-Using Agents|150|Advanced"
    ["pipelines-and-source-control"]="10|Pipelines and Source Control|60|Intermediate"
    ["copilot-studio-kit"]="11|Copilot Studio Kit|60|Intermediate"
)

# Optional labs (will be marked differently)
declare -A optional_labs=(
    ["mcp-qualify-lead"]="1|Model Context Protocol Integration|90|Advanced"
    ["ask-me-anything-30-mins"]="2|Ask Me Anything Agent (30 min version)|30|Beginner"
    ["measure-success"]="3|Measure Success|45|Beginner"
    ["standard-orchestrator"]="4|Standard Orchestrator|75|Intermediate"
)

# Function to convert a lab
convert_lab() {
    local lab_id="$1"
    local lab_info="$2"
    local is_optional="$3"
    
    IFS='|' read -r order title duration difficulty <<< "$lab_info"
    
    local source_file="labs/${lab_id}/README.md"
    local target_file="_labs/${lab_id}.md"
    
    if [[ -f "$source_file" ]]; then
        echo "  📄 Converting $lab_id..."
        
        # Create front matter
        cat > "$target_file" << EOF
---
title: "$title"
order: $order
duration: $duration
difficulty: $difficulty
lab_id: "$lab_id"
optional: $is_optional
---

EOF
        
        # Skip the first heading if it exists and add the content
        tail -n +2 "$source_file" | sed '/^# /d' >> "$target_file"
        
        # Copy assets if they exist
        if [[ -d "labs/${lab_id}/images" ]]; then
            mkdir -p "assets/labs/${lab_id}"
            cp -r "labs/${lab_id}/images" "assets/labs/${lab_id}/"
            echo "    📁 Copied images for $lab_id"
            
            # Update image paths in the markdown
            sed -i "s|images/|/assets/labs/${lab_id}/images/|g" "$target_file"
        fi
        
        if [[ -d "labs/${lab_id}/assets" ]]; then
            mkdir -p "assets/labs/${lab_id}"
            cp -r "labs/${lab_id}/assets" "assets/labs/${lab_id}/"
            echo "    📁 Copied assets for $lab_id"
            
            # Update asset paths in the markdown
            sed -i "s|assets/|/assets/labs/${lab_id}/assets/|g" "$target_file"
        fi
        
        echo "    ✅ Converted $lab_id"
    else
        echo "    ⚠️  Source file not found: $source_file"
    fi
}

# Convert main labs
for lab_id in "${!labs[@]}"; do
    convert_lab "$lab_id" "${labs[$lab_id]}" "false"
done

# Convert optional labs
for lab_id in "${!optional_labs[@]}"; do
    convert_lab "$lab_id" "${optional_labs[$lab_id]}" "true"
done

echo ""
echo "🎉 Lab conversion completed!"
echo "📊 Total labs converted: $((${#labs[@]} + ${#optional_labs[@]}))"
echo ""
echo "🚀 To test locally:"
echo "   bundle install"
echo "   bundle exec jekyll serve"
echo "   Open http://localhost:4000"