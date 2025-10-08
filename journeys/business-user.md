---
layout: default
title: Business User Journey
description: Perfect for business professionals who want to create powerful AI assistants without deep technical knowledge.
journey: business-user
---

# 👤 Business User Journey

Perfect for business professionals who want to create powerful AI assistants without deep technical knowledge.

**Difficulty Level:** Beginner to Intermediate  
**Estimated Time:** 8-12 hours  
**Total Labs:** 10 labs (690 minutes)

---

## Labs in This Journey

{% assign journey_labs = site.labs | where: 'journeys', 'business-user' | sort: 'order' %}

<div class="labs-grid">
{% for lab in journey_labs %}
  <div class="lab-card" data-difficulty="{{ lab.difficulty }}" data-duration="{{ lab.duration }}">
    <div class="lab-header">
      <h3><a href="{{ lab.url }}">{{ lab.title }}</a></h3>
      <div class="lab-meta">
        <span class="difficulty">{{ lab.difficulty }}</span>
        <span class="duration">{{ lab.duration }}min</span>
      </div>
    </div>
    
    <div class="lab-description">
      {{ lab.description }}
    </div>
    
    {% if lab.journeys.size > 1 %}
    <div class="lab-journeys">
      <small>Also in: 
      {% for j in lab.journeys %}
        {% unless j == 'business-user' %}
          <span class="journey-tag">{{ j }}</span>
        {% endunless %}
      {% endfor %}
      </small>
    </div>
    {% endif %}
    
    <div class="lab-actions">
      <a href="{{ lab.url }}" class="btn btn-primary">Start Lab</a>
    </div>
  </div>
{% endfor %}
</div>

{% if journey_labs.size == 0 %}
<div class="no-labs">
  <p>🚧 Labs for this journey are being prepared. Check back soon!</p>
</div>
{% endif %}

---

## Navigation

<div class="journey-nav">
  <a href="/" class="btn btn-secondary">← Back to Home</a>
  {% assign other_journeys = site.data.journeys | where_exp: "j", "j.name != 'business-user'" %}
  {% for other in other_journeys limit: 1 %}
  <a href="/journeys/{{ other.name }}/" class="btn btn-outline">Try {{ other.title }}</a>
  {% endfor %}
</div>
