/**
 * TEST UTILITIES AND HELPER FUNCTIONS
 * 
 * PURPOSE:
 * - Provides common utility functions used across all tests
 * - Handles screenshot management, wait conditions, and data generation
 * - Centralizes reusable test logic to avoid duplication
 * 
 * KEY UTILITIES:
 * - generateTestName() - Create unique names for test agents/resources
 * - waitForElement() - Smart wait with multiple fallback strategies
 * - takeScreenshot() - Capture and save screenshots with descriptive names
 * - cleanupTestData() - Clean up test resources after test completion
 * - validateEnvironment() - Check prerequisites before running tests
 * 
 * USAGE:
 * - Import specific functions or entire TestHelpers class
 * - Use for common operations that appear in multiple tests
 * - Provides consistent error handling and logging
 * 
 * TEAM GUIDELINES:
 * - Add new utilities here instead of duplicating code in tests
 * - Keep functions pure and stateless when possible
 * - Include comprehensive error handling and logging
 * - Document function parameters and return values
 * 
 * EXAMPLES:
 * - const agentName = TestHelpers.generateTestName('WebAgent');
 * - await TestHelpers.takeScreenshot(page, 'agent-created');
 * - await TestHelpers.waitForElement(page, 'button[data-testid="save"]');
 */

export class TestHelpers {
  /**
   * Generate a unique test name with timestamp
   */
  static generateTestName(prefix: string): string {
    return `${prefix}-${Date.now()}-${Math.random().toString(36).substr(2, 9)}`;
  }

  /**
   * Wait for a condition with timeout
   */
  static async waitForCondition(
    condition: () => Promise<boolean>,
    timeoutMs: number = 30000,
    intervalMs: number = 1000
  ): Promise<boolean> {
    const startTime = Date.now();
    
    while (Date.now() - startTime < timeoutMs) {
      if (await condition()) {
        return true;
      }
      await new Promise(resolve => setTimeout(resolve, intervalMs));
    }
    
    return false;
  }

  /**
   * Extract test data from lab documentation
   */
  static parseLabDocumentation(content: string) {
    const titleMatch = content.match(/# (.+)/);
    const durationMatch = content.match(/(\d+)\s*minutes?/i);
    const levelMatch = content.match(/Level.*?(\d+)/i);
    
    return {
      title: titleMatch ? titleMatch[1] : 'Unknown Lab',
      duration: durationMatch ? parseInt(durationMatch[1]) : 30,
      level: levelMatch ? parseInt(levelMatch[1]) : 100
    };
  }

  /**
   * Clean up test agents (helper for cleanup)
   */
  static async cleanupTestAgents(page: any, testPrefix: string) {
    try {
      // This would implement cleanup logic for test agents
      // For now, just log the attempt
      console.log(`Cleaning up test agents with prefix: ${testPrefix}`);
    } catch (error) {
      console.warn('Failed to clean up test agents:', error);
    }
  }

  /**
   * Validate response contains expected AI assistant behaviors
   */
  static validateAIResponse(response: string): {
    isValid: boolean;
    issues: string[];
  } {
    const issues: string[] = [];
    
    if (!response || response.length < 10) {
      issues.push('Response too short');
    }
    
    if (response.includes('I cannot') && response.includes('I don\'t know')) {
      issues.push('Response seems overly restrictive');
    }
    
    if (response.toLowerCase().includes('error') || response.toLowerCase().includes('failed')) {
      issues.push('Response contains error indicators');
    }
    
    return {
      isValid: issues.length === 0,
      issues
    };
  }
}

export class LabTestData {
  static readonly WEB_AGENT = {
    name: 'Web Assistant Test Agent',
    description: 'Test agent for web-based AI assistant lab',
    instructions: 'You are a helpful AI assistant specialized in Microsoft Copilot.',
    knowledgeSource: 'https://docs.microsoft.com/en-us/microsoft-copilot-studio/',
    testQuestions: [
      'What is Microsoft Copilot Studio?',
      'How do I create an agent?',
      'What are knowledge sources?'
    ]
  };

  static readonly SHAREPOINT_AGENT = {
    name: 'Sales Assistant Test Agent',
    description: 'Test agent for SharePoint integration lab',
    instructions: 'You are a Sales Admin Assistant that helps with data analysis.',
    testQuestions: [
      'Analyze sales trends from Q3 data',
      'What are our discount approval policies?',
      'Show me top performing products'
    ]
  };

  static readonly IT_SUPPORT_AGENT = {
    name: 'IT Support Test Agent',
    description: 'Test agent for multi-agent IT support lab',
    instructions: 'You route IT queries to appropriate specialized agents.',
    testQuestions: [
      'I need to check ticket RITM0012345',
      'Cannot access SharePoint document library',
      'How do I reset my password?',
      'My computer is frozen and making noise'
    ]
  };
}