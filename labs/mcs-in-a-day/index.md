---
layout: default
title: MCS in a Day
description: Fast-track full-day workshop introducing Microsoft Copilot Studio through hands-on labs covering declarative agents, custom agents, and autonomous AI
---

<!-- 
🎯 MCS IN A DAY EVENT PAGE: Static structure with dynamic Jekyll templating
📝 This page combines curated content with dynamic lab data from lab-config.yml
🔄 Lab cards are auto-generated from mcs_in_a_day_lab_orders configuration
-->

{% comment %}
Load configuration data for dynamic content generation
{% endcomment %}
{% assign config_data = site.data.lab-config %}
{% assign event_orders = config_data.mcs_in_a_day_lab_orders %}
{% assign lab_metadata = config_data.lab_metadata %}

{% comment %}
Calculate event statistics dynamically
{% endcomment %}
{% assign total_labs = event_orders.size %}
{% assign total_duration = 0 %}
{% assign min_difficulty = 400 %}
{% assign max_difficulty = 0 %}

{% for order_pair in event_orders %}
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

<div class="event-nav">
  <a href="{{ '/labs/' | relative_url }}" class="nav-link">← Back to All Labs</a>
  <div class="event-info">
    <h1>⚡ MCS in a Day</h1>
    <p>Fast-track full-day workshop introducing Microsoft Copilot Studio through hands-on labs covering declarative agents, custom agents, and autonomous AI.</p>
    <div class="event-stats">
      <span>📊 <strong>Difficulty:</strong> Level {{ min_difficulty }} to {{ max_difficulty }}</span>
      <span>⏱️ <strong>Estimated Time:</strong> {{ total_hours }} hours</span>
      <span>📚 <strong>Total Labs:</strong> {{ total_labs }} labs ({{ total_duration }} min)</span>
    </div>
  </div>
</div>

<div class="event-overview">
  <h2>🎯 Event Overview</h2>
  <p>MCS in a Day is an intensive full-day workshop designed to give you hands-on experience with Microsoft Copilot Studio. From your first declarative agent to advanced autonomous AI systems, you'll build real-world solutions that showcase the power and flexibility of the platform.</p>
  
  <h3>What You'll Learn</h3>
  <ul>
    <li>🤖 <strong>Declarative Agents:</strong> Build your first agents for Microsoft 365 Copilot with zero code</li>
    <li>🌐 <strong>Custom Agents:</strong> Create agents that connect to websites and SharePoint</li>
    <li>🔗 <strong>Multi-Agent Systems:</strong> Build advanced employee agents that work together</li>
    <li>🚀 <strong>Autonomous AI:</strong> Deploy autonomous agents that take proactive actions</li>
    <li>📊 <strong>Analytics & Governance:</strong> Understand agent analytics, licensing, and deployment best practices</li>
  </ul>

  <h3>Event Schedule</h3>
  <div class="schedule-overview">
    <p><strong>Duration:</strong> Full day (9:00 AM - 4:15 PM)</p>
    <ul>
      <li>09:00-09:30 | Introductions & Lab Environment Setup</li>
      <li>09:30-10:30 | Microsoft Copilot Studio 101</li>
      <li>10:30-11:00 | ☕ Coffee Break</li>
      <li>11:00-12:30 | Labs 1-3: Declarative & Custom Agents</li>
      <li>12:30-13:30 | 🍽️ Lunch Break</li>
      <li>13:30-14:00 | Lab 4: Advanced Employee Agent</li>
      <li>14:00-14:30 | Agent Analytics & Deployment Fundamentals</li>
      <li>14:30-15:00 | ☕ Coffee Break</li>
      <li>15:00-15:30 | Lab 5: Autonomous Agent</li>
      <li>15:30-16:00 | Licensing & Governance 101</li>
      <li>16:00-16:15 | Wrap-up and Q&A</li>
    </ul>
  </div>

  <h3>Prerequisites</h3>
  <ul>
    <li>✅ Basic understanding of AI and chatbot concepts</li>
    <li>✅ Access to Microsoft 365 subscription (provided in lab environment)</li>
    <li>✅ No prior Copilot Studio experience required - we'll start from the basics!</li>
    <li>✅ Laptop with modern web browser (Chrome, Edge, or Firefox recommended)</li>
  </ul>

  <h3>Workshop Structure</h3>
  <p>The workshop consists of 5 progressive hands-on labs interspersed with instructor-led sessions on theory, best practices, and real-world scenarios. Each lab includes step-by-step instructions and downloadable resources.</p>
</div>

<div class="event-labs">
<h2>📚 Workshop Labs</h2>
<div class="labs-grid">
  {% comment %}
  Generate lab cards dynamically from mcs_in_a_day_lab_orders
  {% endcomment %}
  {% for order_pair in event_orders %}
    {% assign event_order = order_pair[0] %}
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
      <span class="sequence-number">{{ event_order }}</span>
    </div>
    <h3><a href="{{ '/labs/' | relative_url }}{{ lab_id }}/?event=mcs-in-a-day">{{ lab_info.title }}</a></h3>
      <p>{{ lab_info.description | default: lab_info.title }}</p>
      <div class="lab-meta">
        <span class="difficulty">{{ lab_info.difficulty | replace: ' (', ' ' | replace: ')', '' }}</span>
        <span class="duration">⏱️ {{ lab_info.duration }} min</span>
        <span class="section {{ lab_info.section }}">📂 {% case lab_info.section %}{% when 'core_learning_path' %}Core Learning Path{% when 'intermediate_labs' %}Intermediate Labs{% when 'advanced_labs' %}Advanced Labs{% when 'specialized_labs' %}Specialized Labs{% when 'optional_labs' %}Optional Labs{% when 'external_labs' %}External Labs{% else %}{{ lab_info.section | replace: '_', ' ' | capitalize }}{% endcase %}</span>
      </div>
      <div class="lab-actions">
        <a href="{{ '/labs/' | relative_url }}{{ lab_id }}/?event=mcs-in-a-day" class="btn-primary">Start Lab →</a>
        <a href="{{ '/assets/pdfs/' | relative_url }}{{ lab_id }}.pdf" class="btn-secondary" target="_blank">📄 Download PDF</a>
      </div>
    </div>
    {% endif %}
  {% endfor %}
</div>
</div>

<div class="event-resources">
  <h2>📖 Additional Resources</h2>
  <ul>
    <li><a href="https://learn.microsoft.com/en-us/microsoft-copilot-studio/" target="_blank">Microsoft Copilot Studio Documentation</a></li>
    <li><a href="https://learn.microsoft.com/en-us/microsoft-copilot-studio/fundamentals-get-started" target="_blank">Get Started with Copilot Studio</a></li>
    <li><a href="https://learn.microsoft.com/en-us/microsoft-copilot-studio/advanced-autonomous-agents" target="_blank">Autonomous Agents Overview</a></li>
    <li><a href="https://learn.microsoft.com/en-us/microsoft-365-copilot/extensibility/" target="_blank">Microsoft 365 Copilot Extensibility</a></li>
  </ul>
</div>

<div class="event-support">
  <h2>💬 Need Help?</h2>
  <p>If you encounter any issues or have questions during the workshop:</p>
  <ul>
    <li>🔍 Review the lab prerequisites and setup instructions carefully</li>
    <li>📚 Consult the linked documentation for detailed technical information</li>
    <li>💡 Check the troubleshooting sections in each lab</li>
    <li>🤝 Reach out to your workshop instructor or facilitator</li>
    <li>💭 Participate in Q&A sessions during breaks and wrap-up</li>
  </ul>
</div>
