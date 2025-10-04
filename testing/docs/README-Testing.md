# Microsoft Copilot Studio Labs - Playwright Testing Framework

This repository contains comprehensive automated testing for Microsoft Copilot Studio labs using Playwright with TypeScript.

## 🚀 Quick Start

```powershell
# Install dependencies
npm install

# Set up authentication (interactive login)
npx playwright test persistent-profile-auth.ts --headed

# Run specific lab tests
npx playwright test agent-builder-web-lab.spec.ts --headed

# Run all tests
npx playwright test --headed
```

## 🎯 Features

- **✅ Persistent Authentication**: Secure browser profiles that maintain login sessions across test runs
- **✅ Interactive Login**: No credentials stored in files - secure MFA-supported authentication
- **✅ Multi-Browser Support**: Chromium, Firefox, Safari, and mobile device testing
- **✅ Lab-Specific Validation**: Comprehensive tests for each Copilot Studio lab
- **✅ Visual Debugging**: Screenshots and detailed logging for troubleshooting
- **✅ Microsoft 365 Integration**: Native support for Microsoft 365 Copilot and Copilot Chat

## 📁 Project Structure

```
├── playwright.config.ts           # Main Playwright configuration
├── package.json                   # Dependencies and scripts
├── tests/
│   ├── persistent-profile-auth.ts     # Authentication setup
│   ├── agent-builder-web-lab.spec.ts  # Agent Builder Web lab validation
│   ├── lab-validation-persistent.spec.ts # General lab validation
│   └── profile-test.spec.ts            # Profile functionality tests
├── pages/
│   ├── copilot-chat.page.ts          # Copilot Chat page object
│   ├── copilot-studio.page.ts        # Copilot Studio page object
│   └── base.page.ts                   # Base page functionality
├── utils/
│   ├── auth-helper.ts                 # Authentication utilities
│   └── test-data.ts                   # Test data management
└── playwright/.auth/
    └── chromium-profile/              # Persistent browser profile (auto-created)
```

## 🔐 Authentication System

### Option A: Environment Variables (Not Recommended)
```bash
# .env file (not recommended for production)
MS365_USERNAME=your-username@tenant.com
MS365_PASSWORD=your-password
```

### Option B: Interactive Login with Persistent Profile ⭐ **RECOMMENDED**
This is the secure, user-friendly approach that we've implemented:

1. **Run the authentication setup:**
   ```powershell
   npx playwright test persistent-profile-auth.ts --headed
   ```

2. **Complete the interactive login** in the browser window that opens
3. **Authentication persists** across all future test runs
4. **No credentials stored** in files - completely secure
5. **MFA supported** without additional configuration

### Benefits of Persistent Profiles:
- ✅ **Secure**: No credentials stored in code or config files
- ✅ **Isolated**: Dedicated browser profile separate from your regular browsing
- ✅ **Persistent**: Login once, use across all test runs
- ✅ **MFA Ready**: Supports multi-factor authentication seamlessly
- ✅ **Team Friendly**: Each team member can set up their own profile

## 🧪 Available Tests

### 1. Agent Builder Web Lab (`agent-builder-web-lab.spec.ts`)
Comprehensive validation of the Agent Builder Web lab workflow:

- ✅ Navigate to Microsoft 365 Copilot
- ✅ Verify correct page (not wrong Copilot)
- ✅ Access Chat interface
- ✅ Test basic Copilot functionality
- ✅ Locate Agents section and Create agent button
- ✅ Check for Work/Web toggle (license detection)
- ✅ Validate lab prerequisites

**Lab Steps Covered:**
1. Navigate to Microsoft 365 Copilot home page
2. Go to Chat tab
3. Test basic experience with search
4. Find and expand Agents section
5. Locate Create agent button
6. Verify account provisioning status

### 2. General Lab Validation (`lab-validation-persistent.spec.ts`)
Basic validation that can be applied to any Copilot Studio lab:

- ✅ Microsoft 365 Copilot access verification
- ✅ Authentication state validation
- ✅ Interface element detection
- ✅ Basic navigation testing
- ✅ Agent creation workflow access

### 3. Authentication Tests (`profile-test.spec.ts`)
Tests for the authentication and profile system:

- ✅ Persistent profile functionality
- ✅ Authentication state persistence
- ✅ Browser profile isolation

## 🎯 Lab Coverage

Currently implemented tests cover:

| Lab | Status | Test File | Description |
|-----|--------|-----------|-------------|
| Agent Builder Web | ✅ Complete | `agent-builder-web-lab.spec.ts` | Full workflow validation for creating web-based AI assistants |
| Agent Builder SharePoint | 🚧 Planned | TBD | SharePoint-grounded agent creation |
| Ask Me Anything | 🚧 Planned | TBD | Q&A agent with custom knowledge |
| Autonomous Account News | 🚧 Planned | TBD | News-based autonomous agents |

## 🔧 Configuration

### Playwright Configuration (`playwright.config.ts`)
```typescript
// Key configuration options
projects: [
  {
    name: 'setup',
    testMatch: /persistent-profile-auth\.ts/,
  },
  {
    name: 'chromium',
    use: { ...devices['Desktop Chrome'] },
    dependencies: ['setup'],
  }
]
```

