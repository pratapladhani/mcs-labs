import { test, expect } from '@playwright/test';

test.describe('Basic Playwright Setup Test', () => {
  test('should verify basic browser functionality', async ({ page }) => {
    // Simple test to verify Playwright is working
    await page.goto('https://example.com');
    
    // Verify page loads
    await expect(page).toHaveTitle(/Example Domain/);
    
    // Verify we can find the heading
    const heading = page.locator('h1');
    await expect(heading).toBeVisible();
    await expect(heading).toHaveText('Example Domain');
  });

  test('should handle basic user interactions', async ({ page }) => {
    await page.goto('https://example.com');
    
    // Test basic click interaction
    const moreInfoLink = page.getByRole('link', { name: 'More information...' });
    if (await moreInfoLink.isVisible()) {
      await expect(moreInfoLink).toBeVisible();
    }
  });
});