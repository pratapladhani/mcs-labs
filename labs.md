---
layout: default
title: All Labs
permalink: /labs/
---

# All Labs

Browse through all available Microsoft Copilot Studio labs. Labs are organized by difficulty and learning path.

## Core Learning Path
Essential labs to build your foundation:

<div class="labs-grid">
{% assign core_labs = site.labs | where: "optional", false | sort: "order" | where_exp: "lab", "lab.order <= 4" %}
{% for lab in core_labs %}
    <div class="lab-card">
        <h3><a href="{{ lab.url | relative_url }}">{{ lab.title }}</a></h3>
        <p>{{ lab.description | default: lab.excerpt | strip_html | truncate: 120 }}</p>
        <div class="lab-meta">
            <span>⏱️ {{ lab.duration }} min</span>
            <span>📊 {{ lab.difficulty }}</span>
        </div>
    </div>
{% endfor %}
</div>

## Advanced Labs
For users ready for more complex scenarios:

<div class="labs-grid">
{% assign advanced_labs = site.labs | where: "optional", false | sort: "order" | where_exp: "lab", "lab.order > 4" %}
{% for lab in advanced_labs %}
    <div class="lab-card">
        <h3><a href="{{ lab.url | relative_url }}">{{ lab.title }}</a></h3>
        <p>{{ lab.description | default: lab.excerpt | strip_html | truncate: 120 }}</p>
        <div class="lab-meta">
            <span>⏱️ {{ lab.duration }} min</span>
            <span>📊 {{ lab.difficulty }}</span>
        </div>
    </div>
{% endfor %}
</div>

## Optional Labs
Alternative versions and specialized topics:

<div class="labs-grid">
{% assign optional_labs = site.labs | where: "optional", true | sort: "order" %}
{% for lab in optional_labs %}
    <div class="lab-card">
        <h3><a href="{{ lab.url | relative_url }}">{{ lab.title }}</a></h3>
        <p>{{ lab.description | default: lab.excerpt | strip_html | truncate: 120 }}</p>
        <div class="lab-meta">
            <span>⏱️ {{ lab.duration }} min</span>
            <span>📊 {{ lab.difficulty }}</span>
            <span>🔖 Optional</span>
        </div>
    </div>
{% endfor %}
</div>