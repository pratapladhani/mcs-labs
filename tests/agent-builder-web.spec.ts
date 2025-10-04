import { test, expect } from '../fixtures/test-fixtures';

test.describe('Agent Builder Web Lab Tests', () => {
  test.beforeEach(async ({ copilotStudioPage }) => {
    await copilotStudioPage.goto();
    
    // Login with credentials from environment
    const username = process.env.M365_USERNAME;
    const password = process.env.M365_PASSWORD;
    
    if (!username || !password) {
      throw new Error('M365_USERNAME and M365_PASSWORD must be set in environment variables');
    }
    
    await copilotStudioPage.login(username, password);
  });

  test('should create a web-based AI assistant agent', async ({ copilotStudioPage }) => {
    const agentName = `Web Assistant ${Date.now()}`;
    const description = 'An AI assistant that helps with Microsoft Copilot questions';
    const instructions = `You are a helpful AI assistant specialized in Microsoft Copilot. 
    You should provide accurate, helpful information about Copilot features, capabilities, and best practices.
    Always be professional and friendly in your responses.`;

    // Create the agent
    await copilotStudioPage.createAgent(agentName, description, instructions);

    // Add knowledge source (Microsoft Copilot documentation)
    await copilotStudioPage.addWebsiteKnowledge('https://docs.microsoft.com/en-us/microsoft-copilot-studio/');

    // Publish the agent
    await copilotStudioPage.publishAgent();

    // Verify agent was created successfully
    await expect(copilotStudioPage.page.getByText(agentName)).toBeVisible();
  });

  test('should test agent functionality in chat', async ({ copilotStudioPage }) => {
    // Assume we have an existing agent to test
    const testMessage = 'What is Microsoft Copilot Studio?';
    
    await copilotStudioPage.sendChatMessage(testMessage);
    await copilotStudioPage.waitForAgentResponse();
    
    const response = await copilotStudioPage.getLastChatMessage();
    
    // Verify response contains relevant keywords
    expect(response).toContain('Copilot Studio');
    expect(response?.length).toBeGreaterThan(50); // Ensure substantial response
  });

  test('should validate agent instructions are working', async ({ copilotStudioPage }) => {
    const testMessage = 'Tell me about agent builder';
    
    await copilotStudioPage.sendChatMessage(testMessage);
    await copilotStudioPage.waitForAgentResponse();
    
    const response = await copilotStudioPage.getLastChatMessage();
    
    // Verify response is professional and helpful
    expect(response).toBeTruthy();
    expect(response?.toLowerCase()).toMatch(/(agent|builder|copilot|studio)/);
  });
});