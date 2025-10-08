---
layout: default
title: Home
---

# Microsoft Copilot Studio Labs

Welcome to the Microsoft Copilot Studio Labs! This collection provides a structured learning journey through building AI agents with Microsoft Copilot Studio.

## 🎓 **Choose Your Learning Path**

### 🌟 **Complete Learning Journey**
*Recommended for most users - comprehensive progression from basics to advanced*

<div class="learning-path">
<h4>📚 Core Foundation (Start Here)</h4>
<ol>
{% assign core_labs = site.labs | where: "optional", false | sort: "order" | where_exp: "lab", "lab.order <= 3" %}
{% for lab in core_labs %}
<li><strong><a href="{{ lab.url | relative_url }}">{{ lab.title }}</a></strong> <em>({{ lab.duration }} min, {{ lab.difficulty }})</em><br>
{{ lab.description }}</li>
{% endfor %}
</ol>

<h4>🔧 Intermediate Applications</h4>
<ol start="4">
{% assign intermediate_labs = site.labs | where: "optional", false | sort: "order" | where_exp: "lab", "lab.order >= 4 and lab.order <= 6" %}
{% for lab in intermediate_labs %}
<li><strong><a href="{{ lab.url | relative_url }}">{{ lab.title }}</a></strong> <em>({{ lab.duration }} min, {{ lab.difficulty }})</em><br>
{{ lab.description }}</li>
{% endfor %}
</ol>

<h4>🚀 Advanced & Autonomous</h4>
<ol start="7">
{% assign advanced_labs = site.labs | where: "optional", false | sort: "order" | where_exp: "lab", "lab.order >= 7 and lab.order <= 9" %}
{% for lab in advanced_labs %}
<li><strong><a href="{{ lab.url | relative_url }}">{{ lab.title }}</a></strong> <em>({{ lab.duration }} min, {{ lab.difficulty }})</em><br>
{{ lab.description }}</li>
{% endfor %}
</ol>

<h4>⚙️ Specialized Topics</h4>
<ol start="10">
{% assign specialized_labs = site.labs | where: "optional", false | sort: "order" | where_exp: "lab", "lab.order >= 10" %}
{% for lab in specialized_labs %}
<li><strong><a href="{{ lab.url | relative_url }}">{{ lab.title }}</a></strong> <em>({{ lab.duration }} min, {{ lab.difficulty }})</em><br>
{{ lab.description }}</li>
{% endfor %}
</ol>
</div>

---

## 🎯 **Focused Learning Tracks**

<div class="learning-tracks">

### 👨‍💼 **Business User Track** *(~4-5 hours)*
Perfect for business users wanting to create practical agents:
1. [Web-based AI Assistant](#) → 2. [SharePoint AI Assistant](#) → 3. [Public Website Agent](#) → 4. [MBR SharePoint Agent](#) → 5. [Ask Me Anything](#)

### 👨‍💻 **Developer Track** *(~5-6 hours)*
Technical focus with ALM and integration practices:
1. [Web-based AI Assistant](#) → 2. [ALM Best Practices](#) → 3. [Pipelines & Source Control](#) → 4. [Ask Me Anything](#) → 5. [Model Context Protocol](#)

### 🤖 **Autonomous Agent Expert** *(~7-8 hours)*
Advanced autonomous agent development:
1. [Web-based AI Assistant](#) → 2. [SharePoint AI Assistant](#) → 3. [Ask Me Anything](#) → 4. [Autonomous Support](#) → 5. [Autonomous News](#) → 6. [Autonomous CUA](#)

### ⚡ **Quick Start (30-60 min)**
Get started fast with essential skills:
1. [Web-based AI Assistant](#) → 2. [Ask Me Anything (30 min)](#)

</div>

---

## 📚 **All Labs** *(Browse & Pick)*

<div class="labs-grid">
{% assign all_main_labs = site.labs | where: "optional", false | sort: "order" %}
{% for lab in all_main_labs %}
    <div class="lab-card">
        <div class="lab-order">{{ lab.order }}</div>
        <h3><a href="{{ lab.url | relative_url }}">{{ lab.title }}</a></h3>
        <p>{{ lab.description | default: lab.excerpt | strip_html | truncate: 100 }}</p>
        <div class="lab-meta">
            <span>⏱️ {{ lab.duration }} min</span>
            <span>📊 {{ lab.difficulty }}</span>
        </div>
    </div>
{% endfor %}
</div>

### 🔖 **Optional & Specialized Labs**

<div class="labs-grid optional">
{% assign optional_labs = site.labs | where: "optional", true | sort: "order" %}
{% for lab in optional_labs %}
    <div class="lab-card optional">
        <h3><a href="{{ lab.url | relative_url }}">{{ lab.title }}</a></h3>
        <p>{{ lab.description | default: lab.excerpt | strip_html | truncate: 100 }}</p>
        <div class="lab-meta">
            <span>⏱️ {{ lab.duration }} min</span>
            <span>📊 {{ lab.difficulty }}</span>
            <span>🔖 Optional</span>
        </div>
    </div>
{% endfor %}
</div>

---

## 💡 **How to Use This Guide**

### 🎯 **New to Copilot Studio?**
→ Follow the **Complete Learning Journey** from top to bottom

### 🎨 **Have Specific Goals?**
→ Choose a **Focused Learning Track** that matches your role

### 🔍 **Looking for Something Specific?**
→ Browse **All Labs** section and pick what interests you

### ⏰ **Short on Time?**
→ Try the **Quick Start** track for essential skills

---

## 🛠️ **Prerequisites**
- Access to Microsoft Copilot Studio
- Basic understanding of AI concepts (helpful but not required)
- Willingness to learn and experiment!

**Ready to start building amazing AI agents?** Choose your path above and let's get started! 🚀