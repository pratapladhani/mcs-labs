#!/bin/bash

# Jekyll Lab Converter Script
# Converts existing labs to Jekyll format with front matter

echo "🔄 Converting labs to Jekyll format..."

# Create _labs directory if it doesn't exist
mkdir -p _labs

# Lab configuration with order, title, duration, and difficulty
declare -A labs=(
    ["setup-for-success"]="1|ALM Best Practices Setup|60|Beginner"
    ["agent-builder-web"]="2|Web-based AI Assistant with Agent Builder|45|Beginner"
    ["agent-builder-sharepoint"]="3|SharePoint AI Assistant with Agent Builder|60|Beginner"
    ["ask-me-anything"]="4|Ask Me Anything Agent|90|Intermediate"
    ["autonomous-support-agent"]="5|Autonomous Support Agent|120|Advanced"
    ["autonomous-cua"]="6|Autonomous Agent with Computer-Using Agents|150|Advanced"
    ["autonomous-account-news"]="7|Autonomous Account News Agent|120|Advanced"
    ["public-website-agent"]="8|Public Website Agent|90|Intermediate"
    ["standard-orchestrator"]="9|Standard Orchestrator|75|Intermediate"
    ["mcp-qualify-lead"]="10|Model Context Protocol Integration|90|Advanced"
    ["copilot-studio-kit"]="11|Copilot Studio Kit|60|Intermediate"
    ["mbr-prep-sharepoint-agent"]="12|MBR Agent Deploy to SharePoint|75|Intermediate"
)

# Optional labs (will be marked differently)
declare -A optional_labs=(
    ["ask-me-anything-30-mins"]="13|Ask Me Anything Agent (30 min version)|30|Beginner"
    ["measure-success"]="14|Measure Success|45|Beginner"
    ["pipelines-and-source-control"]="15|Pipelines and Source Control|60|Intermediate"
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