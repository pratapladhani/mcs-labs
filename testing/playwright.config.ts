/**
 * PLAYWRIGHT CONFIGURATION
 * 
 * PURPOSE:
 * - Central configuration for all Playwright tests
 * - Defines test execution behavior, browsers, and authentication flow
 * - Sets up multi-browser testing with persistent authentication
 * 
 * KEY FEATURES:
 * - Persistent browser profiles for authentication (no credential storage)
 * - Multi-browser support: Chromium, Firefox, Safari, Mobile
 * - Automatic retry and failure handling
 * - Video/screenshot capture for debugging
 * 
 * AUTHENTICATION FLOW:
 * 1. 'setup' project runs `persistent-profile-auth.ts` first
 * 2. All other projects depend on setup completion
 * 3. Tests inherit authenticated browser profile
 * 
 * CUSTOMIZATION:
 * - Modify `baseURL` for different environments
 * - Adjust `workers` for parallel execution
 * - Update `retries` for flaky test handling
 * 
 * TEAM USAGE:
 * - No direct editing needed for normal testing
 * - Modify timeouts if tests are slow
 * - Add new browsers in `projects` array if needed
 */

import { defineConfig, devices } from '@playwright/test';
import * as dotenv from 'dotenv';

// Load environment variables
dotenv.config();

/**
 * @see https://playwright.dev/docs/test-configuration
 */
export default defineConfig({
  testDir: './tests',
  /* Run tests in files in parallel */
  fullyParallel: true,
  /* Fail the build on CI if you accidentally left test.only in the source code. */
  forbidOnly: !!process.env.CI,
  /* Retry on CI only */
  retries: process.env.CI ? 2 : 0,
  /* Opt out of parallel tests on CI. */
  workers: process.env.CI ? 1 : undefined,
  /* Reporter to use. See https://playwright.dev/docs/test-reporters */
  reporter: [
    ['html'],
    ['json', { outputFile: 'test-results/results.json' }],
    ['junit', { outputFile: 'test-results/results.xml' }]
  ],
  /* Shared settings for all the projects below. See https://playwright.dev/docs/api/class-testoptions. */
  use: {
    /* Base URL to use in actions like `await page.goto('/')`. */
    baseURL: process.env.BASE_URL || 'https://copilotstudio.microsoft.com',
    
    /* Collect trace when retrying the failed test. See https://playwright.dev/docs/trace-viewer */
    trace: 'on-first-retry',
    
    /* Take screenshot on failure */
    screenshot: 'only-on-failure',
    
    /* Record video on failure */
    video: 'retain-on-failure',
    
    /* Global timeout for each action */
    actionTimeout: 30000,
    
    /* Global timeout for navigation */
    navigationTimeout: 60000,
  },

  /* Configure projects for major browsers */
  projects: [
    {
      name: 'setup',
      testMatch: /persistent-profile-auth\.ts/,
    },
    {
      name: 'chromium',
      use: { 
        ...devices['Desktop Chrome'],
        // Use the persistent browser profile for authentication
        channel: 'chromium',
      },
      dependencies: ['setup'],
    },
    // Note: Persistent profile tests handle browser launch directly in the test files
    {
      name: 'firefox',
      use: { 
        ...devices['Desktop Firefox'],
        storageState: 'playwright/.auth/user.json',
      },
      dependencies: ['setup'],
    },
    {
      name: 'webkit',
      use: { 
        ...devices['Desktop Safari'],
        storageState: 'playwright/.auth/user.json',
      },
      dependencies: ['setup'],
    },
    /* Test against mobile viewports. */
    {
      name: 'Mobile Chrome',
      use: { 
        ...devices['Pixel 5'],
        storageState: 'playwright/.auth/user.json',
      },
      dependencies: ['setup'],
    },
    {
      name: 'Mobile Safari',
      use: { 
        ...devices['iPhone 12'],
        storageState: 'playwright/.auth/user.json',
      },
      dependencies: ['setup'],
    },
  ],

  /* Run your local dev server before starting the tests */
  // webServer: {
  //   command: 'npm run start',
  //   url: 'http://127.0.0.1:3000',
  //   reuseExistingServer: !process.env.CI,
  // },
});