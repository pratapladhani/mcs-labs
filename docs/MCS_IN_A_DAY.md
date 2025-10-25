# MCS in a Day

## Overview

**MCS in a Day** is a comprehensive full-day workshop that delivers essential Microsoft Copilot Studio skills through 5 progressive hands-on labs. This intensive training takes participants from beginner to intermediate level in approximately 6 hours of hands-on learning.

**For event system architecture and technical implementation, see [Event System Documentation](./EVENT_SYSTEM.md).**

## Event Characteristics

- **Duration**: Full day (9:00 AM - 4:15 PM with breaks)
- **Target Audience**: Beginners to intermediate users
- **Labs**: 5 hands-on labs
- **Format**: Instructor-led workshop with progressive learning
- **Prerequisites**:
  - No prior Copilot Studio experience required
  - Access to Microsoft 365 environment with Copilot Studio license
  - Basic familiarity with Microsoft Teams for agent deployment

## Schedule

| Time            | Lab                                  | Duration | Description                                                                   |
| --------------- | ------------------------------------ | -------- | ----------------------------------------------------------------------------- |
| 09:00-10:15     | Lab 1: Agent Builder with Web Search | 75 min   | Build your first declarative agent using web search capabilities              |
| 10:30-11:30     | Lab 2: Public Website Agent          | 60 min   | Create an agent that searches and retrieves information from public websites  |
| 11:30-12:00     | Lab 3: Agent Builder with SharePoint | 30 min   | Integrate SharePoint as a knowledge source for your agent                     |
| **12:00-13:00** | **Lunch Break**                      | -        | -                                                                             |
| 13:00-14:00     | Lab 4: Ask Me Anything Agent         | 60 min   | Build a knowledge base agent for FAQ and internal documentation               |
| 14:15-16:15     | Lab 5: Autonomous Support Agent      | 120 min  | Advanced lab creating an autonomous agent with live conversations and actions |

**Total Learning Time**: 6 hours (345 minutes)

## Learning Progression

### Morning Session (Foundation Skills)

- Introduction to declarative agents
- Web search integration
- Public website data sources
- SharePoint knowledge integration

### Afternoon Session (Advanced Capabilities)

- Knowledge base management
- FAQ and internal documentation agents
- Autonomous AI agents
- Live conversation handling
- Action-based automation

## Lab Details

### Lab 1: Agent Builder with Web Search (75 min)

**Difficulty**: Level 100 (Beginner)

- Create declarative agents using web search
- Learn prompt engineering basics
- Test and deploy your first agent

### Lab 2: Public Website Agent (60 min)

**Difficulty**: Level 200 (Intermediate)

- Search and retrieve information from specific public websites
- Configure website connectors
- Handle structured data from web sources

### Lab 3: Agent Builder with SharePoint (30 min)

**Difficulty**: Level 100 (Beginner)

- Connect to SharePoint as knowledge source
- Configure SharePoint connectors
- Quick integration exercise building on previous labs

### Lab 4: Ask Me Anything Agent (60 min)

**Difficulty**: Level 200 (Intermediate)

- Build knowledge base agents for FAQ scenarios
- Upload and manage internal documentation
- Create conversational FAQ experiences

### Lab 5: Autonomous Support Agent (120 min)

**Difficulty**: Level 300 (Advanced)

- Most comprehensive lab of the day
- Create autonomous agents with live conversation handling
- Implement actions and automation
- Real-world support agent scenario

## Technical Details

**Event Configuration** (in `lab-config.yml`):

```yaml
event_configs:
  mcs-in-a-day:
    title: "⚡ MCS in a Day"
    config_key: "mcs_in_a_day_lab_orders"

mcs_in_a_day_lab_orders:
  1: "agent-builder-web"        # 75 min - Web search agent
  2: "public-website-agent"      # 60 min - Public website data
  3: "agent-builder-sharepoint"  # 30 min - SharePoint integration
  4: "ask-me-anything"           # 60 min - Knowledge base agent
  5: "autonomous-support-agent"  # 120 min - Autonomous AI agent
```

**Event Page**: `/labs/mcs-in-a-day/`  
**Event Parameter**: `?event=mcs-in-a-day`  
**CSS Classes**: Generic `.event-*` classes (shared with all events)

