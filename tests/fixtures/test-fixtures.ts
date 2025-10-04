import { test as base, expect } from '@playwright/test';
import { CopilotStudioPage } from './pages/CopilotStudioPage';
import { M365CopilotPage } from './pages/M365CopilotPage';
import { SharePointPage } from './pages/SharePointPage';

type TestFixtures = {
  copilotStudioPage: CopilotStudioPage;
  m365CopilotPage: M365CopilotPage;
  sharePointPage: SharePointPage;
};

export const test = base.extend<TestFixtures>({
  copilotStudioPage: async ({ page }, use) => {
    const copilotStudioPage = new CopilotStudioPage(page);
    await use(copilotStudioPage);
  },
  
  m365CopilotPage: async ({ page }, use) => {
    const m365CopilotPage = new M365CopilotPage(page);
    await use(m365CopilotPage);
  },
  
  sharePointPage: async ({ page }, use) => {
    const sharePointPage = new SharePointPage(page);
    await use(sharePointPage);
  },
});

export { expect };