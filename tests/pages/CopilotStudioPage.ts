import { Page, Locator } from '@playwright/test';

export class CopilotStudioPage {
  readonly page: Page;
  readonly createAgentButton: Locator;
  readonly agentNameInput: Locator;
  readonly descriptionInput: Locator;
  readonly instructionsTextarea: Locator;
  readonly knowledgeSourcesTab: Locator;
  readonly addWebsiteButton: Locator;
  readonly websiteUrlInput: Locator;
  readonly saveButton: Locator;
  readonly publishButton: Locator;
  readonly testInCopilotButton: Locator;
  readonly chatInput: Locator;
  readonly chatMessages: Locator;

  constructor(page: Page) {
    this.page = page;
    this.createAgentButton = page.getByRole('button', { name: /create.*agent/i });
    this.agentNameInput = page.getByLabel(/agent name/i);
    this.descriptionInput = page.getByLabel(/description/i);
    this.instructionsTextarea = page.getByLabel(/instructions/i);
    this.knowledgeSourcesTab = page.getByRole('tab', { name: /knowledge/i });
    this.addWebsiteButton = page.getByRole('button', { name: /add.*website/i });
    this.websiteUrlInput = page.getByLabel(/website.*url/i);
    this.saveButton = page.getByRole('button', { name: /save/i });
    this.publishButton = page.getByRole('button', { name: /publish/i });
    this.testInCopilotButton = page.getByRole('button', { name: /test.*copilot/i });
    this.chatInput = page.getByRole('textbox', { name: /message/i });
    this.chatMessages = page.getByTestId('chat-message');
  }

  async goto() {
    await this.page.goto('/');
  }

  async login(username: string, password: string) {
    // Handle Microsoft authentication
    await this.page.fill('[name="loginfmt"]', username);
    await this.page.click('#idSIButton9');
    await this.page.waitForSelector('[name="passwd"]', { timeout: 10000 });
    await this.page.fill('[name="passwd"]', password);
    await this.page.click('#idSIButton9');
    
    // Handle "Stay signed in?" prompt
    const staySignedInButton = this.page.locator('#idSIButton9');
    if (await staySignedInButton.isVisible({ timeout: 5000 })) {
      await staySignedInButton.click();
    }
  }

  async createAgent(name: string, description: string, instructions: string) {
    await this.createAgentButton.click();
    await this.agentNameInput.fill(name);
    await this.descriptionInput.fill(description);
    await this.instructionsTextarea.fill(instructions);
    await this.saveButton.click();
  }

  async addWebsiteKnowledge(url: string) {
    await this.knowledgeSourcesTab.click();
    await this.addWebsiteButton.click();
    await this.websiteUrlInput.fill(url);
    await this.saveButton.click();
  }

  async publishAgent() {
    await this.publishButton.click();
    // Wait for publishing to complete
    await this.page.waitForSelector('[data-testid="publish-success"]', { timeout: 30000 });
  }

  async testAgentInCopilot() {
    await this.testInCopilotButton.click();
    // This will open in a new tab/window
    const newPage = await this.page.context().waitForEvent('page');
    return newPage;
  }

  async sendChatMessage(message: string) {
    await this.chatInput.fill(message);
    await this.chatInput.press('Enter');
    // Wait for response
    await this.page.waitForSelector('[data-testid="chat-message"]:last-child', { timeout: 30000 });
  }

  async getLastChatMessage() {
    const messages = await this.chatMessages.all();
    if (messages.length > 0) {
      return await messages[messages.length - 1].textContent();
    }
    return null;
  }

  async waitForAgentResponse() {
    // Wait for typing indicator to disappear and new message to appear
    await this.page.waitForFunction(() => {
      const typingIndicator = document.querySelector('[data-testid="typing-indicator"]');
      return !typingIndicator || typingIndicator.style.display === 'none';
    }, { timeout: 60000 });
  }
}