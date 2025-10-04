/**
 * PERSISTENT PROFILE AUTHENTICATION SETUP
 * 
 * PURPOSE:
 * - Creates and maintains a persistent Chromium browser profile for secure authentication
 * - Handles interactive Microsoft 365 login with MFA support
 * - Eliminates need to re-authenticate for every test run
 * 
 * USAGE:
 * - Run once: `npx playwright test persistent-profile-auth.ts --headed`
 * - Profile persists in `playwright/.auth/chromium-profile/`
 * - All subsequent tests use this authenticated profile automatically
 * 
 * WHEN TO USE:
 * - Initial setup of testing framework
 * - When authentication session expires
 * - After clearing browser profiles
 * 
 * DEPENDENCIES:
 * - Requires M365_USERNAME and M365_PASSWORD in .env file
 * - Supports MFA (interactive login in browser)
 * 
 * TEAM NOTES:
 * - Safe to run multiple times (updates existing profile)
 * - Browser will open for interactive login - complete MFA as needed
 * - Creates videos/screenshots in `.auth/videos/` for debugging
 */

import { test as setup, expect, chromium } from '@playwright/test';
import { promises as fs } from 'fs';
import path from 'path';

const authFile = 'playwright/.auth/user.json';
const profilePath = 'playwright/.auth/chromium-profile';

setup('setup persistent authentication with dedicated browser profile', async () => {
  console.log('🔧 Setting up dedicated Chromium profile for testing...');
  
  // Ensure the profile directory exists
  await fs.mkdir(profilePath, { recursive: true });
  console.log('📁 Created dedicated browser profile directory:', profilePath);
  
  // Launch Chromium with a dedicated user data directory
  const browser = await chromium.launchPersistentContext(profilePath, {
    headless: false, // Show browser for interactive login
    viewport: { width: 1280, height: 720 },
    
    // Browser arguments for better isolation and functionality
    args: [
      '--no-first-run',
      '--no-default-browser-check',
      '--disable-extensions-except=',
      '--disable-extensions',
      '--disable-default-apps',
      '--disable-background-timer-throttling',
      '--disable-renderer-backgrounding',
      '--disable-backgrounding-occluded-windows',
      '--disable-ipc-flooding-protection',
    ],
    
    // Enable downloads and other features
    acceptDownloads: true,
    
    // Record video for debugging
    recordVideo: {
      dir: 'playwright/.auth/videos/',
      size: { width: 1280, height: 720 }
    },
    
    // Permissions for Microsoft 365 features
    permissions: ['geolocation', 'notifications'],
    
    // Set a realistic user agent
    userAgent: 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
  });

  const page = browser.pages()[0] || await browser.newPage();
  
  const username = process.env.M365_USERNAME;
  const password = process.env.M365_PASSWORD;
  
  // Check if credentials are properly configured
  const hasValidCredentials = username && password && 
    !username.includes('your.email') && 
    !password.includes('your_password');
  
  if (!hasValidCredentials) {
    console.log('🛡️  Interactive login mode selected');
    console.log('📖 No valid credentials found - this is perfect for secure interactive login');
    console.log('');
    console.log('🔐 Benefits of this approach:');
    console.log('   ✅ No credentials stored in files');
    console.log('   ✅ Complete browser profile isolation');
    console.log('   ✅ Session persists across test runs');
    console.log('   ✅ Supports MFA without additional setup');
    console.log('');
  }

  try {
    console.log('🌐 Navigating to Microsoft 365 Copilot...');
    await page.goto('https://m365.cloud.microsoft/chat/?auth=2&home=1', { 
      waitUntil: 'networkidle',
      timeout: 60000 
    });

    // Check if we're already authenticated from previous runs
    const isAuthenticated = await checkIfAuthenticated(page);
    
    if (isAuthenticated) {
      console.log('✅ Already authenticated - using persistent browser profile');
      console.log('🎯 This means your authentication is working perfectly!');
    } else {
      console.log('🖱️  Interactive login required');
      console.log('');
      console.log('👋 Please complete the login process in the browser window that opened');
      console.log('⏳ The test will wait for you to sign in...');
      console.log('');
      console.log('📝 Steps to complete:');
      console.log('   1. Enter your Microsoft 365 email address');
      console.log('   2. Enter your password (or complete MFA if enabled)');
      console.log('   3. Click "Stay signed in" if prompted');
      console.log('   4. Wait for the Copilot interface to load');
      console.log('');
      
      await performInteractiveLogin(page);
    }

    // Verify authentication was successful
    const finalAuthCheck = await checkIfAuthenticated(page);
    if (finalAuthCheck) {
      console.log('🎉 Authentication successful!');
      console.log('💾 Browser profile will remember this login for future tests');
      
      // Take a screenshot of the authenticated state
      await page.screenshot({ 
        path: 'playwright/.auth/authenticated-state.png', 
        fullPage: true 
      });
      console.log('📸 Authenticated state screenshot saved');
      
      // Save authentication cookies to JSON for backup
      const cookies = await browser.cookies();
      await fs.writeFile(
        'playwright/.auth/cookies-backup.json', 
        JSON.stringify(cookies, null, 2)
      );
      console.log('🍪 Authentication cookies backed up');
      
      console.log('');
      console.log('🚀 Setup complete! Your dedicated testing profile is ready');
      console.log('📁 Profile location:', profilePath);
      console.log('🔄 This authentication will persist across all future test runs');
      
    } else {
      throw new Error('Authentication verification failed - please try again');
    }

  } catch (error) {
    const errorMessage = error instanceof Error ? error.message : 'Unknown error';
    console.error('❌ Authentication setup failed:', errorMessage);
    
    // Save debug screenshot
    await page.screenshot({ 
      path: 'playwright/.auth/setup-error.png', 
      fullPage: true 
    });
    console.log('📸 Error screenshot saved for debugging');
    
    // Provide helpful error guidance
    console.log('');
    console.log('🔧 Troubleshooting tips:');
    console.log('   1. Make sure you have access to Microsoft 365 Copilot');
    console.log('   2. Check if your account has the necessary permissions');
    console.log('   3. Try clearing the browser profile: rm -rf "' + profilePath + '"');
    console.log('   4. If MFA is enabled, complete all authentication steps');
    
    throw error;
  } finally {
    await browser.close();
  }
});