## Facilitator Guidance

### Preparation Checklist

**Before the Event:**

- [ ] Verify all participants have Copilot Studio licenses
- [ ] Test lab environments and prerequisites
- [ ] Prepare SharePoint site with sample documents (Lab 3)
- [ ] Set up support channels (Teams chat, facilitator contact)
- [ ] Print or share lab URLs for easy access

**Day-of Setup:**

- [ ] Ensure stable internet connectivity
- [ ] Test screen sharing and presentation tools
- [ ] Have backup plans for common technical issues
- [ ] Prepare breaks schedule (morning break, lunch, afternoon break)

### Facilitation Tips

**Morning Session:**

1. Start with overview of Copilot Studio capabilities
2. Lab 1 is the foundation - ensure everyone completes it
3. Lab 2 builds directly on Lab 1 concepts
4. Lab 3 is quick (30 min) - good buffer before lunch

**Lunch Break:**

- Encourage networking and questions
- Provide time for slower participants to catch up
- Be available for one-on-one help

**Afternoon Session:**

1. Lab 4 introduces knowledge bases - critical concept
2. Lab 5 is the most complex - allow extra time if needed
3. Encourage peer collaboration
4. Have extension activities ready for fast finishers

### Common Issues & Solutions

| Issue                         | Solution                                                    |
| ----------------------------- | ----------------------------------------------------------- |
| License activation delays     | Have admin contact ready, prepare trial environments        |
| SharePoint connector failures | Pre-configure SharePoint sites, test connections beforehand |
| Slow progress in Lab 5        | Prepared checkpoints allow starting from intermediate state |
| Network connectivity issues   | Offline documentation, mobile hotspot backup                |

## Success Metrics

### Participant Outcomes

By the end of the day, participants should be able to:

- ✅ Create and deploy declarative agents
- ✅ Integrate web search and public website data
- ✅ Connect SharePoint as a knowledge source
- ✅ Build knowledge base agents for FAQ scenarios
- ✅ Understand autonomous agent concepts and basic implementation

### Evaluation Points

- **Morning**: Can participants create a working declarative agent?
- **Mid-day**: Do participants understand different data source types?
- **Afternoon**: Can participants explain when to use autonomous agents?
- **End of day**: Have participants completed at least 4 of 5 labs?

## Additional Resources

### For Facilitators

- [Microsoft Copilot Studio Documentation](https://learn.microsoft.com/microsoft-copilot-studio/)
- [Get Started Guide](https://learn.microsoft.com/microsoft-copilot-studio/fundamentals-get-started)
- [Autonomous Agents Overview](https://learn.microsoft.com/microsoft-copilot-studio/advanced-autonomous-agents)

### For Participants

- [Microsoft 365 Copilot Extensibility](https://learn.microsoft.com/microsoft-365-copilot/extensibility/)
- [Copilot Studio Community](https://powerusers.microsoft.com/t5/Copilot-Studio-Community/ct-p/PVACommunity)
- [Power Platform Learning Paths](https://learn.microsoft.com/training/powerplatform/)

## Customization Options

### Shorter Workshop (Half Day)

Reduce to 3 core labs:

1. Agent Builder with Web Search (75 min)
2. Public Website Agent (60 min)
4. Ask Me Anything Agent (60 min)

**Total**: ~3 hours plus breaks

### Extended Workshop (1.5 Days)

Add additional labs from Bootcamp journey:

- Data Fabric Agent
- Dataverse MCP Connector
- Pipelines and Source Control

### Industry-Specific Variants

- **Healthcare**: Focus on patient FAQ and appointment agents
- **Retail**: Product information and customer support agents
- **Finance**: Document analysis and compliance agents

## Related Documentation

- **Architecture**: [Event System Documentation](./EVENT_SYSTEM.md)
- **Other Events**:
  - [Bootcamp](./BOOTCAMP.md) - Comprehensive Copilot Studio mastery
  - [Azure AI Workshop](./AZURE_AI_WORKSHOP.md) - Azure AI integration focus

---

**Event Version**: 2.0 (Unified Event System)  
**Last Updated**: October 2025

