import { Page, Locator } from '@playwright/test';

export class SharePointPage {
  readonly page: Page;
  readonly uploadButton: Locator;
  readonly fileInput: Locator;
  readonly documentLibrary: Locator;
  readonly newFolderButton: Locator;
  readonly folderNameInput: Locator;

  constructor(page: Page) {
    this.page = page;
    this.uploadButton = page.getByRole('button', { name: /upload/i });
    this.fileInput = page.getByRole('input', { name: /file/i });
    this.documentLibrary = page.getByTestId('document-library');
    this.newFolderButton = page.getByRole('button', { name: /new.*folder/i });
    this.folderNameInput = page.getByLabel(/folder name/i);
  }

  async goto(siteUrl: string) {
    await this.page.goto(siteUrl);
  }

  async uploadFile(filePath: string) {
    await this.uploadButton.click();
    await this.fileInput.setInputFiles(filePath);
    // Wait for upload to complete
    await this.page.waitForSelector('[data-testid="upload-complete"]', { timeout: 30000 });
  }

  async createFolder(folderName: string) {
    await this.newFolderButton.click();
    await this.folderNameInput.fill(folderName);
    await this.page.keyboard.press('Enter');
  }

  async verifyFileExists(fileName: string) {
    return await this.page.getByText(fileName).isVisible();
  }

  async navigateToFolder(folderName: string) {
    await this.page.getByText(folderName).click();
  }
}