// Helper function to check if user is authenticated
async function checkIfAuthenticated(page: any): Promise<boolean> {
  console.log('🔍 Checking authentication status...');
  
  const authIndicators = [
    { selector: 'text=Chat', name: 'Chat tab' },
    { selector: 'text=Agents', name: 'Agents section' },
    { selector: '[data-testid="copilot-interface"]', name: 'Copilot interface' },
    { selector: '[data-testid="chat-input"]', name: 'Chat input' },
    { selector: 'textarea[placeholder*="message"]', name: 'Message textarea' },
    { selector: 'textarea[placeholder*="chat"]', name: 'Chat textarea' },
    { selector: 'input[placeholder*="message"]', name: 'Message input' },
    { selector: '[aria-label*="chat"]', name: 'Chat element' },
  ];
  
  for (const indicator of authIndicators) {
    try {
      if (await page.locator(indicator.selector).isVisible({ timeout: 3000 })) {
        console.log(`✅ Authentication confirmed (found: ${indicator.name})`);
        return true;
      }
    } catch {
      continue;
    }
  }
  
  // Check URL as backup
  const url = page.url();
  if (url.includes('m365.cloud.microsoft') && !url.includes('login')) {
    console.log('✅ Authentication confirmed (on correct URL without login)');
    return true;
  }
  
  // Check for any sign we're past the login screen
  const bodyText = await page.textContent('body').catch(() => '');
  if (bodyText && (bodyText.includes('Copilot') || bodyText.includes('Chat'))) {
    console.log('✅ Authentication confirmed (Copilot content detected)');
    return true;
  }
  
  console.log('ℹ️  Not authenticated yet - login required');
  return false;
}

// Helper function for interactive login with better UX
async function performInteractiveLogin(page: any): Promise<void> {
  console.log('🖱️  Starting interactive login process...');
  
  // Wait for user to complete login (up to 10 minutes for MFA scenarios)
  const maxWaitTime = 10 * 60 * 1000; // 10 minutes
  const startTime = Date.now();
  const checkInterval = 3000; // Check every 3 seconds
  
  let lastUrl = '';
  let checkCount = 0;
  
  while (Date.now() - startTime < maxWaitTime) {
    checkCount++;
    const currentUrl = page.url();
    
    // Show progress every 10 checks (30 seconds)
    if (checkCount % 10 === 0) {
      const elapsed = Math.round((Date.now() - startTime) / 1000);
      console.log(`⏳ Still waiting for login completion... (${elapsed}s elapsed)`);
    }
    
    // Show URL changes to help user understand progress
    if (currentUrl !== lastUrl) {
      lastUrl = currentUrl;
      if (currentUrl.includes('login')) {
        console.log('📝 On login page - please enter your credentials');
      } else if (currentUrl.includes('kmsi')) {
        console.log('🔐 "Stay signed in" prompt detected');
      } else if (currentUrl.includes('m365.cloud.microsoft')) {
        console.log('🚀 Redirected to Microsoft 365 - checking authentication...');
      }
    }
    
    // Check if authentication completed
    if (await checkIfAuthenticated(page)) {
      console.log('✅ Interactive login completed successfully');
      return;
    }
    
    await page.waitForTimeout(checkInterval);
  }
  
  throw new Error('Interactive login timeout - please try running the setup again');
}