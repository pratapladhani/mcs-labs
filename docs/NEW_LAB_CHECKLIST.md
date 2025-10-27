# New Lab Checklist

Quick reference guide for adding new labs to the MCS Labs repository.

## 🚨 Critical Warning

**Adding a lab folder alone is NOT enough!** You MUST update `lab-config.yml` in **FIVE** places or your lab will not appear anywhere on the site.

## 📋 Quick Overview: Where Labs Appear

Understanding where your lab will be visible helps you configure it correctly:

| Configuration Section            | What It Controls                          | Required?          |
| -------------------------------- | ----------------------------------------- | ------------------ |
| **lab_metadata**                 | Lab details (title, duration, difficulty) | ✅ ALWAYS           |
| **lab_orders**                   | Navigation order, prev/next buttons       | ✅ ALWAYS           |
| **lab_journeys**                 | Homepage journey cards visibility         | ✅ For journey labs |
| **bootcamp_lab_orders**          | Bootcamp event page                       | ⚠️ If event lab     |
| **azure_ai_workshop_lab_orders** | Azure AI Workshop page                    | ⚠️ If event lab     |
| **mcs_in_a_day_lab_orders**      | MCS in a Day page                         | ⚠️ If event lab     |

**Decision Tree**:
1. **Is this a standalone lab for self-paced learning?**
   - Add to: `lab_metadata`, `lab_orders`, `lab_journeys` (choose appropriate journeys)
   
2. **Is this for a specific event/workshop?**
   - Add to: `lab_metadata`, `lab_orders`, event-specific `_lab_orders`
   - **Don't** add to `lab_journeys` (events shouldn't appear on homepage)

3. **Is this for both general use AND events?**
   - Add to all relevant sections: `lab_metadata`, `lab_orders`, `lab_journeys`, plus event `_lab_orders`

**Configuration Flow**:
```
labs/your-lab-name/README.md (source content)
           ↓
    lab-config.yml updates:
           ↓
    ┌──────┴──────┐
    ↓             ↓
lab_metadata   lab_orders
    ↓             ↓
    └──────┬──────┘
           ↓
    Choose deployment:
           ↓
    ┌──────┴──────┬──────────────┐
    ↓             ↓              ↓
lab_journeys   Event Orders   Both
    ↓             ↓              ↓
Homepage      Event Pages    Everywhere
(Journey      (Bootcamp,     (Journey +
 Cards)        Workshop)      Event Pages)
```

## ✅ Complete Checklist

### 1. Create Lab Folder
```powershell
mkdir labs/your-lab-name
mkdir labs/your-lab-name/images
# Create labs/your-lab-name/README.md with content
```

### 2. Update lab-config.yml - lab_metadata

**Purpose**: Defines core lab properties - this is the single source of truth for lab information.

**Available Sections**:
- `core_learning_path` - Foundational labs (Levels 100-200)
- `advanced_topics` - Advanced labs (Levels 300-400)

**Available Difficulty Levels**:
- `Beginner (Level 100)` - New to Copilot Studio
- `Beginner to Intermediate (Level 100-200)` - Some Copilot Studio experience
- `Intermediate (Level 200)` - Comfortable with Copilot Studio basics
- `Intermediate to Advanced (Level 200-300)` - Ready for complex scenarios
- `Advanced (Level 300)` - Expert-level, complex integrations
- `Expert (Level 400)` - Cutting-edge, experimental features

```yaml
lab_metadata:
  6:  # Next available number (check existing entries - use next sequential number)
    id: "your-lab-name"  # MUST exactly match folder name in labs/
    title: "Your Lab Title"  # Full descriptive title shown on lab cards
    difficulty: "Beginner (Level 100)"  # Choose from levels above
    duration: 40  # Estimated completion time in minutes
    section: "core_learning_path"  # or "advanced_topics"
```

**How to choose the right number**:
```powershell
# Find the highest number currently used
Select-String -Path "lab-config.yml" -Pattern "^\s+\d+:" -Context 0,1 | Select-Object -Last 5
# Use next sequential number
```

### 3. Update lab-config.yml - lab_orders

**Purpose**: Controls the display order and prev/next navigation across ALL labs.

**Ordering Strategy**:
- Lower numbers appear first
- Numbers don't need to be sequential (gaps are fine)
- Group related labs with similar numbers
- Leave gaps (10, 20, 30) to allow inserting labs later

**How to choose order number**:
```powershell
# View current orders to find gaps
Select-String -Path "lab-config.yml" -Pattern "^\s+[a-z-]+:\s+\d+" -Context 0,0 | 
    ForEach-Object { $_.Line } | Sort-Object
```

