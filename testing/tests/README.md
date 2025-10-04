# MCS Labs Playwright Testing

This directory contains automated end-to-end tests for the Microsoft Copilot Studio Labs using Playwright.

## Setup

1. **Install dependencies:**
   ```bash
   npm install
   ```

2. **Install Playwright browsers:**
   ```bash
   npm run install:browsers
   ```

3. **Configure environment variables:**
   - Copy `.env.example` to `.env`
   - Fill in your Microsoft 365 credentials and other required values:
     ```
     M365_USERNAME=your.email@company.com
     M365_PASSWORD=your_password
     SHAREPOINT_URL=https://yourcompany.sharepoint.com
     ```

## Running Tests

### All Tests
```bash
npm test
```

### Headed Mode (See Browser)
```bash
npm run test:headed
```

### Debug Mode
```bash
npm run test:debug
```

### UI Mode (Interactive)
```bash
npm run test:ui
```

### View Test Report
```bash
npm run test:report
```

## Test Structure

### Page Objects
- `tests/pages/CopilotStudioPage.ts` - Copilot Studio interface interactions
- `tests/pages/M365CopilotPage.ts` - Microsoft 365 Copilot interface
- `tests/pages/SharePointPage.ts` - SharePoint interface interactions

### Test Files
- `tests/agent-builder-web.spec.ts` - Tests for web-based agent creation
- `tests/agent-builder-sharepoint.spec.ts` - Tests for SharePoint integration
- `tests/ask-me-anything.spec.ts` - Tests for multi-agent IT support solution
- `tests/m365-copilot-integration.spec.ts` - Tests for M365 Copilot integration

### Fixtures
- `tests/fixtures/test-fixtures.ts` - Custom test fixtures and page object setup

## Test Scenarios Covered

### Agent Builder Web Lab
- ✅ Create web-based AI assistant agent
- ✅ Test agent functionality in chat
- ✅ Validate agent instructions are working

### Agent Builder SharePoint Lab
- ✅ Create SharePoint-integrated AI assistant
- ✅ Handle sales data analysis queries
- ✅ Provide policy compliance guidance

### Ask Me Anything Lab
- ✅ Create multi-agent IT Support solution
- ✅ Route ServiceNow queries correctly
- ✅ Handle SharePoint queries
- ✅ Handle general IT queries
- ✅ Recognize when to escalate to human support

### M365 Copilot Integration
- ✅ Access agent in M365 Copilot
- ✅ Switch between agents
- ✅ Verify agent response quality

## Authentication

Tests use Microsoft 365 authentication. The `auth.setup.ts` file handles login and saves the authentication state for reuse across tests.

## Configuration

The `playwright.config.ts` file contains:
- Browser configurations (Chromium, Firefox, WebKit)
- Mobile device testing
- Screenshot and video recording on failures
- Test reporting options
- Timeout settings

## Best Practices

1. **Environment Variables**: Never commit credentials to the repository
2. **Page Objects**: Use page object pattern for maintainable tests
3. **Assertions**: Include meaningful assertions to validate functionality
4. **Timeouts**: Configure appropriate timeouts for AI response times
5. **Cleanup**: Clean up test data after test runs

## Troubleshooting

### Common Issues

1. **Authentication Failures**
   - Verify M365 credentials in `.env` file
   - Check if MFA is enabled (may require app passwords)
   - Ensure account has access to Copilot Studio

2. **Timeout Errors**
   - AI responses can be slow; consider increasing timeout values
   - Check network connectivity
   - Verify service availability

3. **Element Not Found**
   - UI selectors may change; update page objects accordingly
   - Use more robust selectors when possible
   - Add explicit waits for dynamic content

## Contributing

When adding new tests:
1. Follow the existing page object pattern
2. Add appropriate assertions
3. Handle both success and failure scenarios
4. Update this README with new test scenarios
5. Test locally before committing

## CI/CD Integration

Tests can be integrated into CI/CD pipelines. Consider:
- Using headless mode in CI
- Storing test credentials securely
- Generating test reports
- Archiving screenshots/videos on failures