# 🔐 Playwright Authentication Setup Guide

## How to Configure Your Credentials

### Option 1: Update .env File (Recommended for Local Testing)
Edit the `.env` file in your project root:

```bash
# Microsoft 365 / Copilot Studio Authentication
M365_USERNAME=your.actual.email@yourcompany.com
M365_PASSWORD=your_actual_password

# OR if you have MFA enabled, use an App Password:
M365_PASSWORD=your_app_password_here
```

### Option 2: Use Environment Variables (Recommended for CI/CD)
Set these in your system environment:

**Windows PowerShell:**
```powershell
$env:M365_USERNAME="your.email@company.com"
$env:M365_PASSWORD="your_password"
```

**Windows Command Prompt:**
```cmd
set M365_USERNAME=your.email@company.com
set M365_PASSWORD=your_password
```

### Option 3: Interactive Login (Most Secure)
We can set up interactive authentication that opens a browser for you to log in manually.

## 🛡️ Security Best Practices

### For Accounts with MFA (Multi-Factor Authentication)
If your Microsoft 365 account has MFA enabled:

1. **Create an App Password:**
   - Go to https://account.microsoft.com/security
   - Select "Additional security options"
   - Under "App passwords" select "Create a new app password"
   - Use this app password instead of your regular password

2. **Use a Test Account:**
   - Consider creating a dedicated test account without MFA
   - This account should have access to Copilot Studio

### For Production/CI Environments
- Store credentials in secure vault (Azure Key Vault, GitHub Secrets, etc.)
- Never commit credentials to git
- Use service accounts where possible

## 🚀 Current Status
Your tests worked because:
- Browser remembered previous login session, OR
- Windows integrated authentication, OR
- Cached credentials from previous sessions

For consistent testing, you should configure proper credentials using one of the options above.