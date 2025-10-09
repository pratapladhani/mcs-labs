# Lab Generation Scripts

This folder contains PowerShell scripts for generating Jekyll lab files from source content.

## Scripts

### `Generate-Labs.ps1`
Main conversion script that reads `lab-config.yml` and generates `_labs/*.md` files from `labs/*/README.md` sources.

**Usage:**
```powershell
# Generate all lab files
./Generate-Labs.ps1

# Get help
./Generate-Labs.ps1 -Help
```

### `Build.ps1`
Simple build script for local development that generates lab files and prepares for Jekyll serving.

**Usage:**
```powershell
# Generate labs and get ready for Jekyll
./Build.ps1
```

## Architecture

These scripts implement the auto-generation architecture described in `LAB-GENERATION.md`:

- **Input**: `labs/*/README.md` + `lab-config.yml`
- **Output**: `_labs/*.md` (auto-generated Jekyll files)
- **Process**: PowerShell → YAML parsing → Jekyll front matter generation

## GitHub Actions Integration

The `Generate-Labs.ps1` script is automatically executed during GitHub Actions deployment via `.github/workflows/deploy-jekyll-labs.yml`.