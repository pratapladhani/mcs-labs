import { Page, Locator } from '@playwright/test';

export class M365CopilotPage {
  readonly page: Page;
  readonly chatInput: Locator;
  readonly chatMessages: Locator;
  readonly sendButton: Locator;
  readonly agentSwitcher: Locator;
  readonly pluginsButton: Locator;

  constructor(page: Page) {
    this.page = page;
    this.chatInput = page.getByRole('textbox', { name: /ask me anything/i });
    this.chatMessages = page.getByTestId('chat-message');
    this.sendButton = page.getByRole('button', { name: /send/i });
    this.agentSwitcher = page.getByTestId('agent-switcher');
    this.pluginsButton = page.getByRole('button', { name: /plugins/i });
  }

  async goto() {
    await this.page.goto('https://copilot.microsoft.com');
  }

  async selectAgent(agentName: string) {
    await this.agentSwitcher.click();
    await this.page.getByText(agentName).click();
  }

  async sendMessage(message: string) {
    await this.chatInput.fill(message);
    await this.sendButton.click();
    // Wait for response
    await this.waitForResponse();
  }

  async waitForResponse() {
    // Wait for typing indicator to disappear
    await this.page.waitForFunction(() => {
      const indicator = document.querySelector('[data-testid="typing-indicator"]');
      return !indicator;
    }, { timeout: 60000 });
  }

  async getLastResponse() {
    const messages = await this.chatMessages.all();
    if (messages.length > 0) {
      return await messages[messages.length - 1].textContent();
    }
    return null;
  }

  async verifyAgentResponse(expectedKeywords: string[]) {
    const response = await this.getLastResponse();
    if (!response) return false;
    
    return expectedKeywords.some(keyword => 
      response.toLowerCase().includes(keyword.toLowerCase())
    );
  }
}