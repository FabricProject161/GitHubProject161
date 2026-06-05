import { test, expect } from '@playwright/test';

const J_ADMIN_USER = process.env.J_ADMIN_USER!;
const J_ADMIN_PASS = process.env.J_ADMIN_PASS!;

test('Joomla admin login works', async ({ page }) => {
  await page.goto('/administrator');

  await page.fill('#mod-login-username', J_ADMIN_USER);
  await page.fill('#mod-login-password', J_ADMIN_PASS);
  await page.click('button[type=submit]');

  await expect(page).toHaveURL(/dashboard/);
});