```yaml
lab_orders:
  # Example: If existing orders are 1, 2, 3, 4, 11, 12...
  your-lab-name: 5  # Fill the gap OR use next available number
  
  # Best practice: Use multiples of 5 or 10 for easier reorganization
  # your-lab-name: 10
  # another-lab: 20
  # advanced-lab: 30
```

**💡 Tip**: Order affects the "Previous Lab" and "Next Lab" navigation buttons at the bottom of each lab page.

### 4. Update lab-config.yml - lab_journeys

**Purpose**: Assigns labs to learning journeys shown as cards on the homepage.

**Available Journeys** (choose one or more):
1. **`quick-start`** - First steps with Copilot Studio (15-30 min labs)
2. **`business-user`** - No-code/low-code solutions for business users
3. **`developer`** - Code-first, integration-focused labs for developers
4. **`autonomous-ai`** - Autonomous agents and advanced AI capabilities

**Journey Selection Guide**:
| Lab Type                             | Recommended Journey(s)                              |
| ------------------------------------ | --------------------------------------------------- |
| Basic setup, first agent             | `quick-start`                                       |
| Low-code connectors, SharePoint      | `business-user`, `quick-start`                      |
| Custom code, APIs, Azure integration | `developer`                                         |
| Autonomous agents, complex workflows | `autonomous-ai`, `developer`                        |
| Universal/foundational concepts      | All relevant journeys (labs can appear in multiple) |

```yaml
lab_journeys:
  quick-start:
    - "your-lab-name"  # Add to quick-start journey
  developer:
    - "your-lab-name"  # Same lab can appear in multiple journeys
  # business-user:
  #   - "your-lab-name"  # Add if relevant for business users
  # autonomous-ai:
  #   - "your-lab-name"  # Add if covers autonomous agent concepts
```

**⚠️ Important**:
- Labs in journeys appear on the homepage
- Order within journey is controlled by `lab_orders` (global ordering)
- Event labs (bootcamp/workshops) should NOT be added here
- A lab can appear in multiple journeys

### 5. Update Event Orders (if applicable)

**Purpose**: Defines custom lab sequences for specific events/workshops.

**When to add to events**:
- Lab is specifically designed for an event curriculum
- Lab fits the event's learning objectives and time constraints
- Lab complements other labs in the event sequence

**Available Events**:

#### A. **Bootcamp** (bootcamp_lab_orders)
- **Target Audience**: Comprehensive 2-3 day training
- **Typical Duration**: Full progression from basics to advanced
- **Lab Selection**: Progressive difficulty, hands-on building

```yaml
bootcamp_lab_orders:
  1: "your-lab-name"  # Use sequential numbers (1, 2, 3...)
  # Order determines the lab sequence in the bootcamp
  # Check existing entries to find next available number
```

#### B. **Azure AI Workshop** (azure_ai_workshop_lab_orders)
- **Target Audience**: Azure-focused developers
- **Typical Duration**: Half-day to full-day workshop
- **Lab Selection**: Azure integration, AI services, advanced features

```yaml
azure_ai_workshop_lab_orders:
  1: "your-lab-name"  # Sequential ordering
  # Focus: Azure AI services, custom connectors, advanced integrations
```

#### C. **MCS in a Day** (mcs_in_a_day_lab_orders)
- **Target Audience**: Quick introduction to MCS capabilities
- **Typical Duration**: 2-4 hours total
- **Lab Selection**: Short labs (15-40 min), core concepts, quick wins

```yaml
mcs_in_a_day_lab_orders:
  1: "your-lab-name"  # Sequential ordering
  # Total event duration target: ~2-3 hours
  # Individual lab duration: 15-40 minutes recommended
```

**⚠️ Event Assignment Best Practices**:

1. **Check total event duration**:
```powershell
# Calculate current total for an event
Select-String -Path "lab-config.yml" -Pattern "mcs_in_a_day_lab_orders:" -Context 0,10
# Then manually sum durations from lab_metadata
```

2. **Maintain logical progression**:
   - Earlier labs should introduce concepts
   - Later labs should build on previous knowledge
   - Avoid dependencies that break the sequence

3. **Consider prerequisites**:
   - Don't add advanced labs early in sequence
   - Ensure earlier labs cover required setup

4. **Event-specific considerations**:
   - **Bootcamp**: Can include longer labs (45-90 min), full spectrum
   - **Azure AI Workshop**: Focus on Azure services, assume Azure knowledge
   - **MCS in a Day**: Shorter labs only, fast-paced, high-impact demos

**Example: Adding to multiple events**:
```yaml
# If lab works for multiple events with different positioning
bootcamp_lab_orders:
  5: "your-lab-name"  # Mid-bootcamp position

mcs_in_a_day_lab_orders:
  2: "your-lab-name"  # Early in MCS day (if short & impactful)

# azure_ai_workshop_lab_orders:
#   (not included - doesn't use Azure services)
```

