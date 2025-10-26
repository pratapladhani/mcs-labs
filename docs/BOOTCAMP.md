# Bootcamp Event

## Overview

The **Bootcamp Journey** is an intensive hands-on learning path covering the full spectrum of Microsoft Copilot Studio capabilities, from beginner agent building to advanced DevOps practices and autonomous AI systems.

**For event system architecture and technical implementation, see [Event System Documentation](./EVENT_SYSTEM.md).**

## Bootcamp Characteristics

- **Duration**: ~20 hours total (self-paced or multi-day workshop)
- **Difficulty**: Level 100 (Beginner) to Level 400 (Advanced)
- **Labs**: 10 comprehensive labs
- **Focus**: Comprehensive Copilot Studio mastery
- **Target Audience**: All skill levels, progressive learning path

## Special Numbering System

Bootcamp uses a unique alphanumeric numbering system to indicate parallel learning paths and skill progression:

```
1a, 1b → Agent Builder foundations (choose one or both)
2 → Setup for Success
3a, 3b → Live data integration paths
4 → Measure Success
5a, 5b → Advanced autonomous agents
6 → Data Fabric Agent
7 → Pipelines and Source Control
```

**Why This System?**
- **Parallel Paths**: Labs with same number but different letters (1a, 1b) can be done in any order
- **Skill Progression**: Numbers indicate overall progression through bootcamp
- **Flexibility**: Allows participants to choose paths based on their interests
- **Clear Dependencies**: Higher numbers build on lower numbers

## Lab Sequence

| Order  | Lab                              | Duration | Difficulty | Description                                    |
| ------ | -------------------------------- | -------- | ---------- | ---------------------------------------------- |
| **1a** | Agent Builder with SharePoint    | 30 min   | 100        | Declarative agent with SharePoint knowledge    |
| **1b** | Agent Builder with Web Search    | 75 min   | 100        | Declarative agent with web search capabilities |
| **2**  | Setup for Success                | 90 min   | 200        | Copilot Studio Kit, environment configuration  |
| **3a** | Public Website Agent             | 60 min   | 200        | Agent that searches public websites            |
| **3b** | Ask Me Anything (30 min version) | 30 min   | 200        | Quick knowledge base agent                     |
| **4**  | Measure Success                  | 60 min   | 300        | Analytics, monitoring, and metrics             |
| **5a** | Autonomous Support Agent         | 120 min  | 300        | Full autonomous agent with live conversations  |
| **5b** | Autonomous CUA Agent             | 120 min  | 300        | Customer account management autonomous agent   |
| **6**  | Data Fabric Agent                | 90 min   | 300        | Enterprise data integration patterns           |
| **7**  | Pipelines and Source Control     | 90 min   | 400        | DevOps practices, CI/CD for Copilot Studio     |

## Learning Progression

### Phase 1: Foundation (Labs 1a/1b, 2)
**Objective**: Understand declarative agents and environment setup

- Build first declarative agents (SharePoint or Web Search)
- Configure development environment with Copilot Studio Kit
- Understand basic prompt engineering
- Deploy agents to Microsoft Teams

### Phase 2: Data Integration (Labs 3a/3b)
**Objective**: Connect to various data sources

- Public website integration
- Knowledge base creation
- Data connector configuration
- Search and retrieval patterns

### Phase 3: Monitoring (Lab 4)
**Objective**: Measure agent effectiveness

- Analytics dashboards
- Conversation metrics
- User satisfaction tracking
- Performance optimization

### Phase 4: Autonomous AI (Labs 5a/5b)
**Objective**: Build advanced autonomous agents

- Live conversation handling
- Multi-turn dialogues
- Action-based automation
- Complex business scenarios

### Phase 5: Enterprise (Labs 6, 7)
**Objective**: Production-ready practices

- Enterprise data fabric patterns
- Source control integration
- CI/CD pipelines
- Team collaboration workflows

## Technical Details

**Event Configuration** (in `lab-config.yml`):

```yaml
event_configs:
  bootcamp:
    title: "⚔️ Bootcamp Journey"
    config_key: "bootcamp_lab_orders"

bootcamp_lab_orders:
  agent-builder-sharepoint: "1a"
  agent-builder-web: "1b"
  setup-for-success: "2"
  public-website-agent: "3a"
  ask-me-anything-30-mins: "3b"
  measure-success: "4"
  autonomous-support-agent: "5a"
  autonomous-cua: "5b"
  data-fabric-agent: "6"
  pipelines-and-source-control: "7"
```

**Event Page**: `/labs/bootcamp/`  
**Event Parameter**: `?event=bootcamp`  
**CSS Classes**: Generic `.event-*` classes (shared with all events)

## Delivery Formats

### Self-Paced Learning
- Participants work through labs at their own pace
- Complete all 10 labs over several weeks
- No facilitation required
- Access to lab documentation and troubleshooting guides

### Multi-Day Workshop
- **Day 1**: Labs 1a/1b, 2 (Foundation)
- **Day 2**: Labs 3a/3b, 4 (Data & Monitoring)
- **Day 3**: Labs 5a/5b (Autonomous AI)
- **Day 4**: Labs 6, 7 (Enterprise)

Each day ~4-5 hours with breaks

### Intensive Bootcamp (1 Week)
- Monday-Friday, 4 hours/day
- Includes instructor-led sessions
- Group exercises and peer learning
- Capstone project on Friday

## Prerequisites

- **Required**:
  - Access to Microsoft 365 environment
  - Copilot Studio license
  - Basic familiarity with Microsoft Teams

- **Recommended**:
  - Understanding of basic AI concepts
  - Experience with SharePoint (for lab 1a)
  - Familiarity with Power Platform (helpful but not required)

## Success Metrics

By completing Bootcamp, participants should be able to:
- ✅ Create and deploy declarative agents
- ✅ Integrate multiple data sources (SharePoint, web, knowledge bases)
- ✅ Configure development environments with best practices
- ✅ Monitor and measure agent effectiveness
- ✅ Build autonomous agents with live conversation handling
- ✅ Implement enterprise data fabric patterns
- ✅ Use source control and CI/CD for Copilot Studio projects

## Related Documentation

- **Architecture**: [Event System Documentation](./EVENT_SYSTEM.md)
- **Other Events**:
  - [Azure AI Workshop](./AZURE_AI_WORKSHOP.md) - Azure AI integration focus
  - [MCS in a Day](./MCS_IN_A_DAY.md) - Fast-track one-day workshop

---

**Event Version**: 2.0 (Unified Event System)  
**Last Updated**: October 2025
