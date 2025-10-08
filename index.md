---
layout: default
title: Home
---

# Microsoft Copilot Studio Labs

Welcome to hands-on labs for building AI agents with Microsoft Copilot Studio. Choose your learning journey based on your goals and experience level.

## 🎯 **Choose Your Learning Journey**

<div class="journey-cards">
    <div class="journey-card quick-start">
        <h3>🚀 Quick Start</h3>
        <p>Get results fast with practical demos and POCs</p>
        <div class="journey-meta">
            <span>⏱️ 30-90 mins</span>
            <span>📊 Level 100-200</span>
        </div>
        <a href="#quick-start-labs" class="journey-btn">Start Journey →</a>
    </div>
    
    <div class="journey-card business-user">
        <h3>💼 Business User</h3>
        <p>Solve real business problems with AI agents</p>
        <div class="journey-meta">
            <span>⏱️ 2-4 hours</span>
            <span>📊 Level 100-300</span>
        </div>
        <a href="#business-user-labs" class="journey-btn">Start Journey →</a>
    </div>
    
    <div class="journey-card developer">
        <h3>🔧 Developer</h3>
        <p>Build robust, production-ready solutions</p>
        <div class="journey-meta">
            <span>⏱️ 4-6 hours</span>
            <span>📊 Level 200-300</span>
        </div>
        <a href="#developer-labs" class="journey-btn">Start Journey →</a>
    </div>
    
    <div class="journey-card autonomous-ai">
        <h3>🤖 Autonomous AI</h3>
        <p>Create AI agents that work independently</p>
        <div class="journey-meta">
            <span>⏱️ 3-5 hours</span>
            <span>📊 Level 300</span>
        </div>
        <a href="#autonomous-ai-labs" class="journey-btn">Start Journey →</a>
    </div>
</div>

<h3 id="quick-start-labs">🚀 <strong>Quick Start Labs</strong></h3>
<p><em>Perfect for demos, POCs, and getting immediate results</em></p>

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
            <a href="{{ lab.url | relative_url }}" class="btn-primary">� View Lab</a>
            {% unless jekyll.environment == "development" %}
            <a href="{{ '/labs/' | append: lab.slug | append: '/' | append: lab.slug | append: '.pdf' | relative_url }}" class="btn-secondary pdf-download" target="_blank" rel="noopener">📄 Download PDF</a>
            {% endunless %}
        </div>
    </div>
  {% endif %}
{% endfor %}
</div>

<h3 id="business-user-labs">💼 <strong>Business User Labs</strong></h3>
<p><em>Practical business applications for solving real problems</em></p>

<div class="labs-grid journey-section">
{% assign business_user_labs = site.labs | where: "lab_type", "main" | sort: "difficulty" %}
{% for lab in business_user_labs %}
  {% if lab.journeys contains "business-user" %}
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
            {% unless jekyll.environment == "development" %}
            <a href="{{ '/labs/' | append: lab.slug | append: '/' | append: lab.slug | append: '.pdf' | relative_url }}" class="btn-secondary pdf-download" target="_blank" rel="noopener">📄 Download PDF</a>
            {% endunless %}
        </div>
    </div>
  {% endif %}
{% endfor %}
</div>

<h3 id="developer-labs">🔧 <strong>Developer Labs</strong></h3>
<p><em>Technical implementation and production-ready development practices</em></p>

<div class="labs-grid journey-section">
{% assign developer_labs = site.labs | where: "lab_type", "main" | sort: "difficulty" %}
{% for lab in developer_labs %}
  {% if lab.journeys contains "developer" %}
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
            {% unless jekyll.environment == "development" %}
            <a href="{{ '/labs/' | append: lab.slug | append: '/' | append: lab.slug | append: '.pdf' | relative_url }}" class="btn-secondary pdf-download" target="_blank" rel="noopener">📄 Download PDF</a>
            {% endunless %}
        </div>
    </div>
  {% endif %}
{% endfor %}
</div>

<h3 id="autonomous-ai-labs">🤖 <strong>Autonomous AI Labs</strong></h3>
<p><em>Advanced AI capabilities with minimal human intervention</em></p>

<div class="labs-grid journey-section">
{% assign autonomous_labs = site.labs | where: "lab_type", "main" | sort: "difficulty" %}
{% for lab in autonomous_labs %}
  {% if lab.journeys contains "autonomous-ai" %}
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
            {% unless jekyll.environment == "development" %}
            <a href="{{ '/labs/' | append: lab.slug | append: '/' | append: lab.slug | append: '.pdf' | relative_url }}" class="btn-secondary pdf-download" target="_blank" rel="noopener">📄 Download PDF</a>
            {% endunless %}
        </div>
    </div>
  {% endif %}
{% endfor %}
</div>

<h3>🌟 <strong>All Labs</strong></h3>
<p><em>Browse all available labs - mix and match as needed</em></p>

<div class="labs-grid main-path">
{% assign main_labs = site.labs | where: "lab_type", "main" | sort: "order" %}
{% for lab in main_labs %}
    <div class="lab-card {% if lab.difficulty <= 100 %}beginner{% elsif lab.difficulty <= 200 %}intermediate{% else %}advanced{% endif %}">
        <div class="journey-badges">
            {% if lab.journeys %}
                {% for journey in lab.journeys %}
                    <span class="journey-badge journey-{{ journey }}">{{ journey | replace: '-', ' ' | capitalize }}</span>
                {% endfor %}
            {% endif %}
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
            {% unless jekyll.environment == "development" %}
            <a href="{{ '/labs/' | append: lab.slug | append: '/' | append: lab.slug | append: '.pdf' | relative_url }}" class="btn-secondary pdf-download" target="_blank" rel="noopener">📄 Download PDF</a>
            {% endunless %}
        </div>
    </div>
{% endfor %}
</div>

<h3>🔖 <strong>Optional & Specialized Labs</strong></h3>
<p><em>Explore when you're ready for specialized topics</em></p>

<div class="labs-grid optional-labs">
{% assign optional_labs = site.labs | where: "lab_type", "optional" | sort: "order" %}
{% for lab in optional_labs %}
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
            {% unless jekyll.environment == "development" %}
            <a href="{{ '/labs/' | append: lab.slug | append: '/' | append: lab.slug | append: '.pdf' | relative_url }}" class="btn-secondary pdf-download" target="_blank" rel="noopener">📄 Download PDF</a>
            {% endunless %}
        </div>
    </div>
{% endfor %}

<!-- External MCP Lab -->
<div class="lab-card external">
    <a href="https://github.com/microsoft/mcsmcp" target="_blank" class="lab-card-link">
        <div class="external-badge">External Lab</div>
        <h3>Model Context Protocol (MCP) & Copilot Studio (External)</h3>
        <p>Alternative MCP lab with full setup guide in external repository. Use this if you prefer the microsoft/mcsmcp approach.</p>
        <div class="lab-meta">
            <span class="duration">⏱️ 90 min</span>
            <span class="difficulty">📊 Advanced</span>
            <span class="external-link">🔗 External</span>
        </div>
    </a>
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