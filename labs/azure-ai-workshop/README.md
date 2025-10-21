# MCS + Azure AI Workshop

This directory contains the Azure AI Workshop framework - a comprehensive hands-on workshop that combines Microsoft Copilot Studio with Azure AI services.

## Current Status

**Framework Status**: ✅ Complete  
**Lab Content Status**: ⏳ In Development  
**Configuration**: Using placeholder lab IDs

## Directory Structure

```
azure-ai-workshop/
├── index.md              # Main workshop page (Jekyll template)
└── README.md            # This file
```

## Workshop Organization

The workshop is structured into 4 progressive modules:

### Module 1: Foundation (Labs 1-2)
Getting started with agent building and Azure setup

### Module 2: Azure AI Integration (Labs 3-5)
Connecting to core Azure AI services

### Module 3: Advanced Scenarios (Labs 6-8)
Complex integrations and autonomous agents

### Module 4: Enterprise Readiness (Labs 9-11)
Deployment, testing, and monitoring

## How to Access

Once deployed, the workshop will be accessible at:
- **URL**: `/labs/azure-ai-workshop/`
- **Navigation**: Top menu → "Azure AI Workshop"

## Adding Lab Content

When lab content is ready:

1. **Create lab folders** in `labs/<lab-id>/` directory
2. **Update lab metadata** in `_data/lab-config.yml` under `lab_metadata` section
3. **Update workshop sequence** in `azure_ai_workshop_lab_orders` section
4. **Replace placeholder IDs** with actual lab identifiers
5. **Run generation script**: `pwsh -File scripts/Generate-Labs.ps1 -SkipPDFs`

## Configuration Reference

Workshop configuration is defined in `_data/lab-config.yml`:

```yaml
azure_ai_workshop_lab_orders:
  1: "placeholder-lab-1"
  2: "placeholder-lab-2"
  # ... etc
```

## Documentation

For complete implementation details, see:
- **Workshop Documentation**: [docs/AZURE_AI_WORKSHOP.md](../../docs/AZURE_AI_WORKSHOP.md)
- **Bootcamp Reference**: [docs/BOOTCAMP_NAVIGATION_SYSTEM.md](../../docs/BOOTCAMP_NAVIGATION_SYSTEM.md)
- **Development Guide**: [docs/DEVELOPMENT.md](../../docs/DEVELOPMENT.md)

## Testing

To test the workshop framework locally:

```powershell
# Generate content
pwsh -File scripts/Generate-Labs.ps1 -SkipPDFs

# Start development server
docker-compose up -d jekyll-dev

# Access at: http://localhost:4000/mcs-labs/labs/azure-ai-workshop/
```

## Notes

- The workshop follows the same architectural pattern as the Bootcamp
- Uses progressive numbering (1, 2, 3...) instead of special numbering (1a, 1b...)
- Completely independent from other journeys and bootcamp
- Supports both Rich and Minimal themes with Light and Dark modes

---

**Created**: October 21, 2025  
**Branch**: feature/azure-ai-workshop  
**Status**: Framework ready for lab content integration
