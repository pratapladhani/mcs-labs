# Playwright Testing Setup for MCS Labs

## Quick Start

1. **Run the setup script:**
   ```powershell
   .\setup-playwright.ps1
   ```

2. **Configure credentials:**
   - Copy `.env.example` to `.env`
   - Add your Microsoft 365 credentials

3. **Run a basic test:**
   ```bash
   npm run test tests/basic-setup.spec.ts
   ```

## Understanding the Error (localhost:9323)

The URL `http://localhost:9323/` appears when you run Playwright in UI mode. This is **normal behavior** and provides an interactive test runner interface. Here's what happened:

- When you run `npx playwright test --ui` or `npm run test:ui`, Playwright launches a local web server
- This gives you a graphical interface to:
  - Select which tests to run
  - Watch tests execute in real-time
  - Debug test failures
  - View test results and reports

### How to Use the UI Mode

1. **Open the UI:** `npm run test:ui`
2. **In the browser interface:**
   - Select tests from the sidebar
   - Click "Run" to execute tests
   - Use the "Debug" button to step through tests
   - View screenshots and videos of test runs

## Alternative Test Running Methods

### Command Line (No Browser Interface)

```bash
# Run all tests (headless)
npm test

# Run specific test file
npm test tests/basic-setup.spec.ts

# Run with browser visible
npm run test:headed

# Run in debug mode (pauses execution)
npm run test:debug
```

### PowerShell Script

```powershell
# Run all tests
.\run-tests.ps1

# Run specific test with browser visible
.\run-tests.ps1 -TestFile "tests/basic-setup.spec.ts" -Headed

# Open UI mode
.\run-tests.ps1 -UI
```

## Test Structure Overview

```
tests/
├── fixtures/           # Custom test fixtures
├── pages/              # Page Object Models
├── utils/              # Test utilities and helpers
├── basic-setup.spec.ts # Basic functionality tests
├── agent-builder-*.spec.ts # Lab-specific tests
└── README.md           # Test documentation
```

## Lab-Specific Tests

Each lab has its own test file:

- `agent-builder-web.spec.ts` - Web-based agent creation
- `agent-builder-sharepoint.spec.ts` - SharePoint integration
- `ask-me-anything.spec.ts` - Multi-agent IT support
- `m365-copilot-integration.spec.ts` - Microsoft 365 integration

## Troubleshooting Common Issues

### 1. Browser Installation Issues
```bash
npx playwright install
```

### 2. Authentication Problems
- Verify credentials in `.env` file
- Check if MFA is required (may need app passwords)
- Ensure account has Copilot Studio access

### 3. Timeout Errors
- AI responses can be slow
- Increase timeout in `playwright.config.ts`
- Check network connectivity

### 4. Element Not Found
- UI selectors may change
- Update page objects in `tests/pages/`
- Use more robust selectors

## Configuration Files

- `playwright.config.ts` - Main Playwright configuration
- `tsconfig.json` - TypeScript configuration
- `.env` - Environment variables (credentials)
- `package.json` - Dependencies and scripts

## Continuous Integration

To run tests in CI environments:

```yaml
# GitHub Actions example
- name: Install dependencies
  run: npm ci

- name: Install Playwright browsers
  run: npx playwright install --with-deps

- name: Run tests
  run: npm test
  env:
    M365_USERNAME: ${{ secrets.M365_USERNAME }}
    M365_PASSWORD: ${{ secrets.M365_PASSWORD }}
```

## Next Steps

1. **Start with basic tests** to verify setup
2. **Configure authentication** for Microsoft 365
3. **Run lab-specific tests** for your use cases
4. **Customize page objects** for your environment
5. **Add new test scenarios** as needed

## Getting Help

- Check the test reports: `npm run test:report`
- Review logs in `test-results/` directory
- Use debug mode: `npm run test:debug`
- Consult Playwright documentation: https://playwright.dev