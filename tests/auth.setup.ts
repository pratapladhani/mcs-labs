import { test as base } from '@playwright/test';

// Authentication setup test
const test = base.extend({
  // Use signed-in state for all tests
  storageState: 'playwright/.auth/user.json',
});

test('authenticate', async ({ page }) => {
  const username = process.env.M365_USERNAME;
  const password = process.env.M365_PASSWORD;
  
  if (!username || !password) {
    throw new Error('M365_USERNAME and M365_PASSWORD must be set in environment variables');
  }

  // Navigate to Copilot Studio
  await page.goto('https://copilotstudio.microsoft.com');

  // Handle Microsoft authentication
  await page.fill('[name="loginfmt"]', username);
  await page.click('#idSIButton9');
  
  // Wait for password field and fill it
  await page.waitForSelector('[name="passwd"]', { timeout: 10000 });
  await page.fill('[name="passwd"]', password);
  await page.click('#idSIButton9');
  
  // Handle "Stay signed in?" prompt if it appears
  const staySignedInButton = page.locator('#idSIButton9');
  if (await staySignedInButton.isVisible({ timeout: 5000 })) {
    await staySignedInButton.click();
  }

  // Wait for successful login - look for Copilot Studio UI elements
  await page.waitForSelector('[data-testid="copilot-studio-home"]', { timeout: 30000 }).catch(() => {
    // If specific test ID doesn't exist, wait for any sign we're logged in
    return page.waitForURL(/copilotstudio\.microsoft\.com/, { timeout: 30000 });
  });

  // Save signed-in state
  await page.context().storageState({ path: 'playwright/.auth/user.json' });
});

export { test };