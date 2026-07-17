---
layout: page
title: Projects
permalink: /projects/
description:
nav: true
nav_order: 3
display_categories: [ESAB, Design, Fun]
horizontal: false
---

<style>
  .projects-column-title {
    color: var(--global-theme-color);
    font-size: 1.25rem;
    font-weight: 600;
    margin-bottom: 1rem;
  }
  @media (min-width: 768px) {
    .projects-column:not(:first-child) {
      border-left: 1px solid var(--global-divider-color);
      padding-left: 2rem;
    }
  }
</style>

<!-- pages/projects.md -->
<div class="projects">
{% if site.enable_project_categories and page.display_categories %}
  <!-- Display categorized projects as side-by-side columns -->
  <div class="row">
    {% for category in page.display_categories %}
      {% assign categorized_projects = site.projects | where: "category", category %}
      {% assign sorted_projects = categorized_projects | sort: "importance" %}
      <div class="col-12 col-md-4 mb-4 projects-column">
        <div class="projects-column-title">{{ category }}</div>
        <!-- Generate cards for each project -->
        {% if page.horizontal %}
          <div class="row row-cols-1">
            {% for project in sorted_projects %}
              {% include projects_horizontal.liquid %}
            {% endfor %}
          </div>
        {% else %}
          <div class="row row-cols-1">
            {% for project in sorted_projects %}
              {% include projects.liquid %}
            {% endfor %}
          </div>
        {% endif %}
      </div>
    {% endfor %}
  </div>

{% else %}

<!-- Display projects without categories -->

{% assign sorted_projects = site.projects | sort: "importance" %}

  <!-- Generate cards for each project -->

{% if page.horizontal %}

  <div class="container">
    <div class="row row-cols-1 row-cols-md-2">
    {% for project in sorted_projects %}
      {% include projects_horizontal.liquid %}
    {% endfor %}
    </div>
  </div>
  {% else %}
  <div class="row row-cols-1 row-cols-md-3">
    {% for project in sorted_projects %}
      {% include projects.liquid %}
    {% endfor %}
  </div>
  {% endif %}
{% endif %}
</div>
