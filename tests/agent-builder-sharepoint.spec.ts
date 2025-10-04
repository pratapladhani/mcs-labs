import { test, expect } from '../fixtures/test-fixtures';

test.describe('Agent Builder SharePoint Lab Tests', () => {
  test.beforeEach(async ({ copilotStudioPage, sharePointPage }) => {
    await copilotStudioPage.goto();
    
    const username = process.env.M365_USERNAME;
    const password = process.env.M365_PASSWORD;
    
    if (!username || !password) {
      throw new Error('M365_USERNAME and M365_PASSWORD must be set in environment variables');
    }
    
    await copilotStudioPage.login(username, password);
  });

  test('should create SharePoint-integrated AI assistant', async ({ copilotStudioPage, sharePointPage }) => {
    const agentName = `Sales Assistant ${Date.now()}`;
    const description = 'AI assistant for sales data analysis and policy compliance';
    const instructions = `You are a Sales Admin Assistant that helps with:
    1. Analyzing Excel sales data from SharePoint
    2. Referencing company policy documents
    3. Creating charts and visualizations
    4. Providing sales trend insights
    Always provide data-driven insights and reference relevant policies.`;

    // Create the agent
    await copilotStudioPage.createAgent(agentName, description, instructions);

    // Add SharePoint knowledge source (would need to be configured with actual SharePoint site)
    const sharePointUrl = process.env.SHAREPOINT_URL || 'https://example.sharepoint.com/sites/sales';
    await copilotStudioPage.addWebsiteKnowledge(sharePointUrl);

    // Publish the agent
    await copilotStudioPage.publishAgent();

    // Verify agent was created successfully
    await expect(copilotStudioPage.page.getByText(agentName)).toBeVisible();
  });

  test('should handle sales data analysis queries', async ({ copilotStudioPage }) => {
    const testMessage = 'Can you analyze the sales trends from our Q3 data in SharePoint?';
    
    await copilotStudioPage.sendChatMessage(testMessage);
    await copilotStudioPage.waitForAgentResponse();
    
    const response = await copilotStudioPage.getLastChatMessage();
    
    // Verify response acknowledges the request appropriately
    expect(response).toBeTruthy();
    expect(response?.toLowerCase()).toMatch(/(sales|data|analysis|sharepoint)/);
  });

  test('should provide policy compliance guidance', async ({ copilotStudioPage }) => {
    const testMessage = 'What are our company policies regarding sales discount approvals?';
    
    await copilotStudioPage.sendChatMessage(testMessage);
    await copilotStudioPage.waitForAgentResponse();
    
    const response = await copilotStudioPage.getLastChatMessage();
    
    // Verify response addresses policy questions
    expect(response).toBeTruthy();
    expect(response?.toLowerCase()).toMatch(/(policy|policies|compliance|approval)/);
  });
});