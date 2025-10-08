---
layout: default
title: Home
---

# Microsoft Copilot Studio Labs

Welcome to hands-on labs for building AI agents with Microsoft Copilot Studio. Choose your learning path below or browse all labs.

## � **Choose Your Learning Journey**

<div class="learning-paths">

### 🌟 **Complete Learning Path** 
*Recommended for most users - follow the numbered sequence*

<div class="labs-grid main-path">
{% assign main_labs = site.labs | where: "optional", false | sort: "order" %}
{% for lab in main_labs %}
    <div class="lab-card {% if lab.order <= 3 %}beginner{% elsif lab.order <= 6 %}intermediate{% else %}advanced{% endif %}">
        <div class="lab-number">{{ lab.order }}</div>
        <div class="difficulty-badge {{ lab.difficulty | downcase }}">{{ lab.difficulty }}</div>
        <h3><a href="{{ lab.url | relative_url }}">{{ lab.title }}</a></h3>
        <p>{{ lab.description | default: lab.excerpt | strip_html | truncate: 100 }}</p>
        <div class="lab-meta">
            <span class="duration">⏱️ {{ lab.duration }} min</span>
            <span class="progress">{% if lab.order <= 3 %}Foundation{% elsif lab.order <= 6 %}Intermediate{% else %}Advanced{% endif %}</span>
        </div>
    </div>
{% endfor %}
</div>

### 🔖 **Optional & Specialized Labs**
*Explore when you're ready for specialized topics*

<div class="labs-grid optional-labs">
{% assign optional_labs = site.labs | where: "optional", true | sort: "order" %}
{% for lab in optional_labs %}
    <div class="lab-card optional">
        <div class="optional-badge">Optional</div>
        <h3><a href="{{ lab.url | relative_url }}">{{ lab.title }}</a></h3>
        <p>{{ lab.description | default: lab.excerpt | strip_html | truncate: 100 }}</p>
        <div class="lab-meta">
            <span class="duration">⏱️ {{ lab.duration }} min</span>
            <span class="difficulty">📊 {{ lab.difficulty }}</span>
        </div>
    </div>
{% endfor %}

<!-- External MCP Lab -->
<div class="lab-card external">
    <div class="external-badge">External Lab</div>
    <h3><a href="https://github.com/microsoft/mcsmcp" target="_blank">Model Context Protocol (MCP) & Copilot Studio (External)</a></h3>
    <p>Alternative MCP lab with full setup guide in external repository. Use this if you prefer the microsoft/mcsmcp approach.</p>
    <div class="lab-meta">
        <span class="duration">⏱️ 90 min</span>
        <span class="difficulty">📊 Advanced</span>
        <span class="external-link">🔗 External</span>
    </div>
</div>
</div>

</div>

---

## 🚀 **Quick Start Guides**

<div class="quick-start-cards">
    <div class="quick-card">
        <h4>🆕 New to Copilot Studio?</h4>
        <p>Start with <strong>Lab 1-3</strong> to build your foundation</p>
        <a href="/labs/agent-builder-web/" class="start-btn">Start Lab 1 →</a>
    </div>
    <div class="quick-card">
        <h4>🔧 Developer Focus?</h4>
        <p>Jump to <strong>ALM & DevOps</strong> practices</p>
        <a href="/labs/setup-for-success/" class="start-btn">Setup for Success →</a>
    </div>
    <div class="quick-card">
        <h4>🤖 Want Autonomous Agents?</h4>
        <p>Advanced automation starting at <strong>Lab 7</strong></p>
        <a href="/labs/autonomous-support-agent/" class="start-btn">Autonomous Labs →</a>
    </div>
</div>

---

## 💡 **How to Use These Labs**

- **📈 Progressive Learning**: Labs build on each other - follow the numbers for best experience
- **⏱️ Time Estimates**: Each lab shows expected completion time  
- **🎯 Skill Levels**: Foundation → Intermediate → Advanced progression
- **🔗 Prerequisites**: Earlier labs prepare you for advanced concepts
- **📱 Any Device**: Labs work on desktop, tablet, and mobile

**Ready to build amazing AI agents?** Pick your starting point above! 🎉

## 🚀 Getting Started

1. **Prerequisites**: Ensure you have access to Microsoft Copilot Studio
2. **Environment Setup**: Follow the "Setup for Success" lab first
3. **Choose Your Path**: Pick a learning path that matches your goals
4. **Build and Learn**: Work through labs at your own pace

## 💡 Tips for Success

- Complete labs in the suggested order for the best learning experience
- Take time to experiment with the concepts in each lab
- Join the community discussions for questions and insights
- Practice with your own use cases after completing each lab

Happy learning! 🎉