### Environment Variables (`.env`)
```bash
# Optional - tests work without these
MS365_BASE_URL=https://m365.cloud.microsoft
HEADLESS=false
TIMEOUT=30000
```

## 🚀 Running Tests

### Interactive Development
```powershell
# Run with browser visible for development
npx playwright test --headed

# Run specific test file
npx playwright test agent-builder-web-lab.spec.ts --headed

# Run with debugging
npx playwright test --debug
```

### CI/CD Mode
```powershell
# Run headless for CI/CD
npx playwright test

# Generate HTML report
npx playwright show-report
```

### Authentication Setup
```powershell
# First-time setup - interactive login
npx playwright test persistent-profile-auth.ts --headed

# Verify authentication status
npx playwright test profile-test.spec.ts --headed
```

## 📸 Visual Debugging

The framework automatically captures screenshots for:

- ✅ **Authentication states**: Login success/failure
- ✅ **Error conditions**: Failed navigation, missing elements
- ✅ **Lab checkpoints**: Key workflow stages
- ✅ **Final validation**: End-to-end test completion

Screenshots are saved to:
- `playwright/.auth/` - Authentication-related screenshots
- `test-results/` - Test execution screenshots

## 🛠️ Development

### Adding New Lab Tests

1. **Create a new test file** in the `tests/` directory:
   ```typescript
   // tests/your-new-lab.spec.ts
   import { test, expect, chromium } from '@playwright/test';
   
   test.describe('Your New Lab Validation', () => {
     // Your test implementation
   });
   ```

2. **Use the persistent context pattern**:
   ```typescript
   const browser = await chromium.launchPersistentContext('playwright/.auth/chromium-profile', {
     headless: false,
     viewport: { width: 1280, height: 720 }
   });
   ```

3. **Follow the step-by-step validation pattern**:
   ```typescript
   await test.step('Step 1: Navigate to lab', async () => {
     // Step implementation
   });
   ```

### Creating Page Objects

```typescript
// pages/your-page.page.ts
export class YourPage {
  constructor(private page: Page) {}
  
  async navigateTo() {
    await this.page.goto('https://your-url.com');
  }
  
  async validateElements() {
    // Validation logic
  }
}
```

## 🤝 Contributing

1. **Create a feature branch** from `main`
2. **Add your tests** following the existing patterns
3. **Run tests locally** to ensure they pass
4. **Commit with descriptive messages**
5. **Create pull request** with test results

## 📚 Resources

### Microsoft Documentation
- [Microsoft 365 Copilot](https://learn.microsoft.com/en-us/microsoft-365-copilot/)
- [Copilot Studio](https://learn.microsoft.com/en-us/microsoft-copilot-studio/)
- [Declarative Agents](https://learn.microsoft.com/en-us/microsoft-365-copilot/extensibility/overview-declarative-agent)

### Playwright Resources
- [Playwright Documentation](https://playwright.dev/)
- [TypeScript Guide](https://playwright.dev/docs/test-typescript)
- [Page Object Model](https://playwright.dev/docs/pom)

## 🐛 Troubleshooting

### Common Issues

**1. "Create agent" button not visible**
```
💡 Solution: Try refreshing with Ctrl + F5
- Account may still be provisioning
- Wait a few minutes and try again
```

**2. Authentication fails**
```
💡 Solution: Re-run interactive login
npx playwright test persistent-profile-auth.ts --headed
```

**3. Wrong Copilot page**
```
💡 Solution: Verify URL is m365.cloud.microsoft (not copilot.cloud.microsoft)
- Close tab and use app launcher
- Navigate to Microsoft 365 Copilot from SharePoint
```

**4. Browser profile issues**
```
💡 Solution: Clear and recreate profile
rm -rf playwright/.auth/chromium-profile
npx playwright test persistent-profile-auth.ts --headed
```

### Debug Mode
```powershell
# Run with step-by-step debugging
npx playwright test --debug

# Generate trace files
npx playwright test --trace on

# View trace files
npx playwright show-trace trace.zip
```

## 📊 Test Results

### Sample Output
```
Running 11 tests using 1 worker

✅ Authentication successful!
✅ Microsoft 365 Copilot page accessible
✅ Chat interface available
✅ Agents section accessible
✅ Ready for agent creation workflow

🎓 Lab Readiness Summary:
- ✅ Microsoft 365 Copilot page accessible
- ✅ Authentication persistent across test runs
- ✅ Chat interface available
- ✅ Ready for agent creation workflow

11 passed (1.9m)
```

## 🔄 Continuous Integration

### GitHub Actions Example
```yaml
name: Copilot Studio Lab Tests
on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: '18'
      - run: npm ci
      - run: npx playwright install
      - run: npx playwright test
      - uses: actions/upload-artifact@v3
        if: always()
        with:
          name: playwright-report
          path: playwright-report/
```

---

## 🎉 Success Metrics

This testing framework provides:

- **🔒 Secure Authentication**: No stored credentials, MFA-ready
- **🔄 Reliable Automation**: Persistent profiles reduce authentication overhead
- **📊 Comprehensive Coverage**: End-to-end lab workflow validation
- **🐛 Easy Debugging**: Visual screenshots and detailed logging
- **👥 Team Scalable**: Each developer can maintain their own secure profile

**Ready to validate your Microsoft Copilot Studio labs with confidence!** 🚀