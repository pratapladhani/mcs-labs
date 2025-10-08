#!/bin/bash

# Smart Lab Converter - Reads from lab-config.yml for flexible lab ordering
# This approach makes it easy to add new labs and reorder without touching code

echo "🎓 Smart Lab Processing with Configuration-Driven Ordering..."

# Create _labs directory if it doesn't exist
mkdir -p _labs

# Function to extract lab info from YAML config
extract_lab_config() {
    local section="$1"
    local output_file="temp_${section}.txt"
    
    # Extract the section and parse it
    awk "
    /^${section}:/ { in_section=1; next }
    /^[a-z_]+:/ && in_section { in_section=0 }
    in_section && /- id:/ { 
        id=\$3; gsub(/\"/, \"\", id)
        getline; title=\$0; gsub(/.*\"/, \"\", title); gsub(/\".*/, \"\", title)
        getline; duration=\$2
        getline; difficulty=\$2
        getline; description=\$0; gsub(/.*\"/, \"\", description); gsub(/\".*/, \"\", description)
        print id \"|\" title \"|\" duration \"|\" difficulty \"|\" description
    }
    " lab-config.yml > "$output_file"
}

# Function to convert a lab
convert_lab() {
    local lab_info="$1"
    local order="$2"
    local is_optional="$3"
    
    IFS='|' read -r lab_id title duration difficulty description <<< "$lab_info"
    
    local source_file="labs/${lab_id}/README.md"
    local target_file="_labs/${lab_id}.md"
    
    if [[ -f "$source_file" ]]; then
        echo "  📄 Converting $lab_id (Order: $order)..."
        
        # Create front matter with proper order
        cat > "$target_file" << EOF
---
title: "$title"
order: $order
duration: $duration
difficulty: $difficulty
lab_id: "$lab_id"
optional: $is_optional
description: "$description"
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

# Extract lab configurations from YAML
echo "📖 Reading lab configuration from lab-config.yml..."

extract_lab_config "core_learning_path"
extract_lab_config "intermediate_labs" 
extract_lab_config "advanced_labs"
extract_lab_config "specialized_labs"
extract_lab_config "optional_labs"

# Process main labs in order
order=1
echo ""
echo "🔄 Converting main learning path labs..."

for section in "temp_core_learning_path.txt" "temp_intermediate_labs.txt" "temp_advanced_labs.txt" "temp_specialized_labs.txt"; do
    if [[ -f "$section" ]]; then
        while IFS= read -r lab_info; do
            if [[ ! -z "$lab_info" ]]; then
                convert_lab "$lab_info" "$order" "false"
                ((order++))
            fi
        done < "$section"
    fi
done

# Process optional labs
echo ""
echo "🔄 Converting optional labs..."
optional_order=1
if [[ -f "temp_optional_labs.txt" ]]; then
    while IFS= read -r lab_info; do
        if [[ ! -z "$lab_info" ]]; then
            convert_lab "$lab_info" "$optional_order" "true"
            ((optional_order++))
        fi
    done < "temp_optional_labs.txt"
fi

# Cleanup temp files
rm -f temp_*.txt

# Create API file for dynamic loading
echo "📊 Creating lab data API..."
cat > "_site/api.json" << 'EOF'
{
  "labs": [
EOF

first=true
for lab_file in _labs/*.md; do
    if [[ -f "$lab_file" ]]; then
        # Extract front matter
        lab_id=$(grep "lab_id:" "$lab_file" | sed 's/.*"\(.*\)".*/\1/')
        title=$(grep "title:" "$lab_file" | sed 's/.*"\(.*\)".*/\1/')
        order=$(grep "order:" "$lab_file" | sed 's/order: //')
        duration=$(grep "duration:" "$lab_file" | sed 's/duration: //')
        difficulty=$(grep "difficulty:" "$lab_file" | sed 's/difficulty: //')
        optional=$(grep "optional:" "$lab_file" | sed 's/optional: //')
        
        if [[ "$first" == true ]]; then
            first=false
        else
            echo "," >> "_site/api.json"
        fi
        
        echo "    {\"id\": \"$lab_id\", \"title\": \"$title\", \"order\": $order, \"duration\": $duration, \"difficulty\": \"$difficulty\", \"optional\": $optional}" >> "_site/api.json"
    fi
done

cat >> "_site/api.json" << 'EOF'

  ]
}
EOF

echo ""
echo "🎉 Smart lab processing completed!"
echo "📁 Generated files:"
ls -la _labs/*.md | wc -l | xargs echo "   - Lab files:"
echo "   - API: _site/api.json"
echo ""
echo "✨ Benefits of this approach:"
echo "   🔧 Easy to reorder labs - just edit lab-config.yml"
echo "   📚 Learning tracks defined for different user goals"
echo "   🔗 Prerequisites system prevents confusion"
echo "   🎯 New labs can be added by updating config only"
echo ""
echo "🚀 To add a new lab:"
echo "   1. Add lab entry to appropriate section in lab-config.yml"
echo "   2. Run this script again"
echo "   3. No code changes needed!"