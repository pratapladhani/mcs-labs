# Azure AI Workshop - Quick Start Guide

## 🎉 What's Been Implemented

I've successfully created a complete framework for the **MCS + Azure AI Workshop** in the feature branch `feature/azure-ai-workshop`. The implementation follows the same architectural pattern as your Bootcamp but is specifically designed for Azure AI integration content.

## 📁 What Was Created

### New Files
1. **Workshop Page**: `labs/azure-ai-workshop/index.md`
   - Main workshop landing page with dynamic content
   - Module overview and statistics
   - Lab card generation
   - Resources and support sections

2. **Workshop README**: `labs/azure-ai-workshop/README.md`
   - Quick reference guide
   - Current status
   - Usage instructions

3. **Documentation Files**:
   - `docs/AZURE_AI_WORKSHOP.md` - Complete architecture and implementation details
   - `docs/AZURE_AI_WORKSHOP_IMPLEMENTATION_GUIDE.md` - Step-by-step integration guide
   - `docs/AZURE_AI_WORKSHOP_SUMMARY.md` - Feature implementation summary

### Modified Files
1. **Navigation**: `_layouts/default.html`
   - Added "Azure AI Workshop" link to header menu

2. **Configuration**: `_data/lab-config.yml`
   - Added `azure_ai_workshop_lab_orders` section with 11 placeholder labs

## 🏗️ Workshop Structure

The workshop is organized into 4 progressive modules:

### Module 1: Foundation (Labs 1-2)
- Basic agent building and Azure setup

### Module 2: Azure AI Integration (Labs 3-5)
- Azure OpenAI, AI Search, Cognitive Services

### Module 3: Advanced Scenarios (Labs 6-8)
- Multi-agent orchestration, autonomous agents, custom connectors

### Module 4: Enterprise Readiness (Labs 9-11)
- ALM, testing, monitoring & analytics

## 🚀 How to Access

Once the lab content is ready, the workshop will be accessible at:
- **URL**: `/labs/azure-ai-workshop/`
- **Navigation**: Click "Azure AI Workshop" in the top header menu

## 📝 Current Status

✅ **Complete:**
- Workshop page template
- Navigation integration
- Configuration structure with placeholders
- Comprehensive documentation
- Feature branch with all changes committed

⏳ **Next Steps (When Labs Are Ready):**
1. Replace placeholder lab IDs with actual labs
2. Add lab metadata to `lab-config.yml`
3. Create lab content in respective folders
4. Run generation script
5. Test complete workshop flow

## 🛠️ Adding Lab Content (When Ready)

### Quick Steps:

1. **Create lab folder** (for new labs):
   ```
   labs/your-lab-id/
   ├── README.md
   └── images/
   ```

2. **Update lab metadata** in `_data/lab-config.yml`:
   ```yaml
   lab_metadata:
     61:  # Use number 60-80 for workshop labs
       id: "your-lab-id"
       title: "Your Lab Title"
       description: "Lab description"
       difficulty: "Intermediate (Level 200)"
       duration: 45
       section: "azure_ai_workshop"
   ```

3. **Update workshop sequence** in `azure_ai_workshop_lab_orders`:
   ```yaml
   azure_ai_workshop_lab_orders:
     1: "your-lab-id"  # Replace placeholder-lab-1
     # ... continue for all labs
   ```

4. **Generate content**:
   ```powershell
   pwsh -File scripts/Generate-Labs.ps1 -SkipPDFs
   ```

## 📚 Documentation Guide

### For Implementation Details
→ Read `docs/AZURE_AI_WORKSHOP_IMPLEMENTATION_GUIDE.md`
- Step-by-step instructions
- Configuration examples
- Testing procedures
- Troubleshooting

### For Architecture Understanding
→ Read `docs/AZURE_AI_WORKSHOP.md`
- System architecture
- File structure
- URL patterns
- Maintenance guidelines

### For Quick Reference
→ Read `labs/azure-ai-workshop/README.md`
- Workshop overview
- Quick testing steps
- Current status

## 🔧 Testing the Framework

You can test the framework right now (even without lab content):

```powershell
# Generate with current placeholders
pwsh -File scripts/Generate-Labs.ps1 -SkipPDFs

# Start development server
docker-compose up -d jekyll-dev

# Navigate to: http://localhost:4000/mcs-labs/labs/azure-ai-workshop/
```

The page will load with placeholder lab IDs, showing you the structure.

## 🌳 Branch Information

- **Branch Name**: `feature/azure-ai-workshop`
- **Based On**: `main`
- **Status**: Ready for lab content integration
- **Commit Hash**: `efa1b83` (Add Azure AI Workshop framework)

### Files Changed Summary:
- 7 files changed
- 1,308 insertions(+)
- 5 deletions(-)

## 🎨 Features

✅ **Dynamic Content Generation**
- Lab cards auto-generated from configuration
- Statistics calculated automatically
- Module-based organization

✅ **Theme Support**
- Works with Rich and Minimal themes
- Supports Light and Dark modes
- Responsive design

✅ **Independent System**
- Separate from Bootcamp and other journeys
- Dedicated navigation link
- Custom URL structure

✅ **Extensible Architecture**
- Easy to add new labs
- Reusable lab system
- Clear module structure

## 📋 Pre-Merge Checklist

When lab content is ready, verify:
- [ ] All placeholder lab IDs replaced
- [ ] Lab metadata complete
- [ ] All labs tested individually
- [ ] Complete workshop flow tested
- [ ] Documentation updated
- [ ] Screenshots added (if needed)
- [ ] User feedback incorporated

## 🤝 Key Design Decisions

1. **Progressive Numbering**: Uses simple 1, 2, 3... instead of 1a, 1b like Bootcamp
2. **Module-Based**: Clear 4-module structure for better organization
3. **Placeholder System**: Allows framework to be complete before content
4. **Pattern Reuse**: Follows Bootcamp pattern for consistency
5. **Independent Configuration**: Separate from other journeys to maintain clean separation

## 💡 Pro Tips

1. **Reuse Existing Labs**: You can include existing labs in the workshop sequence
2. **Mix and Match**: Combine existing labs with new Azure-specific content
3. **Module Focus**: Keep related labs together in each module
4. **Progressive Difficulty**: Start simple in Module 1, advance through Module 4

## 🔗 Related Documentation

- `docs/BOOTCAMP_NAVIGATION_SYSTEM.md` - Similar pattern reference
- `docs/DEVELOPMENT.md` - General development guide
- `docs/ADR.md` - Architecture decision records
- `docs/QUICK_START.md` - Project quick start

## ✨ What Makes This Special

This implementation gives you:
- **Complete framework** ready to accept lab content
- **Comprehensive documentation** for easy maintenance
- **Proven pattern** (same as Bootcamp)
- **Flexible structure** that can evolve as content develops
- **Professional organization** with 4 distinct learning modules

## 🎯 Next Actions

1. **Compile your lab content** - Focus on creating/identifying the labs
2. **Update configuration** - Replace placeholders when ready
3. **Test thoroughly** - Verify the complete workshop experience
4. **Gather feedback** - Iterate based on user experience

---

**Created**: October 21, 2025  
**Branch**: `feature/azure-ai-workshop`  
**Status**: ✅ Framework Complete - Ready for Lab Content  
**Documentation**: Comprehensive guides included

**Need Help?** Check the documentation files or review the implementation guide for detailed instructions.
