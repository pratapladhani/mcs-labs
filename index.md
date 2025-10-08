---
layout: default
title: Home
---

# Microsoft Copilot Studio Labs

Welcome to the Microsoft Copilot Studio Labs! This collection of hands-on labs will guide you through building powerful AI agents using Microsoft Copilot Studio.

## 🎯 Learning Paths

### Core Learning Path
Start here to build your foundation in Copilot Studio:

1. **Agent Builder Web** - Your first web-based AI assistant
2. **Agent Builder SharePoint** - Connect to SharePoint data
3. **Setup for Success** - ALM Best Practices
4. **Public Website Agent** - Web scraping and analysis
5. **MBR SharePoint Agent** - Deploy agents to SharePoint
6. **Ask Me Anything** - Advanced conversation flows

### Advanced Labs
Build sophisticated autonomous agents and advanced scenarios:

7. **Autonomous Support Agent** - Customer service automation
8. **Autonomous Account News** - Intelligent news aggregation
9. **Autonomous CUA** - Computer-Using Agents
10. **Pipelines and Source Control** - ALM and DevOps practices
11. **Copilot Studio Kit** - Advanced tools and utilities

### Optional Labs
Specialized topics and alternative versions:

1. **Model Context Protocol Integration** - External system integration
2. **Ask Me Anything (30 min)** - Shorter version of the main lab

## 📚 All Labs

<div class="labs-grid">
{% assign labs = site.labs | sort: 'order' %}
{% for lab in labs %}
    <div class="lab-card">
        <h3><a href="{{ lab.url | relative_url }}">{{ lab.title }}</a></h3>
        <p>{{ lab.description | default: lab.excerpt | strip_html | truncate: 120 }}</p>
        <div class="lab-meta">
            {% if lab.duration %}<span>⏱️ {{ lab.duration }} min</span>{% endif %}
            {% if lab.difficulty %}<span>📊 {{ lab.difficulty }}</span>{% endif %}
        </div>
    </div>
{% endfor %}
</div>

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