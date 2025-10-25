# Azure AI Workshop

## Overview

The **Azure AI Workshop** is a focused hands-on workshop that teaches Microsoft Copilot Studio integration with Azure AI services to build intelligent, enterprise-grade AI solutions.

**For event system architecture and technical implementation, see [Event System Documentation](./EVENT_SYSTEM.md).**

## Workshop Characteristics

- **Duration**: ~2-10 hours (depending on selected labs)
- **Difficulty**: Level 200-300 (Intermediate to Advanced)
- **Labs**: Currently 1 lab (expandable to 11 labs across 4 modules)
- **Focus**: Microsoft Copilot Studio + Azure AI integration
- **Target Audience**: Intermediate users with Azure AI knowledge

## Current Lab

| Module       | Lab                           | Duration | Difficulty | Description                                               |
| ------------ | ----------------------------- | -------- | ---------- | --------------------------------------------------------- |
| **Module 2** | Contract Alerts with Azure AI | 120 min  | 200        | Document Intelligence integration for contract monitoring |

## Planned Module Structure

The workshop is designed to expand into 4 progressive modules:

### Module 1: Foundation (Labs 1-2)

**Objective**: Basic agent building and Azure integration setup

- Introduction to Microsoft Copilot Studio
- Environment setup for Azure integration
- Azure subscription and service configuration
- Basic prompt engineering with Azure OpenAI

### Module 2: Azure AI Integration (Labs 3-5)

**Objective**: Connect Copilot Studio with Azure AI services

- **Contract Alerts with Azure AI** (Current lab)
  - Azure AI Document Intelligence integration
  - Automated contract analysis and deadline monitoring
  - Power Automate workflow integration
  - Email notification automation
  
- Azure OpenAI Service integration
- Azure AI Search connectivity
- Azure Cognitive Services usage

### Module 3: Advanced Scenarios (Labs 6-8)

**Objective**: Build complex multi-service solutions

- Multi-agent orchestration with Azure
- Autonomous agents leveraging Azure AI
- Custom connectors and advanced integrations
- Real-time data processing with Azure services

### Module 4: Enterprise Readiness (Labs 9-11)

**Objective**: Production deployment and governance

- Application Lifecycle Management (ALM)
- Testing and quality assurance frameworks
- Monitoring, analytics, and optimization
- Security and compliance best practices

## Learning Progression

### Entry Requirements

- Basic understanding of Microsoft Copilot Studio
- Access to Azure subscription (trial or paid)
- Familiarity with Power Platform basics
- Understanding of Azure AI Services (recommended)

### Skills Developed

By completing the workshop, participants will be able to:

- ✅ Integrate Azure AI services with Copilot Studio agents
- ✅ Process and analyze documents using Azure AI Document Intelligence
- ✅ Build automated workflows with Power Automate
- ✅ Monitor and trigger actions based on AI-extracted data
- ✅ Design enterprise-ready AI solutions with Azure backing
- ✅ Implement best practices for Azure AI integration

## Technical Details

**Event Configuration** (in `lab-config.yml`):

```yaml
event_configs:
  azure-ai-workshop:
    title: "☁️ Azure AI Workshop"
    config_key: "azure_ai_workshop_lab_orders"

azure_ai_workshop_lab_orders:
  1: "contract-alerts-azure-ai"
  # Future labs will be added here
```

**Event Page**: `/labs/azure-ai-workshop/`  
**Event Parameter**: `?event=azure-ai-workshop`  
**CSS Classes**: Generic `.event-*` classes (shared with all events)

## Delivery Formats

### Half-Day Workshop

- **Duration**: 2-3 hours
- **Content**: Module 2 (Contract Alerts lab only)
- **Format**: Instructor-led with hands-on exercises
- **Prerequisites**: Azure subscription pre-configured

### Full-Day Workshop

- **Duration**: 6-8 hours
- **Content**: Modules 1-2 or 2-3 (when available)
- **Format**: Mix of presentations and hands-on labs
- **Includes**: Breaks, Q&A sessions, troubleshooting support

### Multi-Day Workshop (Future)

- **Day 1**: Modules 1-2 (Foundation + Azure AI Integration)
- **Day 2**: Module 3 (Advanced Scenarios)
- **Day 3**: Module 4 (Enterprise Readiness)

## Prerequisites

- **Required**:
  - Access to Microsoft 365 environment
  - Copilot Studio license
  - Azure subscription with ability to create resources
  - Basic familiarity with Azure Portal

- **Recommended**:
  - Experience with Azure AI services
  - Understanding of document processing workflows
  - Familiarity with Power Automate
  - Knowledge of JSON and API concepts

## Resources

### Azure Services Used

- [Azure AI Document Intelligence](https://learn.microsoft.com/azure/ai-services/document-intelligence/)
- [Azure OpenAI Service](https://learn.microsoft.com/azure/ai-services/openai/)
- [Azure AI Search](https://learn.microsoft.com/azure/search/)
- [Azure Cognitive Services](https://learn.microsoft.com/azure/ai-services/)

### Microsoft Copilot Studio

- [Microsoft Copilot Studio Documentation](https://learn.microsoft.com/microsoft-copilot-studio/)
- [Generative Actions](https://learn.microsoft.com/microsoft-copilot-studio/advanced-generative-actions)
- [Power Automate Integration](https://learn.microsoft.com/microsoft-copilot-studio/advanced-flow)

## Success Metrics

By completing the available workshop content, participants should be able to:

- ✅ Configure Azure AI services for Copilot Studio integration
- ✅ Build document processing workflows with Azure AI Document Intelligence
- ✅ Create automated monitoring and notification systems
- ✅ Troubleshoot Azure AI integration issues
- ✅ Explain Azure AI value proposition for Copilot Studio solutions

## Expansion Roadmap

Future labs planned for full 11-lab workshop:

**Module 1 (Foundation)**:

- Lab 1: Copilot Studio + Azure OpenAI basics
- Lab 2: Environment setup and configuration

**Module 2 (Azure AI Integration)**:

- Lab 3: Contract Alerts (Current)
- Lab 4: Azure AI Search integration
- Lab 5: Multi-service orchestration

**Module 3 (Advanced Scenarios)**:

- Lab 6: Custom vision and image analysis
- Lab 7: Speech and language understanding
- Lab 8: Real-time data processing

**Module 4 (Enterprise Readiness)**:

- Lab 9: ALM and DevOps practices
- Lab 10: Testing frameworks
- Lab 11: Production monitoring and analytics

## Related Documentation

- **Architecture**: [Event System Documentation](./EVENT_SYSTEM.md)
- **Other Events**:
  - [Bootcamp](./BOOTCAMP.md) - Comprehensive Copilot Studio mastery
  - [MCS in a Day](./MCS_IN_A_DAY.md) - Fast-track one-day workshop

---

**Event Version**: 2.0 (Unified Event System)  
**Last Updated**: October 2025  
**Current Status**: 1 of 11 labs implemented

