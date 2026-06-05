import { test, expect } from '@playwright/test';

test('Submit Visforms form', async ({ page }) => {
  await page.goto('/index.php/myform');

  await page.fill('input[name="vf_field_1"]', 'Dani');
  await page.fill('input[name="vf_field_2"]', '12345');

  await page.click('button[type=submit"]');

  await expect(page.locator('.vf-thankyou')).toBeVisible();
});
