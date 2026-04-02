/**
 * Playwright test — sidebar.js button behaviour
 *
 * Run:
 *   npx playwright test test/sidebar.playwright.js --reporter=list
 *   # or: node test/sidebar.playwright.js  (standalone, no test runner)
 */
const { chromium } = require('playwright');
const path = require('path');
const fs   = require('fs');

const HTML = path.resolve(__dirname, 'sidebar.test.html');

async function run() {
  const browser = await chromium.launch({ headless: true });
  const page    = await browser.newPage();

  const errors = [];
  page.on('pageerror', e => errors.push('JS ERROR: ' + e.message));
  page.on('console',   m => {
    const t = m.type(), txt = m.text();
    if (t === 'error') errors.push('CONSOLE ERROR: ' + txt);
    process.stdout.write(`  [${t}] ${txt}\n`);
  });

  await page.goto('file://' + HTML);
  await page.waitForTimeout(500);

  // Collect test results from DOM
  const results = await page.evaluate(() => {
    const rows = [...document.querySelectorAll('#test-log div')];
    return rows.map(r => ({
      pass: r.classList.contains('pass'),
      text: r.textContent.trim(),
    }));
  });

  let passed = 0, failed = 0;
  console.log('\n── Sidebar Button Tests ─────────────────────────────');
  for (const r of results) {
    console.log(r.text);
    r.pass ? passed++ : failed++;
  }
  console.log(`\n${passed} passed, ${failed} failed`);

  if (errors.length) {
    console.log('\n── JS Errors ────────────────────────────────────────');
    errors.forEach(e => console.log('  ' + e));
  }

  await browser.close();
  process.exit(failed > 0 || errors.length > 0 ? 1 : 0);
}

run().catch(e => { console.error(e); process.exit(1); });
