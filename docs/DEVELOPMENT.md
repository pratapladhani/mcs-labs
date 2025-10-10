# Development Guide

This document contains essential information for developing the Microsoft Copilot Studio Labs project.

## 🏗️ Architecture Overview

### Tech Stack
- **Static Site Generator**: Jekyll (Ruby-based)
- **CSS Framework**: Custom CSS with CSS Custom Properties
- **Content Generation**: PowerShell scripts
- **Containerization**: Docker & Docker Compose
- **Deployment**: GitHub Pages

### Key Architectural Decisions

1. **Docker-First Development**: We use Docker containers for consistent development environment across different machines
2. **Separation of Concerns**: All styling is handled in main CSS file, NOT in generated HTML
3. **Dynamic Content Generation**: Labs are generated from PowerShell scripts, not manually created
4. **Theme System**: CSS Custom Properties enable comprehensive light/dark mode support

## 🚀 Development Environment Setup

### Prerequisites
- Docker Desktop
- Git
- PowerShell (for content generation)

### PowerShell Environment Notes

**⚠️ IMPORTANT**: This project is developed on Windows and uses PowerShell syntax throughout. When working with the terminal commands:

- Use PowerShell cmdlets instead of Unix commands:
  - `Remove-Item -Recurse -Force` instead of `rm -rf`
  - `Get-ChildItem` instead of `ls`
  - `Select-Object -Last 5` instead of `tail -5`
  - `Copy-Item` instead of `cp`
- PowerShell scripts use `.ps1` extension and require execution policy configuration
- Docker commands work the same across platforms, but file operations should use PowerShell syntax

### Starting Development Server

```bash
# Start Jekyll development server (REQUIRED: detached mode with force polling)
docker-compose up -d jekyll-dev

# Check logs
docker-compose logs -f jekyll-dev

# 🌐 Site will be available at: http://localhost:4000/mcs-labs/
# Note: The /mcs-labs/ path is required for local testing
```

**⚠️ CRITICAL**: Always use `-d` (detached) flag and ensure `--force_polling` is in docker-compose.yml for proper file watching on Windows.

### File Watching Configuration

Jekyll file watching requires specific configuration in Docker on Windows:

```yaml
# In docker-compose.yml
command: bundle exec jekyll serve --host 0.0.0.0 --livereload --livereload-port 35729 --incremental --force_polling
```

```yaml
# In _config.yml
livereload: true
livereload_port: 35729
incremental: true
force_polling: true
```

## 📁 Project Structure

```
mcs-labs/
├── _layouts/           # Jekyll layout templates
│   ├── default.html    # Main site layout with theme toggle
│   └── lab.html        # Individual lab page layout
├── assets/css/         # Stylesheets
│   └── style.css       # Main CSS with theme support
├── scripts/            # Content generation
│   └── Generate-Labs.ps1  # Main lab generation script
├── labs/               # Source lab content
├── _labs/              # Generated lab files (auto-generated)
├── docs/               # Documentation
└── docker-compose.yml  # Development environment
```

## 🔄 Content Generation Workflow

### Lab Content Generation

**IMPORTANT**: All lab content is generated via PowerShell scripts. Never edit files in `_labs/` directly.

```bash
# Generate all labs (skip PDFs for faster development)
pwsh -File scripts/Generate-Labs.ps1 -SkipPDFs

# Generate specific journey
pwsh -File scripts/Generate-Labs.ps1 -SelectedJourneys "developer" -SkipPDFs
```

> **💡 Pro Tip for Faster Testing**: Always use the `-SkipPDFs` flag during development! PDF generation can take several minutes and is usually not needed for testing layout, styling, or content changes. Only generate PDFs when you need to test the final output or before production deployment.

### Key Rules for Content Generation

1. **CSS Architecture**: Remove ALL `<style>` blocks from PowerShell-generated HTML
2. **Styling Source**: All styling MUST come from `assets/css/style.css`
3. **Theme Support**: Use CSS Custom Properties (CSS variables) for theme-able properties
4. **Clean HTML**: Generated HTML should contain NO inline styles

### Modifying Lab Generation

When editing `scripts/Generate-Labs.ps1`:

1. **Never add inline CSS**: Use CSS classes and let main CSS handle styling
2. **Test generation**: Always run the script after changes
3. **Clean architecture**: HTML structure only, styling in CSS only

## 🎨 Theme System

### CSS Custom Properties Architecture

```css
:root {
    /* Light theme */
    --bg-primary: #f8f9fa;
    --text-primary: #333333;
    /* ... */
}

[data-theme="dark"] {
    /* Dark theme overrides */
    --bg-primary: #1a1a1a;
    --text-primary: #ffffff;
    /* ... */
}
```

### Theme Toggle Implementation

- **Preload Script**: Immediate theme detection in `<head>` prevents flash
- **Toggle Button**: Located in site header
- **Persistence**: Theme choice saved in localStorage
- **System Detection**: Respects user's OS preference

### Adding New Themed Components

1. Define CSS Custom Properties for colors
2. Use properties in component styles
3. Add dark mode overrides in `[data-theme="dark"]` section
4. Test both light and dark modes

## 🐛 Common Development Issues

### Jekyll Not Detecting File Changes

**Problem**: Changes to files not triggering Jekyll regeneration

**Solution**: Ensure force polling is enabled:
```bash
docker-compose restart jekyll-dev
```

### Theme Toggle Not Working

**Problem**: JavaScript errors in browser console

**Solution**: Check for syntax errors in `_layouts/default.html` script tags

### Styling Not Applied

**Problem**: Styles not showing up in generated pages

**Solution**: 
1. Ensure CSS is in `assets/css/style.css`
2. Remove any `<style>` blocks from PowerShell scripts
3. Use CSS classes, not inline styles

### Docker Issues

**Problem**: Container won't start or file watching broken

**Solution**:
```bash
# Full reset
docker-compose down
docker-compose up -d jekyll-dev
```

## 🔍 Debugging

### Useful Commands

```bash
# View Jekyll logs
docker-compose logs -f jekyll-dev

# Check container status
docker-compose ps

# Access container shell
docker-compose exec jekyll-dev bash

# Full rebuild
docker-compose down
docker-compose build --no-cache
docker-compose up -d jekyll-dev
```

### PowerShell-Specific Commands

Since this project runs on Windows, use these PowerShell equivalents for common operations:

```powershell
# Clean Jekyll cache and generated files
Remove-Item -Recurse -Force _site, .jekyll-cache -ErrorAction SilentlyContinue

# List directory contents
Get-ChildItem _site/

# View last few lines of Docker logs
docker logs mcs-labs-dev | Select-Object -Last 10

# Copy files
Copy-Item source.txt destination.txt

# Find files
Get-ChildItem -Recurse -Filter "*.html" | Where-Object Name -like "*favicon*"

# Check if file exists
Test-Path "favicon.ico"
```

**Common Mistake**: Don't use `rm -rf`, `ls`, `tail`, `cp` commands - these are Unix/bash commands that won't work in PowerShell.

### File Locations in Container

- Workspace: `/workspace`
- Generated site: `/workspace/_site`
- Logs: Container stdout/stderr

## 📚 Additional Resources

- [Jekyll Documentation](https://jekyllrb.com/docs/)
- [CSS Custom Properties](https://developer.mozilla.org/en-US/docs/Web/CSS/--*)
- [Docker Compose](https://docs.docker.com/compose/)

---

**Last Updated**: October 2025  
**Maintainer**: Development Team