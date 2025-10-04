# Microsoft Copilot Studio Labs - Testing Framework

This directory contains the complete Playwright testing framework for automated validation of Microsoft Copilot Studio labs. **Each file includes comprehensive header documentation explaining its purpose, usage, and team guidelines.**

## 🎓 Learning Path for New Team Members

### 1. **Start Here: Understanding the Framework**
```powershell
# Navigate to testing directory
cd testing

# Verify Playwright works (no auth needed)
npx playwright test simple-verification.spec.ts

# Set up authentication (interactive login)
npx playwright test persistent-profile-auth.ts --headed

# Verify authentication works
npx playwright test profile-test.spec.ts --headed
```

### 2. **Run Your First Lab Test**
```powershell
# Complete workflow for Agent Builder Web lab
npx playwright test agent-builder-web-lab.spec.ts --headed

# Or use the automated script
.\scripts\run-tests.ps1 -Action test -Lab agent-builder-web
```

### 3. **Explore the Full Framework**
```powershell
# Run all tests
.\scripts\run-tests.ps1 -Action all

# Or step by step
.\scripts\run-tests.ps1 -Action auth     # Setup authentication
.\scripts\run-tests.ps1 -Action test     # Run all lab tests
.\scripts\run-tests.ps1 -Action clean    # Cleanup test artifacts
```

## � File Purpose Guide (Self-Documented)

**💡 Every file includes detailed header comments explaining its purpose, usage, and team guidelines. Open any file to understand what it does!**

### 🔧 **Core Configuration Files**

```text
playwright.config.ts       → Main Playwright setup (browsers, authentication, timeouts)
package.json               → Dependencies and NPM scripts  
tsconfig.json              → TypeScript configuration
.env / .env.example        → Environment variables (credentials)
```

### 📖 **Documentation & Guides**

```text
docs/README-Testing.md      → Comprehensive testing documentation
docs/AUTHENTICATION-GUIDE.md → Step-by-step auth setup
docs/AUTHENTICATION-STATUS.md → Auth troubleshooting guide
docs/PLAYWRIGHT-GUIDE.md   → Playwright usage patterns
```

### 🚀 **Scripts (Automation)**

```text
scripts/run-tests.ps1       → Main test runner (setup, auth, test, clean)
scripts/test-labs.ps1       → Wrapper script for easy access
scripts/setup-playwright.ps1 → Playwright installation
scripts/setup-credentials.ps1 → Credential configuration helper
```

### 🔐 **Authentication**

```text
tests/persistent-profile-auth.ts → Creates persistent browser profile (run once)
tests/profile-test.spec.ts       → Validates authentication is working
```

### 🧪 **Lab Tests (Main Functionality)**

```text
tests/agent-builder-web-lab.spec.ts → Complete Agent Builder Web workflow
tests/lab-validation-*.spec.ts      → Step-by-step lab validations
tests/agent-builder-sharepoint.spec.ts → SharePoint integration tests
tests/ask-me-anything.spec.ts       → Ask Me Anything lab tests
tests/m365-copilot-integration.spec.ts → Microsoft 365 integration
```

### 🛠️ **Infrastructure & Utilities**

```text
tests/simple-verification.spec.ts → Basic Playwright functionality check
tests/pages/                      → Page Object Models (UI interactions)
tests/utils/                      → Test utilities and helpers
tests/fixtures/                   → Test fixtures and data
```

## 🎯 **Common Team Workflows**

### 🆕 **New Team Member Setup**

```powershell
# 1. Install dependencies
npm install

# 2. Copy and configure credentials
cp .env.example .env
# Edit .env with your Microsoft 365 credentials

# 3. Verify Playwright works
npx playwright test simple-verification.spec.ts

# 4. Set up authentication (interactive)
npx playwright test persistent-profile-auth.ts --headed

# 5. Run your first lab test
npx playwright test agent-builder-web-lab.spec.ts --headed
```

### 🧪 **Daily Testing Workflow**

```powershell
# Quick test run (uses existing auth)
.\scripts\run-tests.ps1 -Action test

# Test specific lab
.\scripts\run-tests.ps1 -Action test -Lab agent-builder-web

# Full clean run (re-authenticate)
.\scripts\run-tests.ps1 -Action all
```

### 🐛 **Troubleshooting Guide**

```powershell
# 1. Basic Playwright issues
npx playwright test simple-verification.spec.ts

# 2. Authentication problems
npx playwright test profile-test.spec.ts --headed

# 3. Re-authenticate if needed
npx playwright test persistent-profile-auth.ts --headed

# 4. Clear all test data
.\scripts\run-tests.ps1 -Action clean
```

## 🔐 **Secure Authentication System**

**No credentials stored in files!** Uses persistent browser profiles:

1. **One-time setup**: Interactive login with MFA support
2. **Persistent sessions**: Authentication saved in browser profile
3. **Team-safe**: Each developer has their own profile
4. **Secure**: No passwords in code or config files

## � **Learning Resources**

- **Start with file headers**: Every file documents its purpose and usage
- **Comprehensive docs**: See `docs/README-Testing.md` for deep technical details  
- **Authentication guide**: Step-by-step setup in `docs/AUTHENTICATION-GUIDE.md`
- **Playwright patterns**: Best practices in `docs/PLAYWRIGHT-GUIDE.md`

## 🚀 **Framework Benefits**

- ✅ **Self-Documenting**: Every file explains its purpose in header comments
- ✅ **Educational**: README focuses on learning and team workflows  
- ✅ **Secure**: No stored credentials, persistent browser profiles
- ✅ **Reliable**: Comprehensive error handling and debugging tools
- ✅ **Team-Ready**: Isolated testing environment, no lab content interference

---

💡 **Pro Tip**: Always read the file header comments - they contain the most up-to-date information about purpose, usage, and team guidelines!