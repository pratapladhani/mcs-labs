#!/bin/bash

# Lab Processing Script - Injects completion widgets during deployment
# This script processes lab markdown files and adds gamification elements

# ===================================================================
# LAB ORGANIZATION & LEARNING PROGRESSION
# ===================================================================
# Labs are organized into learning tracks for progressive skill building

# CORE LEARNING PATH - Required sequence for fundamental skills
declare -A core_labs=(
  ["agent-builder-web"]="Web-based AI Assistant with Agent Builder,100,100,1"
  ["agent-builder-sharepoint"]="Enterprise Data-based AI Assistant,150,100,2"  
  ["setup-for-success"]="ALM Best Practices Setup,200,200,3"
  ["ask-me-anything"]="Ask Me Anything Employee Agent,250,200,4"
  ["pipelines-and-source-control"]="Source Control and Deploy Agents,250,200,5"
)

# ADVANCED AUTONOMOUS TRACK - For automation mastery  
declare -A autonomous_labs=(
  ["autonomous-support-agent"]="Autonomous Support Agent,300,300,6"
  ["autonomous-cua"]="Autonomous Agent with Computer-Using Agents,300,300,7"
  ["autonomous-account-news"]="Autonomous Account News Assistant,300,300,8"
)

# SPECIALIZED USE CASES - Domain-specific applications
declare -A specialized_labs=(
  ["public-website-agent"]="Public Website Agent,200,200,9"
  ["mbr-prep-sharepoint-agent"]="MBR Agent Deploy to SharePoint,200,200,10"
  ["copilot-studio-kit"]="Copilot Studio Kit,200,200,11"
)

# OPTIONAL/ALTERNATIVE LABS - Shorter versions, external labs, bonus content
declare -A optional_labs=(
  ["ask-me-anything-30-mins"]="Ask Me Anything Agent (30 min version),150,200,alt"
  ["mcp-qualify-lead"]="Model Context Protocol Integration,200,300,bonus"
  ["measure-success"]="Measuring Agent Success,100,100,bonus"
  ["standard-orchestrator"]="Standard Orchestrator Pattern,150,200,bonus"
)

# Combine all labs for processing (format: "title,xp,level,order")
declare -A labs=()
for lab in "${!core_labs[@]}"; do labs["$lab"]="${core_labs[$lab]}"; done
for lab in "${!autonomous_labs[@]}"; do labs["$lab"]="${autonomous_labs[$lab]}"; done  
for lab in "${!specialized_labs[@]}"; do labs["$lab"]="${specialized_labs[$lab]}"; done
for lab in "${!optional_labs[@]}"; do labs["$lab"]="${optional_labs[$lab]}"; done

# Function to inject completion widget into markdown
inject_completion_widget() {
  local lab_id="$1"
  local title="$2"
  local xp="$3"
  local level="$4"
  local input_file="$5"
  local output_file="$6"
  
  # Create completion section to append
  local completion_section="

---

## 🎯 Complete This Lab

Congratulations! You've completed the **${title}** lab.

**Ready to earn your XP?**

<div style=\"background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 20px; border-radius: 10px; margin: 20px 0;\">
  <div style=\"display: flex; justify-content: space-between; align-items: center;\">
    <div>
      <h3 style=\"margin: 0 0 10px 0;\">🏆 Earn ${xp} XP</h3>
      <p style=\"margin: 0; opacity: 0.9;\">Level ${level} Lab Complete</p>
    </div>
    <div>
      <a href=\"https://pratapladhani.github.io/mcs-labs/${lab_id}.html\" 
         style=\"background: rgba(255,255,255,0.2); color: white; padding: 12px 20px; border-radius: 8px; text-decoration: none; font-weight: bold; border: 2px solid rgba(255,255,255,0.3);\">
        Mark Complete →
      </a>
    </div>
  </div>
</div>

**Alternative:** Visit the main [Lab Progress Tracker](https://pratapladhani.github.io/mcs-labs/) to track all your completed labs in one place.

---"
  
  # Copy original content and append completion section
  cp "$input_file" "$output_file"
  echo "$completion_section" >> "$output_file"
}

echo "🎮 Processing lab files with gamification..."

# Create lab directories
mkdir -p _site/labs

# Process each lab directory
for lab_dir in labs/*/; do
  if [ -d "$lab_dir" ]; then
    lab_name=$(basename "$lab_dir")
    
    # Skip if no README.md exists
    if [ ! -f "${lab_dir}README.md" ]; then
      echo "⚠️  Skipping $lab_name - no README.md found"
      continue
    fi
    
    # Get lab configuration or use defaults
    if [ "${labs[$lab_name]+isset}" ]; then
      IFS=',' read -ra config <<< "${labs[$lab_name]}"
      title="${config[0]}"
      xp="${config[1]}"
      level="${config[2]}"
    else
      title="$lab_name"
      xp="100"
      level="100"
      echo "⚠️  Using default config for $lab_name"
    fi
    
    echo "✅ Processing $lab_name ($title, ${xp}XP, Level $level)"
    
    # Create lab directory in output
    mkdir -p "_site/labs/$lab_name"
    
    # Inject completion widget into README.md
    inject_completion_widget "$lab_name" "$title" "$xp" "$level" "${lab_dir}README.md" "_site/labs/$lab_name/index.md"
    
    # Copy any additional files (images, assets, etc.)
    if [ -d "${lab_dir}images" ]; then
      cp -r "${lab_dir}images" "_site/labs/$lab_name/"
    fi
    if [ -d "${lab_dir}assets" ]; then
      cp -r "${lab_dir}assets" "_site/labs/$lab_name/"
    fi
    
    # Create individual completion pages
    cat > "_site/${lab_name}.html" << EOF
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Complete Lab: ${title}</title>
    <style>
        body { 
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            margin: 0;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .container { max-width: 600px; padding: 20px; }
        .back-link { 
            position: fixed; top: 20px; left: 20px; 
            background: rgba(255,255,255,0.2); color: white; 
            padding: 10px 15px; border-radius: 5px; 
            text-decoration: none; backdrop-filter: blur(10px);
        }
    </style>
</head>
<body>
    <a href="/" class="back-link">← Back to Dashboard</a>
    <div class="container">
        <script>
        window.LAB_CONFIG = {
            id: '${lab_name}',
            title: '${title}',
            xp: ${xp},
            level: ${level}
        };
        </script>
        <script src="./js/lab-completion-widget.js"></script>
    </div>
</body>
</html>
EOF
  fi
done

# Create API endpoint with all lab data
echo "📊 Creating lab data API..."
cat > "_site/api.json" << 'EOF'
{
  "labs": [
EOF

# Add each lab to the API
first=true
for lab_name in "${!labs[@]}"; do
  IFS=',' read -ra config <<< "${labs[$lab_name]}"
  title="${config[0]}"
  xp="${config[1]}"
  level="${config[2]}"
  
  if [ "$first" = true ]; then
    first=false
  else
    echo "," >> "_site/api.json"
  fi
  
  cat >> "_site/api.json" << EOF
    {"id": "$lab_name", "title": "$title", "xp": $xp, "level": $level}
EOF
done

cat >> "_site/api.json" << EOF
  ],
  "version": "1.0",
  "lastUpdated": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "totalLabs": ${#labs[@]},
  "totalXP": $(echo "${labs[@]}" | tr ',' '\n' | awk 'NR%3==2{sum+=$1}END{print sum}')
}
EOF

echo "🎉 Lab processing completed successfully!"
echo "📁 Generated files:"
find _site -type f -name "*.html" -o -name "*.json" -o -name "*.js" | head -20