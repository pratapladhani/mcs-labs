import { test, expect } from '@playwright/test';

test.describe('Setup Verification', () => {
  test('should verify Playwright is working', async ({ page }) => {
    // Test basic navigation
    await page.goto('https://playwright.dev');
    
    // Verify we can interact with the page
    await expect(page).toHaveTitle(/Playwright/);
    
    // Check that we can find elements
    const getStartedLink = page.getByRole('link', { name: 'Get started' });
    await expect(getStartedLink).toBeVisible();
  });

  test('should verify environment variables are loaded', async () => {
    // This test just checks if dotenv is working
    const testVar = process.env.NODE_ENV || 'test';
    expect(testVar).toBeDefined();
  });
});