---
layout: default
title: Bootcamp Journey
description: Intensive hands-on bootcamp covering agent building, SharePoint integration, autonomous AI, and DevOps practices
---

<!-- 
🎯 BOOTCAMP PAGE: Static structure with dynamic Jekyll templating
📝 This page combines curated content with dynamic lab data from lab-config.yml
🔄 Lab cards are auto-generated from bootcamp_lab_orders configuration
-->

{% comment %}
Load configuration data for dynamic content generation
{% endcomment %}
{% assign config_data = site.data.lab-config %}
{% assign bootcamp_orders = config_data.bootcamp_lab_orders %}
{% assign lab_metadata = config_data.lab_metadata %}

{% comment %}
Calculate bootcamp statistics dynamically
{% endcomment %}
{% assign total_labs = bootcamp_orders.size %}
{% assign total_duration = 0 %}
{% assign min_difficulty = 400 %}
{% assign max_difficulty = 0 %}

{% for order_pair in bootcamp_orders %}
  {% assign lab_id = order_pair[1] %}
  {% for lab_num in lab_metadata %}
    {% assign lab_data = lab_num[1] %}
    {% if lab_data.id == lab_id %}
      {% assign total_duration = total_duration | plus: lab_data.duration %}
      {% assign difficulty_num = lab_data.difficulty | replace: 'Level ', '' | replace: 'Beginner (', '' | replace: 'Intermediate (', '' | replace: 'Advanced (', '' | replace: ')', '' | plus: 0 %}
      {% if difficulty_num < min_difficulty %}
        {% assign min_difficulty = difficulty_num %}
      {% endif %}
      {% if difficulty_num > max_difficulty %}
        {% assign max_difficulty = difficulty_num %}
      {% endif %}
      {% break %}
    {% endif %}
  {% endfor %}
{% endfor %}

{% assign total_hours = total_duration | divided_by: 60.0 | round: 1 %}

<div class="bootcamp-nav">
  <a href="{{ '/labs/' | relative_url }}" class="nav-link">← Back to All Labs</a>
  <div class="bootcamp-info">
    <h1>⚔️ Bootcamp Journey</h1>
    <p>Intensive hands-on bootcamp covering agent building, SharePoint integration, autonomous AI, and DevOps practices.</p>
    <div class="bootcamp-stats">
      <span>📊 <strong>Difficulty:</strong> Level {{ min_difficulty }} to {{ max_difficulty }}</span>
      <span>⏱️ <strong>Estimated Time:</strong> {{ total_hours }} hours</span>
      <span>📚 <strong>Total Labs:</strong> {{ total_labs }} labs ({{ total_duration }} min)</span>
    </div>
  </div>
</div>

<div class="bootcamp-labs">
<div class="labs-grid">
  {% comment %}
  Generate lab cards dynamically from bootcamp_lab_orders
  {% endcomment %}
  {% for order_pair in bootcamp_orders %}
    {% assign bootcamp_order = order_pair[0] %}
    {% assign lab_id = order_pair[1] %}
    
    {% comment %}Find lab metadata for this lab{% endcomment %}
    {% assign lab_info = null %}
    {% assign lab_number = null %}
    {% for lab_num in lab_metadata %}
      {% assign lab_data = lab_num[1] %}
      {% if lab_data.id == lab_id %}
        {% assign lab_info = lab_data %}
        {% assign lab_number = lab_num[0] %}
        {% break %}
      {% endif %}
    {% endfor %}
    
    {% if lab_info %}
  <div class="lab-card">
    <div class="lab-sequence">
      <span class="sequence-number">{{ bootcamp_order }}</span>
    </div>
    <h3><a href="{{ '/labs/' | relative_url }}{{ lab_id }}/?bootcamp=true">{{ lab_info.title }}</a></h3>
      <p>{{ lab_info.description | default: lab_info.title }}</p>
      <div class="lab-meta">
        <span class="difficulty">{{ lab_info.difficulty | replace: ' (', ' ' | replace: ')', '' }}</span>
        <span class="duration">⏱️ {{ lab_info.duration }} min</span>
        <span class="section {{ lab_info.section }}">📂 {% case lab_info.section %}{% when 'core_learning_path' %}Core Learning Path{% when 'intermediate_labs' %}Intermediate Labs{% when 'advanced_labs' %}Advanced Labs{% when 'specialized_labs' %}Specialized Labs{% when 'optional_labs' %}Optional Labs{% when 'external_labs' %}External Labs{% else %}{{ lab_info.section | replace: '_', ' ' | capitalize }}{% endcase %}</span>
      </div>
      <div class="lab-actions">
        <a href="{{ '/labs/' | relative_url }}{{ lab_id }}/?bootcamp=true" class="btn-primary">Start Lab →</a>
        <a href="{{ '/assets/pdfs/' | relative_url }}{{ lab_id }}.pdf" class="btn-secondary" target="_blank">📄 Download PDF</a>
      </div>
    </div>
    {% endif %}
  {% endfor %}
</div>

---

## 🎯 **Bootcamp Journey Overview**

This intensive bootcamp takes you through a carefully curated learning path that builds your Microsoft Copilot Studio skills progressively:

### **Lab 1: Declarative Agents (45 min)**
- **1a:** Web-based AI Assistant - Learn the basics with M365 Copilot integration
- **1b:** SharePoint Agent - Extend to enterprise data with document analysis

### **Lab 2: ALM Foundation (35 min)**
- Master application lifecycle management and deployment best practices

### **Lab 3: Custom Agents (45 min)**  
- **3a:** Public Website Agent - Build customer-facing intelligent chatbots
- **3b:** MBR Agent - Create business-focused SharePoint integration

### **Lab 4: Multi-Agent Systems (40 min)**
- Develop comprehensive "Ask Me Anything" enterprise agents

### **Lab 5: Autonomous Agents (80 min)**
- **5a:** Autonomous Support - Self-managing customer service automation  
- **5b:** Account News Assistant - Proactive sales intelligence automation

### **Lab 6: DevOps & Deployment (30-45 min)**
- Production deployment with Power Platform pipelines and ALM

### **Lab 7: Quality & Testing (30 min)**
- Automated testing and quality assurance with Copilot Studio Kit

---

## 🚀 **Ready to Start?**

**Complete the labs in order** for the best learning experience. Each lab builds on concepts from previous ones, creating a comprehensive foundation in Microsoft Copilot Studio development.

**🎯 Learning Objectives:**
- Master declarative and custom agent development
- Implement enterprise-grade ALM practices  
- Build autonomous AI systems for real business scenarios
- Deploy production-ready agents with confidence

**⚡ Prerequisites:**
- Microsoft 365 access with Copilot Studio licensing
- Basic understanding of AI concepts (helpful but not required)
- Willingness to learn and experiment!

---

**Questions?** Join our community discussions or reach out to the lab maintainers. Happy learning! 🎉