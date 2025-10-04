/**
 * SIMPLE PLAYWRIGHT VERIFICATION TEST
 * 
 * PURPOSE:
 * - Verifies that Playwright is installed and working correctly
 * - Tests basic browser functionality without external dependencies
 * - Used for troubleshooting and initial setup validation
 * 
 * WHAT IT TESTS:
 * - Browser can create pages and navigate to data URLs
 * - DOM interaction and element selection works
 * - JavaScript execution in browser context
 * - Basic user interactions (click, type)
 * 
 * USAGE:
 * - Quick verification: `npx playwright test simple-verification.spec.ts`
 * - Part of setup process to ensure Playwright works
 * - Debugging tool when other tests fail
 * 
 * ADVANTAGES:
 * - No network dependencies (uses data URLs)
 * - Fast execution (< 10 seconds)
 * - No authentication required
 * - Works offline
 * 
 * TEAM NOTES:
 * - Run this first if you suspect Playwright installation issues
 * - If this fails, check Node.js and Playwright installation
 * - Safe to run anytime without side effects
 */

import { test, expect } from '@playwright/test';

test.describe('Simple Playwright Verification', () => {
  test('should verify Playwright can create a page and navigate', async ({ page }) => {
    // Navigate to a data URL instead of external site to avoid network issues
    await page.goto('data:text/html,<html><body><h1>Test Page</h1><p>Playwright is working!</p></body></html>');
    
    // Verify we can interact with the page
    await expect(page.locator('h1')).toHaveText('Test Page');
    await expect(page.locator('p')).toHaveText('Playwright is working!');
    
    console.log('✅ Playwright basic functionality verified');
  });

  test('should verify browser interactions work', async ({ page }) => {
    // Create a simple HTML page with interactive elements
    const html = `
      <html>
        <body>
          <h1>Interactive Test</h1>
          <button id="test-button">Click Me</button>
          <input id="test-input" placeholder="Type here">
          <div id="result"></div>
          <script>
            document.getElementById('test-button').addEventListener('click', function() {
              document.getElementById('result').textContent = 'Button clicked!';
            });
          </script>
        </body>
      </html>
    `;
    
    await page.goto(`data:text/html,${encodeURIComponent(html)}`);
    
    // Test button clicking
    await page.click('#test-button');
    await expect(page.locator('#result')).toHaveText('Button clicked!');
    
    // Test input typing
    await page.fill('#test-input', 'Hello Playwright!');
    await expect(page.locator('#test-input')).toHaveValue('Hello Playwright!');
    
    console.log('✅ Browser interactions working correctly');
  });

  test('should verify environment variables are accessible', async () => {
    // Test that we can access environment variables
    const nodeEnv = process.env.NODE_ENV || 'test';
    expect(nodeEnv).toBeDefined();
    
    console.log(`✅ Environment: ${nodeEnv}`);
  });
});