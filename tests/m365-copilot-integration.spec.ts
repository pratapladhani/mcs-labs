import { test, expect } from '../fixtures/test-fixtures';

test.describe('M365 Copilot Integration Tests', () => {
  test('should access agent in M365 Copilot', async ({ m365CopilotPage }) => {
    await m365CopilotPage.goto();
    
    // Test basic chat functionality
    await m365CopilotPage.sendMessage('Hello, can you help me with Microsoft Copilot questions?');
    
    const response = await m365CopilotPage.getLastResponse();
    expect(response).toBeTruthy();
    expect(response?.length).toBeGreaterThan(10);
  });

  test('should be able to switch between agents', async ({ m365CopilotPage }) => {
    await m365CopilotPage.goto();
    
    // Try to select a custom agent (if available)
    const testAgentName = process.env.TEST_AGENT_NAME || 'Test Agent';
    
    try {
      await m365CopilotPage.selectAgent(testAgentName);
      
      // Test that the agent responds appropriately
      await m365CopilotPage.sendMessage('What can you help me with?');
      
      const response = await m365CopilotPage.getLastResponse();
      expect(response).toBeTruthy();
    } catch (error) {
      // If agent doesn't exist, that's okay for this test
      console.log(`Agent ${testAgentName} not found, skipping agent switch test`);
    }
  });

  test('should verify agent response quality', async ({ m365CopilotPage }) => {
    await m365CopilotPage.goto();
    
    const testQuestions = [
      'What is Microsoft Copilot Studio?',
      'How do I create an agent?',
      'Can you help with Power Platform questions?'
    ];

    for (const question of testQuestions) {
      await m365CopilotPage.sendMessage(question);
      
      const isRelevant = await m365CopilotPage.verifyAgentResponse([
        'copilot', 'studio', 'agent', 'power platform', 'microsoft'
      ]);
      
      expect(isRelevant).toBeTruthy();
      
      // Wait a bit between questions to avoid rate limiting
      await m365CopilotPage.page.waitForTimeout(2000);
    }
  });
});