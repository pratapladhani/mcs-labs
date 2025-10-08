---
layout: default
title: Quick Start Journey
permalink: /journeys/quick-start/
---

# 🚀 Quick Start Journey

**Get results fast with practical demos and POCs**

Perfect for busy professionals who need to demonstrate Copilot Studio capabilities quickly. These labs focus on immediate, visible results that can be shown to stakeholders or used as proof-of-concepts.

## 🎯 **Journey Overview**

- **Duration**: 30-90 minutes per lab
- **Difficulty**: Level 100-200 (Beginner to Intermediate)
- **Focus**: Rapid prototyping and demonstrations
- **Outcome**: Working AI agents you can demo immediately

---

## 📚 **Labs in This Journey**

<div class="labs-grid journey-section">
{% assign quick_start_labs = site.labs | where: "lab_type", "main" | sort: "difficulty" %}
{% for lab in quick_start_labs %}
  {% if lab.journeys contains "quick-start" %}
    <div class="lab-card {% if lab.difficulty <= 100 %}beginner{% elsif lab.difficulty <= 200 %}intermediate{% else %}advanced{% endif %}">
        <div class="journey-badges">
            {% for journey in lab.journeys %}
                <span class="journey-badge journey-{{ journey }}">{{ journey | replace: '-', ' ' | capitalize }}</span>
            {% endfor %}
        </div>
        <div class="difficulty-badge level-{{ lab.difficulty }}">Level {{ lab.difficulty }}</div>
        <h3><a href="{{ lab.url | relative_url }}">{{ lab.title }}</a></h3>
        <p>{{ lab.description | default: lab.excerpt | strip_html | truncate: 100 }}</p>
        <div class="lab-meta">
            <span class="duration">⏱️ {{ lab.duration }} min</span>
            <span class="progress">{% if lab.difficulty <= 100 %}Foundation{% elsif lab.difficulty <= 200 %}Intermediate{% else %}Advanced{% endif %}</span>
        </div>
        <div class="lab-actions">
            <a href="{{ lab.url | relative_url }}" class="btn-primary">🌐 View Lab</a>
        </div>
    </div>
  {% endif %}
{% endfor %}
</div>

<div class="labs-grid optional-labs">
{% assign optional_labs = site.labs | where: "lab_type", "optional" | sort: "order" %}
{% for lab in optional_labs %}
  {% if lab.journeys contains "quick-start" %}
    <div class="lab-card optional">
        <div class="optional-badge">Optional</div>
        <h3><a href="{{ lab.url | relative_url }}">{{ lab.title }}</a></h3>
        <p>{{ lab.description | default: lab.excerpt | strip_html | truncate: 100 }}</p>
        <div class="lab-meta">
            <span class="duration">⏱️ {{ lab.duration }} min</span>
            <span class="difficulty">📊 Level {{ lab.difficulty }}</span>
        </div>
        <div class="lab-actions">
            <a href="{{ lab.url | relative_url }}" class="btn-primary">🌐 View Lab</a>
        </div>
    </div>
  {% endif %}
{% endfor %}
</div>

---

## 🗺️ **Recommended Path**

1. **Start Here**: [Web-based AI Assistant](/mcs-labs/labs/agent-builder-web/) - Your first agent (45 min)
2. **Add Data**: [SharePoint AI Assistant](/mcs-labs/labs/agent-builder-sharepoint/) - Connect to real data (60 min)
3. **Go Public**: [Public Website Agent](/mcs-labs/labs/public-website-agent/) - Web scraping agent (90 min)
4. **Quick Alternative**: [Ask Me Anything (30 min)](/mcs-labs/labs/ask-me-anything-30-mins/) - Shorter version (Optional)

---

## 🎉 **What You'll Build**

By the end of this journey, you'll have:

- ✅ A working web-based AI assistant
- ✅ An agent that can query SharePoint data
- ✅ A public-facing agent that analyzes websites
- ✅ Hands-on experience with core Copilot Studio features
- ✅ Demonstrable prototypes for stakeholders

---

## 🚀 **Ready to Start?**

<div class="journey-actions">
    <a href="/mcs-labs/labs/agent-builder-web/" class="btn-primary btn-large">Start Lab 1: Web-based AI Assistant →</a>
    <a href="/mcs-labs/" class="btn-secondary">← Back to All Journeys</a>
</div>