**How to find next available event number**:
```powershell
# For bootcamp
Select-String -Path "lab-config.yml" -Pattern "bootcamp_lab_orders:" -Context 0,15

# For Azure AI Workshop
Select-String -Path "lab-config.yml" -Pattern "azure_ai_workshop_lab_orders:" -Context 0,15

# For MCS in a Day
Select-String -Path "lab-config.yml" -Pattern "mcs_in_a_day_lab_orders:" -Context 0,10
```

### 6. Generate and Test
```powershell
# Generate lab files
.\scripts\Generate-Labs.ps1 -SkipPDFs

# Restart Docker
docker-compose down
docker-compose up -d

# Visit: http://localhost:4000/mcs-labs/
```

### 7. Verify Lab Appears
- ✅ Shows in "All Labs" page
- ✅ Shows in assigned journey cards
- ✅ Metadata correct (title, duration, difficulty)
- ✅ Navigation works (prev/next buttons)
- ✅ Images display
- ✅ Shows in event pages (if assigned)

### 8. Generate PDFs Before Commit
```powershell
.\scripts\Generate-Labs.ps1 -GeneratePDFs
# Check: assets/pdfs/your-lab-name.pdf
```

## 🚫 Common Mistakes

| Mistake                     | Result                      |
| --------------------------- | --------------------------- |
| Folder only, no config      | Lab won't appear anywhere   |
| Metadata only, no orders    | Broken navigation           |
| Journeys only, no metadata  | Jekyll build errors         |
| Different id vs folder name | Lab not found, broken links |
| No local testing            | CI failures, broken prod    |

## 💡 Pro Tips

**Search existing lab configs:**
```powershell
Select-String -Path "lab-config.yml" -Pattern "agent-builder-web"
```

**Test single lab PDF:**
```powershell
.\scripts\Generate-Labs.ps1 -SingleLabPDF "your-lab-name" -GeneratePDFs
```

**Audit for missing configs:**
```powershell
# List lab folders
Get-ChildItem -Path "labs\" -Directory | Select-Object Name

# Compare with config entries
Select-String -Path "lab-config.yml" -Pattern 'id: "([^"]+)"' -AllMatches
```

## 📚 Full Documentation

See `docs/DEVELOPMENT.md` for complete details and examples.

## 🔄 Regular Maintenance

**The audit runs automatically** every time you execute `Generate-Labs.ps1`, so configuration issues are caught early!

### Manual Audit

You can also run the audit script independently:

```powershell
# Basic audit
.\scripts\Check-LabConfigs.ps1

# Verbose mode (shows lab titles)
.\scripts\Check-LabConfigs.ps1 -Verbose
```

### Automated Checks

✅ **Built into Generate-Labs.ps1**: The lab config audit runs automatically at the start of every generation
- Checks all lab folders have config entries
- Detects orphaned configs (configs without folders)
- Excludes external labs intentionally without folders
- **Fails fast** if issues found - generation won't proceed

This ensures you can't accidentally generate the site with missing or incorrect lab configurations!

```powershell
# PowerShell script to find labs without config entries
$folders = (Get-ChildItem -Path "labs\" -Directory).Name | 
    Where-Object { $_ -ne "bootcamp" -and $_ -ne "azure-ai-workshop" -and $_ -ne "mcs-in-a-day" }

$configIds = (Select-String -Path "lab-config.yml" -Pattern 'id: "([^"]+)"' -AllMatches).Matches | 
    ForEach-Object { $_.Groups[1].Value }

$missingConfigs = $folders | Where-Object { $_ -notin $configIds }

if ($missingConfigs) {
    Write-Host "⚠️ Labs missing config entries:" -ForegroundColor Yellow
    $missingConfigs | ForEach-Object { Write-Host "  - $_" -ForegroundColor Red }
} else {
    Write-Host "✅ All labs have config entries" -ForegroundColor Green
}
```

Save this as `scripts/Check-LabConfigs.ps1` and run periodically.

---

## 📝 Real-World Examples

### Example 1: Quick Start Lab for Homepage

**Scenario**: Creating a beginner-friendly 20-minute lab for new users.

**Configuration**:
```yaml
# lab_metadata
6:
  id: "first-copilot-agent"
  title: "Build Your First Copilot Agent in 20 Minutes"
  difficulty: "Beginner (Level 100)"
  duration: 20
  section: "core_learning_path"

# lab_orders
first-copilot-agent: 1  # First lab in overall sequence

# lab_journeys
quick-start:
  - "first-copilot-agent"
business-user:
  - "first-copilot-agent"  # Also suitable for business users
```

**Result**: Appears on homepage in Quick Start and Business User journeys, shows as first lab in navigation.

---

### Example 2: Event-Only Workshop Lab

**Scenario**: Azure-focused integration lab for half-day workshop (45 min).

