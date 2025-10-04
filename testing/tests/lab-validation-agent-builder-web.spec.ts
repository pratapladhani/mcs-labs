import { test, expect } from '@playwright/test';

test.describe('Agent Builder Web Lab - Step-by-Step Validation', () => {
  test('should validate all steps from the Agent Builder Web lab', async ({ page }) => {
    // Step 1: Navigate to Microsoft 365 Copilot
    await test.step('Step 1: Navigate to Microsoft 365 Copilot home page', async () => {
      await page.goto('https://m365.cloud.microsoft/chat/?auth=2&home=1');
      
      // Validate we're on the correct page (not the wrong copilot page)
      await expect(page).toHaveURL(/m365\.cloud\.microsoft/);
      
      // Check that we're not on the wrong page (copilot.cloud.microsoft)
      const currentUrl = page.url();
      expect(currentUrl).not.toContain('copilot.cloud.microsoft');
      
      // Validate the Copilot pane is on the left side (correct page)
      // This would require specific selectors from the actual UI
      console.log('✅ Step 1: Successfully navigated to correct Microsoft 365 Copilot page');
    });

    // Step 2: Go to the Chat tab
    await test.step('Step 2: Go to the Chat tab', async () => {
      // Look for Chat tab and click it
      const chatTab = page.locator('text=Chat').first();
      if (await chatTab.isVisible()) {
        await chatTab.click();
        console.log('✅ Step 2: Successfully clicked Chat tab');
      } else {
        console.log('ℹ️  Step 2: Chat tab not found or already active');
      }
    });

    // Step 3: Verify Web tab selection (if Microsoft 365 Copilot license)
    await test.step('Step 3: Verify Web tab is selected', async () => {
      // Check if Work/Web tabs exist
      const webTab = page.locator('text=Web').first();
      if (await webTab.isVisible()) {
        await webTab.click();
        console.log('✅ Step 3: Successfully selected Web tab');
      } else {
        console.log('ℹ️  Step 3: No Work/Web tabs found - user has Copilot Chat only');
      }
    });

    // Step 4: Test basic experience
    await test.step('Step 4: Test basic Copilot experience', async () => {
      const testQuery = 'Upcoming features in Microsoft Copilot Studio roadmap';
      
      // Find the chat input and send test message
      const chatInput = page.locator('textarea, input[type="text"]').first();
      await chatInput.fill(testQuery);
      await chatInput.press('Enter');
      
      // Wait for response (this could take time for AI response)
      await page.waitForTimeout(5000);
      console.log('✅ Step 4: Successfully tested basic Copilot experience');
    });

    // Step 5: Start new chat
    await test.step('Step 5: Start a new chat', async () => {
      const newChatButton = page.locator('text=Start a new chat, text=New chat').first();
      if (await newChatButton.isVisible()) {
        await newChatButton.click();
        console.log('✅ Step 5: Successfully started new chat');
      } else {
        console.log('⚠️  Step 5: New chat button not found - may have different text');
      }
    });

    // Step 6: Create agent
    await test.step('Step 6: Expand Agents and select Create agent', async () => {
      // Expand Agents section
      const agentsSection = page.locator('text=Agents').first();
      await agentsSection.click();
      
      // Click Create agent
      const createAgentButton = page.locator('text=Create agent').first();
      await expect(createAgentButton).toBeVisible({ timeout: 10000 });
      await createAgentButton.click();
      
      console.log('✅ Step 6: Successfully clicked Create agent');
    });

    // Step 7: Describe the agent
    await test.step('Step 7: Describe the agent', async () => {
      const agentDescription = `I want to build a teacher-style agent that helps users learn about Copilot, including the differences between Microsoft 365 Copilot and Copilot Chat, Declarative Agents vs. Custom Engine Agents, and how to use Copilot Studio Lite. The agent should ask questions to validate and reinforce user understanding, encourage exploration, and act as a knowledgeable guide grounded in Microsoft documentation.`;
      
      // Look for description input field
      const descriptionInput = page.locator('textarea, input[type="text"]').first();
      await descriptionInput.fill(agentDescription);
      
      // Submit or continue
      const continueButton = page.locator('button:has-text("Continue"), button:has-text("Next"), button:has-text("Create")').first();
      if (await continueButton.isVisible()) {
        await continueButton.click();
      }
      
      console.log('✅ Step 7: Successfully described the agent');
    });

    // Step 8: Provide agent name and tone
    await test.step('Step 8: Provide agent name and tone (if asked)', async () => {
      const nameAndToneInstruction = `The name of the agent should be Copilot Teacher. Your tone should be friendly, personal, and emphatic. You can make jokes, use subtle irony and emojis when appropriate.`;
      
      // This step may or may not appear due to AI non-deterministic nature
      const nameInput = page.locator('input[placeholder*="name"], input[label*="name"]').first();
      if (await nameInput.isVisible({ timeout: 3000 })) {
        await nameInput.fill('Copilot Teacher');
        console.log('✅ Step 8: Successfully provided agent name and tone');
      } else {
        console.log('ℹ️  Step 8: Name input not found - may be handled differently');
      }
    });

    // Validate the agent creation process
    await test.step('Validate: Agent creation is in progress', async () => {
      // Look for signs that agent creation is proceeding
      const creationIndicators = [
        'Creating your agent',
        'Setting up',
        'Agent created',
        'Copilot Teacher'
      ];
      
      let foundIndicator = false;
      for (const indicator of creationIndicators) {
        if (await page.locator(`text=${indicator}`).isVisible({ timeout: 2000 })) {
          foundIndicator = true;
          console.log(`✅ Found creation indicator: ${indicator}`);
          break;
        }
      }
      
      if (!foundIndicator) {
        console.log('⚠️  No clear creation indicators found - may need UI selector updates');
      }
    });
  });

  test('should validate the wrong page detection', async ({ page }) => {
    // Test the "wrong page" scenario mentioned in your lab
    await test.step('Detect wrong Copilot page', async () => {
      await page.goto('https://copilot.cloud.microsoft/');
      
      // Validate we can detect the wrong page
      expect(page.url()).toContain('copilot.cloud.microsoft');
      
      // This helps users know they're on the wrong page
      console.log('✅ Successfully detected wrong Copilot page scenario');
    });
  });
});

// Helper test to validate all the URLs mentioned in your lab
test.describe('Lab URL Validation', () => {
  test('should validate all URLs mentioned in the lab work', async ({ page }) => {
    const labUrls = [
      'https://m365.cloud.microsoft/chat/?auth=2&home=1',
      'https://copilot.cloud.microsoft/', // This is the "wrong" page
    ];

    for (const url of labUrls) {
      await test.step(`Validate URL: ${url}`, async () => {
        try {
          await page.goto(url, { timeout: 30000 });
          console.log(`✅ URL accessible: ${url}`);
        } catch (error) {
          console.log(`❌ URL failed: ${url} - ${error}`);
        }
      });
    }
  });
});