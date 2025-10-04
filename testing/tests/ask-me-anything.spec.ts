import { test, expect } from '../fixtures/test-fixtures';

test.describe('Ask Me Anything Agent Lab Tests', () => {
  test.beforeEach(async ({ copilotStudioPage }) => {
    await copilotStudioPage.goto();
    
    const username = process.env.M365_USERNAME;
    const password = process.env.M365_PASSWORD;
    
    if (!username || !password) {
      throw new Error('M365_USERNAME and M365_PASSWORD must be set in environment variables');
    }
    
    await copilotStudioPage.login(username, password);
  });

  test('should create multi-agent IT Support solution', async ({ copilotStudioPage }) => {
    const agentName = `IT Support Assistant ${Date.now()}`;
    const description = 'Multi-agent IT Support solution with intelligent query routing';
    const instructions = `You are an IT Support routing agent that:
    1. Analyzes user queries to understand the type of IT support needed
    2. Routes queries to appropriate specialized sub-agents
    3. Handles general IT questions directly when appropriate
    4. Escalates complex issues to human support when needed
    
    Available sub-agents:
    - ServiceNow Agent: For ticketing and incident management
    - SharePoint Agent: For document and collaboration issues
    - General IT Agent: For common technical questions`;

    // Create the main routing agent
    await copilotStudioPage.createAgent(agentName, description, instructions);

    // Add knowledge sources
    await copilotStudioPage.addWebsiteKnowledge('https://docs.microsoft.com/en-us/sharepoint/');
    
    // Publish the agent
    await copilotStudioPage.publishAgent();

    // Verify agent was created successfully
    await expect(copilotStudioPage.page.getByText(agentName)).toBeVisible();
  });

  test('should route ServiceNow queries correctly', async ({ copilotStudioPage }) => {
    const testMessage = 'I need to check the status of my IT ticket RITM0012345';
    
    await copilotStudioPage.sendChatMessage(testMessage);
    await copilotStudioPage.waitForAgentResponse();
    
    const response = await copilotStudioPage.getLastChatMessage();
    
    // Verify response indicates ServiceNow routing or handling
    expect(response).toBeTruthy();
    expect(response?.toLowerCase()).toMatch(/(servicenow|ticket|ritm|incident)/);
  });

  test('should handle SharePoint queries', async ({ copilotStudioPage }) => {
    const testMessage = 'I cannot access a SharePoint document library, getting permission denied error';
    
    await copilotStudioPage.sendChatMessage(testMessage);
    await copilotStudioPage.waitForAgentResponse();
    
    const response = await copilotStudioPage.getLastChatMessage();
    
    // Verify response addresses SharePoint issues
    expect(response).toBeTruthy();
    expect(response?.toLowerCase()).toMatch(/(sharepoint|permission|access|document)/);
  });

  test('should handle general IT queries', async ({ copilotStudioPage }) => {
    const testMessage = 'How do I reset my password for Microsoft 365?';
    
    await copilotStudioPage.sendChatMessage(testMessage);
    await copilotStudioPage.waitForAgentResponse();
    
    const response = await copilotStudioPage.getLastChatMessage();
    
    // Verify response provides password reset guidance
    expect(response).toBeTruthy();
    expect(response?.toLowerCase()).toMatch(/(password|reset|microsoft|365|m365)/);
  });

  test('should recognize when to escalate to human support', async ({ copilotStudioPage }) => {
    const testMessage = 'My computer is completely frozen and making strange noises, nothing is working';
    
    await copilotStudioPage.sendChatMessage(testMessage);
    await copilotStudioPage.waitForAgentResponse();
    
    const response = await copilotStudioPage.getLastChatMessage();
    
    // Verify response suggests escalation or immediate help
    expect(response).toBeTruthy();
    expect(response?.toLowerCase()).toMatch(/(escalate|human|support|technician|urgent|hardware)/);
  });
});