**Configuration**:
```yaml
# lab_metadata
7:
  id: "azure-ai-integration"
  title: "Integrate Azure AI Services with Copilot Studio"
  difficulty: "Intermediate to Advanced (Level 200-300)"
  duration: 45
  section: "advanced_topics"

# lab_orders
azure-ai-integration: 25  # Somewhere in middle of overall sequence

# lab_journeys
# NOT ADDED - event-only lab shouldn't appear on homepage

# azure_ai_workshop_lab_orders
3: "azure-ai-integration"  # Third lab in Azure workshop
```

**Result**: Only appears in Azure AI Workshop event page, not on homepage journeys.

---

### Example 3: Universal Lab (Journeys + Multiple Events)

**Scenario**: Agent builder fundamentals useful everywhere (30 min).

**Configuration**:
```yaml
# lab_metadata
8:
  id: "agent-fundamentals"
  title: "Understanding Agent Architecture and Best Practices"
  difficulty: "Intermediate (Level 200)"
  duration: 30
  section: "core_learning_path"

# lab_orders
agent-fundamentals: 10

# lab_journeys
developer:
  - "agent-fundamentals"
autonomous-ai:
  - "agent-fundamentals"

# bootcamp_lab_orders
4: "agent-fundamentals"

# mcs_in_a_day_lab_orders
2: "agent-fundamentals"
```

**Result**: Appears in Developer and Autonomous AI homepage journeys, plus Bootcamp (Lab 4) and MCS in a Day (Lab 2) events.

---

### Example 4: Short Demo Lab for MCS in a Day

**Scenario**: Quick 15-minute demo for time-constrained workshop.

**Configuration**:
```yaml
# lab_metadata
9:
  id: "quick-sharepoint-agent"
  title: "5-Minute SharePoint Agent Demo"
  difficulty: "Beginner (Level 100)"
  duration: 15
  section: "core_learning_path"

# lab_orders
quick-sharepoint-agent: 6

# lab_journeys
quick-start:
  - "quick-sharepoint-agent"

# mcs_in_a_day_lab_orders
1: "quick-sharepoint-agent"  # Perfect opener for short event
```

**Result**: Homepage Quick Start journey + MCS in a Day opener (Lab 1).

---

## 🎯 Configuration Decision Matrix

| Lab Characteristics            | lab_metadata | lab_orders | lab_journeys               | bootcamp       | azure_workshop | mcs_day        |
| ------------------------------ | ------------ | ---------- | -------------------------- | -------------- | -------------- | -------------- |
| **New beginner lab (20 min)**  | ✅            | ✅          | quick-start, business-user | Maybe          | No             | Yes            |
| **Azure integration (45 min)** | ✅            | ✅          | developer                  | Maybe          | ✅              | No             |
| **Autonomous agent (60 min)**  | ✅            | ✅          | autonomous-ai, developer   | ✅              | Maybe          | No             |
| **Quick demo (15 min)**        | ✅            | ✅          | quick-start                | No             | No             | ✅              |
| **Advanced MCP (90 min)**      | ✅            | ✅          | developer                  | ✅              | Maybe          | No             |
| **Event-specific only**        | ✅            | ✅          | None                       | Event-specific | Event-specific | Event-specific |

---

## 🔍 Troubleshooting

### "My lab doesn't appear anywhere"
**Check**: Did you add to `lab_metadata`? This is required for ALL labs.

### "Lab appears but navigation is broken"
**Check**: Did you add to `lab_orders`? This controls prev/next buttons.

### "Lab not on homepage"
**Check**: Did you add to `lab_journeys`? Only labs in journeys appear on homepage cards.

### "Lab shows in wrong event"
**Check**: Verify event-specific `_lab_orders` sections. Remove from events where it shouldn't appear.

### "Lab title/duration wrong"
**Check**: Update `lab_metadata` and regenerate with `.\scripts\Generate-Labs.ps1 -SkipPDFs`

### "Lab appears in wrong order"
**Check**: Review `lab_orders` numbers. Lower = earlier in sequence.

---

## ✅ Final Checklist Before Commit

- [ ] Lab folder created with README.md and images/
- [ ] Added to `lab_metadata` with correct section and difficulty
- [ ] Added to `lab_orders` with appropriate number
- [ ] Added to `lab_journeys` (if homepage lab) OR event orders (if event lab)
- [ ] Ran `.\scripts\Generate-Labs.ps1 -SkipPDFs`
- [ ] Tested locally at http://localhost:4000/mcs-labs/
- [ ] Verified lab appears in expected locations
- [ ] Checked prev/next navigation works
- [ ] Generated PDFs with `.\scripts\Generate-Labs.ps1 -GeneratePDFs`
- [ ] Ran `.\scripts\Check-LabConfigs.ps1` (no errors)
- [ ] Committed changes to feature branch
